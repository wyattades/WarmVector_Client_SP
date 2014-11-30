class Tile extends Entity {

  int type;
  color hit;

  Tile(float i_x, float i_y, float w, float h, int tileType) {
    super(i_x, i_y, w, h);
    type = tileType;
    if (type == World.TILE_SOLID) hit = color(50);
    else if (type == World.TILE_WINDOW) hit = color(0,0,255);
  }
  
}

