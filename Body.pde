class Body extends Entity {

  PVector size;
  color hit;
  int health;
  float orientation;
  Rectangle2D collideBox;

  Body(float i_x, float i_y, float w, float h, float orientation) {
    super(i_x,i_y);
    this.orientation = orientation;
    size = new PVector(w,h);
    collideBox = new Rectangle2D.Float(position.x-size.x/2, position.y-size.y/2, size.x, size.y);
  }
  
  void updateCollideBox() {
    collideBox.setRect(position.x-size.x/2, position.y-size.y/2, size.x, size.y);
  }
  
}

