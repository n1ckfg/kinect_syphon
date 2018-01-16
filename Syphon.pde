String serverName = "Kinect_Server";

// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
// SYPHON (MAC)
import codeanticode.syphon.*;

PGraphics tex;
SyphonServer server;

void setupSyphon() {
  tex = createGraphics(width, height, P2D);
  server = new SyphonServer(this, serverName);
}

void updateSyphon() {
  server.sendImage(tex);
}

// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
/*
// SPOUT (WIN)
import spout.*;

Spout server;

void setupSyphon() {
  server = new Spout(this);
  server.createSender(serverName);
}

void updateSyphon() {
  server.sendTexture();
}
*/
// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~