class PresenceState extends State{
  
/*
    - if looking at robot 1, pause behavior1, otherwise play/resume behavior 1
    - if looking at robot 2, pause behavior2, otherwise play/resume behavior 2
    - on No Presence set state to Interpolation State
    - on Presence state remains Presence 
*/

  void update(){
    //if(isLookingAtRobot1(gazeX, gazeY)){
    //  behavior1.pause();
    //}else{
    //  behavior1.resume();
    //}
    //if(isLookingAtRobot2(gazeX, gazeY)){
    //  behavior2.pause();
    //}else{
    //  behavior2.resume();
    //}
  }
  
  void onNoPresence(){
    //resume any behaviour that might have been paused using tobii;
    if(behavior1.isPaused()){
      behavior1.resume();
    }
    if(behavior2.isPaused()){
      behavior2.resume();
    }
    // once interpolation is done we want to go to noPresenceState
    interpolationState.targetState = noPresenceState;
    // set interpolation parameters
    interpolator1.interpolate(behavior1Presence, behavior1NoPresence, behavior1);
    interpolator2.interpolate(behavior2Presence, behavior2NoPresence, behavior2);
    //transition to interpolation state
    setState(interpolationState);
  }
  
}
