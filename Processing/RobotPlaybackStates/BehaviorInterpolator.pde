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
