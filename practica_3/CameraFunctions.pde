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
    break;

  case view2:   
    updateCameraLookAt();
    rotateY(radians(90));
    break;

  case view3:   
    updateCameraLookAt();
    translate(0, -900, -500);
    rotateY(radians(160));
    break;

  case view4:   
    updateCameraLookAt();
    translate(0, -900, -900);
    rotateX(radians(-20));
    rotateY(radians(240));
    break;

  case view5:
    updateCameraLookAt();
    camera(courtPos.x - 900, courtPos.y - 1000 , courtPos.z, puntoBola.x, puntoBola.y, puntoBola.z, 0, 1, 0);
    break;
  }
}
