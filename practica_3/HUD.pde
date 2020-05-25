void drawHUD() // Funcion que dibuja HUD
{

  cam.beginHUD();


  noStroke();
  textSize(20);
  textAlign(LEFT);
  strokeWeight(1);
  fill(205, 255, 255, 150);
  rectMode(CORNERS);

  if (!showControls)
  {

    if (!endingComplete && gamePhase == Phase.SIMULATION)
    {
      rect(18, 0, 375, 25);

      fill(0, 255);
      text(showControlsText, 20, 20);
      if (showRedArrow)
      {
        fill(255, 0, 0, 255);
        text("<---", 380, 20);
        fill(0, 255);
      }
    } else
    {
      if (endingComplete)
      {
        if (!freeCam)
        {
          rect(18, 0, 330, 25);
          fill(0, 255);
          text(showControlsText2, 20, 20);
        } else
        {
          rect(18, 0, 340, 25);
          fill(0, 255);
          text(showControlsText3, 20, 20);
        }
      }
    }
  } else
  {
    rect(18, 0, 648, 300);
    rect(18, 0, 648, 300);
    rect(width -695, height - 185, width - 180, height - 35);
    rect(width -695, height - 185, width - 180, height - 35); // 2 veces porque queda mejor

    fill(0, 255);

    text(simulationControlsText+cameraControlsText, (20), 20);
    textAlign(LEFT, CENTER);
    text(addingControlText, (width - 690), height - 100);
  }

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
  fill(0, 255);

  if (selectedPoint == PointSelected.DIRECCION)
  {
    textSize(22);
    fill(0, 100, 0);
  }

  text("DIRECTION", (width - 100), height - 150);
  textSize(15);
  fill(0);

  if (selectedPoint == PointSelected.EFECTO)
  {
    textSize(22);
    fill(0, 0, 100);
  }

  text("ADDED SPIN", (width - 100), height - 110);
  textSize(15);
  fill(0);

  if (selectedPoint == PointSelected.POTENCIA)
  {
    textSize(22);
    fill(100, 0, 0 );
  }

  text("POWER", (width - 100), height - 60);
  textSize(15);


  if (endingComplete)
  {
    textSize(30);
    strokeWeight(8);
    fill(255);


    if (playerWin)
    {
      for (int i = 0; i < 6; i++)
      {
        arrayPlayers[i].makeJump = true;
      }

      stroke(0, 255, 0);
      rect((width / 2) - 180, (height / 8 )- 50, (width / 2)+ 180, (height / 8) + 50 );
      fill(0, 255, 0);
      text("YOUR TEAM WINS!\nNICE SERVE!", width / 2, height / 8);
    } else
    {
      for (int i = 6; i < arrayPlayers.length; i++)
      {
        arrayPlayers[i].makeJump = true;
      }

      stroke(255, 0, 0);
      rect((width / 2) - 180, (height / 8 )- 50, (width / 2)+ 180, (height / 8) + 50 );
      fill(255, 0, 0);
      text("YOUR TEAM LOSES...\nBetter luck next year ;D", width / 2, height / 8);
    }
    fill(0);
    strokeWeight(1);
  }


  cam.endHUD();// always!
}
