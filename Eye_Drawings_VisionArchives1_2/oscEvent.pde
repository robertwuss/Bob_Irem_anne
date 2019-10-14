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
