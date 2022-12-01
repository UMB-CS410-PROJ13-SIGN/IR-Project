def main():
    import time
    from machine import Pin
    led = Pin(16, Pin.OUT)
    sensor = Pin(0,Pin.IN)
    received = False

    led.value(1)
    for i in range(100):
        print("Emitting...")
        time.sleep(.1)
        if sensor.value() == 0:
            received = True
            print("Signal Received")
            break

    led.value(0)
    if received == False:
        print("No Signal Detected")
    return received


if __name__ == '__main__':
    main()