String serverName = "Kinect_Server";
PGraphics tex;

// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

// SYPHON (MAC)
import codeanticode.syphon.*;

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
  tex = createGraphics(width, height, P2D);
  server = new Spout(this);
  server.createSender(serverName);
}

void updateSyphon() {
  server.sendTexture(tex);
}
*/
// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
