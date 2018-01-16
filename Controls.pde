void keyPressed() {
  switch(key) {
    case 'c':
      // enter/leave calibration mode, where surfaces can be warped 
      // and moved
      ks.toggleCalibration();
      break;
  
    case 'l':
      // loads the saved layout
      ks.load();
      break;
  
    case 's':
      // saves the layout
      ks.save();
      break;
      
    case 'd':
      drawMode = drawMode.next();
      break;
  }
} 