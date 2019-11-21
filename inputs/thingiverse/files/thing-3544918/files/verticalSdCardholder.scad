
// Number of card slots
cardCount = 4;

// Adding 0 to not show up in thingiverse customizer
y = 15 + 0;
z = 27 + 0;

xSlot = 10 + 0;
ySlot = 3 + 0;

sdCardX = 32 + 0;
sdCardY = 24 + 0;
sdCardZ = 2 + 0;
tol = 0.2 + 0;
angle = -20 + 0;

verticalHolder();

module verticalHolder() {
  difference() {
    cube([(cardCount + 1) * 11, y, z]);
    for (slot = [0 : cardCount ]) {
      translate([xSlot * (slot - 1) + 0.5, y-3, -0.5]) {
        rotate([0, 0, angle]) {
          if (slot == cardCount) {
            cube([50, 20, z + 1]);
          } else {
            cube([xSlot, 20, z + 1]);
          }
        }
      }
      if(slot < cardCount) {
        translate([xSlot * (slot - 1), y, (z - sdCardY)/2 -tol]) {
          rotate([0, 0, angle]) {
            sdCard(tol);
          }
        }
      }
    }
  }
}

module sdCard(tol) {
  rotate([90, 0, 0]) {
    cube([sdCardX, sdCardY + 2 * tol, sdCardZ + 2 * tol]);
  }
}