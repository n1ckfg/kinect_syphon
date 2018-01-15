void setup() {
  size(640, 480, P3D);
  setupShaders();
}

void draw() {
  background(0);
  updateShaders();
  drawShaders();
}