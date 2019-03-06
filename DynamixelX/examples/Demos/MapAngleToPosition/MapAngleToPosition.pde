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
// angle in degrees
float degrees = 90.0;

void setup(){
  size(300,300);
  noFill();
  stroke(255);
  strokeWeight(3);
  // try open to open serial port 
  try{
    // print serial ports
    println(Serial.list());
    // initialize the serial port using the port name (e.g. /dev/tty.usbserial* on OSX, COM# on Windows, etc.) 
    // and baud rate (1M in this case)
    port  = new Serial(this,"/dev/tty.usbserial-FT2GZFM6",1000000);
    // initialize a servo using this serial port and the servo ID
    servo = new XH430(port,9);
    // enable torque
    servo.setTorque(true);
    // set default position
    servo.setGoalPosition(position);
  }
  // handle any error (e.g. port is not connected to computer, busy (used by another software), etc.
  catch(Exception e){
    println("error opening serial port: " + e.getMessage());
    // print the error details
    e.printStackTrace();
  }
  println(XH430.degreesToPosition(68));
  println(XH430.degreesToPosition(111));
}

void draw(){
  background(0);
  text("click and drag -> angle: " + degrees + " position: " + position,10,15);
  // preview rotation
  pushMatrix();
  translate(width * 0.5, height * 0.5);
  rotate(radians(degrees));
  float radius = 120;
  line(-radius,0,0,0);
  ellipse(0,0,radius * 2, radius * 2);
  popMatrix();
}

void mouseDragged(){
  // map mouse X to degrees
  degrees = map(constrain(mouseX,0,width),0,width,0,180);
  // further constrain degrees to a smaller range taking into account potential servo attachment
  degrees = constrain(degrees,68,111);
  // map degrees to servo position
  position = XH430.degreesToPosition(degrees);
  // if the serial port was initialised
  if(port != null){
    // set the position
    servo.setGoalPosition(position);
  }
}
