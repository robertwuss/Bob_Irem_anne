import gazetrack.*;
GazeTrack gazeTrack;

boolean wasPresent = false;

final int GAZE_AT_NOTHING     = 0;
final int GAZE_AT_ROBOT_1     = 1;
final int GAZE_AT_ROBOT_2     = 2;

final int GAZE_ROBOT_1_MIN_X    = -300;
final int GAZE_ROBOT_1_MAX_X    = 900;
final int GAZE_ROBOT_1_MIN_Y    = -2000;
final int GAZE_ROBOT_1_MAX_Y    = 4050;

final int GAZE_ROBOT_2_MIN_X    = 1000;
final int GAZE_ROBOT_2_MAX_X    = 2400;
final int GAZE_ROBOT_2_MIN_Y    = -2000;
final int GAZE_ROBOT_2_MAX_Y    = 4050;

//# global tracking window
final int GAZE_MIN_X        = -300;
final int GAZE_MAX_X        = 2400;

final int GAZE_MIN_Y        = -2000;
final int GAZE_MAX_Y        = 4000;

float gazeX;
float gazeY;

void setupGazeTrack(){
  gazeTrack = new GazeTrack(this);
}

void updateGazeTrack(){
  //check presence
  if (gazeTrack.gazePresent() && !wasPresent) {
    //println("from no presence to presence");
    wasPresent = true;
    //behavior1 = behavior1Presence;
  }

  if (!gazeTrack.gazePresent() && wasPresent) {
    //println("from presence to no presence");
    wasPresent = false;
    //behavior1 = behavior1NoPresence;
  }
  // update gaze position
  gazeX = gazeTrack.getGazeX();
  gazeY = gazeTrack.getGazeY();
}

boolean isLookingAtRobot1(float tobiiX,float tobiiY){
  return tobiiX >= GAZE_ROBOT_1_MIN_X && tobiiX <= GAZE_ROBOT_1_MAX_X && tobiiY >= GAZE_ROBOT_1_MIN_Y && tobiiY <= GAZE_ROBOT_1_MAX_Y;
}

boolean isLookingAtRobot2(float tobiiX,float tobiiY){
  if(tobiiX >= GAZE_ROBOT_2_MIN_X && tobiiX <= GAZE_ROBOT_2_MAX_X && tobiiY >= GAZE_ROBOT_2_MIN_Y  && tobiiY<= GAZE_ROBOT_2_MAX_Y){
    return true;
  }else{
    return false;
  }
}
