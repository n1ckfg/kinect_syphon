Settings settings;
DrawMode drawMode;
LayoutMode layoutMode;
PGraphics depthBuffer, rgbBuffer;

PFont font;
int fontSize = 18;
int lastButtonPress = 0;
int textDelay = 2000;
boolean glitch = false;

void setup() {
  size(640, 480, P2D);
  drawMode = DrawMode.RGBD;
  layoutMode = LayoutMode.SD;
  settings = new Settings("settings.txt");
  
  if (layoutMode == LayoutMode.SD) {
    depthBuffer = createGraphics(640, 480, P2D);
    rgbBuffer = createGraphics(640, 480, P2D);
  } else if (layoutMode == LayoutMode.HOLOFLIX) {
    surface.setSize(1280, 720);
    depthBuffer = createGraphics(640, 480, P2D);
    rgbBuffer = createGraphics(640, 480, P2D);
  } else if (layoutMode == LayoutMode.RGBDTK) {
    surface.setSize(512, 848);
    depthBuffer = createGraphics(424, 512, P2D);
    rgbBuffer = createGraphics(424, 512, P2D);
  }
  
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
    
  if (layoutMode == LayoutMode.SD) {
    if (drawMode == DrawMode.RGBD) {  
      if (glitch) {
        depthBuffer.beginDraw();
        depthBuffer.image(depthImg, 0, 0);
        depthBuffer.filter(shader);
        depthBuffer.endDraw();
             
        tex.beginDraw();
        tex.image(depthBuffer, 0, 0);
        tex.endDraw();
      } else {
        tex.beginDraw();
        tex.filter(shader);
        tex.endDraw();
      }
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
  } else if (layoutMode == LayoutMode.HOLOFLIX) {
    if (drawMode == DrawMode.RGBD) {
      if (glitch) {
        depthBuffer.beginDraw();
        depthBuffer.image(depthImg, 0, 0);
        depthBuffer.filter(shader);
        depthBuffer.endDraw();
             
        tex.beginDraw();
        tex.image(depthImg, 0, 120);
        tex.image(depthBuffer, width/2, 120);
        tex.endDraw();      
      } else {
        tex.beginDraw();
        tex.image(depthImg, 0, 120);
        tex.image(rgbImg, width/2, 120);
        tex.endDraw();
      }
    } else if (drawMode == DrawMode.DEPTH_ONLY) {
      tex.beginDraw();
      tex.image(depthImg, 0, 120);
      tex.endDraw();
    } else if (drawMode == DrawMode.RGB_ONLY) {
      tex.beginDraw();
      tex.image(rgbImg, width/2, 120);
      tex.endDraw();
    } else if (drawMode == DrawMode.DEPTH_COLOR) {
      depthBuffer.beginDraw();
      depthBuffer.image(depthImg, 0, 0);
      depthBuffer.filter(shader2);
      depthBuffer.endDraw();
      
      tex.beginDraw();
      tex.image(depthBuffer, 0, 120);
      tex.image(rgbImg, width/2, 120);
      tex.endDraw();
    }  
  } else if (layoutMode == LayoutMode.RGBDTK) {
    depthBuffer.beginDraw();
    depthBuffer.image(depthImg, 0, 0, depthBuffer.width, depthBuffer.height);
    depthBuffer.endDraw();
      
    rgbBuffer.beginDraw();
    rgbBuffer.image(rgbImg, 0, 0, rgbBuffer.width, rgbBuffer.height);
    rgbBuffer.endDraw();
      
    tex.beginDraw();
    tex.pushMatrix();
    tex.translate(width,0);
    tex.rotate(radians(90));
    tex.image(rgbBuffer, 0, 0);
    tex.popMatrix();
    
    tex.pushMatrix();
    tex.translate(width, height/2);
    tex.rotate(radians(90));
    tex.image(depthBuffer, 0, 0);
    tex.popMatrix();
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
