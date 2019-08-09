// each state
NoPresenceState noPresenceState;
InterpolationState interpolationState;
PresenceState presenceState;
// current state reference
State currentState;

// setup states
void setupStates(){
  // init each state
  noPresenceState    = new NoPresenceState();
  interpolationState = new InterpolationState();  
  presenceState      = new PresenceState();
  // update current state reference
  setState(noPresenceState);
}
// transition from one state to another
void setState(State newState){
  //clear anything the current needs to clear before it goes away
  if(currentState != null){
    currentState.leave();
  }
  //point the new state to the newState
  currentState = newState;
  //reset anything this new state needs to reset as it enters
  currentState.enter();
}

// a generic state class
class State{
  // constructor -> init()
  State(){
    init();
  }
  // initialize things that the state need to run once (e.g. setup gaze tracking, setup serial/servos, etc.)
  void init(){
  
  }
  // to be called continuously (e.g. update gaze, set goal positions, etc.)
  void update(){
  
  }
  // to be called only once when the state is entered (reset anything that needs to be reset) 
  void enter(){
  
  }
  // to be called only once when the state exits 
  void leave(){
  
  }
  // to be called only once when changing from no presence to presence
  void onPresence(){
  
  }
  // to be called only once when changing from presence to no presence
  void onNoPresence(){
    
  }
  
}

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

class PresenceState extends State{
  
/*
    - if looking at robot 1, pause behavior1, otherwise play/resume behavior 1
    - if looking at robot 2, pause behavior2, otherwise play/resume behavior 2
    - on No Presence set state to Interpolation State
    - on Presence state remains Presence 
*/

  void update(){
    if(isLookingAtRobot1(gazeX, gazeY)){
      behavior1.pause();
    }else{
      behavior1.resume();
    }
    if(isLookingAtRobot2(gazeX, gazeY)){
      behavior2.pause();
    }else{
      behavior2.resume();
    }
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
