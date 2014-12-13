class Sprite extends Body {

  PImage[] img;
  int frame, skipTime, time, count;
  float scale;
  boolean repeat, adjustPos;
  color shade;

  Sprite(PImage[] img, float i_x, float i_y, float w, float h, float orientation, float scale, int skipTime, boolean repeat, boolean adjustPos, color shade) {
    super(i_x,i_y,w,h,orientation);
    this.scale = scale;
    this.img = img;
    count = img.length;
    this.skipTime = skipTime;
    this.repeat = repeat;
    this.shade = shade;
    this.adjustPos = adjustPos;
    frame = 0;
    time = millis();
  }

  void update() {
    if (count > 1) {
      if (millis()-time > skipTime) {
        frame++;
        time = millis();
      }
      if (frame == img.length) {
        if (repeat == false)
          state = false;
        else frame = 0;
      }
    }
  }

  void render() {
    imageMode(CENTER);
    pushMatrix();
    if (adjustPos) translate(dispPos.x, dispPos.y);
    else translate(position.x, position.y);
    if (orientation != 0) rotate(orientation);  
    if (scale != 0) scale(scale); 
    if (shade != 255) tint(shade);
    if (size.x == 0 && size.y == 0)
      image(img[frame], 0, 0);
    else 
      image(img[frame], 0, 0, size.x, size.y); 
    popMatrix();
    noTint();
  }
}

