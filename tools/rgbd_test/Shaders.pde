PShader shader; 

PImage tex1, tex2;

PVector shaderMousePos = new PVector(0,0);
PVector shaderMouseClick = new PVector(0,0);

void setupShaders() {
  shader = loadShader("rgba.glsl"); 
  shaderSetSize(shader);
  tex1 = loadImage("rgb.png");
  tex2 = loadImage("depth.png");
  shaderSetTexture(shader, "texture1", tex1);
  shaderSetTexture(shader, "texture2", tex2);
}

void updateShaders() {
  shaderSetMouse(shader);
  shaderSetTime(shader);
}

void drawShaders() {
  filter(shader);
}

void runShaders() {
  updateShaders();
  drawShaders();
}

// ~ ~ ~ ~ ~ ~ ~

void shaderSetSize(PShader ps) {
  ps.set("iResolution", float(width), float(height), 1.0);
}

void shaderSetMouse(PShader ps) {
  if (mousePressed) shaderMousePos = new PVector(mouseX, height - mouseY);
  ps.set("iMouse", shaderMousePos.x, shaderMousePos.y, shaderMouseClick.x, shaderMouseClick.y);
}

void shaderSetTime(PShader ps) {
  ps.set("iGlobalTime", float(millis()) / 1000.0);
}

void shaderMousePressed() {
  shaderMouseClick = new PVector(mouseX, height - mouseY);
}

void shaderMouseReleased() {
  shaderMouseClick = new PVector(-shaderMouseClick.x, -shaderMouseClick.y);
}

void shaderSetTexture(PShader ps, String name, PImage tex) {
  ps.set(name, tex);
}