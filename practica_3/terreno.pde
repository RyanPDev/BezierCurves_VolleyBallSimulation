void drawCourt() {

  noStroke();
  fill(244, 164, 96); 
  pushMatrix();
  
  translate(width/2, height/2);
  rotateX(PI/3);

  translate(-width/2, -height/2);

  for (int x = 0; x < rows; x++) {
    for (int y = 0; y < cols; y++) {
      rect(y*size, x*size, size, size);
    }
  }
  
  popMatrix();
}
