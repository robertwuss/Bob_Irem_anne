void setup(){
  size(450,450);
  // set lower frame rate
  frameRate(30);
  // setup servos and robot(s)
  setupServos();
  // setup behaviours
  setupBehaviors();
  // setup Tobii
  setupGazeTrack();
}

void draw(){
  // update tobii
  updateGazeTrack();
  // update recording row index and set robot positions (if ready)
  behavior1.update();
  behavior2.update();
  // update robots based on tobii
  robot1.isActive = !isLookingAtRobot1(gazeX,gazeY);
  robot2.isActive = !isLookingAtRobot2(gazeX,gazeY);
  // display usage information
  background(0);
  text("currentRow behavior1:" + behavior1.currentRow + " / " + behavior1.lastRow + "\n\n\n" +
       "currentRow behavior2:" + behavior2.currentRow + " / " + behavior2.lastRow + "\n\n\n" +
       "press 1 to toggle robot 1: " + robot1.isActive + "\n\n" + 
       "press 2 to toggle robot 2: " + robot2.isActive + "\n\n" + 
       "press 7 to toggle behavior 1, playing: " + behavior1.isPlaying + "\n\n" +
       "press 9 to toggle behavior 2, playing: " + behavior2.isPlaying + "\n\n" +
       "press 'a' to load a new recording for behavior 1" + "\n\n" + 
       "press 'b' to load a new recording for behavior 2" + "\n\n" + 
       "gazeX: " + gazeX + "\n" + 
       "gazeY: " + gazeY + "\n" + 
       "behavior 1 robotValues: " + behavior1.robotValues[0]+","+behavior1.robotValues[1] +"," + behavior1.robotValues[2] + "\n" +  
       "behavior 1 1st row: " + behavior1.firstRowData[0]+","+behavior1.firstRowData[1] +"," + behavior1.firstRowData[2] + "\n" + 
       "behavior 1 curr. row: " + behavior1.currentRowData[0]+","+behavior1.currentRowData[1] +"," + behavior1.currentRowData[2] + "\n",10,15);
}

void fileSelectedBehavior1(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    behavior1.load(selection.getAbsolutePath());
  }
}

void fileSelectedBehavior2(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    behavior2.load(selection.getAbsolutePath());
  }
}

void keyPressed(){
  if(key == '7'){
    behavior1.isPlaying = !behavior1.isPlaying;
  }
  if(key == '9'){
    behavior2.isPlaying = !behavior2.isPlaying;
  }
  if(key == '1'){
    robot1.isActive = !robot1.isActive; 
  }
  if(key == '2'){
    robot2.isActive = !robot2.isActive;
  }
  if(key == 'A' || key == 'a'){
    selectInput("Select a behavior for robot 1:", "fileSelectedBehavior1");
  }
  if(key == 'B' || key == 'b'){
    selectInput("Select a behavior for robot 2:", "fileSelectedBehavior2");
  }
}
