
public class World {

  ArrayList<Enemy> enemies;
  ArrayList<Tile> tiles;
  ArrayList<Sprite> sprites;
  ArrayList<Vector_Bullet> bullets;
  ArrayList<DroppedWeapon> droppedWeps;
  int[][] tilesArray;
  float dispW, dispH, mapW, mapH;
  int gridW, gridH;
  HashMap<String, PImage[]> imgs;
  ThisPlayer thisPlayer;

  World(int level, HashMap<String, PImage[]> imgs) {
    tiles = new ArrayList<Tile>();
    bullets = new ArrayList<Vector_Bullet>();
    droppedWeps = new ArrayList<DroppedWeapon>();
    enemies = new ArrayList<Enemy>();
    sprites = new ArrayList<Sprite>();
    gridW = imgs.get("leveltiles_"+nf(level, 2, 0))[0].width;
    gridH = imgs.get("leveltiles_"+nf(level, 2, 0))[0].height;
    this.imgs = imgs;
    mapW = gridW*Info.tileSize;
    mapH = gridH*Info.tileSize;
    dispW = width;
    dispH = height;
    tilesArray = getLevelArray(imgs.get("leveltiles_"+nf(level, 2, 0))[0]);
    addTiles();
    thisPlayer = new ThisPlayer(mapW/2, mapH/2, 64, 64, floor(random(1, 5)), tilesArray, tiles, imgs.get("player_0_1")[0], imgs.get("player_0_0")[0], imgs.get("gun_0")[0]);
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
    if (input.mouseLeft && millis()-thisPlayer.shootTime > 300) {
      addBullets(thisPlayer);
    }
    thisPlayer.update(input);
    if (thisPlayer.state == false) beginProgram();
    for (int i = 0; i < droppedWeps.size (); i++) {
      DroppedWeapon dw = droppedWeps.get(i);
      dw.update();
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
      if (s.state == false) sprites.remove(i);
    }
    for (int i = droppedWeps.size ()-1; i >= 0; i--) {
      DroppedWeapon dw = droppedWeps.get(i);
      if (dw.state == false) droppedWeps.remove(i);
    }
    for (int i = bullets.size ()-1; i >= 0; i--) {
      Vector_Bullet b = bullets.get(i);
      if (b.state == false) {
        bullets.remove(i);
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
      e.render();
    }
    for (int i = 0; i < droppedWeps.size (); i++) {
      DroppedWeapon dw = droppedWeps.get(i);
      dw.render();
    }
    thisPlayer.render();
    displayBackgroundImage(imgs.get("levelmap_"+nf(level, 2, 0))[0]);
  }

  void addDroppedWeapon(Player p) {
    droppedWeps.add(new DroppedWeapon(imgs.get("gun_0")[0], p.position.x, p.position.y, 32, 32, p.weaponType, p.round));
  }

  public void addBullets(Player p) {
    if (p.weaponType != 0 && millis()-p.bulletTime>Info.weaponInfo[p.weaponType][0] && p.round > 0) {
      for (int i = 0; i < Info.weaponInfo[p.weaponType][2]; i++) {
        bullets.add(new Vector_Bullet(p.position.x, p.position.y, p.orientation, Info.weaponInfo[p.weaponType][1], Info.weaponInfo[p.weaponType][4], imgs.get("hit"), p));
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
        else if (tilesArray[i][j] == Info.CREATE_ENEMY) {
          tilesArray[i][j] = Info.TILE_EMPTY;
          enemies.add(new Enemy(i*Info.tileSize, j*Info.tileSize, 48, 48, floor(random(1, 5)), random(-1, 1), random(-1, 1), 
          tilesArray, tiles, imgs.get("player_1_1")[0], imgs.get("player_1_0")[0], imgs.get("gun_0")[0]));
        }
      }
    }
  }

  int[][] getLevelArray(PImage img) {
    int[][] values = new int[gridW][gridH];
    for (int i = 0; i < gridW; i++) {
      for (int j = 0; j < gridH; j++) {
        values[i][j] = img.get(i, j);
        if (values[i][j] == color(0)) values[i][j] = Info.TILE_SOLID;
        else if (values[i][j] == color(0, 0, 255)) values[i][j] = Info.TILE_WINDOW;
        else if (values[i][j] == color(255, 0, 0)) values[i][j] = Info.CREATE_ENEMY;
        else values[i][j] = Info.TILE_EMPTY;
        if (i==0||i==gridW-1||j==0||j==gridH-1) values[i][j] = Info.TILE_SOLID;
      }
    }
    return values;
  }

  boolean empty(ArrayList<Entity> e) {
    if (e.size() == 0) return true;
    return false;
  }

  private void displayBackgroundImage(PImage img) {
    PVector p = thisPlayer.position.get();
    p.sub(mapW/2, mapH/2, 0);
    p.mult(-1);
    p.add(gui.PdispPos());
    image(img, p.x, p.y);
  }
}


