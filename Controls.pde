void keyPressed() {
  switch(key) {
    case 'c': // enter/leave calibration mode
      if (drawMode == DrawMode.RGBA) ks.toggleCalibration();
      break;
  
    case 'l': // loads the saved layout
      if (drawMode == DrawMode.RGBA) ks.load();
      break;
  
    case 's': // saves the layout
      if (drawMode == DrawMode.RGBA) ks.save();
      break;
      
    case 'r': // reset the layout
      if (drawMode == DrawMode.RGBA) initCalibration();
      break;
      
    case 'd':
      lastButtonPress = millis();
      drawMode = drawMode.next();
      break;
  }
} 