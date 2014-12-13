class Player extends Body {

  float round, topSpeed;
  int bulletTime, weaponType, shootTime;
  PVector velocity,size;
  int[][] tilesArray;
  ArrayList<Tile> tiles;
  PImage gunpose, normalpose, gun;
  World world;

  Player(float i_x, float i_y, float w, float h, float orientation, int weaponType, PImage gunpose, PImage normalpose, PImage gun, World world) {
    super(i_x, i_y, w, h, orientation);
    round = Info.weaponInfo[weaponType][3];
    size = new PVector(w,h);
    topSpeed = 8;
    health = 100;
    shootTime = millis();
    bulletTime = millis();
    this.weaponType = weaponType;
    this.round = round;
    this.tilesArray = world.tilesArray;
    this.tiles = world.tiles;
    this.world = world;
    this.gunpose = gunpose;
    this.normalpose = normalpose;
    this.gun = gun;
    velocity = new PVector(0, 0);
    hit = color(255, 0, 0);
  }

  void update() {
  }

  void updatePosition() {
    updateCollideBox();
    position.add(velocity);
  }

  void render() {
    pushMatrix();
    translate(dispPos.x, dispPos.y);
    rotate(orientation);   
    scale(1.33);
    if (weaponType != 0) {
      image(gunpose, 0, 0);
      image(gun, 24, 2);
    } else
      image(normalpose, 0, 0);
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
    x = x/Info.tileSize;
    y = y/Info.tileSize;
    if (tilesArray[int(x)][int(y)] != Info.TILE_EMPTY) return true;
    return false;
  }
}

