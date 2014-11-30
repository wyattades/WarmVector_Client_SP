
public class World {

  ArrayList<Entity> ents;
  ArrayList<Enemy> enemies;
  ArrayList<Tile> tiles;
  ArrayList<Vector_Bullet> bullets;
  ArrayList<DroppedWeapon> droppedWeps;
  int[][] tilesArray;

  float dispW, dispH, mapW, mapH;
  int gridW, gridH, mouseRightTime;

  static final int tileSize = 16;
  static final int TILE_EMPTY = 0;
  static final int TILE_SOLID = 1;
  static final int TILE_WINDOW = 2;
  static final int CREATE_ENEMY = 3;

  // {frequency,spread,amount,cartridge,damage};
  float[][] weaponInfo = {
    {
      0, 0, 0, 0, 0
    }
    , {
      100, .06, 1, 60, 100
    }
    , {
      500, .01, 1, 12, 400
    }
    , {
      20, .12, 1, 200, 50
    }
    , {
      750, .20, 6, 12, 150
    }
  };
  String[] weaponName = {
    "None", "M4 Rifle", "Barret 50Cal", "LMG", "Remington"
  };
  ThisPlayer thisPlayer;

  World() {
    ents = new ArrayList<Entity>();
    tiles = new ArrayList<Tile>();
    bullets = new ArrayList<Vector_Bullet>();
    droppedWeps = new ArrayList<DroppedWeapon>();
    enemies = new ArrayList<Enemy>();
    gridW = image[0].width;
    gridH = image[0].height;
    mapW = gridW*tileSize;
    mapH = gridH*tileSize;
    dispW = width;
    dispH = height;
    mouseRightTime = 0;
    tilesArray = getLevelArray();
    addTiles();
    thisPlayer = new ThisPlayer(mapW/2, mapH/2, 64, 64, 1, 60);
    thisPlayer.username = "Good Guy";
  }

  public void update() {
    for (int i = 0; i < enemies.size (); i++) {
      Enemy e = enemies.get(i);
      e.update(thisPlayer);
    }
    for (int i = 0; i < bullets.size (); i++) {
      Vector_Bullet b = bullets.get(i);
      b.update();
    }
    if (input.mouseLeft) addBullets(thisPlayer);
    thisPlayer.update(input, tilesArray);

    for (int i = 0; i < droppedWeps.size (); i++) {
      DroppedWeapon dw = droppedWeps.get(i);
      dw.update();
      if (dw.checkPickUp(thisPlayer)) droppedWeps.remove(i);
    }

    for (int i = droppedWeps.size ()-1; i >= 0; i--) {
      DroppedWeapon dw = droppedWeps.get(i);
      if (dw.checkPickUp(thisPlayer)) droppedWeps.remove(i);
    }

    for (int i = bullets.size ()-1; i >= 0; i--) {
      Vector_Bullet b = bullets.get(i);
      if (b.state == false) {
        bullets.remove(b);
      }
    }
    if (thisPlayer.state == false && thisPlayer.weaponType != 0) {
      addDroppedWeapon(thisPlayer);
    }
  }

  public void render() {
    for (int i = 0; i < bullets.size (); i++) {
      Vector_Bullet b = bullets.get(i);
      b.render();
    }
    displayBackgroundImage();
    for (int i = 0; i < enemies.size (); i++) {
      Enemy e = enemies.get(i);
      e.render(image);
    }
    for (int i = 0; i < droppedWeps.size (); i++) {
      DroppedWeapon dw = droppedWeps.get(i);
      dw.render(image);
    }
    thisPlayer.render(image);
  }

  void addDroppedWeapon(Player p) {
    droppedWeps.add(new DroppedWeapon(p.position.x, p.position.y, 32, 32, p.weaponType, p.round));
  }

  public void addBullets(Player p) {
    if (p.weaponType != 0 && millis()-p.bulletTime>weaponInfo[p.weaponType][0] && p.round > 0) {
      for (int i = 0; i < weaponInfo[p.weaponType][2]; i++) {
        PVector gunLength = new PVector(50, 0);
        gunLength.rotate(p.orientation);
        bullets.add(new Vector_Bullet(p.position.x+gunLength.x, p.position.y+gunLength.y, p.orientation, weaponInfo[p.weaponType][1], weaponInfo[p.weaponType][4]));
      }
      p.bulletTime = millis();
      p.round--;
    }
  }

  private void addTiles() {
    for (int i = 0; i < gridW; i++) {
      for (int j = 0; j < gridH; j++) {
        if (tilesArray[i][j] == TILE_SOLID) tiles.add(new Tile((i+.5)*tileSize, (j+.5)*tileSize, tileSize, tileSize, TILE_SOLID));
        else if (tilesArray[i][j] == TILE_WINDOW) tiles.add(new Tile((i+.5)*tileSize, (j+.5)*tileSize, tileSize, tileSize, TILE_WINDOW));
      }
    }
  }
  
  Enemy addEnemy(int posx, int posy) {
    return new Enemy(posx, posy, 48, 48, 1, 60, random(-1, 1), random(-1, 1),tilesArray,tiles);
  }

  int[][] getLevelArray() {
    int[][] values = new int[gridW][gridH];
    for (int i = 0; i < gridW; i++) {
      for (int j = 0; j < gridH; j++) {
        values[i][j] = image[level].get(i, j);
        if (values[i][j] == color(0)) values[i][j] = TILE_SOLID;
        else if (values[i][j] == color(0, 0, 255)) values[i][j] = TILE_WINDOW;
        else if (values[i][j] == color(255, 0, 0)) {
          enemies.add(addEnemy(i*tileSize,j*tileSize));
          values[i][j] = TILE_EMPTY;
        } else values[i][j] = TILE_EMPTY;
        if (i==0||i==gridW-1||j==0||j==gridH-1) values[i][j] = TILE_SOLID;
      }
    }
    return values;
  }

  private void displayBackgroundImage() {
    PVector p = thisPlayer.position.get();
    p.sub(mapW/2, mapH/2, 0);
    p.mult(-1);
    p.add(gui.PdispPos());
    //p.add(world.dispW/2,world.dispH/2,0);
    image(image[1], p.x, p.y, mapW, mapH);
  }
}

