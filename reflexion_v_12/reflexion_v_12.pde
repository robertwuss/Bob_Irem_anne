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

import processing.video.*;

Capture cam;



float pos_Xo ;
float pos_Yo ;
float pos_Zo ;


float tobii_X;
float tobii_Y;
float tobii_Z;

int pos_Zo1;

boolean isTorqueOn = false;

float x = 1500;
float y = 2010;
float z = 1800;
float easing = 0.05;

float xo = 1500;
float yo = 1500;
float zo = 1800;

Serial myPort;

int startTime;
float counter = .5;
int time = millis();

int angle = 0;

void setup() {
  size(1920, 1080);
  //background(102);
  noStroke();
  fill(0, 102);

  float xo = 1500;
  float yo = 2010;
  float zo = 1800;

  String[] cameras = Capture.list();

  cam = new Capture(this, cameras[0]);
  cam.start();


  udp = new UDP( this, 8888 );
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
  data = subset(data, 0, data.length-2);
  String message = new String( data );
  float[] list = float (split(message, ','));
  //println( list[0]);

  tobii_X = map(list[0], -20, 20, 0, 800);
  ////println(pos_Xi);
  float tobii_Yi = constrain(list[1], -5, 10);
  tobii_Y = map(tobii_Yi, -5, 10, 800, 0);


  tobii_Z = tobii_Y;
  //println(pos_Yi);

  //println( tobii_X );
  println( tobii_Y);
  // println(tobii_Z);
}




void draw() {
  background(100, 100, 100);

  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0, width, height);


if (isTorqueOn) {
  rect(30, 20, 55, 55);
  fill(0, 255, 0);

  float targetX= tobii_X;
  float targetY = tobii_Y;
  float targetZ = tobii_Z;

  float dx = targetX - x;
  x += dx * easing;
  //println(x);
  pos_Xo = map(x, 0, 800, (int)3800, (int)2000);
  int xo = round(pos_Xo);
  //println("XO " +xo);


  float dy = targetY - y;
  y += dy * easing;
  //println(y);
  pos_Yo = map(y, 0, 800, (int)2800, (int)1800);
  int yo = round(pos_Yo);
  //println("YO " + yo);


  float dz = targetZ - z;
  z += dz * easing;
  pos_Zo = map(y, 0, 800, (int)1750, (int)2200);
  int zo = round(pos_Zo);
  //println("ZO "+ zo);
  if (millis() >3000) {

    //servos[0].setGoalPosition(xo);
    //servos[1].setGoalPosition(yo);
    //servos[2].setGoalPosition(zo);

    ellipse(x, y, 20, 20);
  }
} else {



  rect(30, 20, 55, 55);
  fill(100, 100, 200);
  text("click to toggle torque", 10, 15);
  //println(mouseY);


  float targetX= mouseX;
  float targetY = mouseY;
  float targetZ = mouseY;

  float dx = targetX - x;
  x += dx * easing;
  //println(x);
  pos_Xo = map(x, 0, 800, (int)3800, (int)2000);
  int xo = round(pos_Xo);
  //println("XO " +xo);


  float dy = targetY - y;
  y += dy * easing;
  //println(y);
  pos_Yo = map(y, 0, 800, (int)2800, (int)1800);
  int yo = round(pos_Yo);
  //println("YO " + yo);


  float dz = targetZ - z;
  z += dz * easing;
  pos_Zo = map(y, 0, 800, (int)1750, (int)2200);
  int zo = round(pos_Zo);
  //println("ZO "+ zo);
  if (millis() >3000) {

    //servos[0].setGoalPosition(xo);
    //servos[1].setGoalPosition(yo);
    //servos[2].setGoalPosition(zo);

    ellipse(x, y, 20, 20);
    line(mouseX, mouseY, pmouseX, pmouseY);
  }
}

}







void mousePressed() {
  // toggle troque value
  isTorqueOn = !isTorqueOn;
  // if the serial port was initialised
  if (port != null) {
  }
}
