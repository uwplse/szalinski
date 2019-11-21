

innerSide = 50.3;
tol = 0.2;
z = 30;
wall = 1.5;
cornerSide = 12;
cornerZ = 1;


innerX = innerSide + tol;
innerY = innerSide + tol;

outerX = innerX + 2*wall;
outerY = innerY + 2*wall;

connector();

module connector() {
  difference() {
    cube([outerX, outerY, z]);
    translate([wall, wall, -1])
      cube([innerX, innerY, z + 2]);
  }
  translate([wall, wall, (z - cornerZ)/2])
    corner();

  translate([wall + innerX, wall, (z - cornerZ)/2])
    rotate(90, [0, 0, 1])
      corner();

  translate([wall + innerX, wall + innerY, (z - cornerZ)/2])
    rotate(180, [0, 0, 1])
      corner();

  translate([wall, wall + innerY, (z - cornerZ)/2])
    rotate(270, [0, 0, 1])
      corner();
}

module corner() {
  color("red")
    linear_extrude(height = cornerZ)
      polygon(points=[[0, 0], [cornerSide, 0], [0, cornerSide]]);
}