const std = @import("std");

const esp = struct {
    usingnamespace @cImport({
        @cInclude("sdkconfig.h");
        @cInclude("esp_err.h");
        @cInclude("esp_log.h");

        // zig opaque struct-in-struct not supported -> override manually
        // @cInclude("driver/ledc.h");
        @cInclude("hal/ledc_types.h");
        @cInclude("driver/gpio.h");
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

pub const std_options = struct {
    pub fn logFn(comptime message_level: std.log.Level, comptime scope: @Type(.EnumLiteral), comptime format: []const u8, args: anytype) void {
        const color = switch (message_level) {
            .err => "\x1b[31m", // red
            .warn => "\x1b[33m", // yellow
            .info => "\x1b[32m", // green
            .debug => "",
        };

        const esp_level = switch (message_level) {
            .err => esp.ESP_LOG_ERROR,
            .warn => esp.ESP_LOG_WARN,
            .info => esp.ESP_LOG_INFO,
            .debug => esp.ESP_LOG_DEBUG,
        };

        const prefix = switch (message_level) {
            .err => "E",
            .warn => "W",
            .info => "I",
            .debug => "D",
        };

        const fmt = std.fmt.comptimePrint(color ++ prefix ++ " (%u): {s}\x1b[0m\n", .{format});
        const timestamp = esp.esp_log_timestamp();
        @call(.auto, esp.esp_log_write, .{ esp_level, @tagName(scope), fmt, timestamp } ++ args);
    }
};

const LED_GPIO_0: u32 = 11;

export fn app_main() void {
    _ = esp.gpio_reset_pin(LED_GPIO_0);
    _ = esp.gpio_set_direction(LED_GPIO_0, esp.GPIO_MODE_OUTPUT);

    const timer = esp.TimerConfig{
        .speed_mode = esp.LEDC_LOW_SPEED_MODE,
        .timer_num = esp.LEDC_TIMER_0,
        .duty_resolution = esp.LEDC_TIMER_13_BIT,
        .freq_hz = 440,
        .clk_cfg = esp.LEDC_AUTO_CLK,
    };
    _ = esp.ledc_timer_config(&timer);

    const c0 = esp.ChannelConfig{
        .gpio_num = LED_GPIO_0,
        .speed_mode = esp.LEDC_LOW_SPEED_MODE,
        .channel = esp.LEDC_CHANNEL_0,
        .intr_type = esp.LEDC_INTR_DISABLE,
        .timer_sel = esp.LEDC_TIMER_0,
        .duty = 0,
        .hpoint = 0,
        .flags = 0,
    };

    _ = esp.ledc_channel_config(&c0);

    while (true) {
        _ = esp.ledc_set_duty(esp.LEDC_LOW_SPEED_MODE, esp.LEDC_CHANNEL_0, 100 * 8191 / 100);
        _ = esp.ledc_update_duty(esp.LEDC_LOW_SPEED_MODE, esp.LEDC_CHANNEL_0);
        freertos.vTaskDelay(500 / freertos.portTICK_PERIOD_MS);
        _ = esp.ledc_set_duty(esp.LEDC_LOW_SPEED_MODE, esp.LEDC_CHANNEL_0, 20 * 8191 / 100);
        _ = esp.ledc_update_duty(esp.LEDC_LOW_SPEED_MODE, esp.LEDC_CHANNEL_0);
        freertos.vTaskDelay(500 / freertos.portTICK_PERIOD_MS);
    }
}
