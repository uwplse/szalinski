tileHeight =  2; // [2:20]
tileWidth = 100;  // [10:300]
border = 0; // [5]
type = "Rhombus"; // [Rhombus,Rhombille Tile]

module tri() {
  translate([tileWidth / 2, 0, 0])
    cylinder(r = tileWidth, h = tileHeight, $fn = 3);
}

module poly() {
  union() {
    translate([0, 0, 0]) {
      tri();
      mirror([1, 0, 0]) tri();
    }
  }
}

module borderedRhombus() {
  rotate([0, 00, 30]) difference() {
    resize([tileWidth, 0, 0], auto = true) poly();
    resize([tileWidth - 2 * border, 0, 0], auto = true) 
      translate([0, 0, tileHeight - 1])  poly();
  }
}

module rhombus() {
  rotate([0, 00, 30]) poly();
}

module tile() {
  offset = sqrt(3) * tileWidth / 2;
  union() {
    color("LemonChiffon")                        translate([0, offset, 0])   poly();
    color("SandyBrown")    rotate([0, 0, 120])   translate([0, offset, 0])   poly();
    color("YellowGreen")   rotate([0, 0, 60])    translate([0, -offset, 0])  poly();
  }
}

if (type == "Rhombille Tile") { tile(); }
else if (border > 0) { borderedRhombus(); }
else { rhombus(); }