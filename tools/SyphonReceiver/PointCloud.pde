// Daniel Shiffman
// Kinect Point Cloud example

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

// Angle for rotation
float a = 2.5;
float bitDepthAdjust = 0.25;

// We'll use a lookup table so that we don't have to repeat the math over and over
float[] depthLookUp = new float[2048];

void setupPointCloud() {
  // Lookup table for all possible depth values (0 - 2047)
  for (int i = 0; i < depthLookUp.length; i++) {
    depthLookUp[i] = rawDepthToMeters(i);
  }
}

void drawPointCloud() {
  // Get the raw depth as array of integers
  canvas.loadPixels();//kinect.getRawDepth();

  // We're just going to calculate and draw every 4th pixel (equivalent of 160x120)
  int skip = 4;

  // Translate and rotate
  translate(500, 0, -50);
  rotateY(a);

  for (int x = 0; x < width; x += skip) {
    for (int y = 0; y < height; y += skip) {
      int offset = x + y*width;

      // Convert kinect data to world xyz coordinate
      int rawDepth = int(alpha(canvas.pixels[offset]));
      PVector v = depthToWorld(x, y, rawDepth);

      stroke(canvas.pixels[offset]);
      strokeWeight(8);
      pushMatrix();
      // Scale up by 200
      float factor = 100;
      translate(v.x*factor, v.y*factor, factor-v.z*factor);
      // Draw a point
      point(0, 0);
      popMatrix();
    }
  }
}

// These functions come from: http://graphics.stanford.edu/~mdfisher/Kinect.html
float rawDepthToMeters(int depthValue) {
  if (depthValue < 2047) {
    return (float)(1.0 / ((double)(depthValue) * (bitDepthAdjust*-0.0030711016) + (bitDepthAdjust*3.3309495161)));
  }
  return 0.0f;
}

PVector depthToWorld(int x, int y, int depthValue) {
  final double fx_d = 1.0 / (bitDepthAdjust*5.9421434211923247e+02);
  final double fy_d = 1.0 / (bitDepthAdjust*5.9104053696870778e+02);
  final double cx_d = (bitDepthAdjust*3.3930780975300314e+02);
  final double cy_d = (bitDepthAdjust*2.4273913761751615e+02);

  PVector result = new PVector();
  double depth =  depthLookUp[depthValue];//rawDepthToMeters(depthValue);
  result.x = (float)((x - cx_d) * depth * fx_d);
  result.y = (float)((y - cy_d) * depth * fy_d);
  result.z = (float)(depth);
  return result;
}