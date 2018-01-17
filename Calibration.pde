// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

// KEYSTONE (quick setup, but not accurate)
import deadpixel.keystone.*;

Keystone ks;
CornerPinSurface surface;
PGraphics depthImgKey;

void initCalibration() {
  ks = new Keystone(this);
  surface = ks.createCornerPinSurface(width, height, 20); // width, height, divisions
}

void setupCalibration() {
  depthImgKey = createGraphics(width, height, P2D);
  initCalibration();
  ks.load();
}

void updateCalibration() {
  depthImgKey.beginDraw();
  depthImgKey.clear();
  surface.render(depthImgKey, depthImg);
  depthImgKey.endDraw();
}

// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~