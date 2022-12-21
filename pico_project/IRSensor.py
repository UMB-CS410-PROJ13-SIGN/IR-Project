
#Author: Adam D'Ambrosio
#Date: 12/21/2022
#
#The following code is intended for use with a Raspberry Pi Pico W
#that passes the provided tests 1-5. It outputs a signal through pin
#16 and receives a signal through pin 0. Running the code will power an
#IR LED for ten seconds. If the IR sensor receives a signal the program
#will cease and a "true" value will be generated. If no signal is detected
#within ten seconds a "false" value will be generated. The terminal will
#then display a prompt asking if the user would like to send the value to
#the atsign server. Typing 'y' will send the value.


def main():
    import time
    from machine import Pin
    led = Pin(16, Pin.OUT) # Output signal to the IR LED
    sensor = Pin(0,Pin.IN) # Input signal from the IR receiver
    received = False # Value defaults to false

    led.value(1)
    for i in range(100): # Program runs for about ten seconds
        print("Emitting...")
        time.sleep(.1)
        if sensor.value() == 0: # The sensor returns 0 when an IR signal is received
            received = True # Set value to true
            print("Signal Received")
            break

    led.value(0)
    if received == False: # If no signal was received
        print("No Signal Detected")


    import sys
    shouldRun = str(input('Send? (y/n): ')).lower() # Option to send the value to the atsign server
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

    atClient.put_public('ir', str(received), -1, 'IR')

    print('Value has been sent')


if __name__ == '__main__':
    main()
