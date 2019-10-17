

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

ArrayList history; 

float leftEyeX = 0;
float leftEyeY= 0;

Eyedrawing eyedrawing;
//Eyerobot eyerobot;

void setup() {
  background(0);
  size(1920, 1020);
  history  = new ArrayList();
  eyedrawing = new Eyedrawing();
  //eyerobot = new Eyerobot();

  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 12000);
  // setup servos and robot(s)
  setupServos();
  setupBehaviors();
  setupTable();
  
}


void draw() {
  eyedrawing.draw();
  //eyerobot.update();
  behavior1.update();
  drawTable();
  //behvaior2.update();
}
