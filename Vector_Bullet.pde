class Vector_Bullet extends Entity {

  PVector shot;
  float amount, damage, orientation;
  ArrayList<PVector> points;
  int time;
  color s;
  PImage[] image;
  Body hitObject;
  World world;

  Vector_Bullet(float i_x, float i_y, float orientation, int bulletNumber, float spread, float damage, PImage[] image, Player shooter, World world) {
    super(i_x,i_y);
    time = millis();
    this.world = world;
    this.image = image;
    s = color(255, 255, random(255));
    position = new PVector(i_x, i_y);
    state = true;
    this.amount = amount;
    this.damage = damage;
    shot = new PVector(100000, 0);
    this.orientation = orientation;
    shot.rotate(orientation);
    if (millis() - shooter.bulletTime > 750 && bulletNumber == 0)
      shot.rotate(random(-0.2*spread, 0.2*spread));
    else
      shot.rotate(random(-1*spread, spread));
    orientation = shot.heading();
    float previousDist = 100000;
    for (int j = 0; j < world.tiles.size (); j++) {
      Tile t = world.tiles.get(j);
      if (t.collideBox.intersectsLine(position.x, position.y, position.x+shot.x, position.y+shot.y)==true) { //if bulletline intersects with tile 
        float dist = dist(t.position.x, t.position.y, position.x, position.y);
        if (dist < previousDist) {
          if (t.type == Info.TILE_SOLID) {
            previousDist = dist;
            hitObject = t;
          } else if (t.type == Info.TILE_WINDOW) {
            world.sprites.add(new Sprite(image, t.position.x, t.position.y, 0, 0, shot.heading()+3.14, 0, 50, false, true, t.hit));
          }
        }
      }
    }
    for (int k = 0; k < world.enemies.size (); k++) {
      Player p = world.enemies.get(k);
      if (p.collideBox.intersectsLine(position.x, position.y, position.x+shot.x, position.y+shot.y)==true && p != shooter) {
        float dist = dist(p.position.x, p.position.y, position.x, position.y);
        if (dist < previousDist) {
          previousDist = dist;
          hitObject = p;
        }
      }
    }
    ThisPlayer e = world.thisPlayer;
    if (e.collideBox.intersectsLine(position.x, position.y, position.x+shot.x, position.y+shot.y)==true && e != shooter) {
      float dist = dist(e.position.x, e.position.y, position.x, position.y);
      if (dist < previousDist) {
        previousDist = dist;
        hitObject = e;
      }
    }
    shot.setMag(previousDist-20);

    hitObject.health -= damage;
    world.sprites.add(new Sprite(image, position.x+shot.x, position.y+shot.y, 0, 0, orientation+3.14, 0, 50, false, true, hitObject.hit));
  }

  void update() {
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

