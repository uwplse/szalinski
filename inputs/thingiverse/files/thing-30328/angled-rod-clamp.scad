// Rod diameter
rod_dia=8;
// Wall thickness
wall=3;
// Screw diameter
screw_dia=3;
// Gap between clamps.
gap=2;
// Space between screw and rod.
screw_separation=1;
// Bevel
bevel=1;  //  [1, 0]
// Smooth channel
smooth=1;  //  [1, 0]


/* [Hidden] */
render_movable_parts = false;

module rod() {
  color([0.7, 0.7, 0.7]) {
    rotate([0,0,180/8])
      cylinder(r=rod_dia/2/cos(180/8), h=80, $fn=smooth ? 23 : 8, center=true);
  }
}

module clamp() {
  dia = rod_dia + screw_dia/2 + screw_separation+ wall;
  difference() {
    rotate([0,90,0])  {
      rotate([0,0,45/2]) {
	translate([0,0,gap / 2]) {
	  cylinder(r=dia/cos(180/8),
		   h=rod_dia+wall-gap / 2, $fn=8);
	}
      }
    }
    if (bevel) {
      for (rot=[0:45:360]) {
        rotate([rot,0,0]) {
  	  translate([rod_dia+wall,dia,0]) {
	    rotate([0,0,45]) {
	      cube([wall*2 * cos(180/4) - 0.2, 100, 100], center=true);
            }
	  }
        }
      }
    }
    translate([rod_dia/2,
	       (rod_dia+screw_dia+screw_separation)/2,0]) {
      rod();
      translate([-rod_dia/2, 0,0]) {
      cube([rod_dia, rod_dia, 100], center=true);
      }
    }
    rotate([0,90,0])  {
      cylinder(r=screw_dia/2, $fn=10, h = 100, center=true);
    }
  }
  if (render_movable_parts) {
    translate([rod_dia/2, (rod_dia+screw_dia+screw_separation)/2,0]) rod();
  }
}

rotate([0,90,0]) {
  translate([gap / 2,0,0]) {
    if (render_movable_parts) {
      clamp();
    }
    
    rotate([45,180,0]) clamp();
  }
}

