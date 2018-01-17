void keyPressed() {
  switch(key) {
    case 'c': // enter/leave calibration mode
      if (drawMode == DrawMode.RGBA) toggleCalibration();
      break;
  
    case 'l': // loads the saved layout
      if (drawMode == DrawMode.RGBA) loadCalibration();
      break;
  
    case 's': // saves the layout
      if (drawMode == DrawMode.RGBA) saveCalibration();
      break;
      
    case 'r': // reset the layout
      if (drawMode == DrawMode.RGBA) resetCalibration();
      break;
      
    case 'd':
      lastButtonPress = millis();
      drawMode = drawMode.next();
      break;
  }
} 