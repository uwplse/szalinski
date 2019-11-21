module borderRoundedTriangle(height,size) {
  sPos = size/2;
  yPos = sqrt((size*size)-(sPos*sPos))-sPos;
  translate([0,-(sPos-yPos),0])
  intersection() {
    translate([sPos,sPos,0]) cylinder(h=height, d=size*2, $fn=size*4);
    translate([-sPos,sPos,0]) cylinder(h=height, d=size*2, $fn=size*4);
    translate([0,-yPos,0]) cylinder(h=height, d=size*2, $fn=size*4);
  }
}

difference() {
  borderRoundedTriangle(6.5,33);

  translate([0,0,1.5]) borderRoundedTriangle(5,24);

  difference() {
    borderRoundedTriangle(5,31);
    borderRoundedTriangle(5,26);
  }
}

translate([0,25.5,0])
difference() {
  translate([0,0,0.5]) cube([15,20,1], center=true);
  translate([0,-42.5,0]) cylinder(h=1, d=66, $fn=80);
}

translate([-10,35,1]) rotate([0, 90, 0]) cylinder(h=20, d=2, $fn=20)
translate([0,-12.3,0.5]) cube([4,3,1], center=true);
