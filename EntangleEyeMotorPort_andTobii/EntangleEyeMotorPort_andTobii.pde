import netP5.*;
import oscP5.*;

import gazetrack.*;
GazeTrack gazeTrack;


import dynamixel.*;
import processing.serial.*;

OscP5 oscP5;
NetAddress myRemoteLocation;


// servo IDs to control
int[] servoIDs = {21, 24, 25, 14, 22, 23};

int numServos = 6;
// servo instances
XH430[] servos = new XH430[numServos];

XH430 servo;
Serial port;

int robot1_pos_Xo ;
int robot1_pos_Yo ;
int robot1_pos_Zo ;

int robot2_pos_Xo ;
int robot2_pos_Yo ;
int robot2_pos_Zo ;

boolean isTorqueOn = true;
boolean wasPresent = false;

Serial myPort;

void setup() {
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 10000);
  background(255);
  size(1280, 720);
  
  gazeTrack = new GazeTrack(this);
  

  
  try {

    //println(Serial.list());
    port  = new Serial(this, "COM14", 1000000);
    // initialize servo using this serial port and the servo ID
    for (int i = 0; i < numServos; i++) {
      XH430 servo = new XH430(port, servoIDs[i]);
      servo.setTorque(true);
      servos[i] = servo;
    }
    
  }

  catch(Exception e) {
    println("error opening serial port: " + e.getMessage());
    // print the error details
    e.printStackTrace();
  }
}

void draw() {
  background(255);
  
  //check presence
  if(gazeTrack.gazePresent() && !wasPresent){
    
    // send OSC messaage only once
    oscP5.send(new OscMessage("/presence").add(1), myRemoteLocation); 
    println("from no presence to presence");
    wasPresent = true;
  }
  
  if(!gazeTrack.gazePresent() && wasPresent){
    
    oscP5.send(new OscMessage("/presence").add(0), myRemoteLocation);
    println("from presence to no presence");
    wasPresent = false; 
  }
  
   OscMessage myMessage = new OscMessage("/eyePosXY");
  
  myMessage.add(gazeTrack.getGazeX());
  myMessage.add(gazeTrack.getGazeY());
  //println(gazeTrack.getGazeX());

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation); 
}

  void oscEvent(OscMessage theOscMessage) {

    if (theOscMessage.addrPattern().equals("/robot1_pos_Xo")) {
      robot1_pos_Xo = theOscMessage.get(0).intValue();
      //println("xo " +robot1_pos_Xo);

      println (robot1_pos_Xo);
      //servos[0].setGoalPosition(robot1_pos_Xo);
    }

    if (theOscMessage.addrPattern().equals("/robot1_pos_Yo")) {
      robot1_pos_Yo = theOscMessage.get(0).intValue();
      println("yo " + robot1_pos_Yo);
      // servos[1].setTorque(true);
      servos[1].setGoalPosition(robot1_pos_Yo);
    }

    if (theOscMessage.addrPattern().equals("/robot1_pos_Zo")) {
      robot1_pos_Zo = theOscMessage.get(0).intValue();
      servos[2].setGoalPosition(robot1_pos_Zo);
      //println("zo " + robot1_pos_Zo);
    }

    if (theOscMessage.addrPattern().equals("/robot2_pos_Xo")) {
      robot2_pos_Xo = theOscMessage.get(0).intValue();
      println("xo2 " +robot2_pos_Xo);
      servos[3].setGoalPosition(robot2_pos_Xo);
    }

    if (theOscMessage.addrPattern().equals("/robot2_pos_Yo")) {
      robot2_pos_Yo = theOscMessage.get(0).intValue();
      println("yo2 " + robot2_pos_Yo);
      servos[4].setGoalPosition(robot2_pos_Yo);
    }

    if (theOscMessage.addrPattern().equals("/robot2_pos_Zo")) {
      robot2_pos_Zo = theOscMessage.get(0).intValue();
      println("zo2 " + robot2_pos_Zo);
      servos[5].setGoalPosition(robot2_pos_Xo);
    }
  }
