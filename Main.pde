class Main {

  //WarmVector game created by Wyatt Ades

  //String[] config = loadStrings("..\..\WarmVector\config.txt");
  PApplet parent;
  Minim minim;
  private HashMap<String, PImage[]> image;
  private ArrayList<AudioPlayer> audio;
  private Input input;
  private World world;
  private GUI gui;
  private StartMenu startMenu;
  private Sprite helpMenu;

  private int level;

  Main(PApplet parent) {
    this.parent = parent;
    size(displayWidth, displayHeight);
    frameRate(60);
    noCursor();
    rectMode(CENTER);
    imageMode(CENTER);
    textAlign(CENTER);
    level = 1;
    audio = new ArrayList<AudioPlayer>();
    image = new HashMap<String, PImage[]>(17);
    input = new Input();
    minim = new Minim(this);
    loadFiles();
    beginProgram();
  }

  public void beginProgram() {
    world = new World(level, image, input);
    gui = new GUI(world, image.get("levelmap_"+nf(level, 2, 0))[0], level);
    startMenu = new StartMenu(level, input);
    helpMenu = new Sprite(image.get("help"), width/2, height/2, 600, 450, 0, 0, 750, true, false, 255);
    startMenu.stage = 1;
  }

  public void newWorld(int new_level) {
    level = new_level;
    if (image.get("leveltiles_"+nf(level, 2, 0)) == null) {
      main.startMenu.stage = 8;
      return;
    }
    world = new World(level, image, input);
    startMenu = new StartMenu(level, input);
    startMenu.stage = 4;
    gui = new GUI(world, image.get("levelmap_"+nf(level, 2, 0))[0], level);
  }

  void loadFiles() {
    String dir = sketchPath + "/data/";
    File file = new File(dir);
    File[] files = file.listFiles();

    for (int i = 0; i < files.length; i++) {
      if (files[i].getName().contains(".gif") )
        image.put(files[i].getName().replace(".gif", ""), Gif.getPImages(parent, files[i].getName()));
      else if ( files[i].getName().contains(".png") )
        image.put( files[i].getName().replace(".png", ""), new PImage[] { 
          loadImage(files[i].getName())
        } 
      );
      else if ( files[i].getName().contains(".wav") )
        audio.add(minim.loadFile(files[i].getName()+".wav"));
    }
  }

  void run() {
    background(120);
    input.updateMouse(mouseX, mouseY);
    if (input.tab) startMenu.stage = 1;
    if (startMenu.stage == 1) {
      startMenu.render();
      startMenu.update();
    } else if (startMenu.stage == 2) {
      newWorld(1);
    } else if (startMenu.stage == 3) {
      newWorld(level);
    } else if (startMenu.stage == 4) {
      noCursor();
      world.update();
      world.render();
      gui.render();
    } else if (startMenu.stage == 8) {
      textSize(200);
      textAlign(CENTER);
      text("YOU WIN!",width/2,height/2);
    } else if (startMenu.stage == 9) {
      helpMenu.update();
      helpMenu.render();
    } else if (startMenu.stage == 10) {
      exit();
    }
  }
}

