void keyPressed() // Funcion propia de Processing que se ejecuta cada vez que se presiona una tecla
{
  if ((key == ' ') && gamePhase != Phase.STARTING) //Activar o desactivar el modo random
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
  if ((key == 'c'|| key == 'C') && gamePhase != Phase.STARTING)
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
        selectedPoint = PointSelected.NONE;
      } else if (selectedPoint == PointSelected.NONE)
      {
        selectedPoint = PointSelected.DIRECCION;
      }
    }
  }
}

void keyReleased() // Funcion propia de Processing que se ejecuta cada vez que se presiona una tecla
{

  if ((key == 'c'|| key == 'C') && gamePhase != Phase.STARTING) // Hacer que la camara siga o deje de seguir a la meta
  {
    if (changedSelectedObject)
    {
      changedSelectedObject = false;
    }
  }
}
