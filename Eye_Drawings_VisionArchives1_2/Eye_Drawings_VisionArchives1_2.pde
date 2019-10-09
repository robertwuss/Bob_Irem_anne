

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

ArrayList history; 



float leftEyeX = 0;
float leftEyeY= 0;



void setup() {
  background(0);
  size(1920, 1020);
  history  = new ArrayList();


 

  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 12000);
}


void draw() {
 
  float x = map(leftEyeX, 0.1,0.8,1920,0);
    float y = map(leftEyeY, -.1,1, 0, 1020);
    for (int i = 0; i < history.size(); i++) {
      PVector p = (PVector) history.get(i);
      float d = dist(x, y, p.x, p.y);

      stroke (255,30);
      strokeWeight(25/d);

      if (d < 100) {
        //if (random(10) < 5) // Skip some lines randomly
          line(x, y, p.x + 2, p.y + 2);
      }
    }
    history.add(new PVector(x, y));
    //strokeWeight(2.6);

    //println(x, y);
  }
 






void oscEvent(OscMessage theOscMessage) {

  if (theOscMessage.addrPattern().equals("/leftEye/coord")) {

    float leftX= theOscMessage.get(0).floatValue();
    float leftY= theOscMessage.get(1).floatValue(); 
    
    leftEyeX = leftX;
    leftEyeY = leftY;


    println(leftX, leftY);
  }

  if (theOscMessage.addrPattern().equals("/rightEye/coord")) {
    float rightX= theOscMessage.get(0).floatValue();
    float rightY= theOscMessage.get(1).floatValue();

  }
}
