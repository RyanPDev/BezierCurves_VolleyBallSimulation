void updateCameraLookAt() //Actualiza el modo de seguimiento de la camara
{
  if (cameraPhase == CamPhase.COURT)
  {
    cam.lookAt(courtPos.x,-400, courtPos.z, animationTimeInMillis);
  }
}
