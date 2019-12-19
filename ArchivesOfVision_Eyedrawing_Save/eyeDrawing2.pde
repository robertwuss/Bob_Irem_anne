//color [] myCol = {#192438, #43787c, #64b5b8, #7cd0da, #7cd0da, #ff1818, #ff3e3e, #ff6060, 
//  #ff7f7f, #ff9696, #fefd01, #ead515, #d2a62c, #bc7a42, #a4485b
//};


//ArrayList history; 
//float leftEyeX_eye = 0;
//float leftEyeY_eye= 0;

//Eyedrawing eyedrawing;


//void setupEyedrawing() {
//  history  = new ArrayList();
//  eyedrawing = new Eyedrawing();
//  for (int i=0; i<15; i++) { 
//    float z = i*frameCount*0.1;
//  }
//}

//class Eyedrawing {


//  void draw() {

//    //    //float x = map(leftEyeX_eye, -.03, 1.16, 1920, 0);
//    //    //float y = map(leftEyeY_eye, -.6, 1.2, 0, 1020);

//    float x = map(pogX, -.2, .6, 0, 1920);
//    float y = map(pogY, -.28, .7, 0, 1020);

//    for (int i = 0; i < history.size(); i++) {
//      PVector p = (PVector) history.get(i);
//      float d = dist(x, y, p.x, p.y);



//      stroke (255);
//      strokeWeight(30/d);
//      textSize (35);
//      fill (255);
//      //text("x point of gaze:" + x, 100, 100);
//      //text("y point of gaze:" + y, 100, 150);

//      int colourIndex = i%myCol.length;
//      if (d < 200) {
//        //if (random(10) < 5) 
//          stroke((myCol[colourIndex]));
//        line(x, y, p.x + 10, p.y + 10);
//      }
//    }
//    history.add(new PVector(x, y));
//    strokeWeight(6.6);

//    //println(x, y);
//  }
//}
