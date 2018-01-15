Settings settings;

void setup() {
  size(640, 480, P2D);
  settings = new Settings("settings.txt");
  frameRate(30);
  
  setupSyphon();
  setupShaders();
  setupKinect();
}

void draw() {
  updateKinect();
  
  tex.beginDraw();
  tex.filter(shader);
  tex.endDraw();
  image(tex, 0, 0);
  
  updateSyphon();
}