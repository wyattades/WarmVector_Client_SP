class Tile extends Body {

  int type;
  color hit;

  Tile(float i_x, float i_y, float w, float h, float orientation, int tileType) {
    super(i_x, i_y, w, h, orientation);
    type = tileType;
    if (type == Info.TILE_SOLID) hit = color(50);
    else if (type == Info.TILE_WINDOW) hit = color(0, 0, 255);
  }
}

