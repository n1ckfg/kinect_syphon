PShader shader; 
PImage rgbImg, depthImg;

PVector shaderMousePos = new PVector(0,0);
PVector shaderMouseClick = new PVector(0,0);

void setupShaders() {
  shader = loadShader("rgba.glsl"); 
  shaderSetSize(shader);
  rgbImg = loadImage("rgb.png");
  depthImg = loadImage("depth.png");
}

void updateShaders() {
  //shaderSetMouse(shader);
  //shaderSetTime(shader);
  shaderSetTexture(shader, "tex0", rgbImg);
  shaderSetTexture(shader, "tex1", depthImg);
}

void drawShaders() {
  filter(shader);
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