//WarmVector game created by Wyatt Ades

import gifAnimation.*;
import ddf.minim.*;
import java.awt.geom.*;

//String[] config = loadStrings("..\..\WarmVector\config.txt");
Minim minim;
String[] audioStrings = { //stores the names of all the audio files
}; 
String[] imageStrings = { //stores the names of all the image files
  "leveltiles_01", "levelmap_01", "player_0_0", "player_0_1", "player_1_0", "player_1_1", "gun_0", "gun_1","gun_2","gun_3","bullet"
}; 
PImage[] hitParticles;
PImage[] help;
AudioPlayer[] audio = new AudioPlayer[audioStrings.length]; //creates an array for the audio files
PImage[] image = new PImage[imageStrings.length]; //creates an array for the image files

Input input;
World world;
GUI gui;
StartMenu startMenu;
Sprite helpMenu;

int level;

boolean sketchFullScreen() {
  return false;
}

void beginProgram() {
  level = 0;
  world = new World();
  gui = new GUI();
  startMenu = new StartMenu();
  startMenu.stage = 1;
}

void setup() {
  size(displayWidth*5/6, displayHeight*5/6);
  frameRate(60);
  noCursor();
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER);
  input = new Input();
  minim = new Minim(this);
  loadFiles();
  hitParticles = Gif.getPImages(this, "hit.gif");
  help = Gif.getPImages(this, "help.gif");
  helpMenu = new Sprite(help, width,height+100, 600, 450, 0, image.length, 750, true, 255);
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
  background(120);
  if (input.tab) startMenu.stage = 1;
  if (startMenu.stage == 1) {
    startMenu.render();
    startMenu.update();
  } else if (startMenu.stage == 2 || startMenu.stage == 3) {
    world.update();
    gui.update();
    world.render();
    gui.render();
  } else if (startMenu.stage == 9) {
    helpMenu.update();
    helpMenu.render();
  } else if (startMenu.stage == 10) {
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

