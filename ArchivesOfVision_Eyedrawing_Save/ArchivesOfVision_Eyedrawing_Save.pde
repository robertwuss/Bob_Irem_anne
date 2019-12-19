import codeanticode.syphon.*;

SyphonServer server;
void setup() {
  background(0);
  size(1920, 1020, P3D);

  // setup servos, Robots, Table, OSC, Eyedrawing

  setupTable();
  setupOsc();
  setupEyedrawing();
  server = new SyphonServer(this, "Processing Syphon");
}


void draw() {
  eyedrawing.draw();

  drawTable();
  server.sendScreen();
  
}
