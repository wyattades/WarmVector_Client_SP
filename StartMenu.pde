class StartMenu {

  ArrayList<Button> buttons;
  int stage;
  Input input;

  StartMenu(int level, Input input) {
    buttons = new ArrayList<Button>();
    this.input = input;
    buttons.add(new Button(width/2, height/2-100, 300, 80, color(100), color(255, 0, 0), "NEW GAME", 2, input));
    if (level != 1) buttons.add(new Button(width/2, height/2, 300, 80, color(100), color(255, 0, 0), "CONTINUE", 3, input));
    buttons.add(new Button(width/2, height/2+200, 200, 80, color(100), color(255, 0, 0), "QUIT", 10, input));
    buttons.add(new Button(width/2, height/2+100, 200, 80, color(100), color(255, 0, 0), "HELP", 9, input));
  }

  void render() {
    cursor(ARROW);
    for (int i = 0; i < buttons.size (); i++) {
      Button b = buttons.get(i);
      b.render();
    }
  }

  void update() {
    for (int i = 0; i < buttons.size (); i++) {
      Button b = buttons.get(i);
      if (b.overClick()) stage = b.send;
    }
  }
}

class Button {

  PVector pos, size;
  String text;
  int send;
  color f, s;
  Input input;

  Button(float x, float y, float w, float h, color f, color s, String text, int send, Input input) {
    pos = new PVector(x, y);
    size = new PVector(w, h);
    this.input = input;
    this.text = text;
    this.send = send;
    this.f = f;
    this.s = s;
  }

  boolean overBox() {
    if (input.mousePos.x > pos.x-size.x/2 && input.mousePos.x < pos.x+size.x/2 && input.mousePos.y > pos.y-size.y/2 && input.mousePos.y < pos.y+size.y/2)
      return true;
    return false;
  }

  boolean overClick() {
    if (overBox() && input.mouseLeft == true) 
      return true;    
    return false;
  }

  void render() {
    if (overBox()) {
      fill(f);
      stroke(s);
    } else {
      fill(s);
      stroke(f);
    }
    strokeWeight(1);
    rect(pos.x, pos.y, size.x, size.y);
    textSize(30);
    fill(0);
    textAlign(CENTER);
    text(text, pos.x, pos.y+10);
  }
}

