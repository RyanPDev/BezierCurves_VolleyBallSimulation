void drawCourt() {

  pushMatrix();

  translate(courtPos.x, courtPos.y, courtPos.z);

  stroke(255);
  strokeWeight(8);
  fill(244, 164, 96); 

  box(courtSize.x, courtSize.y, courtSize.z);

  fill(255, 204, 0); 
  box(floorSize.x, floorSize.y, floorSize.z);
  
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
  
  translate(courtPos.x, courtPos.y, courtPos.z);
  noStroke();
  fill(255);
  box(courtSize.x, courtSize.y + 0.1, courtLinesSize);
  
  popMatrix();
  
  popMatrix();
}
