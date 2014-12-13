class Input {

  boolean keyUp, keyLeft, keyRight, keyDown, mouseLeft, mouseRight, tab;
  int mouseRightTime, mouseLeftTime;
  PVector mousePos;

  Input() {
    keyUp = keyLeft = keyRight = keyDown = mouseLeft = mouseRight = tab = false;
    mouseRightTime = mouseLeftTime = 0;
    mousePos = new PVector(0,0);
  }
  
  void updateMouse(int mousex, int mousey) {
    mousePos.set(mousex,mousey);
  }

  void pressMouse(int mouseButton) {
    if (mouseButton == LEFT) {
      mouseLeft = true;
    }
    if (mouseButton == RIGHT) {
      mouseRight = true;
    }
  }

  void releaseMouse(int mouseButton) {
    if (mouseButton == LEFT) {
      mouseLeft = false;
    }
    if (mouseButton == RIGHT) {
      mouseRight = false;
    }
  }

  void pressKey(int key, int keyCode) {
    if (key == TAB) {
      tab = true;
    }
    if (keyCode == 'W') {
      keyUp = true;
    }
    if (keyCode == 'A') {
      keyLeft = true;
    }
    if (keyCode == 'S') {
      keyDown = true;
    }
    if (keyCode == 'D') {
      keyRight = true;
    }
  }

  void releaseKey(int key, int keyCode) {
    if (key == TAB) {
      tab = false;
    }
    if (keyCode == 'W') {
      keyUp = false;
    }
    if (keyCode == 'A') {
      keyLeft = false;
    }
    if (keyCode == 'S') {
      keyDown = false;
    }
    if (keyCode == 'D') {
      keyRight = false;
    }
  }
}

