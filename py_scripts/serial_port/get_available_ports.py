from serial.tools.list_ports import comports
import sys

portList = ''
for port in comports():
    portList += port.name + ','

# Get rid of last ','
portList = portList[0:-1]

# Output ports without new line 
sys.stdout.write(portList)
# print(portList)
