PShader shader, shader2;
PImage rgbImg, depthImg;

PVector shaderMousePos = new PVector(0,0);
PVector shaderMouseClick = new PVector(0,0);

void setupShaders() {
  shader = loadShader("rgba.glsl"); 
  shader2 = loadShader("depth_color.glsl"); 
  shaderSetSize(shader, 640, 480);
  shaderSetSize(shader2, 640, 480);
}

void updateShaders() {
  //shaderSetMouse(shader);
  //shaderSetTime(shader);
  if (drawMode == DrawMode.RGBD) {
    shaderSetTexture(shader, "tex0", rgbImg);
    shaderSetTexture(shader, "tex1", depthImg);
  }
  
  if (layoutMode == LayoutMode.RGBDTK || drawMode == DrawMode.DEPTH_COLOR) {
    shaderSetTexture(shader2, "tex0", depthImg);
  }
}

void drawShaders() {
  filter(shader);
}

// ~ ~ ~ ~ ~ ~ ~

void shaderSetVar(PShader ps, String name, float val) {
    ps.set(name, val);
}

void shaderSetSize(PShader ps) {
  ps.set("iResolution", float(width), float(height), 1.0);
}

void shaderSetSize(PShader ps, float w, float h) {
  ps.set("iResolution", w, h, 1.0);
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
