class Eyerobot {
  int[] robotValues = new int[3];
  float r1_x = 3500;
  float r1_y = 4000;
  float r1_z = 3500 ;
  float easing = 0.03;

  float pos_Xo ;
  float pos_Yo ;
  float pos_Zo ;

  Robot robot;

  void update () {

    float targetX= mouseX;
    float targetY = mouseY;
    float targetZ = mouseY;

    float dx = targetX - r1_x;
    r1_x += dx * easing;
    pos_Xo = map(r1_x, 0, 800, (int)3900, (int)3200);
    int xo = round(pos_Xo);

    float dy = targetY - r1_y;
    r1_y += dy * easing;
    pos_Yo = map(r1_y, 800, 0, (int)4000, (int)3500);
    int yo = round(pos_Yo);
    int yo_constrain = constrain(yo, 1200, 300);
  
    float dz = targetZ - r1_z;
    r1_z += dz * easing;
    int pos_Zo = int (map(r1_y, 0, 800, (int)3500, (int)3100));
    int zo = round(pos_Zo);
   
    robotValues[0] = xo;
    robotValues[1] = zo;
    robotValues[2] = yo;

    // send the positions to robot1
    robot1.setGoalPositions(robotValues);
    println(robotValues);
  }
}
