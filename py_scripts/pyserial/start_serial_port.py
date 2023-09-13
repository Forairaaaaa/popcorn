import select
import sys
import argparse
import serial
import atexit
from threading import Thread
import time


# Get config 
parser = argparse.ArgumentParser()
parser.add_argument("-p", "--port", help="serial port name",
                    action='store', required=True)
parser.add_argument("-b", "--baudrate", help="baud rate",
                    action='store', default=115200)

# Prase 
args = parser.parse_args()
print('start serial port with:', args.port, args.baudrate)


# Use utf-8 
sys.stdout.reconfigure(encoding='utf-8')
sys.stdin.reconfigure(encoding='utf-8')
sys.stderr.reconfigure(encoding='utf-8')


# Set config 
ser = serial.Serial()
ser.port = args.port
ser.baudrate = args.baudrate


# Open port 
try:
    ser.open()
except serial.SerialException as e:
    sys.stderr.write('Could not open serial port {}: {}\n'.format(ser.name, e))
    sys.exit(1)


# Close serial port when exit 
@atexit.register
def onExit():
    global ser
    try:
        ser.close()
    except serial.SerialException as e:
        sys.stderr.write('Could not close serial port {}: {}\n'.format(ser.name, e))
        sys.exit(1)
    print('bye')



while True:
    # Redirect serial rx to stdout 
    if (ser.in_waiting):
        sys.stdout.buffer.write(ser.read())
        sys.stdout.flush()




    
