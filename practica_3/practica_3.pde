MyBezier bezierCamPos;
MyBezier bezierCamLookAt; 

// consts for state - must be unique numbers 
final int stateEditSouth=0; 
final int stateEditTop=1;
final int stateEditWest=2;
final int stateShowMovie=3; 
final int stateShowMovieWithBeziers=4;
final int stateShowMovieLookingAhead=5;
final int stateWaitForLoad=6; 
final int stateWaitForSave=7; 
final int stateHelp=8;
int state = stateEditSouth;

// values for camera distance/zoom (from scene) in edit modes
int camRadiusSouth = 1240;
int camRadiusTop   = -1700;
int camRadiusWest  = -700;

// values for cam pos for pan mode
PVector camPosSouth = new PVector (0, 0, 0), 
  camPosTop = new PVector (0, 0, 0), 
  camPosWest = new PVector (0, 0, 0);

boolean recordMovieAfterEnter=false; 
boolean recordMovieAfterEnterHasStarted=false; 

void setup() {
  size(1500, 700, P3D);
  background(111);
  perspective(PI/3.0, (float) width/height, 1, 1000000);
  if (bezierCamPos==null) {
    defineTwoBeziers();
  }
}

void draw() {
  background(111); 
  camera(camPosSouth.x, camPosSouth.y, camRadiusSouth, camPosSouth.x, camPosSouth.y, 0, 0, 1, 0);
  showBeziersForEdit();
  switch (state) {
  case stateEditSouth:
    // edit 
    background(111); 
    lights();
    camera();
    camera(camPosSouth.x, camPosSouth.y, camRadiusSouth, 
      camPosSouth.x, camPosSouth.y, 0, 
      0, 1, 0);
    showBeziersForEdit();//
    break; 

  case stateEditTop:
    // edit
    background(111); 
    lights();
    camera(camPosTop.x, camRadiusTop, camPosTop.z, 
      camPosTop.x, 0, camPosTop.z, 
      0, 0, 1);
    showBeziersForEdit();//
    break; 

  case stateShowMovie:
    background(111); 
    lights();
    PVector pos = bezierCamPos.showAsMovie(); //
    PVector lookAt = bezierCamLookAt.showAsMovie(); //
    camera(pos.x, pos.y, pos.z, 
      lookAt.x, lookAt.y, lookAt.z, 
      0, 1, 0);
    break;

  case stateShowMovieWithBeziers:
    background(111); 
    lights();
    pos = bezierCamPos.showAsMovie(); //
    lookAt = bezierCamLookAt.showAsMovie(); //
    camera(pos.x, pos.y, pos.z, 
      lookAt.x, lookAt.y, lookAt.z, 
      0, 1, 0);
    bezierCamLookAt.showBezier(); //
    bezierCamLookAt.showInMovement(); //
    break;
  }
}
