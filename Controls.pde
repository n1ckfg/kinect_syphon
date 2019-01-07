void keyPressed() {
  switch(key) {      
    case 'd':
      lastButtonPress = millis();
      drawMode = drawMode.next();
      break;
    case 'g':
      glitch = !glitch;
      break;
    case 'i':
      invertDepth = !invertDepth;
      break;
  }  
} 

float threshStep = 5;

void changeThreshold(float val) {
    threshold += val;
    threshold = constrain(threshold, 0, 255);
    println("threshold: " + threshold);
}

void updateControls() {
  if (keyPressed) {
    switch(keyCode) {
      case UP:
        changeThreshold(threshStep);
        break;
      case DOWN:
        changeThreshold(-threshStep);
        break;
    }
  }
}
