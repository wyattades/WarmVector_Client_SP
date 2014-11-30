class ThisPlayer extends Player {

  float rotateDist = 80;
  int health;
  float tempID;

  ThisPlayer(float i_x, float i_y, float w, float h, int weaponType, int round) {
    super(i_x, i_y, w, h, weaponType, round);
    topSpeed = 10;
    velocity = new PVector(0, 0);
    health = 1000;
    rotateDist = 80;
  }
  
  void update(Input input, int[][] tilesArray) {
    updateLife();
    if (input.mouseRight) changeGun();

    velocity.set(0, 0, 0);
    if (input.keyLeft && input.keyRight); 
    else if (input.keyLeft) updateVelX(tilesArray, -topSpeed);
    else if (input.keyRight) updateVelX(tilesArray, topSpeed);
    if (input.keyUp && input.keyDown);
    else if (input.keyUp) updateVelY(tilesArray, -topSpeed);
    else if (input.keyDown) updateVelY(tilesArray, topSpeed);
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

  private void updateLife() {
    if (health <= 0) {
      health = 0;
      state = false;
    }
  }

  private void updateAngle() {
    orientation = atan2(gui.cursor.y-dispPos.y, gui.cursor.x-dispPos.x);
  }

}

