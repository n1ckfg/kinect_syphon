void setup() {
  size(640, 480, P3D);
  setupShaders();
}

void draw() {
  updateShaders();
  drawShaders();
}