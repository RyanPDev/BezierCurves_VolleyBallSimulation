void drawCourt() {

  pushMatrix();

  translate(courtPos.x, courtPos.y, courtPos.z);

  stroke(255);
  strokeWeight(8);
  fill(244, 164, 96); 

  box(courtSize.x, courtSize.y, courtSize.z);

  fill(255, 211,0); 
  box(floorSize.x, floorSize.y, floorSize.z);



  fill(135, 206, 235); 
  box(5000, floorSize.y/2, 5000);

  noStroke();
  fill(255);
  box(courtSize.x, courtSize.y + 0.1, courtLinesSize);
  pushMatrix();
  stroke(0);
  strokeWeight(2);
  translate(1800, -150/2, 0);
  fill(255, 224, 0); 
  box(floorSize.x, -150, floorSize.z);
  for (int i = 0; i< 3; i++)
  {
    translate(300, -150, 0);
    box(floorSize.x, 150, floorSize.z);
  }
  popMatrix();

  pushMatrix();

  translate(-1800, -150/2, 0);
  fill(255, 224, 0); 
  box(floorSize.x, -150, floorSize.z);
  for (int i = 0; i< 3; i++)
  {
    translate(-300, -150, 0);
    box(floorSize.x, 150, floorSize.z);
  }
  popMatrix();

  pushMatrix();
  strokeWeight(8);
  translate(-distanceCenterAntena, -antenaHeight/2, 0);
  noStroke();
  fill(30, 144, 255);
  box(antenaSize, antenaHeight, antenaSize); 

  popMatrix();

  pushMatrix();

  translate(distanceCenterAntena, -antenaHeight/2, 0);
  noStroke();
  fill(30, 144, 255);
  box(antenaSize, antenaHeight, antenaSize);

  popMatrix();

  pushMatrix();

  translate(courtPos.x, courtPos.y, courtPos.z - 300);
  noStroke();
  fill(255);
  box(courtSize.x, courtSize.y + 0.1, courtLinesSize);

  popMatrix();

  pushMatrix();

  translate(courtPos.x, courtPos.y, courtPos.z + 300);
  noStroke();
  fill(255);
  box(courtSize.x, courtSize.y + 0.1, courtLinesSize);

  popMatrix();

  pushMatrix();

  stroke(0);

  translate(-distanceCenterAntena, -antenaHeight, 0);
  strokeWeight(1);
  noFill();
  for (int y = 0; y < (antenaHeight/1.7)/netScale; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x <= (distanceCenterAntena*2)/netScale; x++) {
      vertex(x*netScale, y*netScale);
      vertex(x*netScale, (y+1)*netScale);
      //rect(x*scl, y*scl, scl, scl);
    }
    endShape();
  }

  popMatrix();

  popMatrix();
}
