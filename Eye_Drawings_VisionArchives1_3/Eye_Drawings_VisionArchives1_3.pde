
void setup() {
  background(0);
  size(1920, 1020);

  // setup servos, Robots, Table, OSC, Eyedrawing
  setupServos();
  setupBehaviors();
  setupTable();
  setupOsc();
  setupEyedrawing();
}


void draw() {
  eyedrawing.draw();
  behavior1.update();
  drawTable();
 
}
