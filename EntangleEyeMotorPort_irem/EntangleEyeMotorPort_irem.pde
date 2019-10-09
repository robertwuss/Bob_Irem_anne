import netP5.*;
import oscP5.*;

import dynamixel.*;
import processing.serial.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

Serial port;
// servo IDs to control


//int [] robot1_Servos = {21, 24, 25}; 


int[] servoIDs = {21, 24, 25};
int numServos = 3;
XH430[] servos = new XH430[numServos];
//XH430 servo;

int robot1_pos_Xo ;
int robot1_pos_Yo ;
int robot1_pos_Zo ;

int robot2_pos_Xo ;
int robot2_pos_Yo ;
int robot2_pos_Zo ;


boolean isTorqueOn = true;

void setup() {
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 12000);

  background(255);
  size(1280, 720);
  
  

  try {

    //println(Serial.list());
    port  = new Serial(this, "COM14", 115200);
    // initialize servo using this serial port and the servo ID
    for (int i = 0; i < numServos; i++) {
    XH430 servo = new XH430(port, servoIDs[i]);

      servos[2] = servo;
      servo.setTorque(true);
   
    }

  }

  catch(Exception e) {
    println("error opening serial port: " + e.getMessage());
    // print the error details
    e.printStackTrace();
  }
}


void draw() {
  background(0);
}

//  if (isTorqueOn) {

//    //servos[0].setGoalPosition(robot1_pos_Xo);
//    //println(robot1_pos_Xo);
//    //servos[1].setGoalPosition(robot1_pos_Yo);
//    //servos[2].setGoalPosition(robot1_pos_Zo);
//    //servos[3].setGoalPosition(robot2_pos_Xo);
//    //servos[4].setGoalPosition(robot2_pos_Yo);
//    //servos[5].setGoalPosition(robot2_pos_Zo);
//  }
//}


void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  //print("### received an osc message.");
  //print(" addrpattern: "+theOscMessage.addrPattern());
  // println(" typetag: "+theOscMessage.typetag());

  if (theOscMessage.addrPattern().equals("/robot1_pos_Xo")) {
    robot1_pos_Xo = theOscMessage.get(0).intValue();
    //println("xo " +robot1_pos_Xo);

    //println (robot1_pos_Xo);
   // servos[0].setGoalPosition(robot1_pos_Xo);
  }

  if (theOscMessage.addrPattern().equals("/robot1_pos_Yo")) {
    robot1_pos_Yo = theOscMessage.get(0).intValue();
    //println("yo " + robot1_pos_Yo);
    // servos[1].setTorque(true);
    //servos[1].setGoalPosition(robot1_pos_Yo);
  }

  if (theOscMessage.addrPattern().equals("/robot1_pos_Zo")) {
    robot1_pos_Zo = theOscMessage.get(0).intValue();
    //servos[2].setGoalPosition(robot1_pos_Zo);
    //println("zo " + robot1_pos_Zo);
  }

  if (theOscMessage.addrPattern().equals("/robot2_pos_Xo")) {
    robot2_pos_Xo = theOscMessage.get(0).intValue();
    //println("xo2 " +robot2_pos_Xo);
  }

  if (theOscMessage.addrPattern().equals("/robot2_pos_Yo")) {
    robot2_pos_Yo = theOscMessage.get(0).intValue();
    //println("yo2 " + robot2_pos_Yo);
  }

  if (theOscMessage.addrPattern().equals("/robot2_pos_Zo")) {
    robot2_pos_Zo = theOscMessage.get(0).intValue();
    //println("zo2 " + robot2_pos_Zo);
  }
}
