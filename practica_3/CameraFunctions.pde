void updateCameraLookAt() //Actualiza el modo de seguimiento de la camara
{
  if (cameraPhase == CamPhase.COURT)
  {
    cam.lookAt(courtPos.x, courtPos.y, courtPos.z, animationTimeInMillis);
  }
}
