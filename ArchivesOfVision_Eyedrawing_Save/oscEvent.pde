import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

float pogX;
float pogY;
float rightX;
float rightY;
float leftX;
float leftY;

void setupOsc() {

  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 12000);
}


void oscEvent(OscMessage theOscMessage) {

  if (theOscMessage.addrPattern().equals("/leftEye/coord")) {

    float leftX= theOscMessage.get(0).floatValue();
    float leftY= theOscMessage.get(1).floatValue(); 

    // check for NaN recieved from Tobii SDK
    if (Float.isNaN(leftX)) {

      return;
    }

    if (Float.isNaN(leftY)) {

      return;
    }
    leftEyeX_eye = leftX;
    leftEyeY_eye = leftY;
    pogX = (rightX + leftX)/2;
    //println( pogX, pogY);
  }

  if (theOscMessage.addrPattern().equals("/rightEye/coord")) {
    float rightX= theOscMessage.get(0).floatValue();
    float rightY= theOscMessage.get(1).floatValue();

    if (Float.isNaN(rightX)) {

      return;
    }

    if (Float.isNaN(rightY)) {

      return;
    }
    pogY = (rightY + leftY)/2;
    //println(pogY);
    //println(leftX);
  }



 
}
