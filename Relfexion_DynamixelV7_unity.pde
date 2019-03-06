
import dynamixel.*;
import processing.serial.*;

import hypermedia.net.*;
UDP udp;

int position = 2047;
// servo IDs to control
int[] servoIDs = {21, 22, 23};
// servo instances
XH430[] servos = new XH430[servoIDs.length];

XH430 servo;
Serial port;

float posX = 2500;
float posY = 2500;
float posJaw;
int prevpos_X;
int pos_Xo = 1800;
int pos_Yo = 2990;
int zo= 1800;
int pos_Zo = 0;

float pos_Xi =1800;
float pos_Yi = 3000;

int s1;
int s2;
int s3;


boolean first_Iteration = true;

boolean isTorqueOn = false;



Serial myPort;


Table table;
Table loadtable;

void setup() {
  size(400, 400);
  frameRate(60);


 udp = new UDP( this, 8888 );
  //udp.log( true );     // <-- printout the connection activity
  udp.listen( true );



  try {

    println(Serial.list());
    port  = new Serial(this, "COM4", 1000000);
    // initialize servo using this serial port and the servo ID
    for (int i = 0; i < servoIDs.length; i++) {
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


void receive( byte[] data, String ip, int port ) {  // <-- extended handler
  
  
  // get the "real" message =
  // forget the ";\n" at the end <-- !!! only for a communication with Pd !!!
  data = subset(data, 0, data.length-2);
  String message = new String( data );
  float[] list = float (split(message, ','));
  //println( list[0]);
    
    pos_Xi = map(list[0], 20, -20, 3000, 1800);
  //println(pos_Xi);
    pos_Yi = map(list[1], -20, 20, 3000, 2500);
    //println(pos_Yi);
  }




void draw() {

  if (isTorqueOn) {
    rect(30, 20, 55, 55);
    fill(0, 255, 0);
  } else {
    rect(30, 20, 55, 55);
    fill(255, 0, 0);
    text("click to toggle torque", 10, 15);
    pos_Xi = map(mouseX, 400, 0, 3500, 1350);
    pos_Yi = map(mouseY, 0, 400, 3000, 2500);
    //println(pos_Xi);
   // println(pos_Yi);
   
  }



  int damping = 4;
  float maxMove = 3;
  pos_Xo = int(pos_Xo + constrain((pos_Xi - pos_Xo)/damping, -maxMove, maxMove));
  pos_Yo = constrain (int(pos_Yo + constrain((pos_Yi - pos_Yo)/damping, -maxMove, maxMove)), 2500, 3000) ;
 zo= (3700 - (int) map(pos_Yo, 3000, 2500, 1900, 1500));


  servos[0].setGoalPosition(pos_Xo);
  servos[1].setGoalPosition(pos_Yo);
  servos[2].setGoalPosition(zo);
  
  //println("Zo is ", zo);
  println(  "Yo is ", pos_Yo);
  println( "Xo is ", pos_Xo);
  //println("POS_ZO is ", pos_Zo);


  int xo = (int) map(pos_Xo, 0, 4000, 0, 400);   
  int yo = (int) map(pos_Yo, 3000, 0, 0, 400);
  //println(xo);
  //println(yo);
  ellipse(map(xo, 0, 400, 0, 400), map(yo, 0, 400, 0, 400), 20, 20);
}


void mousePressed() {
  // toggle troque value
  isTorqueOn = !isTorqueOn;
  // if the serial port was initialised
  if (port != null) {



    //      servos[0].setTorque(isTorqueOn);
    //      servos[1].setTorque(isTorqueOn);
    //      servos[2].setTorque(isTorqueOn);
  }
}
