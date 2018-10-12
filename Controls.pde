void keyPressed() {
  switch(key) {      
    case 'd':
      lastButtonPress = millis();
      drawMode = drawMode.next();
      break;
    case 'g':
      glitch = !glitch;
  }
  
  switch(keyCode) {
    case UP:
      changeThreshold(threshStep);
      break;
    case DOWN:
      changeThreshold(-threshStep);
      break;
  }

} 

int threshStep = 5;

void changeThreshold(int val) {
    threshold += val;
    threshold = constrain(threshold, 0, 255);
    println("threshold: " + threshold);
}
