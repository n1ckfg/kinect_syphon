import SimpleOpenNI.*;
import codeanticode.syphon.*;

SimpleOpenNI context;
SyphonServer server;
String serverName = "Kinect to Syphon";
PGraphics buffer;

int sW = 640;
int sH = 480;
int fps = 30;

boolean showImage = true;
boolean mirror = true;
boolean multiThread = true;

void setup() {
  try {
    Settings settings = new Settings("settings.txt");
  } catch (Exception e) {
    println("No settings file. Using defaults.");
  }
  
  if (showImage) {
    size(sW, sH, P2D);
  } else {
    size(50, 50, P2D);
  }
  
  frameRate(fps);
  noSmooth();
  
  buffer = createGraphics(sW, sH, P2D);
  
  if (multiThread) {
    context = new SimpleOpenNI(this,SimpleOpenNI.RUN_MODE_MULTI_THREADED);
  } else {
    context = new SimpleOpenNI(this);
  }
    
  context.setMirror(mirror);
  context.enableDepth();
    
  server = new SyphonServer(this, serverName);
}

void draw() {
  context.update();
  buffer.beginDraw();
  buffer.image(context.depthImage(), 0, 0, sW, sH);
  buffer.endDraw();
  server.sendImage(buffer);
  
  if (showImage) {
    image(buffer,0,0);
  } else {
    background(0,255,0);
  }
  
  frame.setTitle(""+frameRate);
}
