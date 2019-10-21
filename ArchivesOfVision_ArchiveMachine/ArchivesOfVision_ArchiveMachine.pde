void setup(){
  size (400,400);
  setupBehaviors();
  setupEyedrawing();
  behavior1 = new Behavior(eyedrawing);
}

void draw(){
  
 eyedrawing.draw();
  
behavior1.update(); 
  
  
}
