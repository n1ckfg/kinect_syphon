Settings settings;
DrawMode drawMode;
LayoutMode layoutMode;
PGraphics dBuffer_640, dBuffer2_640, dBuffer_512, rBuffer_640, rBuffer2_640, rBuffer_512;

PFont font;
int fontSize = 18;
int lastButtonPress = 0;
int textDelay = 2000;
boolean glitch = false;
float threshold = 0;

void setup() {
  size(640, 480, P2D);
  drawMode = DrawMode.RGBD;
  layoutMode = LayoutMode.SD;
  settings = new Settings("settings.txt");

  dBuffer_640 = createGraphics(640, 480, P2D);
  dBuffer2_640 = createGraphics(640, 480, P2D);
  dBuffer_512 = createGraphics(512, 424, P2D);
  rBuffer_640 = createGraphics(640, 480, P2D);
  rBuffer2_640 = createGraphics(640, 480, P2D);
  rBuffer_512 = createGraphics(512, 424, P2D);
    
  if (layoutMode == LayoutMode.SD) {
    //
  } else if (layoutMode == LayoutMode.HOLOFLIX) {
    surface.setSize(1280, 720);
  } else if (layoutMode == LayoutMode.RGBDTK) {
    surface.setSize(512, 848);
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
  
  updateControls();
  updateKinect();
  updateShaders();
  
  if (layoutMode == LayoutMode.SD) {
    if (drawMode == DrawMode.RGBD) {  
      if (glitch) {
        dBuffer_640.beginDraw();
        dBuffer_640.image(depthImg, 0, 0);
        dBuffer_640.filter(shader_rgba);
        dBuffer_640.endDraw();
             
        tex.beginDraw();
        tex.image(dBuffer_640, 0, 0);
        tex.endDraw();
      } else {
        tex.beginDraw();
        tex.filter(shader_rgba);
        tex.endDraw();
      }
    } else if (drawMode == DrawMode.DEPTH_ONLY) {
      tex.beginDraw();
      tex.filter(shader_threshmult_d);
      tex.endDraw();
    } else if (drawMode == DrawMode.RGB_ONLY) {
      tex.beginDraw();
      tex.image(rgbImg, 0, 0);
      tex.endDraw();
    } else if (drawMode == DrawMode.DEPTH_COLOR) {
      tex.beginDraw();
      tex.filter(shader_depth_color);
      tex.endDraw();
    }
  } else if (layoutMode == LayoutMode.HOLOFLIX) {
    if (drawMode == DrawMode.RGBD) {
      dBuffer_640.beginDraw();
      dBuffer_640.filter(shader_threshmult_d);
      dBuffer_640.endDraw();
  
      rBuffer_640.beginDraw();
      rBuffer_640.filter(shader_threshmult_r);
      rBuffer_640.endDraw();       
      
      tex.beginDraw();
      tex.image(dBuffer_640, 0, 120);
      tex.image(rBuffer_640, width/2, 120);
      tex.endDraw();     
    } else if (drawMode == DrawMode.DEPTH_ONLY) {
      tex.beginDraw();
      tex.image(depthImg, 0, 120);
      tex.filter(shader_threshmult_d);
      tex.endDraw();
    } else if (drawMode == DrawMode.RGB_ONLY) {
      tex.beginDraw();
      tex.image(rgbImg, width/2, 120);
      tex.endDraw();
    } else if (drawMode == DrawMode.DEPTH_COLOR) {      
      dBuffer_640.beginDraw();
      dBuffer_640.filter(shader_threshmult_d);
      dBuffer_640.endDraw();

      dBuffer2_640.beginDraw();
      dBuffer2_640.filter(shader_depth_color2);
      dBuffer2_640.endDraw();
      
      rBuffer_640.beginDraw();
      rBuffer_640.filter(shader_threshmult_r);
      rBuffer_640.endDraw();       
      
      tex.beginDraw();
      tex.image(dBuffer2_640, 0, 120);
      tex.image(rBuffer_640, width/2, 120);
      tex.endDraw();  
    }  
  } else if (layoutMode == LayoutMode.RGBDTK) {
    dBuffer_640.beginDraw();
    dBuffer_640.filter(shader_threshmult_d);
    dBuffer_640.endDraw();

    dBuffer2_640.beginDraw();
    dBuffer2_640.filter(shader_depth_color2);
    dBuffer2_640.endDraw();
    
    dBuffer_512.beginDraw();
    dBuffer_512.image(dBuffer2_640, 0, 0, dBuffer_512.width, dBuffer_512.height);
    dBuffer_512.endDraw();
 
    rBuffer_640.beginDraw();
    rBuffer_640.filter(shader_threshmult_r);
    rBuffer_640.endDraw();
    
    rBuffer_512.beginDraw();
    rBuffer_512.image(rBuffer_640, 0, 0, rBuffer_512.width, rBuffer_512.height);
    rBuffer_512.endDraw();
    
    tex.beginDraw();
    tex.image(dBuffer_512, 0, height/2);
    tex.image(rBuffer_512, 0, 0, width, height/2);
    tex.endDraw(); 
  }
  
  tex.beginDraw();
  tex.background(0);
  tex.image(tex, 0, 0);
  tex.endDraw();
  
  updateSyphon();  
  image(tex,0,0);
  
  if (millis() < lastButtonPress + textDelay) {
    fill(0);
    text(""+drawMode, fontSize, 1.5*fontSize);
    fill(255);
    text(""+drawMode, fontSize - 1, 1.5 * fontSize - 1);
  }
}
