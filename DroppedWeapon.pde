class DroppedWeapon extends Entity {

  int type, rounds;

  DroppedWeapon(float i_x, float i_y, float w, float h, int type, int i_rounds) {
    super(i_x, i_y, w, h);
    this.type = type;
    rounds = i_rounds;
    orientation = random(TWO_PI);
  }

  public void render(PImage[] image) {
    pushMatrix();
    translate(dispPos.x,dispPos.y);
    scale(1.33);
    rotate(orientation);
    image(image[4],0,0);
    popMatrix();
  }

  public void update() {
    updateDispPos();
  }

  public boolean checkPickUp(Player p) {
    if (input.mouseRight && p.weaponType == 0 && collideBox.intersects(p.position.x, p.position.y, p.size.x, p.size.y)) {
      if (millis()-world.mouseRightTime>500) {
        world.mouseRightTime = millis();
        p.weaponType = type;
        p.round = rounds;
        return true;
      }
    }
    return false;
  }
}

