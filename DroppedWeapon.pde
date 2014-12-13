class DroppedWeapon extends Body {

  int type;
  float rounds;
  PImage gun;
  PVector size;

  DroppedWeapon(PImage gun, float i_x, float i_y, float w, float h, float orientation, int type, float i_rounds) {
    super(i_x, i_y, w, h, orientation);
    size = new PVector(w,h);
    this.gun = gun;
    this.type = type;
    rounds = i_rounds;
    orientation = random(TWO_PI);
  }

  public void render() {
    pushMatrix();
    translate(dispPos.x, dispPos.y);
    rotate(orientation);
    scale(1.33);
    image(gun, 0, 0);
    popMatrix();
  }

  public void update() {

  }

  public boolean collidePlayer(Player p) {
    if (collideBox.intersects(p.position.x, p.position.y, p.size.x, p.size.y)) 
      return true;
    return false;
  }
}
