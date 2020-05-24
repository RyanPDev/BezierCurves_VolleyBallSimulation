void keyPressed() // Funcion propia de Processing que se ejecuta cada vez que se presiona una tecla
{

  switch(key) {
  case ' ':
    if (gamePhase == Phase.SIMULATION) {
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

  case 's':    
  case 'S':
    if (!isServing) {
      isServing = true;
      auxiliarPhase = gamePhase;
      gamePhase = Phase.SERVE;
    } else{

      stopServing();
    }
    break;

  case 'x':
  case 'X':
  case 'c':
  case 'C':
    if (gamePhase == Phase.SIMULATION) {
      if (!changedSelectedObject) {
        changedSelectedObject = true;
        if (selectedPoint == PointSelected.DIRECCION)
        {
          selectedPoint = PointSelected.EFECTO;
        } else if (selectedPoint == PointSelected.EFECTO)
        {
          selectedPoint = PointSelected.POTENCIA;
        } else if (selectedPoint == PointSelected.POTENCIA)
        {
          selectedPoint = PointSelected.DIRECCION;
        } else if (selectedPoint == PointSelected.NONE)
        {
          selectedPoint = PointSelected.DIRECCION;
        }
      }
    }
    break;

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
  }
}

void stopServing()
{
  gamePhase = auxiliarPhase;
  isServing = false;
  curveInGame = true;
  ballInGame = true;
  ballCollided = 0;
  //puntoBola = new PVector(0, 0, 0);
  u = 0;
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
