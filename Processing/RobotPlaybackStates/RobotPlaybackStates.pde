void setup() {
  size(450, 450);
  // set lower frame rate
  frameRate(30);
  // setup servos and robot(s)
  setupServos();
  // setup behaviours
  setupBehaviors();
  // setup Tobii
  setupGazeTrack();
  // setup states
  setupStates();
}

void draw() {
  // update tobii
  updateGazeTrack();
  // update recording row index and set robot positions (if ready)
  behavior1.update();
  behavior2.update();
  // update current state
  currentState.update();
  // display usage information
  background(0);
  drawInfo();
}

void drawInfo(){
  text("behavior1 currentRow:" + behavior1.currentRow + " / " + behavior1.lastRow + "\n" +
    "behavior2 currentRow:" + behavior2.currentRow + " / " + behavior2.lastRow + "\n\n" +
    "behaviour 1 robotValues: " + behavior1.robotValues[0] + "," + behavior1.robotValues[1] + "," + behavior1.robotValues[2] + "\n" + 
    "behaviour 2 robotValues: " + behavior2.robotValues[0] + "," + behavior2.robotValues[1] + "," + behavior2.robotValues[2] + "\n\n" + 
    "press '1' to toggle robot 1: " + robot1.isActive + "\n" + 
    "press '2' to toggle robot 2: " + robot2.isActive + "\n\n" + 
    "gazeX: " + gazeX + "\n" + 
    "gazeY: " + gazeY + "\n" +
    "isLookingAtRobot1: " + isLookingAtRobot1(gazeX,gazeY) + "\n" + 
    "isLookingAtRobot2: " + isLookingAtRobot2(gazeX,gazeY) + "\n\n" + 
    "behavior 1 robotValues: " + behavior1.robotValues[0]+","+behavior1.robotValues[1] +"," + behavior1.robotValues[2] + "\n" +  
    "behavior 1 1st row: " + behavior1.firstRowData[0]+","+behavior1.firstRowData[1] +"," + behavior1.firstRowData[2] + "\n" + 
    "behavior 1 curr. row: " + behavior1.currentRowData[0]+","+behavior1.currentRowData[1] +"," + behavior1.currentRowData[2] + "\n\n" +
    "behavior 2 robotValues: " + behavior2.robotValues[0]+","+behavior2.robotValues[1] +"," + behavior2.robotValues[2] + "\n" +  
    "behavior 2 1st row: " + behavior2.firstRowData[0]+","+behavior2.firstRowData[1] +"," + behavior2.firstRowData[2] + "\n" + 
    "behavior 2 curr. row: " + behavior2.currentRowData[0]+","+behavior2.currentRowData[1] +"," + behavior2.currentRowData[2] + "\n\n" +
    "interpolator1 values: " + interpolator1.robotValues[0]+","+interpolator1.robotValues[1] +"," + interpolator1.robotValues[2] + "\n" +
    "interpolator2 values: " + interpolator2.robotValues[0]+","+interpolator2.robotValues[1] +"," + interpolator2.robotValues[2] + "\n\n" +
    "current state: " + currentState.toString().substring(currentState.toString().indexOf("$")+1,currentState.toString().indexOf("@")) + "\n\n" + 
    "press 'p' to simulate presence \n" +
    "press 'n' to simulate no presence \n" 
    , 10, 15);
}

void keyPressed() {
  if (key == '1') {
    robot1.isActive = !robot1.isActive;
  }
  if (key == '2') {
    robot2.isActive = !robot2.isActive;
  }
  if(key == 'p'){
    currentState.onPresence();
  }
  if(key == 'n'){
    currentState.onNoPresence();
  }
}
