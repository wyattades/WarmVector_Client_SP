class Player extends Entity {
  
  float round, topSpeed;
  int bulletTime, weaponType;
  PVector velocity;
  int[][] tilesArray;
  ArrayList<Tile> tiles;

  Player(float i_x, float i_y, float w, float h, int weaponType, int[][] tilesArray, ArrayList<Tile> tiles) {
    super(i_x, i_y, w, h);
    round = Info.weaponInfo[weaponType][3];
    topSpeed = 8;
    bulletTime = millis();
    this.weaponType = weaponType;
    this.round = round;
    this.tilesArray = tilesArray;
    this.tiles = tiles;
    velocity = new PVector(0, 0);
    hit = color(255,0,0);
  }

  void update() {
  }

  void updatePosition() {
    updateCollideBox();
    position.add(velocity);
  }

  void render(PImage image1, PImage image2, PImage gun) {
    pushMatrix();
    translate(dispPos.x, dispPos.y);
    rotate(orientation);   
    scale(1.333);
    if (weaponType != 0) {
      image(image1, 0, 0);
      image(gun, 24, 2);
    } else
      image(image2, 0, 0);
    popMatrix();
  }
  
  void updateLife() {
    if (health <= 0) {
      health = 0;
      state = false;
    }
  }

  void updateVelX(float velX) {
    if ((velX > 0 && !collideTile(size.x/2, 0, 0, size.y*.3)) || (velX < 0  && !collideTile(-size.x/2, 0, 0, size.y*.3))) velocity.x = velX;
  }

  void updateVelY(float velY) {
    if ((velY > 0 && !collideTile(0, size.y/2, size.x*.3, 0)) || (velY < 0  && !collideTile(0, -size.y/2, size.x*.3, 0))) velocity.y = velY;
  }

  boolean collideTile(float ax, float ay, float dx, float dy) {
    if (inTile(position.x+ax, position.y+ay)
      || inTile(position.x+ax+dx, position.y+ay+dy) 
      || inTile(position.x+ax-dx, position.y+ay-dy)) return true;
    return false;
  }

  boolean inTile(float x, float y) {
    x = x/World.tileSize;
    y = y/World.tileSize;
    if (tilesArray[int(x)][int(y)] != World.TILE_EMPTY) return true;
    return false;
  }
}

