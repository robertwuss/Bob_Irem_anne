void oscEvent(OscMessage theOscMessage) {

  if (theOscMessage.addrPattern().equals("/leftEye/coord")) {

    float leftX= theOscMessage.get(0).floatValue();
    float leftY= theOscMessage.get(1).floatValue(); 
    
   if (Float.isNaN(leftX)) {
     
     return;
   }

  if (Float.isNaN(leftY)) {
     
     return;
   }
    leftEyeX = leftX;
    leftEyeY = leftY;
    //println(leftX);
  }

  if (theOscMessage.addrPattern().equals("/rightEye/coord")) {
    float rightX= theOscMessage.get(0).floatValue();
    float rightY= theOscMessage.get(1).floatValue();
  }
}
