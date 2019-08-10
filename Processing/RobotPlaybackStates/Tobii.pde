import gazetrack.*;
GazeTrack gazeTrack;

boolean wasPresent = false;

final int GAZE_ROBOT_1_MIN_X    = -300;
final int GAZE_ROBOT_1_MAX_X    = 900;
final int GAZE_ROBOT_1_MIN_Y    = -2000;
final int GAZE_ROBOT_1_MAX_Y    = 4050;

final int GAZE_ROBOT_2_MIN_X    = 1000;
final int GAZE_ROBOT_2_MAX_X    = 2400;
final int GAZE_ROBOT_2_MIN_Y    = -2000;
final int GAZE_ROBOT_2_MAX_Y    = 4050;

float gazeX;
float gazeY;

void setupGazeTrack() {
  gazeTrack = new GazeTrack(this);
}

void updateGazeTrack() {
  // update gaze position
  gazeX = gazeTrack.getGazeX();
  gazeY = gazeTrack.getGazeY();
  // GazeTrack library still sends gazePresent() as true even if no tobii is connected
  // leftEye,rightEye present is more reliable
  //println(gazeTrack.leftEyePresent(),gazeTrack.rightEyePresent(),gazeTrack.gazePresent());
  boolean isPresent = gazeTrack.leftEyePresent() || gazeTrack.rightEyePresent(); 
  if(gazeX > 0.0 && gazeY > 0.0){
    //check presence
    if (isPresent && !wasPresent) {
      println("from no presence to presence");
      wasPresent = true;
      // update current state
      currentState.onPresence();
    }
  
    if (!isPresent && wasPresent) {
      println("from presence to no presence");
      wasPresent = false;
      // update current state
      currentState.onNoPresence();
    }
  }
}

boolean isLookingAtRobot1(float tobiiX, float tobiiY) {
  return tobiiX >= GAZE_ROBOT_1_MIN_X && tobiiX <= GAZE_ROBOT_1_MAX_X && tobiiY >= GAZE_ROBOT_1_MIN_Y && tobiiY <= GAZE_ROBOT_1_MAX_Y;
}

boolean isLookingAtRobot2(float tobiiX, float tobiiY) {
  if (tobiiX >= GAZE_ROBOT_2_MIN_X && tobiiX <= GAZE_ROBOT_2_MAX_X && tobiiY >= GAZE_ROBOT_2_MIN_Y  && tobiiY<= GAZE_ROBOT_2_MAX_Y) {
    return true;
  } else {
    return false;
  }
}
