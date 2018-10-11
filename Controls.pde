void keyPressed() {
  switch(key) {      
    case 'd':
      lastButtonPress = millis();
      drawMode = drawMode.next();
      break;
  }
} 
