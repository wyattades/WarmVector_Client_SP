class Vector_Bullet {

  PVector i_pos, shot, dispPos;
  float amount, damage, orientation;
  ArrayList<PVector> points;
  boolean state;
  int time;
  color s;

  Vector_Bullet(float i_x, float i_y, float i_orientation, float spread, float damage) {
    time = millis();
    s = color(255,255,random(255));
    i_pos = new PVector(i_x, i_y);
    dispPos = new PVector(0, 0);
    state = true;
    this.amount = amount;
    this.damage = damage;
    shot = new PVector(100000, 0);
    shot.rotate(i_orientation);
    shot.rotate(random(-1*spread, spread));
    orientation = shot.heading();
    points = new ArrayList<PVector>();
    for (int j = 0; j < world.tiles.size (); j++) {
      Tile t = world.tiles.get(j);
      if (t.collideBox.intersectsLine(i_pos.x, i_pos.y, i_pos.x+shot.x, i_pos.y+shot.y)==true && t.type == world.TILE_SOLID) { //if bulletline intersects with tile 
        points.add(new PVector(t.position.x, t.position.y)); //add all points of intersection with tile
      }
    }
    for (int k = 0; k < world.enemies.size (); k++) {
      Player p = world.enemies.get(k);
      if (p.collideBox.intersectsLine(i_pos.x, i_pos.y, i_pos.x+shot.x, i_pos.y+shot.y)==true) {
        points.add(new PVector(p.position.x, p.position.y));
      }
    }
    if (world.thisPlayer.collideBox.intersectsLine(i_pos.x, i_pos.y, i_pos.x+shot.x, i_pos.y+shot.y)==true) {
      points.add(new PVector(world.thisPlayer.position.x, world.thisPlayer.position.y));
    }
    float previousDist = 100000;
    for (int k = 0; k < points.size (); k++) {
      PVector p = points.get(k);
      float dist = dist(p.x, p.y, i_pos.x, i_pos.y);
      if (dist < previousDist) previousDist = dist;
    }
    shot.setMag(previousDist);
  }

  void update() {
    dispPos = gui.dispPos(i_pos);
    if (millis() - time > 100) state = false;
  }

  void render() {
    strokeWeight(1.5);
    stroke(s);
    line(dispPos.x, dispPos.y, dispPos.x+shot.x, dispPos.y+shot.y);
  }
}

