class Enemy extends Player {
  
  int[][] tilesArray;
  ArrayList<Tile> tiles;
  
  Enemy(float i_x, float i_y, float w, float h, int weaponType, int round, float i_vx, float i_vy, int[][] tilesArray, ArrayList<Tile> tiles) {
    super(i_x, i_y, w, h, weaponType, round);
    this.tiles = tiles;
    this.tilesArray = tilesArray;
    username = "Enemy";
    velocity.set(i_vx,i_vy,0);
  }
  
  void update(ThisPlayer thisPlayer) {
    if (lineOfSight(thisPlayer.position) && distBetween(thisPlayer.position).mag() < 400) {
        if (lookingAt(thisPlayer.position, 0.05)) {
          world.addBullets(this);
          velocity.set(0, 0, 0);
        } else { 
          orientTo(thisPlayer.position, 0.1);
          if (distBetween(thisPlayer.position).mag() > 100) goTowards(thisPlayer.position, 3.5);
          else velocity.set(0, 0, 0);
        }
      } else {
        patrol(2.5);
        PVector lookPos = new PVector(position.x+velocity.x, position.y+velocity.y);
        if (!lookingAt(lookPos, 0.06)) orientTo(lookPos, 0.12);
      }
      updatePosition();
      updateDispPos();
  }
  
  void patrol(float speed) {
    velocity.setMag(speed);
    if (collideTile(tilesArray, size.x/2, 0, size.x*0.3, 0) || collideTile(tilesArray, -size.x/2, 0, size.x*0.3, 0)) velocity.x *= -1;
    if (collideTile(tilesArray, 0, size.y/2, 0, size.y*0.3) || collideTile(tilesArray, 0, -size.y/2, 0, size.y*0.3)) velocity.y *= -1;
  }

  void goTowards(PVector pos, float speed) {
    velocity.set(0,0,0);
    PVector vel = distBetween(pos).get();
    vel.setMag(speed);
    updateVelX(tilesArray,vel.x);
    updateVelY(tilesArray,vel.y);
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

  boolean lineOfSight(PVector pos) {
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

