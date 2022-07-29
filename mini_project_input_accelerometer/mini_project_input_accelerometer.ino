// Watch video here: https://www.youtube.com/watch?v=omZ538TElCU
 
/* Accelerometer connection pins (I2C) to Arduino are shown below:

Arduino     Accelerometer ADXL345
  A5            SCL
  A4            SDA
  3.3V          CS
  3.3V          VCC
  GND           GND
*/ 

#include <Wire.h>
#include <ADXL345.h>


ADXL345 adxl; //variable adxl is an instance of the ADXL345 library

int x,y,z;  
int rawX, rawY, rawZ;
float X, Y, Z;
float rollrad, pitchrad;
float rolldeg, pitchdeg;

void setup(){
   pinMode(8, OUTPUT); 
   pinMode(9, OUTPUT); 
   pinMode(10, OUTPUT); 
   pinMode(11, OUTPUT); 
}

void loop(){
     digitalWrite(8,HIGH);
     digitalWrite(9,LOW);
     digitalWrite(10,HIGH);
     digitalWrite(11,HIGH);
}
