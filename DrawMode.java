// https://forum.processing.org/two/discussion/9877/how-to-use-enums
// https://stackoverflow.com/questions/17664445/is-there-an-increment-operator-for-java-enum

enum DrawMode { 
  
  RGBD,
  DEPTH_ONLY,
  RGB_ONLY,
  DEPTH_COLOR {
    @Override
    DrawMode next() {
      // rollover to the first
      return values()[0];
    };
  };

  DrawMode next() {
    // No bounds checking required here, because the last instance overrides
    return values()[ordinal() + 1];
  }
  
}