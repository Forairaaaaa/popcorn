from serial.tools.list_ports import comports
import sys
import argparse


# -d to get descriptions
parser = argparse.ArgumentParser()
parser.add_argument("-d", "--desc", help="port description",
                    action='store_true')
args = parser.parse_args()


portList = ''
for port in comports():
    if args.desc == True:
        portList += port.description + ','
    else:
        portList += port.name + ','

# Get rid of last ','
portList = portList[0:-1]

# For dart decode 
sys.stdout.reconfigure(encoding='utf-8')

# Output ports without new line
sys.stdout.write(portList)
# print(portList)
