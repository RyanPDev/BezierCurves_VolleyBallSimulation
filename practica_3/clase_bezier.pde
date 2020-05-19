class MyBezier {

  PVector[] pvList;
  PVector[] screenPos=new PVector[4];

  color col1; 

  boolean hold=false; 
  int indexHold=-1; 

  int stepsShowInMovement = 400;
  int i_in_draw=0; 

  boolean isCamPos=false; 

  MyBezier(PVector[] pvList_, color col_, boolean isCamPos_) {
    pvList=pvList_;
    col1=col_;
    for (int i=0; i<4; i++) {
      screenPos[i]=new PVector();
    }
    isCamPos=isCamPos_;
  }

  void showBezier() {
    fill(col1);
    int i2=0; 
    for (PVector pv : pvList) {      
      if (i2==0||i2==3) {
        // anchor
        stroke(100); 
        myBox(pv.x, pv.y, pv.z, 17);
      } else {
        // control point
        mySphere(pv.x, pv.y, pv.z, 17);
      }

      screenPos[i2].x = screenX(pv.x, pv.y, pv.z); 
      screenPos[i2].y = screenY(pv.x, pv.y, pv.z);
      i2++;
    }

    fill(col1);
    noStroke(); 
    int steps = 4;
    for (int i = 0; i <= steps; i++) {
      float t = i / float(steps);
      float x = bezierPoint(pvList[0].x, pvList[1].x, pvList[2].x, pvList[3].x, t);
      float y = bezierPoint(pvList[0].y, pvList[1].y, pvList[2].y, pvList[3].y, t);
      float z = bezierPoint(pvList[0].z, pvList[1].z, pvList[2].z, pvList[3].z, t);
      mySphere(x, y, z, 5);
    }
  }

  void showInMovement() {
    fill(col1);
    float t = i_in_draw / float(stepsShowInMovement);
    float x = bezierPoint(pvList[0].x, pvList[1].x, pvList[2].x, pvList[3].x, t);
    float y = bezierPoint(pvList[0].y, pvList[1].y, pvList[2].y, pvList[3].y, t);
    float z = bezierPoint(pvList[0].z, pvList[1].z, pvList[2].z, pvList[3].z, t);
    fill(0, 255, 0); // green 
    mySphere(x, y, z, 5);

    if (state!=stateShowMovieWithBeziers) {
      i_in_draw++;
      if ( i_in_draw > stepsShowInMovement ) {
        i_in_draw=0;
      }
    }
  }

  PVector showAsMovie() {
    float t = i_in_draw / float(stepsShowInMovement);
    float x = bezierPoint(pvList[0].x, pvList[1].x, pvList[2].x, pvList[3].x, t);
    float y = bezierPoint(pvList[0].y, pvList[1].y, pvList[2].y, pvList[3].y, t);
    float z = bezierPoint(pvList[0].z, pvList[1].z, pvList[2].z, pvList[3].z, t);

    i_in_draw++;
    if ( i_in_draw > stepsShowInMovement ) {
      i_in_draw=0;
      checkRecordMovieAfterEnter();
    }

    return new PVector(x, y, z);
  }

  void checkRecordMovieAfterEnter() { 
    if (!recordMovieAfterEnter) {
      return;
    }

    if (!isCamPos) {
      return;
    }
  }

  boolean classMousePressed() {
    int i=0; 
    for (PVector pv : pvList) {
      if (dist(screenPos[i].x, screenPos[i].y, mouseX, mouseY)<22) {
        hold=true;
        indexHold=i; 
        return true;
      }
      i++;
    }
    return false;
  }

  void classMouseReleased() {
    hold=false;
    indexHold=-1;
  }

  void holdAction() {
    if (hold) {
      switch(state) {
      case stateEditSouth: 
        pvList[indexHold].x+=mouseX-pmouseX;
        pvList[indexHold].y+=mouseY-pmouseY;
        break;

      case stateEditTop: 
        pvList[indexHold].x+=mouseX-pmouseX;
        pvList[indexHold].z+=mouseY-pmouseY;
        break;

      default:
        break;
      }
    }
  }
}
