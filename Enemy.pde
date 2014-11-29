class Enemy extends Player {
  
  Enemy(float i_x, float i_y, float w, float h, int weaponType, int round, float i_vx, float i_vy) {
    super(i_x, i_y, w, h, weaponType, round);
    username = "Enemy";
    velocity.set(i_vx,i_vy,0);
  }
  
  void update() {
    
  }
  
  void patrol(World w, float speed) {
    velocity.setMag(speed);
    if (collideTile(w, size.x/2, 0, size.x*0.3, 0) || collideTile(w, -size.x/2, 0, size.x*0.3, 0)) velocity.x *= -1;
    if (collideTile(w, 0, size.y/2, 0, size.y*0.3) || collideTile(w, 0, -size.y/2, 0, size.y*0.3)) velocity.y *= -1;
  }

  void goTowards(World w, PVector pos, float speed) {
    velocity.set(0,0,0);
    PVector vel = distBetween(pos).get();
    vel.setMag(speed);
    updateVelX(w,vel.x);
    updateVelY(w,vel.y);
  }

  void orientTo(PVector pos, float speed) {
    if (angle_Between(pos) < 0) {
      orientation += speed;
    } else {
      orientation -= speed;
    }
  }
  
  float angle_Between(PVector pos) {
    PVector o = new PVector(1, 0);
    o.rotate(orientation);
    float a;
    //if (orientation) < 10) a = o.heading() + distBetween(pos).heading() + PI;
    a = orientation-distBetween(pos).heading()+TWO_PI;
    //else a = o.heading() - distBetween(pos).heading();
    return a;
  }

  PVector distBetween(PVector pos) {
    PVector d = pos.get();
    d.sub(position);
    return d;
  }

  boolean lineOfSight(PVector pos, ArrayList<Tile> tiles) {
    for (int i = 0; i < tiles.size(); i++) {
      Tile t = tiles.get(i);
      if (t.collideBox.intersectsLine(position.x, position.y, pos.x, pos.y) && t.type == world.TILE_SOLID) { //if bulletline intersects with solid tile 
        return false;
      }
    }
    return true;
  }

  boolean lookingAt(PVector pos, float tolerance) {
    if (abs(angle_Between(pos)) < tolerance) {
      return true;
    }
    return false;
  }
}

