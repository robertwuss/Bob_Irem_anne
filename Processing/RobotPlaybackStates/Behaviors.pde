import de.looksgood.ani.*;

Behavior behavior1;
Behavior behavior2;

Behavior behavior1NoPresence;
Behavior behavior1Presence;

Behavior behavior2NoPresence;
Behavior behavior2Presence;

BehaviorInterpolator interpolator1;
BehaviorInterpolator interpolator2;

void setupBehaviors() {
  // Ani.init() must be called always first!
  Ani.init(this);
  Ani.noAutostart();
  
  behavior1Presence = new Behavior(robot1);
  behavior1Presence.load("robot1-presence.txt");
  behavior1NoPresence = new Behavior(robot1);
  behavior1NoPresence.load("robot1-no-presence.txt");

  behavior2Presence = new Behavior(robot2);
  behavior2Presence.load("robot2-presence.txt");
  behavior2NoPresence = new Behavior(robot2);
  behavior2NoPresence.load("robot2-no-presence.txt");
  
  behavior1 = behavior1NoPresence;
  behavior2 = behavior2NoPresence;

  interpolator1 = new BehaviorInterpolator();
  interpolator2 = new BehaviorInterpolator();
}
