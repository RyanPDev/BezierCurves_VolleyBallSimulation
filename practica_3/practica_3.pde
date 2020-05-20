MyBezier bezierCamPos;
MyBezier bezierCamLookAt; 

// consts for state - must be unique numbers 
final int stateEditSouth=0; 
final int stateEditTop=1;
final int stateEditWest=2;
final int stateShowMovie=3; 
final int stateShowMovieWithBeziers=4;
final int stateShowMovieLookingAhead=5;
final int stateShowTerrain=6;
final int stateHelp=7;
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

curvaBezier miPrimeraBezier;
boolean mouseClick = false;
boolean pointgrabbed = false;
int cols, rows;
int scl = 10;
int w = 500, h = 600;

void setup() {
  size(800, 600, P3D);
  background(111);
  cols = w /scl;
  rows = h/scl;
  perspective(PI/3.0, (float) width/height, 1, 1000000);
  if (bezierCamPos==null) {
    defineTwoBeziers();
  }

  //CODIGO DEL OSCAR
  color c = color(255, 255, 0);
  PVector[] p = new PVector[4];
  p[0] = new PVector(200, 200); // BEZIER SI PASA POR EL PRIMERO
  p[1] = new PVector(300, 300); // BEZIER NO PASA POR EL SEGUNDO
  p[2] = new PVector(400, 200); // BEZIER NO PASA POR EL TERCERO
  p[3] = new PVector(500, 300); // BEZIER SI PASA POR EL ULTIMO

  // PUNTOS A PINTAR?
  float num = 50;
  // LLAMADA AL CONSTRUCTOR DE LA CURVA
  miPrimeraBezier = new curvaBezier(p, c, num);
}

void draw() {
  background(111);
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
  /*case stateEditTop:
    // edit
    background(0); 
    lights();
    camera(width/2 + 150, height/2, (height/2)/tan(PI*30/180), width/2 + 150, height/2, 0, 0, 1, 0);
    noStroke();
    fill(111);
    translate(width/2, height/2);
    rotateX(PI/3);
    translate(-w/2, -h/2);
    lights();
    for (int x = 0; x < cols; x++) {
      for (int y = 0; y < rows; y++) {        
        rect(x*scl, y*scl, scl, scl);
      }
    }
    break; */

  case stateShowTerrain:
    background(0); 
    lights();
    camera(width/2 + 100, height/2 + 50, (height/2)/tan(PI*30/180), width/2 + 100, height/2 + 50, 0, 0, 1, 0);
    noStroke();
    fill(111);
    translate(width/2, height/2);
    rotateX(PI/3);
    translate(-w/2, -h/2);
    lights();
    for (int x = 0; x < cols; x++) {
      for (int y = 0; y < rows; y++) {        
        rect(x*scl, y*scl, scl, scl);
      }
    }
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

  //miPrimeraBezier.pintarCurva();
}
