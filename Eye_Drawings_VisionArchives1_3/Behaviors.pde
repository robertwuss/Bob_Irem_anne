import de.looksgood.ani.*;

Behavior behavior1;
//Behavior behavior2;
//Behavior behavior3;

void setupBehaviors() {
  // Ani.init() must be called always first!
  Ani.init(this);
  Ani.noAutostart();

  behavior1 = new Behavior(robot1);
  //behavior2 = new Behavior(robot2);
  //behavior3 = new Behavior(robot3);


  behavior1.load("robot1.csv");
  //behavior2.load("robot2-presence.txt");
  //behavior3.load("robot3-presence.txt");

  behavior1.resume();
  //behavior2.resume();
  //behavior3.resume();
}