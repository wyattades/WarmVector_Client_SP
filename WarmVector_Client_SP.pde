import gifAnimation.*;
import ddf.minim.*;
import java.awt.geom.*;
import java.io.File;

Main main;

boolean sketchFullScreen() {
  return true;
}

void setup() {
  main = new Main(this);
}

void draw() {
  main.run();
}

void keyPressed() {
  main.input.pressKey(key, keyCode);
}

void keyReleased() {
  main.input.releaseKey(key, keyCode);
}

void mousePressed() {
  main.input.pressMouse(mouseButton);
}

void mouseReleased() {
  main.input.releaseMouse(mouseButton);
}

