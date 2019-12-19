ArrayList history; 
float leftEyeX_eye = 0;
float leftEyeY_eye= 0;

Eyedrawing eyedrawing;


void setupEyedrawing() {
  history  = new ArrayList();
  eyedrawing = new Eyedrawing();
}

class Eyedrawing {


  void draw(){
    //fill(0,0,0,0.01);
    //rect(0,0,width,height);
    //float x = map(leftEyeX_eye, -.03, 1.16, 1920, 0);
    //float y = map(leftEyeY_eye, -.6, 1.2, 0, 1020);
   
    float x = map(pogX, .4, 0, 1920, 0);
    float y = map(pogY, .05, .5, 0, 1020);
    println(pogY);

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
