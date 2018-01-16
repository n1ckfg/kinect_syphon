boolean mirror = true;

// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
// SIMPLEOPENNI
/*
import SimpleOpenNI.*;

SimpleOpenNI context;

void setupKinect() {
  context = new SimpleOpenNI(this);
  context.setMirror(mirror);
  context.enableDepth();
  context.enableRGB();
}

void updateKinect() {
  context.update();
  depthImg = context.depthImage();
  rgbImg = context.rgbImage();
}
*/

// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
// OPENKINECT (MAC / OPENNI / Kinect v1)
import org.openkinect.freenect.*;
import org.openkinect.processing.*;

Kinect kinect;

void setupKinect() {
  kinect = new Kinect(this);
  kinect.enableMirror(mirror);
  kinect.initDepth();
  kinect.initVideo();
}

void updateKinect() {
  depthImg = kinect.getDepthImage();
  rgbImg = kinect.getVideoImage();
}