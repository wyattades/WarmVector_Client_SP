abstract class Entity {

  PVector position, dispPos;
  boolean state;

  Entity(float i_x, float i_y) {
    position = new PVector(i_x, i_y);
    dispPos = new PVector(0, 0);
    state = true;
  }

}

