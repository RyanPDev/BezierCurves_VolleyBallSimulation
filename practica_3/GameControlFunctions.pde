void keyPressed() // Funcion propia de Processing que se ejecuta cada vez que se presiona una tecla
{
  if ((key == ' ') && gamePhase == Phase.SIMULATION) //Activar o desactivar el modo random
  {
    if (!freeCam)
    {
      freeCam = true;
    } else if (freeCam)
    {
      freeCam = false;
    }
    cam.setActive(freeCam);
  }
  if ((key == 's'|| key == 'S')) //Activar o desactivar el modo random
  {
    if (!isServing)
    {
      isServing = true;
      auxiliarPhase = gamePhase;
      gamePhase = Phase.SERVE;
    } else if (isServing)
    {

      stopServing();
      
    }
  }
  if ((key == 'x'|| key == 'X' || key == 'c'|| key == 'C') && gamePhase == Phase.SIMULATION)
  {
    if (!changedSelectedObject)
    {
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
}

void stopServing()
{
  gamePhase = auxiliarPhase;
      isServing = false;
      curveInGame = true;
 
          ballCollided = 0;
      puntoBola = new PVector(0, 0, 0);
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
