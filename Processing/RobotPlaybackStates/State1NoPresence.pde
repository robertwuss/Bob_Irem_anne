class NoPresenceState extends State{
  
/*
    - run behavior1NoPresence
    - run behavior2NoPresence
    - on Presence set state to Interpolation State
    - on No Presence state remains No Presence 
*/ 

  void enter(){
    if(behavior1.isPaused()){
      behavior1.resume();
    }
    if(behavior2.isPaused()){
      behavior2.resume();
    }
  }
  
  void onPresence(){
    // once interpolation is done we want to go to presenceState
    interpolationState.targetState = presenceState;
    // set interpolation parameters
    interpolator1.interpolate(behavior1NoPresence, behavior1Presence, behavior1);
    interpolator2.interpolate(behavior2NoPresence, behavior2Presence, behavior2);
    //transition to interpolation state
    setState(interpolationState);
  }
  
  
}
