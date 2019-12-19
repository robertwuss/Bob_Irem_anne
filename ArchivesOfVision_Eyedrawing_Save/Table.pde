
float r1_x= 3500;
float r1_pos_Xo= 3500;

float r1_y= 3000;
float r1_pos_Yo= 3000;

float leftEyeX_motor ;
float leftEyeY_motor ;

float easing = .03;

Table table_robot;
Table table_eye;

String filename_eye;
String filename_robot;

void setupTable() {

  table_robot = new Table();
  table_robot.addColumn("x");
  table_robot.addColumn("y ");

  table_eye = new Table();
  table_eye.addColumn("x");
  table_eye.addColumn("y ");
}

void drawTable() {
  TableRow row_robot = table_robot.addRow();
  TableRow row_eye = table_eye.addRow();

  // map data to the constrains of the motors
  //All motors are constrained to the same mappings
  leftEyeX_motor =map(leftEyeX_eye, -1, 1, 2600, 3900);
  leftEyeY_motor =map(leftEyeY_eye, -1, 2, 2050, 3200);

  // eases the data because of how fast the eye moves
  float targetX= leftEyeX_motor;
  float dx = targetX - r1_x; 
  r1_x += dx * easing;
  r1_pos_Xo = r1_x;
  int r1_xout = constrain(round(r1_pos_Xo), 2600, 3900);

  float targetY= leftEyeY_eye;
  float dy = targetY - r1_y; 
  r1_y += dy * easing;
  r1_pos_Yo = r1_y;
  int r1_yout = constrain(round(r1_pos_Yo), 2050, 3200);



  //Set the values of all columns in that row.
  row_robot.setFloat("x", r1_xout );
  row_robot.setFloat("y ", r1_yout );
  
  row_eye.setFloat("x", leftEyeX_eye);
  row_eye.setFloat("y ", leftEyeY_eye);
}

void keyPressed() {

  //variables used for the filename timestamp
  int d = day();
  int m = month();
  int h = hour();
  int min = minute();
  int s = second();
 
  //variable as string under the data folder set as (mm-dd--hh-min-s.csv)
  filename_eye = "data/" + "eye_data" +  str(m) + "-" + str(d) + "--" + str(h) + "-" + str(min) + "-"  + ".csv";
  filename_robot = "data/" + "robot_data" +  str(m) + "-" + str(d) + "--" + str(h) + "-" + str(min) + "-"  + ".csv";
  if (key == ' ') {
    saveTable(table_robot, filename_robot, "tsv");
    saveTable(table_eye,filename_eye, "tsv");
    println("tableSaved_R1");
    fill(0);
    rect(0,0,width,height);
   
  }
}
