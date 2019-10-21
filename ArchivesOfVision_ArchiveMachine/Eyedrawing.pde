ArrayList history; 


Eyedrawing eyedrawing;


void setupEyedrawing() {
  history  = new ArrayList();
  eyedrawing = new Eyedrawing();
}

class Eyedrawing {


  void draw() {

    float leftEyeX = behavior1.eyeDrawingValues[0];
    float leftEyeY = behavior1.eyeDrawingValues[0];

    float x = map(leftEyeX, 0.1, 0.8, 1920, 0);
    float y = map(leftEyeY, -.1, 1, 0, 1020);


    //println(x);
    for (int i = 0; i < history.size(); i++) {
      PVector p = (PVector) history.get(i);
      float d = dist(x, y, p.x, p.y);

      stroke (255, 30);
      strokeWeight(25/d);

      if (d < 100) {
        //if (random(10) < 5) // Skip some lines randomly
        line(x, y, p.x + 2, p.y + 2);
      }
    }
    history.add(new PVector(x, y));
    //strokeWeight(2.6);

    //println(x, y);
    
    
  }
}
