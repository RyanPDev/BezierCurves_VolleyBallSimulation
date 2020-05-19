void mousePressed() {

  if (mouseButton==LEFT) {
    // check beziers 
    if ( ! bezierCamPos.classMousePressed() ) 
      bezierCamLookAt.classMousePressed();
  }
}//func

void mouseReleased() {
  bezierCamPos.classMouseReleased();
  bezierCamLookAt.classMouseReleased();
}
