
public class World {

  private ArrayList<Enemy> enemies;
  private ArrayList<Tile> tiles;
  private ArrayList<Sprite> sprites;
  private ArrayList<Vector_Bullet> bullets;
  private ArrayList<DroppedWeapon> droppedWeps;
  private int[][] tilesArray;
  private float dispW, dispH, mapW, mapH;
  private int gridW, gridH, level;
  private HashMap<String, PImage[]> imgs;
  private ThisPlayer thisPlayer;
  private PVector PdispPos, WdispPos, cursor;
  private Input input;

  World(int level, HashMap<String, PImage[]> imgs, Input input) {
    this.input = input;
    this.level = level;
    tiles = new ArrayList<Tile>();
    bullets = new ArrayList<Vector_Bullet>();
    droppedWeps = new ArrayList<DroppedWeapon>();
    enemies = new ArrayList<Enemy>();
    sprites = new ArrayList<Sprite>();
    PdispPos = new PVector(0, 0);
    WdispPos = new PVector(0, 0);
    cursor = new PVector(0, 0);
    gridW = imgs.get("leveltiles_"+nf(level, 2, 0))[0].width;
    gridH = imgs.get("leveltiles_"+nf(level, 2, 0))[0].height;
    this.imgs = imgs;
    mapW = gridW*Info.tileSize;
    mapH = gridH*Info.tileSize;
    dispW = width;
    dispH = height;
    tilesArray = getLevelArray(imgs.get("leveltiles_"+nf(level, 2, 0))[0]);
    addTiles();
  }

  private void addTiles() {
    PVector playerPos = new PVector(dispW/2, dispH/2);
    for (int i = 0; i < gridW; i++) {
      for (int j = 0; j < gridH; j++) {
        if (tilesArray[i][j] == Info.TILE_SOLID) tiles.add(new Tile((i+.5)*Info.tileSize, (j+.5)*Info.tileSize, Info.tileSize, Info.tileSize, 0, Info.TILE_SOLID));
        else if (tilesArray[i][j] == Info.TILE_WINDOW) tiles.add(new Tile((i+.5)*Info.tileSize, (j+.5)*Info.tileSize, Info.tileSize, Info.tileSize, 0, Info.TILE_WINDOW));
        else if (tilesArray[i][j] == Info.CREATE_ENEMY) {
          tilesArray[i][j] = Info.TILE_EMPTY;
          enemies.add(new Enemy(i*Info.tileSize, j*Info.tileSize, 48, 48, 0, floor(random(1, 5)), this, random(-1, 1), random(-1, 1), imgs.get("player_1_1")[0], imgs.get("player_1_0")[0], imgs.get("gun_0")[0]));
        } else if (tilesArray[i][j] == Info.CREATE_THISPLAYER) {
          tilesArray[i][j] = Info.TILE_EMPTY;
          playerPos.set(i*Info.tileSize, j*Info.tileSize, 0);
        }
      }
    }
    thisPlayer = new ThisPlayer(playerPos.x, playerPos.y, 64, 64, 0, floor(random(1, 5)), this, imgs.get("player_0_1")[0], imgs.get("player_0_0")[0], imgs.get("gun_0")[0]);
  }

  int[][] getLevelArray(PImage img) {
    int[][] values = new int[gridW][gridH];
    for (int i = 0; i < gridW; i++) {
      for (int j = 0; j < gridH; j++) {
        values[i][j] = img.get(i, j);
        if (values[i][j] == color(0)) values[i][j] = Info.TILE_SOLID;
        else if (values[i][j] == color(0, 0, 255)) values[i][j] = Info.TILE_WINDOW;
        else if (values[i][j] == color(255, 0, 0)) values[i][j] = Info.CREATE_ENEMY;
        else if (values[i][j] == color(0, 255, 0)) values[i][j] = Info.CREATE_THISPLAYER;
        else values[i][j] = Info.TILE_EMPTY;
        if (i==0||i==gridW-1||j==0||j==gridH-1) values[i][j] = Info.TILE_SOLID;
      }
    }
    return values;
  }

  public void update() {
    updateCursor(input.mousePos);
    thisPlayer.updateAngle(cursor);
    updatePdispPos();
    thisPlayer.update(input);
    thisPlayer.dispPos.set(PdispPos);
    updateWdispPos();
    if (input.mouseLeft) {
      addBullets(thisPlayer);
    }
    for (int i = 0; i < enemies.size (); i++) {
      Enemy e = enemies.get(i);
      e.update(thisPlayer);
      e.dispPos.set(setDispPos(e.position));
    }
    for (int i = 0; i < sprites.size (); i++) {
      Sprite s = sprites.get(i);
      s.update();
      s.dispPos.set(setDispPos(s.position));
    }
    for (int i = 0; i < bullets.size (); i++) {
      Vector_Bullet b = bullets.get(i);
      b.update();
      b.dispPos.set(setDispPos(b.position));
    }
    for (int i = 0; i < droppedWeps.size (); i++) {
      DroppedWeapon dw = droppedWeps.get(i);
      dw.update();
      dw.dispPos.set(setDispPos(dw.position));
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
    if (enemies.size() == 0) main.newWorld(level+1);
    if (thisPlayer.state == false) main.startMenu.stage = 1;
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
    droppedWeps.add(new DroppedWeapon(imgs.get("gun_0")[0], p.position.x, p.position.y, 64, 64, 0, p.weaponType, p.round));
  }

  public void addBullets(Player p) {
    if (p.weaponType != 0 && millis()-p.bulletTime>Info.weaponInfo[p.weaponType][0] && p.round > 0) {
      for (int i = 0; i < Info.weaponInfo[p.weaponType][2]; i++) {
        bullets.add(new Vector_Bullet(p.position.x, p.position.y, p.orientation, i, Info.weaponInfo[p.weaponType][1], Info.weaponInfo[p.weaponType][4], imgs.get("hit"), p, this));
      }
      p.bulletTime = millis();
      p.round--;
    }
  }

  private void updateCursor(PVector mouse) {
    cursor.set(mouse.x, mouse.y, 0);
    PVector p = thisPlayer.dispPos.get();
    p.sub(dispW/2, dispH/2, 0);
    cursor.add(p);
  }

  PVector setDispPos(PVector pos) {
    PVector d = pos.get();
    d.add(WdispPos);
    d.add(PdispPos);
    d.sub(mapW/2, mapH/2, 0);
    return d;
  }

  void updateWdispPos() {
    PVector d = thisPlayer.position.get();
    d.sub(mapW/2, mapH/2, 0);
    d.mult(-1);
    WdispPos.set(d);
  }

  void updatePdispPos() {  
    float rotateDist = 100*dist(cursor.x, cursor.y, dispW/2, dispH/2)/(dispW/2);
    PVector d = new PVector(-rotateDist, 0);
    d.rotate(thisPlayer.orientation);
    d.add(dispW/2, dispH/2, 0);
    //    float maxspeed = 60, accel = 0.03, neg_accel = accel*0.8;
    //    if (w.thisPlayer.velocity.x == 0) {
    //      if (dispVelocity.x < 0) dispVelocity.x += neg_accel;
    //      if (dispVelocity.x > 0) dispVelocity.x -= neg_accel;
    //    } else if (w.thisPlayer.velocity.x < 0) {
    //      if (dispVelocity.x > -maxspeed) dispVelocity.x -= accel;
    //    } else {
    //      if (dispVelocity.x < maxspeed) dispVelocity.x += accel;
    //    }
    //
    //    if (w.thisPlayer.velocity.y == 0) {
    //      if (dispVelocity.y < 0) dispVelocity.y += neg_accel;
    //      if (dispVelocity.y > 0) dispVelocity.y -= neg_accel;
    //    } else if (w.thisPlayer.velocity.y < 0) {
    //      if (dispVelocity.y > -maxspeed) dispVelocity.y -= accel;
    //    } else {
    //      if (dispVelocity.y < maxspeed) dispVelocity.y += accel;
    //    }
    //    d.add(dispVelocity);
    PdispPos.set(d);
  }

  boolean empty(ArrayList<Entity> e) {
    if (e.size() == 0) return true;
    return false;
  }

  private void displayBackgroundImage(PImage img) {
    PVector p = thisPlayer.position.get();
    p.sub(mapW/2, mapH/2, 0);
    p.mult(-1);
    p.add(PdispPos);
    image(img, p.x, p.y);
  }
}

