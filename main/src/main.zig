const std = @import("std");

const esp = struct {
    usingnamespace @cImport({
        @cInclude("sdkconfig.h");
        @cInclude("esp_err.h");
        @cInclude("esp_log.h");

        // zig opaque struct-in-struct not supported -> rewrite extern structs and calls in zig by hand
        // @cInclude("driver/ledc.h");
        @cInclude("hal/ledc_types.h");
    });

    const TimerConfig = extern struct {
        speed_mode: esp.ledc_mode_t,
        duty_resolution: esp.ledc_timer_bit_t,
        timer_num: esp.ledc_timer_t,
        freq_hz: u32,
        clk_cfg: esp.ledc_clk_cfg_t,
    };

    const ChannelConfig = extern struct {
        gpio_num: u32 = 0,
        speed_mode: esp.ledc_mode_t,
        channel: esp.ledc_channel_t,
        intr_type: esp.ledc_intr_type_t,
        timer_sel: esp.ledc_timer_t,
        duty: u32,
        hpoint: i32,
        flags: u32,
    };

    extern fn ledc_timer_config(config: *const TimerConfig) esp.esp_err_t;
    extern fn ledc_channel_config(config: *const ChannelConfig) esp.esp_err_t;

    extern fn ledc_set_duty(speed_mode: esp.ledc_mode_t, channel: esp.ledc_channel_t, duty: u32) esp.esp_err_t;
    extern fn ledc_update_duty(speed_mode: esp.ledc_mode_t, channel: esp.ledc_channel_t) esp.esp_err_t;
};

const freertos = @cImport({
    @cInclude("freertos/FreeRTOS.h");
    @cInclude("freertos/task.h");
});

fn min(a: u32, b: u32) u32 {
    return if (a > b) b else a;
}

const Candle = struct {
    gpio: u32 = 0,
    seed: u32 = 0,
    channel: esp.ledc_channel_t,
    pub fn init(gpio: u32, timer: esp.ledc_timer_t, channel: esp.ledc_channel_t) Candle {
        const c = esp.ChannelConfig{
            .gpio_num = gpio,
            .speed_mode = esp.LEDC_LOW_SPEED_MODE,
            .channel = channel,
            .intr_type = esp.LEDC_INTR_DISABLE,
            .timer_sel = timer,
            .duty = 0,
            .hpoint = 0,
            .flags = 0,
        };
        _ = esp.ledc_channel_config(&c);

        var self: Candle = .{
            .gpio = gpio,
            .seed = 0,
            .channel = channel,
        };

        return self;
    }

    pub fn lfsr32(self: *Candle) u32 {
        if (self.seed & 1 > 0) {
            self.seed = (self.seed >> 1);
        } else {
            self.seed = (self.seed >> 1) ^ 0x7ffff159;
        }
        return self.seed;
    }

    pub fn tick(self: *Candle) void {
        const poop = min(self.lfsr32() & 0x1f, 15);

        if (poop > 3) {
            _ = esp.ledc_set_duty(esp.LEDC_LOW_SPEED_MODE, self.channel, poop * 8191 / 15);
            _ = esp.ledc_update_duty(esp.LEDC_LOW_SPEED_MODE, self.channel);
        }
    }
};

fn setup_timer(timer: esp.ledc_timer_t, freq_hz: u32) c_int {
    const t = esp.TimerConfig{
        .speed_mode = esp.LEDC_LOW_SPEED_MODE,
        .timer_num = timer,
        .duty_resolution = esp.LEDC_TIMER_13_BIT,
        .freq_hz = freq_hz,
        .clk_cfg = esp.LEDC_AUTO_CLK,
    };
    return esp.ledc_timer_config(&t);
}

export fn app_main() void {
    _ = setup_timer(esp.LEDC_TIMER_0, 440);

    var c0 = Candle.init(8, esp.LEDC_TIMER_0, esp.LEDC_CHANNEL_0);
    var c1 = Candle.init(9, esp.LEDC_TIMER_0, esp.LEDC_CHANNEL_1);
    var c2 = Candle.init(10, esp.LEDC_TIMER_0, esp.LEDC_CHANNEL_2);
    var c3 = Candle.init(11, esp.LEDC_TIMER_0, esp.LEDC_CHANNEL_3);
    var c4 = Candle.init(12, esp.LEDC_TIMER_0, esp.LEDC_CHANNEL_4);

    c1.tick();
    c2.tick();
    c2.tick();
    c3.tick();

    while (true) {
        c0.tick();
        c1.tick();
        c2.tick();
        c3.tick();
        c4.tick();
        freertos.vTaskDelay(50 / freertos.portTICK_PERIOD_MS);
    }
}
