boolean mirror = false;
boolean align = true;
boolean multithreaded = true;
//PImage depthImg, rgbImg;

// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

/*
// OPENKINECT (MAC / OPENNI / Kinect v1)
import org.openkinect.freenect.*;
import org.openkinect.processing.*;

Kinect kinect;

void setupKinect() {
  depthImg = createImage(640, 480, RGB);
  rgbImg = createImage(640, 480, RGB);
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
/*
// KINECT4WIN (WIN / MS SDK 1.8 / Kinect v1)
import kinect4WinSDK.Kinect;
import kinect4WinSDK.SkeletonData;

Kinect kinect;

void setupKinect() {
  depthImg = createImage(640, 480, RGB);
  rgbImg = createImage(640, 480, RGB);
  kinect = new Kinect(this);
}

void updateKinect() {
  depthImg = kinect.GetDepth();
  rgbImg = kinect.GetImage();
}
*/
// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

// SIMPLEOPENNI (Kinect v1, all platforms)
import SimpleOpenNI.*;

SimpleOpenNI context;

void setupKinect() {
  depthImg = createImage(640, 480, RGB);
  rgbImg = createImage(640, 480, RGB);
  if (multithreaded) {
    context = new SimpleOpenNI(this,SimpleOpenNI.RUN_MODE_MULTI_THREADED);
  } else {
    context = new SimpleOpenNI(this);
  }
  context.setMirror(mirror);
  context.enableDepth();
  context.enableRGB();
  //context.enableIR();
  if (align) {
    context.alternativeViewPointDepthToImage();
    context.setDepthColorSyncEnabled(true);
  }
}

void updateKinect() {
  context.update();
  depthImg = context.depthImage();
  rgbImg = context.rgbImage();
  //rgbImg = context.irImage();
}

// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
