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
