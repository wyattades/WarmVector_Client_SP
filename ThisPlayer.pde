class ThisPlayer extends Player {

  float rotateDist = 80;

  ThisPlayer(float i_x, float i_y, float w, float h, int weaponType, int[][] tilesArray, ArrayList<Tile> tiles) {
    super(i_x, i_y, w, h, weaponType, tilesArray, tiles);
    topSpeed = 10;
    velocity = new PVector(0, 0);
    rotateDist = 80;
  }

  void update(Input input) {
    updateLife();
    if (input.mouseRight) changeGun();

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

  private void changeGun() {
    if (millis()-world.mouseRightTime>500 && weaponType != 0) {
      world.addDroppedWeapon(world.thisPlayer);
      weaponType = 0;
      world.mouseRightTime = millis();
    }
  }

  private void updateAngle() {
    orientation = atan2(gui.cursor.y-dispPos.y, gui.cursor.x-dispPos.x);
  }
}

