/*
*  Developed by George Profenza for 
*  the Interactive Architecture Lab RS201 DynamixelWorkshop 
*  by Jessica In and Sean Malikides
*  
*  The Bartlett School of Architecture, UCL
*
*  Have fun! 
*  Stay safe, don't break Sean's acrylics!
*/

import dynamixel.*;
import processing.serial.*;

XH430 servo;
Serial port;

boolean isTorqueOn = false;

void setup(){
  size(300,300);
  // try open to open serial port 
  try{
    // print serial ports
    println(Serial.list());
    // initialize the serial port using the port name (e.g. /dev/tty.usbserial* on OSX, COM# on Windows, etc.) 
    // and baud rate (1M in this case)
    port  = new Serial(this,"/dev/tty.usbserial-FT2GZFM6",1000000);
    // initialize a servo using this serial port and the servo ID
    servo = new XH430(port,9); 
  }
  // handle any error (e.g. port is not connected to computer, busy (used by another software), etc.
  catch(Exception e){
    println("error opening serial port: " + e.getMessage());
    // print the error details
    e.printStackTrace();
  }
}

void draw(){
  if(isTorqueOn){
    background(0,192,0);
  }else{
    background(0);
  }
  text("click to toggle torque",10,15);
}

void mousePressed(){
  // toggle troque value
  isTorqueOn = !isTorqueOn;
  // if the serial port was initialised
  if(port != null){
    // control the torque
    servo.setTorque(isTorqueOn);  
  }
}
