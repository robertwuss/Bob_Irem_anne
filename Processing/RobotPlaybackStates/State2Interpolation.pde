class InterpolationState extends State{
  
/*
    - interpolate from behavior1NoPresence to behavior1Presence (or vice versa depending on presence)
    - interpolate from behavior2NoPresence to behavior2Presence
      (or vice versa depending on presence)
    - if No Presence is received in this state, reverse the interpolation
    - onInterpolationComplete: set state to Presence State if there still is presence, otherwich set state back to No Presence 
*/ 
  // a reference to the layer we need to transition to once 
  State targetState;
  
  void onBehaviorInterpolationComplete(){
    // check if interpolator has animation reverse, if so reverse it
    if(interpolator1.isReversed()){
      interpolator1.reverse();
    }
    if(interpolator2.isReversed()){
      interpolator2.reverse();
    }
    // set point active behaviours to interpolation target
    behavior1 = interpolator1.to;
    behavior2 = interpolator2.to;
    // resume behaviours
    behavior1.resume();
    behavior2.resume();
    // change state
    setState(targetState); 
  }
  
  void onPresence(){
    // if transitioning to no presence, rewind and go back to presence
    if(targetState == noPresenceState){
      println("reversed animation");
      interpolator1.reverse();
      interpolator2.reverse();
      targetState = presenceState;
    }
  }
  
  void onNoPresence(){
    // if transitioning to presence, rewind and go back to no presence
    if(targetState == presenceState){
      println("reversed animation");
      interpolator1.reverse();
      interpolator2.reverse();
      targetState = noPresenceState;
    }
  }
  
  
}
