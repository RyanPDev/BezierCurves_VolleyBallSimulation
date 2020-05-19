void defineTwoBeziers() {
  PVector[] pvListCamPos = { 
    new PVector(15, 80, -110), 
    new PVector(10, 10, -120), 
    new PVector(90, 90, 0), 
    new PVector(85, 20, 0)   }; 

  PVector[] pvListCamLookAt = { 
    new PVector(115, 180, 110), 
    new PVector(110, 110, 120), 
    new PVector(190, 190, 0), 
    new PVector(185, 120, 0)   }; 

  bezierCamPos=new MyBezier(pvListCamPos, color(255, 0, 0), true);   // red 
  bezierCamLookAt=new MyBezier(pvListCamLookAt, color(0, 0, 255), false );  // blue
}

void showBeziersForEdit() {
  bezierCamPos.showBezier();  
  bezierCamLookAt.showBezier();

  bezierCamPos.showInMovement();
  bezierCamLookAt.showInMovement();

  bezierCamPos.holdAction(); 
  bezierCamLookAt.holdAction();
}

void mySphere(float x, float y, float z, 
  float size1) {
  pushMatrix();
  translate(x, y, z);
  noStroke(); 
  sphere(size1);
  popMatrix();
}

void myBox (float x, float y, float z, 
  float size1) {
  pushMatrix();
  translate(x, y, z);
  box(size1);
  popMatrix();
}
