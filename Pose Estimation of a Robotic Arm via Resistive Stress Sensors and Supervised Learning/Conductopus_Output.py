from time import sleep
import serial
import csv

ser = serial.Serial( ’/dev/ttyACM0’, 9600) # Establish the connection on a specific port

fileName = ”data.csv ”
with open (fileName, ’wb’) as csvFile:
  write = csv.writer(csvFile)
  #Add locations to where resistor is
  write.writerow ([’Time(ms)’ , ’ Resistance1’ , ’Resistance2’ , ’Resistance3’ , ’Resistance 4‘, ‘Resistance 5’])

  counter = 32 # Below 32 everything in ASCII is gibberish
  while True :
    counter += 1
    ser.write(str(chr(counter))) 
    output = ser.readline()

    write.writerow(output.replace(”\r\n”,””).split(”,”))

    print ser.readline()
    # sleep(.1) # Delay for one tenth of a second
    if  counter == 255:
      counter = 32  


