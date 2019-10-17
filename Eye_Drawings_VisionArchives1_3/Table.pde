
float r1_x= 3500;
float r1_pos_Xo= 3500;

float r1_y= 3000;
float r1_pos_Yo= 3000;

float easing = .03;
Table table;

void setupTable() {

  table = new Table();
  table.addColumn("x");
  table.addColumn("y ");
}

void drawTable() {
  TableRow row = table.addRow();

  leftEyeX =constrain(round(map(leftEyeX, -1, 1, 3000, 4000)), 3300, 4000);
  leftEyeY =constrain(round(map(leftEyeY, -1, 2, 2950, 3100)), 2950, 3100);


  float targetX= leftEyeX;
  float dx = targetX - r1_x; 
  r1_x += dx * easing;
  r1_pos_Xo = r1_x;
  int r1_xout = round(r1_pos_Xo);

  float targetY= leftEyeY;
  float dy = targetX - r1_y; 
  r1_y += dx * easing;
  r1_pos_Yo = r1_y;
  int r1_yout = round(r1_pos_Yo);

  //Set the values of all columns in that row.
  row.setFloat("x", r1_xout );
  row.setFloat("y ", r1_yout);
}

void keyPressed() {
  if (key == ' ') {
    saveTable(table, "/Users/robertwuss/Documents/Processing/Bob_Irem_anne/Eye_Drawings_VisionArchives1_3/data/robot1.csv", "tsv");
    println("tableSaved");
  }
}
