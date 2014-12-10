class GUI {

  PVector cursor, dispVelocity;
  World w;
  PImage minimap;

  GUI(World w, PImage minimap, int level) {
    this.w = w;
    this.minimap = minimap;
    ;
    //w.sprites.add(new Sprite(images.get("levelmap_"+nf(level,2,0)), w.mapW, w.mapH, width-140, 120, 0, 0.12, 0, false, 255));
    cursor = new PVector(0, 0);
    dispVelocity = new PVector(0, 0);
  }

  void update() {
    noCursor();
    updateCursor();
  }

  void render() {
    displayMinimap();
    displayCursor();
    displayWords();
  }

  private void displayWords() {
    fill(255);
    strokeWeight(1.5);
    stroke(255, 0, 0);
    rectMode(CORNER);
    rect(22, 30, 330, 97);
    rectMode(CENTER);

    textAlign(LEFT);
    textSize(30);
    fill(0);
    String displayAmmo = nf(w.thisPlayer.round, 2, 0);
    if (Info.weaponInfo[w.thisPlayer.weaponType][3] == -1) displayAmmo = "Inf";
    if (w.thisPlayer.weaponType == 0) displayAmmo = "NA";

    text("Weapon: "+Info.weaponName[w.thisPlayer.weaponType], 30, 60);
    text("Ammo: "+displayAmmo, 30, 90);
    text("Health: "+nf(w.thisPlayer.health, 4, 0), 30, 120);
  }

  private void displayMinimap() {
    strokeWeight(1.5/0.12);
    stroke(255, 0, 0);
    fill(255);
    pushMatrix();
    translate(width-140, 120);
    scale(0.12);
    rect(0, 0, w.mapW, w.mapH);  
    image(minimap, 0, 0);
    strokeWeight(60);
    stroke(255, 0, 0);
    point(w.thisPlayer.position.x-w.mapW/2, w.thisPlayer.position.y-w.mapH/2);
    for (int i = 0; i < w.enemies.size (); i++) {
      Enemy p = w.enemies.get(i);
      stroke(0, 0, 255);
      point(p.position.x-w.mapW/2, p.position.y-w.mapH/2);
    }
    popMatrix();
  }

  private void displayCursor() {
    float linesize = 24;
    stroke(255);
    strokeWeight(3);
    point(cursor.x, cursor.y);
    line(cursor.x-linesize/2, cursor.y, cursor.x-linesize/4, cursor.y);
    line(cursor.x, cursor.y-linesize/2, cursor.x, cursor.y-linesize/4);
    line(cursor.x+linesize/4, cursor.y, cursor.x+linesize/2, cursor.y);
    line(cursor.x, cursor.y+linesize/4, cursor.x, cursor.y+linesize/2);
  }

  PVector dispPos(PVector Pos) {
    PVector d = Pos.get();
    d.add(WdispPos());
    d.add(PdispPos());
    d.sub(w.mapW/2, w.mapH/2, 0);
    return d;
  }

  PVector WdispPos() {
    PVector d = w.thisPlayer.position.get();
    d.sub(w.mapW/2, w.mapH/2, 0);
    d.mult(-1);
    return d;
  }

  PVector PdispPos() {  
    float rotateDist = 100*dist(gui.cursor.x, gui.cursor.y, w.dispW/2, w.dispH/2)/(w.dispW/2);
    PVector d = new PVector(-rotateDist, 0);
    d.rotate(w.thisPlayer.orientation);
    d.add(w.dispW/2, w.dispH/2, 0);
//    float maxspeed = 60, accel = 0.03, neg_accel = accel*0.8;
//    if (w.thisPlayer.velocity.x == 0) {
//      if (dispVelocity.x < 0) dispVelocity.x += neg_accel;
//      if (dispVelocity.x > 0) dispVelocity.x -= neg_accel;
//    } else if (w.thisPlayer.velocity.x < 0) {
//      if (dispVelocity.x > -maxspeed) dispVelocity.x -= accel;
//    } else {
//      if (dispVelocity.x < maxspeed) dispVelocity.x += accel;
//    }
//
//    if (w.thisPlayer.velocity.y == 0) {
//      if (dispVelocity.y < 0) dispVelocity.y += neg_accel;
//      if (dispVelocity.y > 0) dispVelocity.y -= neg_accel;
//    } else if (w.thisPlayer.velocity.y < 0) {
//      if (dispVelocity.y > -maxspeed) dispVelocity.y -= accel;
//    } else {
//      if (dispVelocity.y < maxspeed) dispVelocity.y += accel;
//    }
//    d.add(dispVelocity);
    return d;
  }

  private void updateCursor() {
    cursor.set(mouseX, mouseY, 0);
    PVector p = w.thisPlayer.dispPos.get();
    p.sub(w.dispW/2, w.dispH/2, 0);
    cursor.add(p);
  }
}

