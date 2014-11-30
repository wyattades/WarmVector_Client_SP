
public class World {

  ArrayList<Enemy> enemies;
  ArrayList<Tile> tiles;
  ArrayList<Sprite> sprites;
  ArrayList<Vector_Bullet> bullets;
  ArrayList<DroppedWeapon> droppedWeps;
  int[][] tilesArray;

  float dispW, dispH, mapW, mapH;
  int gridW, gridH, mouseRightTime;


  
  ThisPlayer thisPlayer;

  World() {
    tiles = new ArrayList<Tile>();
    bullets = new ArrayList<Vector_Bullet>();
    droppedWeps = new ArrayList<DroppedWeapon>();
    enemies = new ArrayList<Enemy>();
    sprites = new ArrayList<Sprite>();
    gridW = image[0].width;
    gridH = image[0].height;
    mapW = gridW*Info.tileSize;
    mapH = gridH*Info.tileSize;
    dispW = width;
    dispH = height;
    tilesArray = getLevelArray(image, level);
    addTiles();
    thisPlayer = new ThisPlayer(mapW/2, mapH/2, 64, 64, floor(random(1, 5)), tilesArray, tiles);
  }

  public void update() {
    for (int i = 0; i < enemies.size (); i++) {
      Enemy e = enemies.get(i);
      e.update(thisPlayer);
    }
    for (int i = 0; i < sprites.size (); i++) {
      Sprite s = sprites.get(i);
      s.update();
    }
    for (int i = 0; i < bullets.size (); i++) {
      Vector_Bullet b = bullets.get(i);
      b.update();
    }
    if (input.mouseLeft) addBullets(thisPlayer);
    thisPlayer.update(input);
    if (thisPlayer.state == false) beginProgram();
    for (int i = 0; i < droppedWeps.size (); i++) {
      DroppedWeapon dw = droppedWeps.get(i);
      dw.update();
      if (dw.checkPickUp(thisPlayer)) droppedWeps.remove(i);
    }
    for (int i = enemies.size ()-1; i >= 0; i--) {
      Enemy e = enemies.get(i);
      if (e.state == false) {
        addDroppedWeapon(e);
        enemies.remove(e);
      }
    }
    for (int i = sprites.size ()-1; i >= 0; i--) {
      Sprite s = sprites.get(i);
      if (s.state == false) sprites.remove(s);
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
  }

  public void render() {
    for (int i = 0; i < bullets.size (); i++) {
      Vector_Bullet b = bullets.get(i);
      b.render();
    }
    for (int i = 0; i < sprites.size (); i++) {
      Sprite s = sprites.get(i);
      s.render();
    }
    for (int i = 0; i < enemies.size (); i++) {
      Enemy e = enemies.get(i);
      e.render(image[5], image[4], image[6]);
    }
    for (int i = 0; i < droppedWeps.size (); i++) {
      DroppedWeapon dw = droppedWeps.get(i);
      dw.render(image);
    }
    thisPlayer.render(image[3], image[2], image[thisPlayer.weaponType+5]);
    displayBackgroundImage();
  }

  void addDroppedWeapon(Player p) {
    droppedWeps.add(new DroppedWeapon(p.position.x, p.position.y, 32, 32, p.weaponType, p.round));
  }

  public void addBullets(Player p) {
    if (p.weaponType != 0 && millis()-p.bulletTime>Info.weaponInfo[p.weaponType][0] && p.round > 0) {
      for (int i = 0; i < Info.weaponInfo[p.weaponType][2]; i++) {
        bullets.add(new Vector_Bullet(p.position.x, p.position.y, p.orientation, Info.weaponInfo[p.weaponType][1], Info.weaponInfo[p.weaponType][4], hitParticles, p));
      }
      p.bulletTime = millis();
      p.round--;
    }
  }

  private void addTiles() {
    for (int i = 0; i < gridW; i++) {
      for (int j = 0; j < gridH; j++) {
        if (tilesArray[i][j] == Info.TILE_SOLID) tiles.add(new Tile((i+.5)*Info.tileSize, (j+.5)*Info.tileSize, Info.tileSize, Info.tileSize, Info.TILE_SOLID));
        else if (tilesArray[i][j] == Info.TILE_WINDOW) tiles.add(new Tile((i+.5)*Info.tileSize, (j+.5)*Info.tileSize, Info.tileSize, Info.tileSize, Info.TILE_WINDOW));
        else if (tilesArray[i][j] == Info.CREATE_ENEMY) tilesArray[i][j] = Info.TILE_EMPTY;
      }
    }
    int[][] initialTilesArray = getLevelArray(image, level);
    for (int i = 0; i < gridW; i++) {
      for (int j = 0; j < gridH; j++) {
        if (initialTilesArray[i][j] == Info.CREATE_ENEMY) {
          enemies.add(new Enemy(i*Info.tileSize, j*Info.tileSize, 48, 48, floor(random(1, 5)), random(-1, 1), random(-1, 1), tilesArray, tiles));
        }
      }
    }
  }

  int[][] getLevelArray(PImage[] image, int level) {
    int[][] values = new int[gridW][gridH];
    for (int i = 0; i < gridW; i++) {
      for (int j = 0; j < gridH; j++) {
        values[i][j] = image[level].get(i, j);
        if (values[i][j] == color(0)) values[i][j] = Info.TILE_SOLID;
        else if (values[i][j] == color(0, 0, 255)) values[i][j] = Info.TILE_WINDOW;
        else if (values[i][j] == color(255, 0, 0)) values[i][j] = Info.CREATE_ENEMY;
        else values[i][j] = Info.TILE_EMPTY;
        if (i==0||i==gridW-1||j==0||j==gridH-1) values[i][j] = Info.TILE_SOLID;
      }
    }
    return values;
  }

  private void displayBackgroundImage() {
    PVector p = thisPlayer.position.get();
    p.sub(mapW/2, mapH/2, 0);
    p.mult(-1);
    p.add(gui.PdispPos());
    image(image[1], p.x, p.y);
  }
}

