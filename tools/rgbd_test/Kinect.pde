boolean mirror = true;

// SIMPLEOPENNI
import SimpleOpenNI.*;

SimpleOpenNI context;

void setupKinect() {
  context = new SimpleOpenNI(this, SimpleOpenNI.RUN_MODE_MULTI_THREADED);
  context.setMirror(mirror);
  context.enableDepth(640, 480, 30);
}

void updateKinect() {
  context.update();
  rgbImg = context.rgbImage();
  depthImg = context.depthImage();
}

void drawKinect() {
  image(depthImg, 0, 0);
} 

void runKinect() {
  updateKinect();
  drawKinect();
}