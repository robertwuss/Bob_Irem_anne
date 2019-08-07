import de.looksgood.ani.*;

Behavior behavior1;
Behavior behavior2;

Behavior behavior1NoPresence;
Behavior behavior1Presence;

Behavior behavior2NoPresence;
Behavior behavior2Presence;


void setupBehaviors(){
   // Ani.init() must be called always first!
  Ani.init(this);
  Ani.noAutostart();
  
  behavior1 = new Behavior(robot1);
  behavior2 = new Behavior(robot2);
  // TODO: init the other behaviors
  behavior1Presence = new Behavior(robot1);
  behavior1Presence.load("2019-08-02_19-18-20_test.txt");
}

class Behavior{
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
  Ani interpolateToFirstRowServo3;
  
  float servo1Value;
  float servo2Value;
  float servo3Value;
  int[] robotValues = new int[3];
  
  int[] firstRowData = new int[3];
  int[] currentRowData = new int[3];
  
  boolean isInterpolating;
  
  // TODO: find home 
  Behavior(Robot robot){
    this.robot = robot;
    // init animation(this sketch,duration in seconds, property to animate,value to animate to, easing, callback
    interpolateToFirstRowServo1 = new Ani(this, interpolationDurationSeconds, "servo1Value", 0, Ani.QUAD_OUT, "onUpdate:onInterpolationUpdate, onEnd:onInterpolationComplete");
    interpolateToFirstRowServo2 = new Ani(this, interpolationDurationSeconds, "servo2Value", 0, Ani.QUAD_OUT);
    interpolateToFirstRowServo3 = new Ani(this, interpolationDurationSeconds, "servo3Value", 0, Ani.QUAD_OUT);
  }
  
  void onInterpolationUpdate(Ani animation){
    // convert floats to ints
    robotValues[0] = round(servo1Value);
    robotValues[1] = round(servo2Value);
    robotValues[2] = round(servo3Value);
    println("onInterpolationUpdate: " +robotValues[0] + "," + robotValues[1] + "," + robotValues[2]); 
  } 
  
  void onInterpolationComplete(Ani animation){
    isInterpolating = false;
    currentRow = 0;
  }
  
  void load(String path){
    // try to load, handling errors
    try{
      // load TSV (tab separated values) file
      data = loadTable(path,"tsv");
      // reset current row
      currentRow = 0;
      lastRow = data.getRowCount() - 1;
      if(lastRow == -1){
        println("empty tsv file!!!");
      }
      // stop playback (in case it was previously playing
      isPlaying = false;
    }catch(Exception e){
      println("error loading recording:");
      e.printStackTrace();
    }
  }
  
  void updateRow(){
    //get the positions to interpolate to = 1st row
    firstRowData = data.getIntRow(0);
    currentRowData = data.getIntRow(currentRow);
    // go to next frame only if there is at least one more frame to play 
    if(currentRow < lastRow){
      currentRow++;
      robotValues = currentRowData;
    }else{
      if(!isInterpolating){
        isInterpolating = true;
        //set these positions to the interpolators
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
  
  void update(){
     if(isPlaying){
       
        updateRow();
        
        // pass table data to robot
        if(robot != null){
          // send the current row of the recording
          robot.setGoalPositions(robotValues);

        }
     }
  }
  
}
