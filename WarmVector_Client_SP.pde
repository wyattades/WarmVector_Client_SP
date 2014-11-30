//WarmVector game created by Wyatt Ades

import ddf.minim.*;
import java.awt.geom.*;

//String[] config = loadStrings("..\..\WarmVector\config.txt");
Minim minim;
String[] audioStrings = { //stores the names of all the audio files
}; 
String[] imageStrings = { //stores the names of all the image files
  "leveltiles_01", "levelmap_01","enemy_0_0","enemy_0_1","gun_0","bullet"
}; 
AudioPlayer[] audio = new AudioPlayer[audioStrings.length]; //creates an array for the audio files
PImage[] image = new PImage[imageStrings.length]; //creates an array for the image files

Input input;
World world;
GUI gui;
StartMenu startmenu;

int level,stage;

boolean sketchFullScreen() {
  return false;
}

void beginProgram() {
  level = 0;
  stage = 1;
  world = new World();
  gui = new GUI();
  startmenu = new StartMenu();
}

void setup() {
  size(displayWidth*5/6,displayHeight*5/6);
  frameRate(60);
  noCursor();
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER);
  input = new Input();
  minim = new Minim(this);
  loadFiles();
  beginProgram();
}

void loadFiles() {
  for (int i = 0; i < audioStrings.length; i++) { //loads all audio files
    audio[i] = minim.loadFile(audioStrings[i]+".mp3");
  }
  for (int i = 0; i < imageStrings.length; i++) { //loads all images
    image[i] = loadImage(imageStrings[i]+".png");
  }
}

void draw() {
  background(200);
  if (stage == 1) {
    startmenu.render();
    startmenu.update();
  } else if (stage == 2 || stage == 3) {
    world.update();
    gui.update();
    world.render();
    gui.render();
  } else if (stage == 10) {
    exit();
  }
}

void keyPressed() {
  input.pressKey(key, keyCode);
}

void keyReleased() {
  input.releaseKey(key, keyCode);
}

void mousePressed() {
  input.pressMouse(mouseButton);
}

void mouseReleased() {
  input.releaseMouse(mouseButton);
}
