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
  float interpolationDurationSeconds = 3.0;

  Ani interpolateToFirstRowServo1;
  Ani interpolateToFirstRowServo2;
  

  float servo1Value;
  float servo2Value;
 
  int[] robotValues = new int[2];

  int[] firstRowData = new int[2];
  int[] currentRowData = new int[2];

  boolean isInterpolating;

  Behavior(Robot robot) {
    this.robot = robot;
    // init animation(this sketch,duration in seconds, property to animate,value to animate to, easing, callback
    interpolateToFirstRowServo1 = new Ani(this, interpolationDurationSeconds, "servo1Value", 0, Ani.QUAD_OUT, "onUpdate:onInterpolationUpdate, onEnd:onInterpolationComplete");
    interpolateToFirstRowServo2 = new Ani(this, interpolationDurationSeconds, "servo2Value", 0, Ani.QUAD_OUT);
   
  }

  void onInterpolationUpdate(Ani animation) {
    // convert floats to ints
    robotValues[0] = round(servo1Value);
    robotValues[1] = round(servo2Value);
    
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
      
    }else{
      isPlaying = false;
    }
  }
  
  void resume(){
    if(isInterpolating){
      interpolateToFirstRowServo1.resume();
      interpolateToFirstRowServo2.resume();
      
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
    firstRowData = data.getIntRow(1);
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
       
        interpolateToFirstRowServo1.setEnd(firstRowData[0]);
        interpolateToFirstRowServo2.setEnd(firstRowData[1]);
        
        //start interpolating      
        interpolateToFirstRowServo1.start();
        interpolateToFirstRowServo2.start();
        
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
        println("robot1 " + robotValues[0], robotValues[1]);
      }
    }
  }
}
