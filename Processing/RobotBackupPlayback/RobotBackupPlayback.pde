void setup () {
  size(450, 450);
  // set lower frame rate
  frameRate(30);
  // setup servos and robot(s)
  setupServos();
  setupBehaviors();
  setupGazeTrack();
}

void draw () {
  behavior1.update();
  behavior2.update();
  updateGazeTrack();
  if (isPresent) {
    if (isLookingAtRobot1(gazeX, gazeY)) {
      behavior1.pause();
    } else {
      behavior1.resume();
    }
     if (isLookingAtRobot2(gazeX, gazeY)) {
      behavior2.pause();
    } else {
      behavior2.resume();
    }
  }
}

void keyPressed() {
  if (key == '1') {
    robot1.isActive = !robot1.isActive;
  }
  if (key == '2') {
    robot2.isActive = !robot2.isActive;
  }
}
