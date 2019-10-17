float lefteyeX_motor;
float lefteyeY_motor;
float r1_x= 3500;
float pos_Xo= 3500;
float easing = .03;
Table table;

void setupTable() {

  table = new Table();
  table.addColumn("x");
  table.addColumn("y");
}

void drawTable() {
  TableRow row = table.addRow();

  leftEyeX =constrain(round(map(leftEyeX, -1, 0.8, 3300, 4000)), 3300, 4000);
  leftEyeY =constrain(round(map(leftEyeY, -1, 2, 2950, 3150)), 2950, 3150);


  float targetX= leftEyeX;
  float dx = targetX - r1_x; 
  r1_x += dx * easing;
  pos_Xo = r1_x;
  int xo = round(pos_Xo);

  //Set the values of all columns in that row.
  row.setFloat("x", xo );
  row.setFloat("y", leftEyeY );
}

void keyPressed() {
  if (key == ' ') {
    saveTable(table, "/Users/robertwuss/Documents/Processing/Bob_Irem_anne/Eye_Drawings_VisionArchives1_3/data/robot1.csv");
    println("tableSaved");
  }
}
