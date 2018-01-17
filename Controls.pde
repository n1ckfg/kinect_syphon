void keyPressed() {
  switch(key) {
    case 'c': // enter/leave calibration mode
      if (drawMode == DrawMode.RGBD) ks.toggleCalibration();
      break;
  
    case 'l': // loads the saved layout
      if (drawMode == DrawMode.RGBD) ks.load();
      break;
  
    case 's': // saves the layout
      if (drawMode == DrawMode.RGBD) ks.save();
      break;
      
    case 'r': // reset the layout
      if (drawMode == DrawMode.RGBD) initCalibration();
      break;
      
    case 'd':
      lastButtonPress = millis();
      drawMode = drawMode.next();
      break;
  }
} 