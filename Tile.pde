class Tile {

  int type;
  PVector position,size;
  Rectangle2D collideBox;

  Tile(float i_x, float i_y, float w, float h, int tileType) {
    position = new PVector(i_x,i_y);
    size = new PVector(w,h);
    type = tileType;
    collideBox = new Rectangle2D.Float(position.x, position.y, size.x, size.y);
  }

}

