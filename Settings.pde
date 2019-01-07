class Settings {
  
  String[] data;
  
  Settings(String _s) {
    try {
      data = loadStrings(_s);
      for (int i=0;i<data.length;i++) {
        if (data[i].equals("Server Name")) serverName = setString(data[i+1]);
        if (data[i].equals("Mirror")) mirror = setBoolean(data[i+1]);
        if (data[i].equals("Glitch")) glitch = setBoolean(data[i+1]);
        if (data[i].equals("Threshold")) threshold = setFloat(data[i+1]);
        if (data[i].equals("Calibrate RGBD")) align = setBoolean(data[i+1]);
        if (data[i].equals("Invert Depth")) invertDepth = setBoolean(data[i+1]);
        if (data[i].equals("Draw Mode (RGBD, DEPTH_ONLY, RGB_ONLY, DEPTH_COLOR)")) {
            if (data[i+1].equals("RGBD")) {
              drawMode = DrawMode.RGBD;
            } else if (data[i+1].equals("DEPTH_ONLY")) {
              drawMode = DrawMode.DEPTH_ONLY;
            } else if (data[i+1].equals("RGB_ONLY")) {
              drawMode = DrawMode.RGB_ONLY;
            } else if (data[i+1].equals("DEPTH_COLOR")) {
              drawMode = DrawMode.DEPTH_COLOR;              
            }
        }
        if (data[i].equals("Layout Mode (SD, HOLOFLIX, RGBDTK)")) {
            if (data[i+1].equals("SD")) {
              layoutMode = LayoutMode.SD;
            } else if (data[i+1].equals("HOLOFLIX")) {
              layoutMode = LayoutMode.HOLOFLIX;
            } else if (data[i+1].equals("RGBDTK")) {
              layoutMode = LayoutMode.RGBDTK;
            }
        }
      }
    } catch(Exception e) {
      println("Couldn't load settings file. Using defaults.");
    }
  }

  int setInt(String _s) {
    return int(_s);
  }

  float setFloat(String _s) {
    return float(_s);
  }

  boolean setBoolean(String _s) {
    return boolean(_s);
  }

  String setString(String _s) {
    return ""+(_s);
  }
  
  color setColor(String _s) {
    color endColor = color(0);
    int commaCounter=0;
    String sr = "";
    String sg = "";
    String sb = "";
    String sa = "";
    int r = 0;
    int g = 0;
    int b = 0;
    int a = 0;

    for (int i=0;i<_s.length();i++) {
        if (_s.charAt(i)!=char(' ') && _s.charAt(i)!=char('(') && _s.charAt(i)!=char(')')) {
          if (_s.charAt(i)==char(',')){
            commaCounter++;
          }else{
          if (commaCounter==0) sr += _s.charAt(i);
          if (commaCounter==1) sg += _s.charAt(i);
          if (commaCounter==2) sb += _s.charAt(i); 
          if (commaCounter==3) sa += _s.charAt(i);
         }
       }
     }

    if (sr!="" && sg=="" && sb=="" && sa=="") {
      r = int(sr);
      endColor = color(r);
    }
    if (sr!="" && sg!="" && sb=="" && sa=="") {
      r = int(sr);
      g = int(sg);
      endColor = color(r, g);
    }
    if (sr!="" && sg!="" && sb!="" && sa=="") {
      r = int(sr);
      g = int(sg);
      b = int(sb);
      endColor = color(r, g, b);
    }
    if (sr!="" && sg!="" && sb!="" && sa!="") {
      r = int(sr);
      g = int(sg);
      b = int(sb);
      a = int(sa);
      endColor = color(r, g, b, a);
    }
      return endColor;
  }
}
