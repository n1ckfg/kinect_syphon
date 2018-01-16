Settings settings;
DrawMode drawMode;

void setup() {
  size(640, 480, P2D);
  settings = new Settings("settings.txt");
  drawMode = DrawMode.RGBD;
  frameRate(30);
  
  setupSyphon();
  setupShaders();
  setupKinect();
  setupKeystone();
}

void draw() {
  background(0);
  
  updateKinect();
  updateKeystone();
  updateShaders();
  
  tex.beginDraw();
  tex.filter(shader);
  tex.endDraw();

  updateSyphon();  
  
  if (drawMode == DrawMode.RGBD) {
    image(tex,0,0);
  } else if (drawMode == DrawMode.DEPTH_ONLY) {
    image(depthImg, 0, 0);
  } else if (drawMode == DrawMode.RGB_ONLY) {
    image(rgbImg, 0, 0);
  }
}