// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

// KEYSTONE (quick setup, but not accurate)
import deadpixel.keystone.*;

Keystone ks;
CornerPinSurface surface;
PGraphics depthImgKey;

void setupCalibration() {
  depthImgKey = createGraphics(width, height, P2D);
  resetCalibration();
  ks.load();
}

void updateCalibration() {
  depthImgKey.beginDraw();
  depthImgKey.clear();
  surface.render(depthImgKey, depthImg);
  depthImgKey.endDraw();
}

void toggleCalibration() {
  ks.toggleCalibration();
}

void loadCalibration() {
  ks.load();
}

void saveCalibration() {
  ks.save();
}

void resetCalibration() {
  ks = new Keystone(this);
  surface = ks.createCornerPinSurface(width, height, 20); // width, height, divisions
}


// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~