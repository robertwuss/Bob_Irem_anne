import de.looksgood.ani.*;

Behavior behavior1;
Behavior behavior2;
Behavior behavior3;

void setupBehaviors() {
  // Ani.init() must be called always first!
  Ani.init(this);
  Ani.noAutostart();

  behavior1 = new Behavior(eyedrawing);
  //behavior2 = new Behavior(robot2);
  //behavior3 = new Behavior(robot3);


  behavior1.load("EyedrawingData1");
  //behavior2.load("r2test");
  //behavior3.load("r3test");

  behavior1.resume();
  //behavior2.resume();
  //behavior3.resume();
}
