import codeanticode.syphon.*;

PGraphics canvas;
SyphonServer server;

void setup() {
  size(640, 480, P3D);
  canvas = createGraphics(width, height, P3D);
  server = new SyphonServer(this, "Kinect_Syphon");
  setupShaders();
}

void draw() {
  canvas.beginDraw();
  canvas.filter(shader);
  canvas.endDraw();
  image(canvas, 0, 0);
  server.sendImage(canvas);
}