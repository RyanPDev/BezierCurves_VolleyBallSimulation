void keyPressed() // Funcion propia de Processing que se ejecuta cada vez que se presiona una tecla
{

  switch(key) {
  case ' ': // Controla si se pueden editar los puntos
    if (gamePhase == Phase.SIMULATION || gamePhase == Phase.SERVE) {
      if (!freeCam)
      {
        freeCam = true;
      } else if (freeCam)
      {
        freeCam = false;
      }
      cam.setActive(freeCam);
    }
    break;
  case 'h':    
  case 'H': // Enseña o esconde los controles de la simulación;
    if (!showControls && gamePhase == Phase.SIMULATION && !endingComplete)
    {
      if (showRedArrow)
      {
        showRedArrow = false;  //Solo queremos enseñar la flecha roja la primera vez
      }
      showControls = true;
    } else if (showControls)
    {
      showControls = false;
    }
    break;
  case 's':    // Empieza el saque o lo para
  case 'S':
    if (!isServing) {
      showControls = false;
      isServing = true;
      auxiliarPhase = gamePhase;
      ballCollided = 0;
      gamePhase = Phase.SERVE;
    } else {
      arrayPlayers[0].pos.y = -(playerHeight/2);
      resetBallPos();
      stopServing();
    }
    playerWin = false;
    endingComplete = false;
    break;

  case 'x':
  case 'X': // Modifica que punto se está cambiando
  case 'c':
  case 'C':
    if (gamePhase == Phase.SIMULATION) {
      if (!changedSelectedObject) {
        changedSelectedObject = true;
        if (selectedPoint == PointSelected.DIRECTION)
        {
          selectedPoint = PointSelected.SPIN;
        } else if (selectedPoint == PointSelected.SPIN)
        {
          selectedPoint = PointSelected.POWER;
        } else if (selectedPoint == PointSelected.POWER)
        {
          selectedPoint = PointSelected.DIRECTION;
        } else if (selectedPoint == PointSelected.NONE)
        {
          selectedPoint = PointSelected.DIRECTION;
        }
      }
    }
    break;
 // Cambia los diferentes estados de la camara
  case '1':
    state = view1;
    break;

  case '2':
    state = view2;
    break;

  case '3':
    state = view3;
    break;

  case '4':
    state = view4;
    break;

  case '5':
    state = view5;
    break;

  case '6':
    state = view6;
    break;

  case '7':
    state = view7;
    break;
  case '8':
    state = view8;
    break;
  case '9':
    state = view9;
    break;
  }
}

void keyReleased() // Funcion propia de Processing que se ejecuta cada vez que se presiona una tecla
{

  if ((key == 'x'|| key == 'X' || key == 'c'|| key == 'C') && gamePhase == Phase.SIMULATION) // Hacer que la camara siga o deje de seguir a la meta
  {
    if (changedSelectedObject)
    {
      changedSelectedObject = false;
    }
  }
}

void stopServing() // Para la ejecucion del saque
{
  resetBooleans(); //--> Pestaña GeneratingFunctions
  impossibleServe = false;
  gamePhase = auxiliarPhase;
}

void mouseDragged()
{
  if (gamePhase == Phase.SIMULATION)
  {
    int point = 0;
    shouldModify = true;
    switch(selectedPoint)
    {
    case DIRECTION:
      point = 1;
      break;
    case SPIN:
      point = 2;
      break;
    case POWER:
      point = 3;
      break;
    default:
      shouldModify = false;
      break;
    }

    if (!mouseClick)
    {
      arrayPlayers[0].pos = new PVector(courtInitPos.x + 200, -playerHeight / 2, courtInitPos.z - 500);
      resetBallPos(); //--> Pestaña GeneratingFunctions
      playerWin = false;
      endingComplete = false;
      mouseClick = true;
      serveCurve.lastMouseInput = new PVector(mouseX, mouseY, 0);
    }
    if (!freeCam && shouldModify)
    {
      serveCurve.moveControlPointsMouse(new PVector(mouseX, mouseY, 0), point); //--> Pestaña BezierClass
    }
  }
}
void mouseReleased()
{
  if (gamePhase == Phase.SIMULATION)
  {
    if (mouseClick)
      mouseClick = false;
  }
}
