thickness = 10;
gap = 15;
length = 90;
lip_length = 5;
fragments = 10;

module arms (){
  arm(0, true);
  arm(gap+thickness, false);
}

module arm(xOffset, lip){
  translate([xOffset, 0, 0])
  cylinder(r=thickness/2, h=length, $fn=fragments);

  // Round tip:
  translate([xOffset, 0, length])
  hull(){
    sphere($fn=fragments, r=thickness/2);

    if (lip) {
      translate([lip_length,0,0])
      sphere($fn=fragments, r=thickness/2);
    }
  }
}

module corner() {
  difference(){

    rotate_extrude($fn=fragments * 2)
      translate([gap/2 + thickness/2, 0, 0])
      circle(r=thickness/2, $fn=fragments);

    translate([-thickness/2 - gap, (length + thickness + gap) /-1, -thickness])
    cube([thickness + gap*2, length + thickness + gap, thickness * 2]);

  }
}

rotate(v=[1,0,0], a=90)
translate([-(gap + thickness)/2,0,0])
arms();
corner();
