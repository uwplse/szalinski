canopyHoleDiameter = 1.0;
frameHoleDiameter = 2.4;
frameHoleBottomDiameter = 4;
frameHoleOffset = 0;
boardHoleDiameter = 1.0;
boardHoleOffset = 4;
canopyOffset = 2.2;

walls = 1.2;

height = 3.4;
heightBoard = 2;

$fn = 45;

frameHoleRadius = frameHoleDiameter / 2;
boardHoleRadius = boardHoleDiameter / 2;
canopyHoleRadius = canopyHoleDiameter / 2;
frameHoleBottomRadius = frameHoleBottomDiameter / 2;

difference() {
  group() {
    cylinder(r = frameHoleRadius + walls, h = height);

    hull() {
      cylinder(r = frameHoleRadius + walls, h = heightBoard);
      translate([0, boardHoleOffset, 0])
        cylinder(r = boardHoleRadius + walls, h = heightBoard);
    }
    
    translate([0, 0, height/2])
      rotate([90,0,0])
        cylinder(r = height / 2, h = canopyOffset + frameHoleRadius + walls);
  }

  hull() {
    translate([0, 0, -0.1])
      cylinder(r = frameHoleBottomRadius, h = 0.1);
    translate([0, 0, height / 2 - frameHoleOffset])
      cylinder(r = frameHoleRadius, h = 0.1);
  }
  
  translate([0, 0, -1])
    cylinder(r = frameHoleRadius, h = height + 2);

  translate([0, boardHoleOffset, -1])
    cylinder(r = boardHoleRadius, h = heightBoard + 2);
  
  translate([0, -walls - boardHoleRadius, height/2])
      rotate([90,0,0])
        cylinder(r = canopyHoleRadius, h = canopyOffset + frameHoleRadius + walls);
}
  