PShader shader_rgba, shader_depth_color, shader_depth_color2, shader_threshmult_d, shader_threshmult_r;
PImage rgbImg, depthImg;

PVector shaderMousePos = new PVector(0,0);
PVector shaderMouseClick = new PVector(0,0);

void setupShaders() {
  shader_rgba = loadShader("rgba.glsl"); 
  shader_depth_color = loadShader("depth_color.glsl"); 
  shader_depth_color2 = loadShader("depth_color2.glsl"); 
  shader_threshmult_d = loadShader("threshmult_d.glsl");
  shader_threshmult_r = loadShader("threshmult_r.glsl");
  
  shaderSetSize(shader_rgba, 640, 480);
  shaderSetSize(shader_depth_color, 640, 480);
  shaderSetSize(shader_depth_color2, 640, 480);
  shaderSetSize(shader_threshmult_d, 640, 480);
  shaderSetSize(shader_threshmult_r, 640, 480);
}

void updateShaders() {
  //shaderSetMouse(shader);
  //shaderSetTime(shader);
  if (drawMode == DrawMode.RGBD) {
    shaderSetTexture(shader_rgba, "tex0", rgbImg);
    shaderSetTexture(shader_rgba, "tex1", depthImg);
  }
  
  if (layoutMode == LayoutMode.RGBDTK || drawMode == DrawMode.DEPTH_COLOR) {
    shaderSetTexture(shader_depth_color2, "tex0", dBuffer_640);
  }
    
  if (layoutMode == LayoutMode.RGBDTK || layoutMode == LayoutMode.HOLOFLIX) {
    if (glitch) {
      shaderSetVar(shader_threshmult_d, "alpha", 0);
      shaderSetVar(shader_threshmult_r, "alpha", 0);
    } else {
      shaderSetVar(shader_threshmult_d, "alpha", 1);
      shaderSetVar(shader_threshmult_r, "alpha", 1);
    }
    shaderSetVar(shader_threshmult_d, "threshold", threshold);
    shaderSetTexture(shader_threshmult_d, "tex0", depthImg);
    shaderSetVar(shader_threshmult_r, "threshold", threshold);
    shaderSetTexture(shader_threshmult_r, "tex0", depthImg);
    shaderSetTexture(shader_threshmult_r, "tex1", rgbImg);
  }
}

//void drawShaders() {
  //filter(shader);
//}

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
