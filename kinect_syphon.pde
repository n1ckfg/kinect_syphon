Settings settings;
DrawMode drawMode;
PFont font;
int fontSize = 18;
int lastButtonPress = 0;
int textDelay = 2000;

void setup() {
  size(640, 480, P2D);
  settings = new Settings("settings.txt");
  drawMode = DrawMode.RGBA;
  frameRate(30);
  font = loadFont("Silkscreen-18.vlw");
  textFont(font, fontSize);
  
  setupSyphon();
  setupShaders();
  setupKinect();
  
  lastButtonPress = millis();
}

void draw() {
  background(0);
  
  updateKinect();
  updateShaders();
    
  if (drawMode == DrawMode.RGBA) {
    tex.beginDraw();
    tex.filter(shader);
    tex.endDraw();
  } else if (drawMode == DrawMode.DEPTH_ONLY) {
    tex.beginDraw();
    tex.image(depthImg, 0, 0);
    tex.endDraw();
  } else if (drawMode == DrawMode.RGB_ONLY) {
    tex.beginDraw();
    tex.image(rgbImg, 0, 0);
    tex.endDraw();
  } else if (drawMode == DrawMode.DEPTH_COLOR) {
    tex.beginDraw();
    tex.filter(shader2);
    tex.endDraw();
  }
  
  updateSyphon();  
  image(tex,0,0);
  
  if (millis() < lastButtonPress + textDelay) {
    fill(0);
    text(""+drawMode, fontSize, 1.5*fontSize);
    fill(255);
    text(""+drawMode, fontSize - 1, 1.5 * fontSize - 1);
  }
}
