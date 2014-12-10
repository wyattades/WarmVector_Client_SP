//WarmVector game created by Wyatt Ades

import gifAnimation.*;
import ddf.minim.*;
import java.awt.geom.*;
import java.io.File;

//String[] config = loadStrings("..\..\WarmVector\config.txt");
Minim minim;
private HashMap<String, PImage[]> image;
private ArrayList<AudioPlayer> audio;
private Input input;
private World world;
private GUI gui;
private StartMenu startMenu;
private Sprite helpMenu;

private int level;

boolean sketchFullScreen() {
  return false;
}

void beginProgram() {
  level = 1;
  world = new World(level, image);
  gui = new GUI(world, image.get("levelmap_"+nf(level, 2, 0))[0], level);
  startMenu = new StartMenu();
  helpMenu = new Sprite(image.get("help"), width/2, height/2, 600, 450, 0, 0, 750, true, false, 255);
  startMenu.stage = 1;
}

void nextWorld() {
  level++;
  world = new World(level, image);
  gui = new GUI(world, image.get("levelmap_"+nf(level, 2, 0))[0], level);
}

void setup() {
  size(displayWidth*5/6, displayHeight*5/6);
  frameRate(60);
  noCursor();
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER);
  audio = new ArrayList<AudioPlayer>();
  image = new HashMap<String, PImage[]>(17);
  input = new Input();
  minim = new Minim(this);
  loadFiles();
  beginProgram();
}

void loadFiles() {
  String dir = sketchPath + "/data/";
  File file = new File(dir);
  File[] files = file.listFiles();

  for (int i = 0; i < files.length; i++) {
    if (files[i].getName().contains(".gif") )
      image.put(files[i].getName().replace(".gif", ""), Gif.getPImages(this, files[i].getName()));
    else if ( files[i].getName().contains(".png") )
      image.put( files[i].getName().replace(".png", ""), new PImage[] { 
        loadImage(files[i].getName())
      } 
    );
    else if ( files[i].getName().contains(".wav") )
      audio.add(minim.loadFile(files[i].getName()+".wav"));
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

