void drawCourt() {

  pushMatrix();

  translate(courtPos.x, courtPos.y, courtPos.z);

  stroke(255);
  strokeWeight(8);
  fill(244, 164, 96); 

  box(courtSize.x, courtSize.y, courtSize.z);

  fill(255, 204, 0); 
  box(floorSize.x, floorSize.y, floorSize.z);

  noStroke();
  fill(255);
  box(courtSize.x, courtSize.y + 0.1, courtLinesSize);

  pushMatrix();

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
  for (int y = 0; y < (243/1.7)/scl; y++){
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x <= 1097/scl; x++){
      vertex(x*scl, y*scl);
      vertex(x*scl, (y+1)*scl);
      //rect(x*scl, y*scl, scl, scl);
    }
    endShape();
  }
  
  popMatrix();

  popMatrix();
}
