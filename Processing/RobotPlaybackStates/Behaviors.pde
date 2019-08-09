import de.looksgood.ani.*;

Behavior behavior1;
Behavior behavior2;

Behavior behavior1NoPresence;
Behavior behavior1Presence;

Behavior behavior2NoPresence;
Behavior behavior2Presence;

BehaviorInterpolator interpolator1;
BehaviorInterpolator interpolator2;

void setupBehaviors() {
  // Ani.init() must be called always first!
  Ani.init(this);
  Ani.noAutostart();
  
  behavior1Presence = new Behavior(robot1);
  behavior1Presence.load("robot1-presence.txt");
  behavior1NoPresence = new Behavior(robot1);
  behavior1NoPresence.load("robot1-no-presence.txt");

  behavior2Presence = new Behavior(robot2);
  behavior2Presence.load("robot2-presence.txt");
  behavior2NoPresence = new Behavior(robot2);
  behavior2NoPresence.load("robot2-no-presence.txt");
  
  behavior1 = behavior1NoPresence;
  behavior2 = behavior2NoPresence;

  interpolator1 = new BehaviorInterpolator();
  interpolator2 = new BehaviorInterpolator();
}

class Behavior {
  // the data to be loaded (tsv file)
  Table data;
  // current row counter
  int currentRow = 0;
  // last row index
  int lastRow;
  // playback toggle
  boolean isPlaying = false;
  // reference to the robot to be controlled
  Robot robot;
  // animation to be used when last row is reached
  float interpolationDurationSeconds = 5.0;

  Ani interpolateToFirstRowServo1;
  Ani interpolateToFirstRowServo2;
  Ani interpolateToFirstRowServo3;

  float servo1Value;
  float servo2Value;
  float servo3Value;
  int[] robotValues = new int[3];

  int[] firstRowData = new int[3];
  int[] currentRowData = new int[3];

  boolean isInterpolating;

  Behavior(Robot robot) {
    this.robot = robot;
    // init animation(this sketch,duration in seconds, property to animate,value to animate to, easing, callback
    interpolateToFirstRowServo1 = new Ani(this, interpolationDurationSeconds, "servo1Value", 0, Ani.QUAD_OUT, "onUpdate:onInterpolationUpdate, onEnd:onInterpolationComplete");
    interpolateToFirstRowServo2 = new Ani(this, interpolationDurationSeconds, "servo2Value", 0, Ani.QUAD_OUT);
    interpolateToFirstRowServo3 = new Ani(this, interpolationDurationSeconds, "servo3Value", 0, Ani.QUAD_OUT);
  }

  void onInterpolationUpdate(Ani animation) {
    // convert floats to ints
    robotValues[0] = round(servo1Value);
    robotValues[1] = round(servo2Value);
    robotValues[2] = round(servo3Value);
   //println("onInterpolationUpdate: " +robotValues[0] + "," + robotValues[1] + "," + robotValues[2]);
  } 

  void onInterpolationComplete(Ani animation) {
    isInterpolating = false;
    currentRow = 0;
    //println("behavior.onInterpolationComplete");
  }

  void load(String path) {
    // try to load, handling errors
    try {
      // load TSV (tab separated values) file
      data = loadTable(path, "tsv");
      // reset current row
      currentRow = 0;
      lastRow = data.getRowCount() - 1;
      if (lastRow == -1) {
        println("empty tsv file!!!");
      }
      // stop playback (in case it was previously playing
      isPlaying = false;
    }
    catch(Exception e) {
      println("error loading recording:");
      e.printStackTrace();
    }
  }
  
  void pause(){
    if(isInterpolating){
      interpolateToFirstRowServo1.pause();
      interpolateToFirstRowServo2.pause();
      interpolateToFirstRowServo3.pause();
    }else{
      isPlaying = false;
    }
  }
  
  void resume(){
    if(isInterpolating){
      interpolateToFirstRowServo1.resume();
      interpolateToFirstRowServo2.resume();
      interpolateToFirstRowServo3.resume();
    }else{
      isPlaying = true;
    }
  }
  
  boolean isPaused(){
    if(isInterpolating){
      return !interpolateToFirstRowServo1.isPlaying();
    }else{
      return !isPlaying;
    }
  }

  void updateRow() {
    if (data == null) {
      println("error! no data to process");
      return;
    }
    //get the positions to interpolate to = 1st row
    firstRowData = data.getIntRow(0);
    currentRowData = data.getIntRow(currentRow);
    // go to next frame only if there is at least one more frame to play 
    if (currentRow < lastRow) {
      currentRow++;
      robotValues = currentRowData;
    } else {
      if (!isInterpolating) {
        isInterpolating = true;
        //set these positions to the interpolator1s
        interpolateToFirstRowServo1.setBegin(currentRowData[0]);
        interpolateToFirstRowServo2.setBegin(currentRowData[1]);
        interpolateToFirstRowServo3.setBegin(currentRowData[2]);
        interpolateToFirstRowServo1.setEnd(firstRowData[0]);
        interpolateToFirstRowServo2.setEnd(firstRowData[1]);
        interpolateToFirstRowServo3.setEnd(firstRowData[2]);
        //start interpolating      
        interpolateToFirstRowServo1.start();
        interpolateToFirstRowServo2.start();
        interpolateToFirstRowServo3.start();
      }
    }
  }

  void update() {
    if (isPlaying) {

      updateRow();

      // pass table data to robot
      if (robot != null) {
        // send the current row of the recording
        robot.setGoalPositions(robotValues);
      }
    }
  }
}

class BehaviorInterpolator {

  // animation to be used when last row is reached
  float interpolationDurationSeconds = 3.0;

  Ani interpolator1Servo1;
  Ani interpolator1Servo2;
  Ani interpolator1Servo3;

  float servo1Value;
  float servo2Value;
  float servo3Value;
  int[] robotValues = new int[3];

  Behavior from;
  Behavior to;
  Behavior target;

  BehaviorInterpolator() {
    interpolator1Servo1 = new Ani(this, interpolationDurationSeconds, "servo1Value", 0, Ani.QUAD_OUT, "onUpdate:onInterpolationUpdate, onEnd:onInterpolationComplete");
    interpolator1Servo2 = new Ani(this, interpolationDurationSeconds, "servo2Value", 0, Ani.QUAD_OUT);
    interpolator1Servo3 = new Ani(this, interpolationDurationSeconds, "servo3Value", 0, Ani.QUAD_OUT);
  } 
  /**
  /*@param from - behaviour to interpolate from
  /*@param to - behaviour to interpolate to
  /*@param target - behaviour to assign to once transition is complete
   */
  void interpolate(Behavior from, Behavior to, Behavior target) {
    if (from == null) {
      println("error! null Behavior from");
      return;
    }
    if (to == null) {
      println("error! null Behavior to");
      return;
    }
    if (target == null) {
      println("error! null Behavior target");
      return;
    }
    //println(from, to, target);
    // store local references to behaviours
    this.from = from;
    this.to = to;
    this.target = target;
    // pause behaviours so they won't write positions to the servos
    from.pause();
    to.pause();
    target.pause();
    // get servo positions
    int[] poseFrom = from.data.getIntRow(from.currentRow);
    int[] poseTo   = to.data.getIntRow(to.currentRow);
    //println("poseFrom:");
    //println(poseFrom);
    //println("poseTo:");
    //println(poseTo);
    
    //set these positions to the interpolator
    interpolator1Servo1.setBegin(poseFrom[0]);
    interpolator1Servo2.setBegin(poseFrom[1]);
    interpolator1Servo3.setBegin(poseFrom[2]);
    interpolator1Servo1.setEnd(poseTo[0]);
    interpolator1Servo2.setEnd(poseTo[1]);
    interpolator1Servo3.setEnd(poseTo[2]);
    //start interpolating      
    interpolator1Servo1.start();
    interpolator1Servo2.start();
    interpolator1Servo3.start();
  }
  
  void reverse(){
    interpolator1Servo1.reverse();
    interpolator1Servo2.reverse();
    interpolator1Servo3.reverse();
  }
  
  boolean isReversed(){
    return interpolator1Servo1.getDirection().equals(Ani.BACKWARD);
  }

  void onInterpolationComplete(Ani animation) {
    interpolationState.onBehaviorInterpolationComplete();
  }

  void onInterpolationUpdate(Ani animation) {
    // convert floats to ints
    robotValues[0] = round(servo1Value);
    robotValues[1] = round(servo2Value);
    robotValues[2] = round(servo3Value);
    //println(this,"onInterpolationUpdate",robotValues[0],robotValues[1],robotValues[2]);
    // write values to robot
    if (to.robot != null) {
      to.robot.setGoalPositions(robotValues);
    }
  }
}
