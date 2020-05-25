void updateCameraLookAt() //Actualiza el modo de seguimiento de la camara
{
  if (cameraPhase == CamPhase.COURT)
  {
    cam.lookAt(courtPos.x, courtPos.y, courtPos.z, animationTimeInMillis);
    rotateX(radians(20));
    rotateY(radians(180));
  }
}

void cameraAngle()
{
  switch (state) {
  case view1: 
    updateCameraLookAt();
    camera7 = false;
    camera8 = false;
    camera9 = false;
    break;

  case view2:   
    updateCameraLookAt();
    rotateY(radians(90));
    camera7 = false;
    camera8 = false;
    camera9 = false;
    break;

  case view3:   
    updateCameraLookAt();
    translate(0, -900, -500);
    rotateY(radians(160));
    camera7 = false;
    camera8 = false;
    camera9 = false;
    break;

  case view4:   
    updateCameraLookAt();
    translate(0, -900, -900);
    rotateX(radians(-20));
    rotateY(radians(240));
    camera7 = false;
    camera8 = false;
    camera9 = false;
    break;

  case view5:
    updateCameraLookAt();
    camera(courtPos.x - 900, courtPos.y - 1000, courtPos.z, puntoBola.x, puntoBola.y, puntoBola.z, 0, 1, 0);
    camera7 = false;
    camera8 = false;
    camera9 = false;
    break;

  case view6:
    updateCameraLookAt();
    camera(courtPos.x - 1350, courtPos.y - 600, courtPos.z, puntoBola.x, puntoBola.y, puntoBola.z, 0, 1, 0);
    camera7 = false;
    camera8 = false;
    camera9 = false;
    break;

  case view7:
    float p;
    PVector nextPos = new PVector(0, 0, 0);
    p = u;
    p += incrementoBolaU;

    if (ballInGame)
    {
      if (ballCollided != 1)
        nextPos = miPrimeraBezier.calculameUnPunto(1);
      else
        nextPos = blockCurve.calculameUnPunto(1);
    } else
    {
      if (!ballSpiked)
      {
        nextPos = recieveCurve.calculameUnPunto(1);
      } else
      {
        nextPos = spikeCurve.calculameUnPunto(1);
      }
    }
    updateCameraLookAt();
    camera(puntoBola.x, puntoBola.y, puntoBola.z, nextPos.x, nextPos.y, nextPos.z, 0, 1, 0);
    camera7 = true;
    camera8 = false;
    camera9 = false;
    break;
  case view8:
    updateCameraLookAt();
    if (initServing && !endingComplete)
      camera(arrayPlayers[0].pos.x, arrayPlayers[0].pos.y - 80, arrayPlayers[0].pos.z - 20, miPrimeraBezier.puntosDeControl[3].x, miPrimeraBezier.puntosDeControl[3].y, miPrimeraBezier.puntosDeControl[3].z, 0, 1, 0);
    else
      camera(arrayPlayers[0].pos.x, arrayPlayers[0].pos.y - 80, arrayPlayers[0].pos.z - 20, puntoBola.x, puntoBola.y, puntoBola.z, 0, 1, 0);
    camera7 = false;
    camera8 = true;
    camera9 = false;
    break;
  case view9:
    updateCameraLookAt();
    camera(arrayPlayers[7].pos.x, arrayPlayers[7].pos.y - 80, arrayPlayers[7].pos.z, puntoBola.x, puntoBola.y, puntoBola.z, 0, 1, 0);
    camera7 = false;
    camera8 = false;
    camera9 = true;
    break;
  }
}
