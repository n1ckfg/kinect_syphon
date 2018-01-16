boolean mirror = true;

// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
// SIMPLEOPENNI (Kinect v1, all platforms)
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
/*
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
*/
// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
// KINECT4WIN (WIN / MS SDK 1.8 / Kinect v1)

import kinect4WinSDK.Kinect;
import kinect4WinSDK.SkeletonData;

Kinect kinect;

void setupKinect() {
  kinect = new Kinect(this);
}

void updateKinect() {
  depthImg = kinect.GetDepth();
  rgbImg = kinect.GetImage();
}