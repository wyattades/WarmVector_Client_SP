abstract class Entity {

  PVector position, size, dispPos;
  float orientation;
  boolean state;
  color hit;
  int health;
  Rectangle2D collideBox;

  Entity(float i_x, float i_y, float w, float h) {
    position = new PVector(i_x, i_y);
    size = new PVector(w, h);
    dispPos = new PVector(0, 0);
    state = true;
    health = 400;
    collideBox = new Rectangle2D.Float(position.x-size.x/2, position.y-size.y/2, size.x, size.y);
  }

  void updateCollideBox() {
    collideBox.setRect(position.x-size.x/2, position.y-size.y/2, size.x, size.y);
  }

  void updateDispPos() {
    dispPos.set(gui.dispPos(position));
  }
}

