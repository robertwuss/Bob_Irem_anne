ArrayList history; 


void setup() {
  background(0);
  size ( 1920, 1080);
  history  = new ArrayList();


}
void draw () {
float x = mouseX;
float y = mouseY;
  for (int i = 0; i < history.size(); i++) {
    PVector p = (PVector) history.get(i);
    float d = dist(x, y, p.x, p.y);
    
    stroke (255);
    strokeWeight(20/d);

    if (d < 150) {
       if (random(10) < 2) // Skip some lines randomly
        line(mouseX, mouseY, p.x + 5, p.y + 2);
    }
  }
  history.add(new PVector(x, y));
  strokeWeight(2.6);
  
  println(x,y);

}
