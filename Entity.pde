abstract class Entity {

  PVector position, size, dispPos;
  float orientation;
  boolean state;
  Rectangle2D collideBox;

  Entity(float i_x, float i_y, float w, float h) {
    position = new PVector(i_x, i_y);
    size = new PVector(w, h);
    dispPos = new PVector(0, 0);
    state = true;
    collideBox = new Rectangle2D.Float(position.x, position.y, size.x, size.y);
  }
  
  abstract void update();

  abstract void render(PImage image[]);
  
  void updateCollideBox() {
    collideBox.setRect(position.x-size.x/2,position.y-size.y/2,size.x,size.y);
  }

  void updateDispPos() {
    dispPos.set(gui.dispPos(position));
  }
  
  boolean collideTile(int[][] tilesArray, float x, float y) {
    if (tilesArray == null) println("null");
    x = x/World.tileSize;
    y = y/World.tileSize;
    if (tilesArray[int(x)][int(y)] != World.TILE_EMPTY) return true;
    return false;
  }
}

