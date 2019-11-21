nut_dia=16; //diameter nut

difference() {

  union() {
    import("spinn.stl");
      for (i=[0:4]) {
      rotate([0,0,72*i])
      translate([12, 16, 0])
      cylinder(r=8, h=5.5, center=true);
      }
  }

  for (i=[0:4]) {
  rotate([0,0,72*i])
  translate([0, -19.8, 0])
  cylinder(r=nut_dia/2, h=5.5, $fn=6, center=true);
  }

}

  cylinder(r=nut_dia/2, h=5.5, $fn=6, center=true);
