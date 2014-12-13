class GUI {

  PVector dispVelocity;
  World world;
  PImage minimap;

  GUI(World world, PImage minimap, int level) {
    this.world = world;
    this.minimap = minimap;
    //w.sprites.add(new Sprite(images.get("levelmap_"+nf(level,2,0)), w.mapW, w.mapH, width-140, 120, 0, 0.12, 0, false, 255));

    dispVelocity = new PVector(0, 0);
  }


  void render() {
    displayMinimap();
    displayCursor();
    displayWords();
  }

  private void displayWords() {

    textAlign(RIGHT);
    textSize(30);
    fill(255,180);
    String displayAmmo = nf(world.thisPlayer.round, 2, 0);
    if (Info.weaponInfo[world.thisPlayer.weaponType][3] == -1) displayAmmo = "Inf";
    if (world.thisPlayer.weaponType == 0) displayAmmo = "NA";
    pushMatrix();
    translate(width-40,height-90);
    text("Weapon: "+Info.weaponName[world.thisPlayer.weaponType], 0, 0);
    text("Ammo: "+displayAmmo+"/"+nf(Info.weaponInfo[world.thisPlayer.weaponType][3],2,0), 0, 30);
    text("Health: "+nf(world.thisPlayer.health, 3, 0), 0, 60);
    popMatrix();
    text("Enemies: "+world.enemies.size(),width-40,60);
  }

  private void displayMinimap() {
    strokeWeight(1.5/0.12);
    stroke(255, 0, 0,120);
    fill(255,120);
    pushMatrix();
    translate(140, 120);
    scale(0.11);
    rect(0, 0, world.mapW, world.mapH);  
    image(minimap, 0, 0);
    strokeWeight(60);
    stroke(255, 0, 0,120);
    point(world.thisPlayer.position.x-world.mapW/2, world.thisPlayer.position.y-world.mapH/2);
    for (int i = 0; i < world.enemies.size (); i++) {
      Enemy p = world.enemies.get(i);
      stroke(0, 0, 255,120);
      point(p.position.x-world.mapW/2, p.position.y-world.mapH/2);
    }
    popMatrix();
  }

  private void displayCursor() {
    float linesize = 24;
    stroke(255);
    strokeWeight(3);
    point(world.cursor.x, world.cursor.y);
    line(world.cursor.x-linesize/2, world.cursor.y, world.cursor.x-linesize/4, world.cursor.y);
    line(world.cursor.x, world.cursor.y-linesize/2, world.cursor.x, world.cursor.y-linesize/4);
    line(world.cursor.x+linesize/4, world.cursor.y, world.cursor.x+linesize/2, world.cursor.y);
    line(world.cursor.x, world.cursor.y+linesize/4, world.cursor.x, world.cursor.y+linesize/2);
  }

}

