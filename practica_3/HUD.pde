void drawHUD() // Funcion que dibuja HUD
{

  cam.beginHUD();
  

  strokeWeight(1);
  //fill(205, 255, 255, 150);
  rectMode(CORNERS);
  
  

    //fill(0, 255);
  
  textAlign(CENTER, CENTER);
  textSize(15); 
  fill(0);
  if (selectedPoint == PointSelected.FIRST)
  {
    textSize(22);
    fill(0, 255, 0);
  }
  
  text("DIRECTION", (width - 100), height - 150);
  textSize(15);
  fill(0);
  
  if (selectedPoint == PointSelected.SECOND)
  {
    textSize(22);
    fill(255, 0, 0);
  }
  
  text("ADDED SPIN", (width - 100), height - 110);
  textSize(15);
  fill(0);
  
  if (selectedPoint == PointSelected.LAST)
  {
    textSize(22);
    fill(255, 192, 203 );
  }
  
  text("DESTINATION", (width - 100), height - 60);
  textSize(15);
  fill(0);

  cam.endHUD();// always!
}
