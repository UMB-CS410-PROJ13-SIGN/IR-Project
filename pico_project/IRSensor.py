def main():
    import time
    from machine import Pin
    led = Pin(16, Pin.OUT) # Output signal to the IR LED
    sensor = Pin(0,Pin.IN) # Input signal from the IR receiver
    received = False

    led.value(1)
    for i in range(100):
        print("Emitting...")
        time.sleep(.1)
        if sensor.value() == 0: # The sensor returns 0 when an IR signal is received
            received = True
            print("Signal Received")
            break

    led.value(0)
    if received == False: # If no signal was received
        print("No Signal Detected")


    import sys
    shouldRun = str(input('Send? (y/n): ')).lower()
    if shouldRun != 'y':
        sys.exit(1)
    del sys

    from lib.at_client.io_util import read_settings
    ssid, password, atSign = read_settings()
    del read_settings

    print('Connecting to WiFi %s...' % ssid)
    from lib.wifi import init_wlan
    init_wlan(ssid, password)
    del ssid, password, init_wlan

    from lib.at_client.at_client import AtClient
    atClient = AtClient(atSign)
    del AtClient
    atClient.pkam_authenticate(verbose=True)    

    atClient.put_public('IR', str(received))

    print('Value has been sent')


if __name__ == '__main__':
    main()
