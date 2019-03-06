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

// default servo position: move up
int position = 2047;
// servo IDs to control
int[] servoIDs = {6,15,16,20,13,9};
// servo instances
XH430[] servos = new XH430[servoIDs.length];

void setup(){
  size(300,300);
  // try open to open serial port 
  try{
    // print serial ports
    println(Serial.list());
    // initialize the serial port using the port name (e.g. /dev/tty.usbserial* on OSX, COM# on Windows, etc.) 
    // and baud rate (1M in this case)
    port  = new Serial(this,"/dev/tty.usbserial-FT2GZFM6",1000000);
    // initialize servo using this serial port and the servo ID
    for(int i = 0 ; i < servoIDs.length; i++){
      XH430 servo = new XH430(port,servoIDs[i]);
      // enable torque
      servo.setTorque(true);
      // set default position
      servo.setGoalPosition(position);
      // update the array with the servo reference
      servos[i] = servo;
    }
  }
  // handle any error (e.g. port is not connected to computer, busy (used by another software), etc.
  catch(Exception e){
    println("error opening serial port: " + e.getMessage());
    // print the error details
    e.printStackTrace();
  }
}

void draw(){
  background(0);
  text("click and drag to control servo position: " + position,10,15);
}

void mouseDragged(){
  // map and constrain mouse X position to servo position
  // notice the servo positions are from a high value to a low value
  // when looking at the horn the servo position increase in counter clock-wise order
  position = (int)map(constrain(mouseX,0,width),0,width,2297,1808);
  // if the serial port was initialised
  if(port != null){
    // for each servo
    for(int i = 0 ; i < servos.length; i++){
      // set the position
      servos[i].setGoalPosition(position);
    }
  }
}