class Tile {

  int type;
  PVector position,size;
  color hit;
  Rectangle2D collideBox;

  Tile(float i_x, float i_y, float w, float h, int tileType) {
    position = new PVector(i_x,i_y);
    size = new PVector(w,h);
    type = tileType;
    hit = color(50);
    collideBox = new Rectangle2D.Float(position.x-size.x/2, position.y-size.y/2, size.x, size.y);
  }

}

