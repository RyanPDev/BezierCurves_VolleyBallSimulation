void updateCameraLookAt() //Actualiza el modo de seguimiento de la camara
{
  if (cameraPhase == CamPhase.COURT)
  {
    cam.lookAt(0, 0, 0, 1500, animationTimeInMillis);
  }
}
