import codeanticode.syphon.*;

PGraphics canvas;
SyphonClient client;

public void setup() {
  size(640, 480, P3D);
  
  println("Available Syphon servers:");
  println(SyphonClient.listServers());
    
  // Create syhpon client to receive frames 
  // from the first available running server: 
  client = new SyphonClient(this);

  // A Syphon server can be specified by the name of the application that it contains it,
  // its name, or both:
  
  // Only application name.
  //client = new SyphonClient(this, "unity_test", "Main Camera");
    
  // Both application and server names
  //client = new SyphonClient(this, "SendFrames", "Processing Syphon");
  
  // Only server name
  //client = new SyphonClient(this, "", "Processing Syphon");
    
  // An application can have several servers:
  //client = new SyphonClient(this, "Quartz Composer", "Raw Image");
  //client = new SyphonClient(this, "Quartz Composer", "Scene");
  
  setupPointCloud();
}

public void draw() {  
  if (client.newFrame()) {
    background(0);
    canvas = client.getGraphics(canvas);
    image(canvas, 0, 0, width, height);    
    //drawPointCloud();
  }  
}

void keyPressed() {
  if (key == ' ') {
    client.stop();  
  } else if (key == 'd') {
    println(client.getServerName());
  }
}