class Player extends Entity {
  String username;
  boolean valid;
  int weaponType, round, id, bulletTime;
  PVector velocity;
  color f,s;

  Player(float i_x, float i_y, float w, float h, int weaponType, int round) {
    super(i_x, i_y, w, h);
    bulletTime = millis();
    this.weaponType = weaponType;
    this.round = round;
    velocity = new PVector(0, 0);
    f = color(#BF0208);
    s = color(0);
  }
  
  void update() {
    
  }

  void updatePosition() {
    position.add(velocity);
  }

  void render() {
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

  void updateVelX(World w, float velX) {
    if ((velX > 0 && !collideTile(w, size.x/2, 0, 0, size.y*.3)) || (velX < 0  && !collideTile(w, -size.x/2, 0, 0, size.y*.3))) velocity.x = velX;
  }
  
  void updateVelY(World w, float velY) {
    if ((velY > 0 && !collideTile(w, 0, size.y/2, size.x*.3, 0)) || (velY < 0  && !collideTile(w, 0, -size.y/2, size.x*.3, 0))) velocity.y = velY;
  }

  boolean collideTile(World w, float ax, float ay, float dx, float dy) {
    if (w.collideTile(position.x+ax, position.y+ay)
      || w.collideTile(position.x+ax+dx, position.y+ay+dy) 
      || w.collideTile(position.x+ax-dx, position.y+ay-dy)) return true;
    return false;
  }
}

