static class Info {

  static final int tileSize = 16;
  static final int TILE_EMPTY = 0;
  static final int TILE_SOLID = 1;
  static final int TILE_WINDOW = 2;
  static final int CREATE_ENEMY = 3;

  // {frequency,spread,amount,cartridge,damage};
  static final float[][] weaponInfo = {
    {
      0, 0, 0, 0, 0
    }
    , {
      100, .06, 1, 100000, 100
    }
    , {
      500, .01, 1, 12, 400
    }
    , {
      20, .12, 1, 200, 50
    }
    , {
      750, .20, 6, 12, 150
    }
  };

  static final String[] weaponName = {
    "None", "M4 Rifle", "Barret 50Cal", "LMG", "Remington"
  };
}

