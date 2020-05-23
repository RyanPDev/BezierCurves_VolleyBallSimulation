void drawHUD() // Funcion que dibuja HUD
{

  cam.beginHUD();


  strokeWeight(1);

  rectMode(CORNERS);



  //fill(0, 255);

  textAlign(CENTER, CENTER);
  textSize(15); 
  fill(0);
  
  if (!freeCam)
  {
    textSize(22);
    fill(0, 255, 255);
  }

  text("EDIT MODE", (width - 100), height - 200);
  textSize(15);
  fill(0);
  
  if (selectedPoint == PointSelected.DIRECCION)
  {
    textSize(22);
    fill(0, 255, 0);
  }

  text("DIRECTION", (width - 100), height - 150);
  textSize(15);
  fill(0);

  if (selectedPoint == PointSelected.EFECTO)
  {
    textSize(22);
    fill(0, 0, 255);
  }

  text("ADDED SPIN", (width - 100), height - 110);
  textSize(15);
  fill(0);

  if (selectedPoint == PointSelected.POTENCIA)
  {
    textSize(22);
    fill(255, 0,0 );
  }

  text("POWER", (width - 100), height - 60);
  textSize(15);
  fill(0);

  cam.endHUD();// always!
}
