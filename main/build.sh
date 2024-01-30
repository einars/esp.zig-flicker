#!/bin/sh

set -o pipefail -o errexit -o nounset

/usr/bin/zig build-lib \
  /proj/esph2/zig-flicker/main/src/main.zig \
  --cache-dir /proj/esph2/zig-flicker/build/esp-idf/main/zig-cache \
  --global-cache-dir /home/e/.cache/zig \
  --name zig \
  -static -target riscv32-freestanding-none \
  -mcpu generic_rv32+c+m \
  -I /proj/esph2/zig-flicker/build/config -I /proj/esph2/zig-flicker/main -I /proj/esph2/zig-flicker/build/config -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/newlib/platform_include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/freertos/FreeRTOS-Kernel/include -I /opt/esp-idf/components/freertos/FreeRTOS-Kernel/portable/riscv/include -I /opt/esp-idf/components/freertos/esp_additions/include/freertos -I /opt/esp-idf/components/freertos/esp_additions/include -I /opt/esp-idf/components/freertos/esp_additions/arch/riscv/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/esp_hw_support/include -I /opt/esp-idf/components/esp_hw_support/include/soc -I /opt/esp-idf/components/esp_hw_support/include/soc/esp32h2 -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/esp_hw_support/port/esp32h2 -I /opt/esp-idf/components/esp_hw_support/port/esp32h2/private_include -I /opt/esp-idf/components/heap/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/log/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/soc/include -I /opt/esp-idf/components/soc/esp32h2 -I /opt/esp-idf/components/soc/esp32h2/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/hal/esp32h2/include -I /opt/esp-idf/components/hal/include -I /opt/esp-idf/components/hal/platform_port/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/esp_rom/include -I /opt/esp-idf/components/esp_rom/include/esp32h2 -I /opt/esp-idf/components/esp_rom/esp32h2 -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/esp_common/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/esp_system/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/esp_system/port/soc -I /opt/esp-idf/components/esp_system/port/include/riscv -I /opt/esp-idf/components/esp_system/port/include/private -I /opt/esp-idf/components/riscv/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/lwip/include -I /opt/esp-idf/components/lwip/include/apps -I /opt/esp-idf/components/lwip/include/apps/sntp -I /opt/esp-idf/components/lwip/lwip/src/include -I /opt/esp-idf/components/lwip/port/include -I /opt/esp-idf/components/lwip/port/freertos/include -I /opt/esp-idf/components/lwip/port/esp32xx/include -I /opt/esp-idf/components/lwip/port/esp32xx/include/arch -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/esp_ringbuf/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/efuse/include -I /opt/esp-idf/components/efuse/esp32h2/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/driver/include -I /opt/esp-idf/components/driver/deprecated -I /opt/esp-idf/components/driver/analog_comparator/include -I /opt/esp-idf/components/driver/dac/include -I /opt/esp-idf/components/driver/gpio/include -I /opt/esp-idf/components/driver/gptimer/include -I /opt/esp-idf/components/driver/i2c/include -I /opt/esp-idf/components/driver/i2s/include -I /opt/esp-idf/components/driver/ledc/include -I /opt/esp-idf/components/driver/mcpwm/include -I /opt/esp-idf/components/driver/parlio/include -I /opt/esp-idf/components/driver/pcnt/include -I /opt/esp-idf/components/driver/rmt/include -I /opt/esp-idf/components/driver/sdio_slave/include -I /opt/esp-idf/components/driver/sdmmc/include -I /opt/esp-idf/components/driver/sigma_delta/include -I /opt/esp-idf/components/driver/spi/include -I /opt/esp-idf/components/driver/temperature_sensor/include -I /opt/esp-idf/components/driver/touch_sensor/include -I /opt/esp-idf/components/driver/twai/include -I /opt/esp-idf/components/driver/uart/include -I /opt/esp-idf/components/driver/usb_serial_jtag/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/esp_pm/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/mbedtls/port/include -I /opt/esp-idf/components/mbedtls/mbedtls/include -I /opt/esp-idf/components/mbedtls/mbedtls/library -I /opt/esp-idf/components/mbedtls/esp_crt_bundle/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/mbedtls/mbedtls/include -I /opt/esp-idf/components/mbedtls/mbedtls/include -I /opt/esp-idf/components/mbedtls/mbedtls/include -I /opt/esp-idf/components/mbedtls/mbedtls/3rdparty/everest/include -I /opt/esp-idf/components/mbedtls/mbedtls/include -I /opt/esp-idf/components/mbedtls/mbedtls/3rdparty/p256-m -I /opt/esp-idf/components/mbedtls/mbedtls/3rdparty/p256-m/p256-m -I /opt/esp-idf/components/mbedtls/mbedtls/include -I /opt/esp-idf/components/esp_app_format/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/bootloader_support/include -I /opt/esp-idf/components/bootloader_support/bootloader_flash/include -I /proj/esph2/zig-flicker/build/config -I /proj/esph2/zig-flicker/build/config -I /proj/esph2/zig-flicker/build/config -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/esp_partition/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/app_update/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/esp_mm/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/spi_flash/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/pthread/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/esp_timer/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/app_trace/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/esp_event/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/nvs_flash/include -I /opt/esp-idf/components/spi_flash/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/esp_phy/include -I /opt/esp-idf/components/esp_phy/esp32h2/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/vfs/include -I /proj/esph2/zig-flicker/build/config -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/esp_netif/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/wpa_supplicant/include -I /opt/esp-idf/components/wpa_supplicant/port/include -I /opt/esp-idf/components/wpa_supplicant/esp_supplicant/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/esp_coex/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/esp_wifi/include -I /opt/esp-idf/components/esp_wifi/wifi_apps/include -I /proj/esph2/zig-flicker/build/config -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/unity/include -I /opt/esp-idf/components/unity/unity/src -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/cmock/CMock/src -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/console -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/http_parser -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/esp-tls -I /opt/esp-idf/components/esp-tls/esp-tls-crypto -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/esp_adc/include -I /opt/esp-idf/components/esp_adc/interface -I /opt/esp-idf/components/esp_adc/esp32h2/include -I /opt/esp-idf/components/esp_adc/deprecated/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/esp_eth/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/esp_gdbstub/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/esp_hid/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/tcp_transport/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/esp_http_client/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/esp_http_server/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/esp_https_ota/include -I /proj/esph2/zig-flicker/build/config -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/esp_psram/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/esp_lcd/include -I /opt/esp-idf/components/esp_lcd/interface -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/protobuf-c/protobuf-c -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/protocomm/include/common -I /opt/esp-idf/components/protocomm/include/security -I /opt/esp-idf/components/protocomm/include/transports -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/esp_local_ctrl/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/espcoredump/include -I /opt/esp-idf/components/espcoredump/include/port/riscv -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/wear_levelling/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/sdmmc/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/fatfs/diskio -I /opt/esp-idf/components/fatfs/vfs -I /opt/esp-idf/components/fatfs/src -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/idf_test/include -I /opt/esp-idf/components/idf_test/include/esp32h2 -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/ieee802154/include -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/json/cJSON -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/mqtt/esp-mqtt/include -I /proj/esph2/zig-flicker/build/config -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/spiffs/include -I /proj/esph2/zig-flicker/build/config -I /proj/esph2/zig-flicker/build/config -I /proj/esph2/zig-flicker/build/config -I /opt/esp-idf/components/wifi_provisioning/include -I /proj/esph2/zig-flicker/build/config -I /home/e/.espressif/tools/riscv32-esp-elf/esp-12.2.0_20230208/riscv32-esp-elf/lib/gcc/riscv32-esp-elf/12.2.0/include -I /home/e/.espressif/tools/riscv32-esp-elf/esp-12.2.0_20230208/riscv32-esp-elf/lib/gcc/riscv32-esp-elf/12.2.0/include-fixed -I /home/e/.espressif/tools/riscv32-esp-elf/esp-12.2.0_20230208/riscv32-esp-elf/riscv32-esp-elf/sys-include -I /home/e/.espressif/tools/riscv32-esp-elf/esp-12.2.0_20230208/riscv32-esp-elf/riscv32-esp-elf/include
