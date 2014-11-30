class Sprite {

  PVector pos, size, dispPos;
  PImage[] image;
  int frame, skipTime, time, count;
  float orientation;
  boolean state, repeat;
  color shade;

  Sprite(PImage[] image, float i_x, float i_y, float w, float h, float orientation, int count, int skipTime, boolean repeat, color shade) {
    pos = new PVector(i_x, i_y);
    size = new PVector(w,h);
    dispPos = new PVector(0, 0);
    this.image = image;
    this.count = count;
    this.skipTime = skipTime;
    this.repeat = repeat;
    this.shade = shade;
    this.orientation = orientation;
    frame = 0;
    time = millis();
    state = true;
  }

  void update() {
    dispPos.set(gui.dispPos(pos));
    if (millis()-time > skipTime) {
      frame++;
      time = millis();
    }
    if (frame == image.length) {
      if (repeat == false)
        state = false;
      else frame = 0;
    }
  }

  void render() {
    pushMatrix();
    translate(dispPos.x, dispPos.y);
    rotate(orientation);   
    scale(1.333);
    imageMode(CENTER);
    tint(shade);
    if (size.mag() == 0)
      image(image[frame], 0, 0);
    else 
      image(image[frame], 0, 0, size.x, size.y);
    noTint();
    popMatrix();
  }
}

