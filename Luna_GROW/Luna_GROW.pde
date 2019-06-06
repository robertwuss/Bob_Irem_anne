import dynamixel.*;
import processing.serial.*;



int position = 2047;
// servo IDs to control
int[] servoIDs = {21, 22, 23, 14, 24, 25};
// servo instances
XH430[] servos = new XH430[servoIDs.length];

XH430 servo;
Serial port;





//import spout.*;

PGraphics pgr; // Canvas to receive a texture
PImage img; // Image to receive a texture

// DECLARE A SPOUT OBJECT
//Spout spout;

ArrayList history; 
IntList previousPosX;
IntList previousPosY;


float pos_Xo ;
float pos_Yo ;
float pos_Zo ;


float tobii_X;
float tobii_Y;
float tobii_Z;

int pos_Zo1;

boolean isTorqueOn = false;

float x ;
float y =0;
float z =0;
float easing = 0.03;

float xo ;
float yo = 0;
float zo = 0;
int laikaY= 3000;

Serial myPort;

int startTime;
float counter = .5;
int time = millis();

int tobii_prevX;
int tobii_prevY;

int angle = 0;



import gazetrack.*;

GazeTrack gazeTrack;


void setup() {
  background(255);
  size(1280, 720, P3D);
  //background(102);
  noStroke();
  fill(0, 102);
  smooth();
  history  = new ArrayList();
  previousPosX = new IntList();
  previousPosY = new IntList();

  gazeTrack = new GazeTrack(this);

  surface.setResizable(true);

  pgr = createGraphics(width, height, PConstants.P2D);
  img = createImage(width, height, ARGB);



  //spout = new Spout(this);

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


void draw() {
  //background(0);

  if (gazeTrack.gazePresent())
  {
    //ellipse(gazeTrack.getGazeX(), gazeTrack.getGazeY(), 80, 80);


    tobii_X = gazeTrack.getGazeX();
    tobii_Y = gazeTrack.getGazeY();
    tobii_Z = tobii_Y;
  }


  if (isTorqueOn) {
    rect(30, 20, 55, 55);
    fill(0, 255, 0);

    float targetX= tobii_X;
    float targetY = tobii_Y;
    float targetZ = tobii_Z;

    // println("tobbi y" +tobii_Y);

    float dx = targetX - x;
    x += (dx * .05);
    //println(x);
    pos_Xo = map(x, 100, 1600, (int)4300, (int)3200);
    int xo = round(pos_Xo);
    int xo_constrain = constrain(xo, 2500, 4200);
    //println("XO " +xo);


    float dy = targetY - y;
    y += dy * .02;
    //println(y);
    //pos_Yo = (int)constrain(map(y, 0, 800, 3800, 1800), (int) 3800,  (int)1800);
    //println(y);
    pos_Yo = map(y, 1400, 100, (int)300, (int)1200);
    int yo = round(pos_Yo);
    int yo_constrain = constrain(yo, 300, 1200);
    //println("YO " + yo);
    //  println(yo);



    float dz = targetZ - z;
    z += dz * easing;
    pos_Zo = map(y, 100, 1400, (int)300, (int)600);
    int zo = round(pos_Zo);
    // println("ZO "+ zo);

    int zo_constrain = constrain(zo, 300, 600);
    //println(zo);
    if (millis() >0) {


      println("X is " + xo);
     // println("Y is " + laikaY);
      println("Z is " + zo_constrain);
      
      int laikaY = int (map (yo_constrain, 1200,300, (int) 3000, (int)2100));
      println("Y is " + laikaY);

      servos[0].setGoalPosition(xo_constrain);
      servos[1].setGoalPosition(yo_constrain);
      servos[2].setGoalPosition(zo_constrain);
      //servos[3].setGoalPosition(xo_constrain);
      //servos[4].setGoalPosition(laikaY);
      //servos[5].setGoalPosition(zo_constrain);



      // ellipse(x, y, 20, 20);

      line(x, y, tobii_prevX, tobii_prevY);
      //stroke(random(100, 255), random(80, 255), random(70, 255), 200);
      stroke(0, 40);
      line(x, y, tobii_prevX, tobii_prevY);

      for (int j = 0; j < history.size(); j++) {
        PVector p = (PVector) history.get(j);
        float d = dist(x, y, p.x, p.y);
        // Adjust the stroke weight according to the distance
        strokeWeight(25/d);

        // Draw a line from the current mouse point to 
        // the historical point if the distance is less
        // than 25
        if (d < 25) {
          if (random(10) < 5) // Skip some lines randomly
            line(x, y, p.x + 2, p.y + 2);
        }
      }

      history.add(new PVector(x, y));
      strokeWeight(0.2);
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
    pos_Xo = map(x, 0, 800, (int)4000, (int)2500);
    int xo = round(pos_Xo);
    //println("XO " +xo);


    float dy = targetY - y;
    y += dy * easing;
    //println(y);
    pos_Yo = map(y, 800, 0, (int)1200, (int)300);
    int yo = round(pos_Yo);
    int yo_constrain = constrain(yo, 1200, 300);
    //println("YO " + yo);
    //println(yo);



    float dz = targetZ - z;
    z += dz * easing;
    int pos_Zo = int (map(y, 0, 800, (int)300, (int)600));
    int zo = round(pos_Zo);
    println("ZO "+ pos_Zo);
    
    
int laikaY = int (map (yo, 1200,300, (int) 3000, (int)2100));
println("laika " +laikaY);




    servos[0].setGoalPosition(xo);
   servos[1].setGoalPosition(yo);
    servos[2].setGoalPosition(pos_Zo);
    //servos[3].setGoalPosition(xo);
    //servos[4].setGoalPosition(laikaY);
    //servos[5].setGoalPosition(pos_Zo);

    //ellipse(x, y, 20, 20);



    line(mouseX, mouseY, pmouseX, pmouseY);
    //stroke(random(100, 255), random(80, 255), random(70, 255), 200);
    stroke(0, 20);
    line(mouseX, mouseY, pmouseX, pmouseY);

    for (int j = 0; j < history.size(); j++) {
      PVector p = (PVector) history.get(j);
      float d = dist(mouseX, mouseY, p.x, p.y);
      // Adjust the stroke weight according to the distance
      strokeWeight(25/d);

      // Draw a line from the current mouse point to 
      // the historical point if the distance is less
      // than 25
      if (d < 80) {
        if (random(10) < 5) // Skip some lines randomly
          line(mouseX, mouseY, p.x + 2, p.y + 2);
      }
    }

    history.add(new PVector(mouseX, mouseY));
    strokeWeight(1);
  }





  tobii_prevX = (int) x;
  tobii_prevY= (int) y;
}







void mousePressed() {
  // toggle troque value
  isTorqueOn = !isTorqueOn;
  // if the serial port was initialised
  if (port != null) {
  }
}

void keyPressed() {

  background (255);
}
