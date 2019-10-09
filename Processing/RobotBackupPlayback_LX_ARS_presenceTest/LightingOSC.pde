
import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress myRemoteLocation;

float VP_R;
int VP_G = 0;
int VP_B = 0;
int VP_W= 0;

void setupLighting() {

  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 8338);

  myRemoteLocation = new NetAddress("127.0.0.1", 12000);
}

void robotLxSend() {
  OscMessage robot1Message = new OscMessage("/robot1Light");
  OscMessage robot2Message = new OscMessage("/robot2Light");
  OscMessage viewPort = new OscMessage("/viewport");
  OscMessage pulse = new OscMessage("/pulse");
 


  if (isPresent) {
     viewPort.add(1);
     oscP5.send(viewPort, myRemoteLocation);
     
     pulse.add(1);
     oscP5.send(pulse, myRemoteLocation);


    if (isLookingAtRobot1(gazeX, gazeY)) {

      robot1Message.add(0); 
      oscP5.send(robot1Message, myRemoteLocation);
    } else {

      robot1Message.add(30); 
      oscP5.send(robot1Message, myRemoteLocation);
    }
    if (isLookingAtRobot2(gazeX, gazeY)) {

      robot2Message.add(0); 
      oscP5.send(robot2Message, myRemoteLocation);
    } else {

      robot2Message.add(30);
      oscP5.send(robot2Message, myRemoteLocation);
    }
  } else  {
      
    robot1Message.add(30);
    oscP5.send(robot1Message, myRemoteLocation);
    
    robot2Message.add(30);
    oscP5.send(robot2Message, myRemoteLocation);
    
    viewPort.add(-1);
    oscP5.send(viewPort, myRemoteLocation);
     
     pulse.add(0);
     oscP5.send(pulse, myRemoteLocation);
 
    
  }
}
