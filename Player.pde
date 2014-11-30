class Player extends Entity {
  String username;
  boolean valid;
  int weaponType, round, id, bulletTime;
  PVector velocity;
  color hit;
  float topSpeed;

  Player(float i_x, float i_y, float w, float h, int weaponType, int round) {
    super(i_x, i_y, w, h);
    topSpeed = 8;
    bulletTime = millis();
    this.weaponType = weaponType;
    this.round = round;
    velocity = new PVector(0, 0);
    hit = color(255,0,0);
  }
  
  void update() {
    
  }

  void updatePosition() {
    updateCollideBox();
    position.add(velocity);
  }

  void render(PImage[] image) {
    pushMatrix();
    translate(dispPos.x, dispPos.y);
    rotate(orientation);   
    scale(1.333);
    if (weaponType != 0) {
      image(image[3],0,0);
      image(image[4],24,2);
    } else
      image(image[2],0,0);
    popMatrix();
  }

  void updateVelX(int[][] tilesArray, float velX) {
    if ((velX > 0 && !collideTile(tilesArray, size.x/2, 0, 0, size.y*.3)) || (velX < 0  && !collideTile(tilesArray, -size.x/2, 0, 0, size.y*.3))) velocity.x = velX;
  }
  
  void updateVelY(int[][] tilesArray, float velY) {
    if ((velY > 0 && !collideTile(tilesArray, 0, size.y/2, size.x*.3, 0)) || (velY < 0  && !collideTile(tilesArray, 0, -size.y/2, size.x*.3, 0))) velocity.y = velY;
  }

  boolean collideTile(int[][] tilesArray, float ax, float ay, float dx, float dy) {
    if (collideTile(tilesArray,position.x+ax, position.y+ay)
      || collideTile(tilesArray,position.x+ax+dx, position.y+ay+dy) 
      || collideTile(tilesArray,position.x+ax-dx, position.y+ay-dy)) return true;
    return false;
  }
}

