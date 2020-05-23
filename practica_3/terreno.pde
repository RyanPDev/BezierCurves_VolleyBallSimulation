void drawCourt() {

  
  pushMatrix();
  
  translate(courtPos.x,courtPos.y,courtPos.z);

  stroke(255);
  strokeWeight(8);
  fill(244, 164, 96); 
  
  box(courtSize.x,courtSize.y,courtSize.z);
  
  fill(255, 204, 0); 
  box(floorSize.x,floorSize.y,floorSize.z);
  
  
  popMatrix();
}
