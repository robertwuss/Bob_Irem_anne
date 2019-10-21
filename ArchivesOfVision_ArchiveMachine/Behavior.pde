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
  Eyedrawing eyedrawing;
  // animation to be used when last row is reached
  float interpolationDurationSeconds = 3.0;

  Ani interpolateToFirstRowServo1;
  Ani interpolateToFirstRowServo2;
  

  float eyedrawing_X;
  float eyedrawing_Y;
 
  int[] eyeDrawingValues = new int[2];

  int[] firstRowData = new int[2];
  int[] currentRowData = new int[2];

  boolean isInterpolating;

  Behavior(Eyedrawing eyedrawing) {
    this.eyedrawing = eyedrawing;
    // init animation(this sketch,duration in seconds, property to animate,value to animate to, easing, callback
    interpolateToFirstRowServo1 = new Ani(this, interpolationDurationSeconds, "eyedrawing_X", 0, Ani.QUAD_OUT, "onUpdate:onInterpolationUpdate, onEnd:onInterpolationComplete");
    interpolateToFirstRowServo2 = new Ani(this, interpolationDurationSeconds, "eyedrawing_Y", 0, Ani.QUAD_OUT);
   
  }

  void onInterpolationUpdate(Ani animation) {
    // convert floats to ints
    eyeDrawingValues[0] = round(eyedrawing_X);
    eyeDrawingValues[1] = round(eyedrawing_Y);
    
   //println("onInterpolationUpdate: " +eyeDrawingValues[0] + "," + robotValues[1] + "," + robotValues[2]);
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
      data = loadTable(path, "header");
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
    println (firstRowData);
    currentRowData = data.getIntRow(currentRow);
    // go to next frame only if there is at least one more frame to play 
    if (currentRow < lastRow) {
      currentRow++;
      eyeDrawingValues = currentRowData;
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
   

      updateRow();
      println(eyeDrawingValues);

   
      
    }
  }
