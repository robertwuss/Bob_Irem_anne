import dynamixel.*;
import processing.serial.*;

// serial baud rate: adjust this to what that the dynamixels are using
int BAUD_RATE    = 1000000;
// serial port name: adjust this to what the U2D2 port name is on this computer (see Serial list print: first Console print)
String PORT_NAME = "/dev/tty.usbserial-FT2H2ZCB";

Serial port;
// double check these are the right servo IDs
int[] servoIDs = {14, 22, 23};
// total servos
int numServos = 3;
// reference to all servos
XH430[] servos = new XH430[numServos];
// first robot
Robot robot1;
// second robot
Robot robot2;
Robot robot3;

void setupServos() {
  // try open to open serial port 
  try {
    // print serial ports
    printArray(Serial.list());
    // initialize the serial port using the port name (e.g. /dev/tty.usbserial* on OSX, COM# on Windows, etc.) 
    // and baud rate (1M in this case)
    port  = new Serial(this, PORT_NAME, BAUD_RATE);
  }
  // handle any error (e.g. port is not connected to computer, busy (used by another software), etc.
  catch(Exception e) {
    println("error opening serial port: " + e.getMessage());
    // print the error details
    e.printStackTrace();
  }
  //TODO
  // initialize servo using this serial port and the servo ID
  for (int i = 0; i < numServos; i++) {
    servos[i] = new XH430(port, servoIDs[i]);
  }
  // initialize robot passing the coresponding servo to each one
  robot1 = new Robot(new XH430[]{ servos[0], servos[1], servos[2]});
  // enable torque
  robot1.setTorque(true);
  // initialize robot passing the coresponding servo to each one
  robot2 = new Robot(new XH430[]{ servos[3], servos[4],servos[5] });
    // enable torque
    //robot2.setTorque(true);

    robot3 = new Robot(new XH430[]{servos[6], servos [7], servos [8]});

  robot1.isActive = true;
  robot2.isActive = true;
  robot3.isActive = true;
}

class Robot {
  // number of servos
  int numServos; 
  // reference to the servos this robot is handling
  XH430[] servos;
  // should it set goal positions ?
  boolean isActive = false;

  Robot(XH430[] servos) {
    // store constructor argument as internal property
    this.servos = servos;
    // count servos and store value
    this.numServos = servos.length;
  }

  // set torque for all servos
  void setTorque(boolean enabled) {
    // error checking
    if (servos == null) {
      println("error! no servos to control");
      return;
    }
    // for each servo, set the torque
    for (int i = 0; i < numServos; i++) {
      servos[i].setTorque(enabled);
    }
  }

  // set goal positions for all servos
  void setGoalPositions(int[] positions) {
    // nothing to do if this robot is inactive
    //if(!isActive){
    // return;
    // }

    // error checking
    if (servos == null) {
      println("error! no servos to control");
      return;
    }
    if (positions == null) {
      println("error! no positions to set");
      return;
    }
    if (positions.length != numServos) {
      println("error! expecting same number of positions("+positions.length+") as servos("+numServos+")");
      return;
    }
    for (int i = 0; i < numServos; i++) {
      if (!isPositionValid(positions[i])) {
        println("error! invalid position["+i+"]="+positions[i]+" valid range is 0-4095");
        return;
      }
    }
    // finally, for each servo, set the goal position
    try {

      for (int i = 0; i < numServos; i++) {
        servos[i].setGoalPosition(positions[i]);
      }
    }
    catch(Exception e) {
      println("error setting positions:");
      e.printStackTrace();
    }
  }
  // avoid erroneus values
  boolean isPositionValid(int position) {
    return (position >= 0 && position <= 4095);
  }
}
