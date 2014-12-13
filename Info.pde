static class Info {

  static final int tileSize = 16;
  static final int TILE_EMPTY = 0;
  static final int TILE_SOLID = 1;
  static final int TILE_WINDOW = 2;
  static final int CREATE_ENEMY = 3;
  static final int CREATE_THISPLAYER = 4;

  // {frequency,spread,amount,cartridge,damage};
  static final float[][] weaponInfo = {
    {
      0, 0, 0, 0, 0
    }
    , {
      80, .04, 1, 90, 30
    }
    , {
      750, .01, 1, 12, 100
    }
    , {
      40, .18, 1, 200, 17
    }
    , {
      500, .22, 6, 12, 24
    }
  };

  static final String[] weaponName = {
    "None", "M4 Rifle", "Barrett 50Cal", "LMG", "Remington"
  };
  
}

