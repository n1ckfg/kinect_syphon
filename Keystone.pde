import deadpixel.keystone.*;

Keystone ks;
CornerPinSurface surface;
PGraphics depthImgKey;

void setupKeystone() {
  depthImgKey = createGraphics(width, height, P2D);
  ks = new Keystone(this);
  surface = ks.createCornerPinSurface(width, height, 20); // width, height, divisions
}

void updateKeystone() {
  depthImgKey.beginDraw();
  depthImgKey.clear();
  surface.render(depthImgKey, depthImg);
  depthImgKey.endDraw();
}