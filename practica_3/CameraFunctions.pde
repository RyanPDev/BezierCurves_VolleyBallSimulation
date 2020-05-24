void updateCameraLookAt() //Actualiza el modo de seguimiento de la camara
{
  if (cameraPhase == CamPhase.COURT)
  {
    cam.lookAt(courtPos.x, courtPos.y, courtPos.z, animationTimeInMillis);
  }
}

void cameraAngle()
{
  switch (state) {
  case frontView: 
   
    updateCameraLookAt();
    rotateX(radians(20));
    rotateY(radians(180));
    
    break;

  case sideView:   
    updateCameraLookAt();
    rotateX(radians(20));
    rotateY(radians(90));
  
    break;
  }
}
