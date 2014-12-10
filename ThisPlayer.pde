class ThisPlayer extends Player {

  float rotateDist = 80;
  int startTime;

  ThisPlayer(float i_x, float i_y, float w, float h, int weaponType, int[][] tilesArray, ArrayList<Tile> tiles, PImage gunpose, PImage normalpose, PImage gun) {
    super(i_x, i_y, w, h, weaponType, tilesArray, tiles, gunpose, normalpose, gun);
    topSpeed = 10;
    velocity = new PVector(0, 0);
    rotateDist = 80;
  }

  void update(Input input) {
    updateLife();
    if (input.mouseRight && millis()-input.mouseRightTime>500) {
      input.mouseRightTime = millis();
      boolean collide = true;
      if (weaponType != 0) {
        world.addDroppedWeapon(this);
        weaponType = 0;
        for (int i = 0; i < world.droppedWeps.size ()-1; i++) {
          DroppedWeapon dw = world.droppedWeps.get(i);
          if (dw.collidePlayer(this)) {
            weaponType = dw.type;
            round = dw.rounds;
            dw.state = false;
            break;
          }
        }
      } else {
        for (int i = 0; i < world.droppedWeps.size (); i++) {
        DroppedWeapon dw = world.droppedWeps.get(i);
          if (dw.collidePlayer(this)) {
            weaponType = dw.type;
            round = dw.rounds;
            dw.state = false;
            break;
          }
        }
      }
    }

    velocity.set(0, 0, 0);
    if (input.keyLeft && input.keyRight); 
    else if (input.keyLeft) updateVelX(-topSpeed);
    else if (input.keyRight) updateVelX(topSpeed);
    if (input.keyUp && input.keyDown);
    else if (input.keyUp) updateVelY(-topSpeed);
    else if (input.keyDown) updateVelY(topSpeed);
    if (velocity.mag()>topSpeed) velocity.setMag(topSpeed);
    updatePosition();
    dispPos.set(gui.PdispPos());
    updateAngle();
  }

  private void updateAngle() {
    orientation = atan2(gui.cursor.y-dispPos.y, gui.cursor.x-dispPos.x);
  }
}

