class Vector_Bullet {

  PVector i_pos, shot, dispPos;
  float amount, damage, orientation;
  ArrayList<PVector> points;
  boolean state;
  int time;
  color s;
  PImage[] image;
  Entity hitEntity;

  Vector_Bullet(float i_x, float i_y, float i_orientation, float spread, float damage, PImage[] image, Player shooter) {
    time = millis();
    this.image = image;
    s = color(255, 255, random(255));
    i_pos = new PVector(i_x, i_y);
    state = true;
    this.amount = amount;
    this.damage = damage;
    shot = new PVector(100000, 0);
    shot.rotate(i_orientation);
    shot.rotate(random(-1*spread, spread));
    orientation = shot.heading();
    float previousDist = 100000;
    for (int j = 0; j < world.tiles.size (); j++) {
      Tile t = world.tiles.get(j);
      if (t.collideBox.intersectsLine(i_pos.x, i_pos.y, i_pos.x+shot.x, i_pos.y+shot.y)==true) { //if bulletline intersects with tile 
        float dist = dist(t.position.x, t.position.y, i_pos.x, i_pos.y);
        if (dist < previousDist) {
          if (t.type == Info.TILE_SOLID) {
            previousDist = dist;
            hitEntity = t;
          } else if (t.type == Info.TILE_WINDOW) {
            world.sprites.add(new Sprite(image, t.position.x, t.position.y, 0, 0, shot.heading()+3.14, 0, 50, false, true, t.hit));
          }
        }
      }
    }
    for (int k = 0; k < world.enemies.size (); k++) {
      Player p = world.enemies.get(k);
      if (p.collideBox.intersectsLine(i_pos.x, i_pos.y, i_pos.x+shot.x, i_pos.y+shot.y)==true && p != shooter) {
        float dist = dist(p.position.x, p.position.y, i_pos.x, i_pos.y);
        if (dist < previousDist) {
          previousDist = dist;
          hitEntity = p;
        }
      }
    }
    ThisPlayer e = world.thisPlayer;
    if (e.collideBox.intersectsLine(i_pos.x, i_pos.y, i_pos.x+shot.x, i_pos.y+shot.y)==true && e != shooter) {
      float dist = dist(e.position.x, e.position.y, i_pos.x, i_pos.y);
      if (dist < previousDist) {
        previousDist = dist;
        hitEntity = e;
      }
    }
    shot.setMag(previousDist-20);

    hitEntity.health -= damage;
    dispPos = gui.dispPos(i_pos).get();
    world.sprites.add(new Sprite(image, i_pos.x+shot.x, i_pos.y+shot.y, 0, 0, orientation+3.14, 0, 50, false, true, hitEntity.hit));
  }

  void update() {
    dispPos = gui.dispPos(i_pos);
    if (millis() - time > 40) state = false;
  }

  void render() {
    strokeWeight(1.5);
    stroke(s);
    PVector gunLength = new PVector(50, 0);
    gunLength.rotate(orientation);
    line(dispPos.x+gunLength.x, dispPos.y+gunLength.y, dispPos.x+shot.x, dispPos.y+shot.y);
  }
}

