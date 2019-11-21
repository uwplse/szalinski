/* [Global] */

// preview[view:north west, tilt:top diagonal]

// What should be rendered
what			    = 2;		// [0:Center holder,1:Side holder,2:Lamp shade]

// Diameter of the bottom part from down to up
// Standard E14 socket is slightly wider on it's top

Bottom_Diameter    = 33.4;	// [33:50]
Top_Diameter       = 34.3;	// [34:60]

// Diameter of the top part (shading), the end edge is the outer limit
Added_Diameter     = 55;	     // [50:100]

// Height of the socket's part
Cylinder_Height    = 30;		// [30:100]

// Height of the shade part
Added_Height       = 70;		// [50:100]

// Height of the screws which will be cut from the bottom part
Screws_Height      = 12;		// [12:20]

// The thickness of the cylinder walls
Wall_Thickness     =  1.75;   // [1.75:thin,3:thick]

/* [Screws] */

// There are two types of screws.
// A is the screw which holds holder and shading part together.
// B is the screw which holds the wires.

Screw_Spacing      = 19;	      // [15:25]
A_Screw_Radius     =  1.75;    // [1.5:thin,2:thick]
B_Screw_Radius     =  2.25;    // [2.25:thin:3:thick]

/* [Box parameters] */

// This is the box on the top of the socket
Box_Width          =  8;  // [6:10]
Box_Height         =  2;  // [2:3]
Bottom_Thickness   =  1;  // [1:3]

/* [Rod] */

// Diameter of the rod which goes through the upper part
Rod_Diameter       =  8.1; // [6:12]

/* [Hidden] */

Cylinder_Thickness = Wall_Thickness * 2;
Screw_Center       =  5 - 2*A_Screw_Radius;
fudge              =  0.01;

module bigger_elipse_hole() {
  union() {
    translate([0, Bottom_Diameter / -2.5, - Screws_Height]) linear_extrude(height = Screws_Height * 2 - B_Screw_Radius) hull() {
      translate([0, Bottom_Diameter / -2, 0]) circle(r = B_Screw_Radius, $fn = 72);
      translate([0, Bottom_Diameter / 2, 0]) circle(r = B_Screw_Radius, $fn = 72);
    }
    translate([0, Bottom_Diameter / 3, Screws_Height - B_Screw_Radius]) rotate([90, 0, 0]) cylinder(r = B_Screw_Radius, h = Bottom_Diameter, $fn = 72);
  }
}

module inner_plain_bottom_with_holes() {
  inner_fn = 72;
  difference() {
    cylinder(r1 = (Bottom_Diameter + Cylinder_Thickness) / 2, r2 = Bottom_Diameter / 2, h = Cylinder_Height / 2, $fn = inner_fn);
    translate([0, 0, Wall_Thickness])
      cylinder(r   = Bottom_Diameter / 2 - Cylinder_Thickness,
               h   = Cylinder_Height / 2 + fudge,
               $fn = inner_fn);

    translate([0, Screw_Spacing / -2, Cylinder_Height / 2 + Wall_Thickness])
      screw_elipse_hole();
    translate([0, Screw_Spacing / 2, Cylinder_Height / 2 + Wall_Thickness])
      screw_elipse_hole();

    translate([0, Screw_Spacing / -2, -fudge]) screw_elipse_hole();
    translate([0, Screw_Spacing / 2, -fudge]) screw_elipse_hole();

    rotate([0, 0, 90]) {
      translate([0, Screw_Spacing / -2, -fudge]) rotate([0, 0, -90]) scale([2, 3, 1]) screw_elipse_hole();
      translate([0, Screw_Spacing / 2, -fudge]) rotate([0, 0, -90]) scale([2, 3, 1]) screw_elipse_hole();
    }
  }
}

module inner_plain_cylinder() {
  inner_fn = 72;
  difference() {
    cylinder(r1 = (Bottom_Diameter + Cylinder_Thickness) / 2, r2 = (Top_Diameter + Cylinder_Thickness) / 2, h = Cylinder_Height, $fn = inner_fn);
    translate([0, 0, fudge / -2])
      cylinder(r1 = Bottom_Diameter / 2, r2 = Top_Diameter / 2, h = Cylinder_Height + fudge, $fn = inner_fn);
  }
}

module inner_cylinder() {
  difference() {
    inner_plain_cylinder();

    rotate([0, 0, -90]) {
      translate([0, Screw_Spacing / -2, 0]) rotate([0, 0, 90]) bigger_elipse_hole();
      translate([0, Screw_Spacing / 2, 0])  rotate([0, 0, 90]) bigger_elipse_hole();
    }

  }
}

module outer_cylinder() {
  outer_fn = 72;
  translate([0, 0, Cylinder_Height - fudge])
    difference() {
      cylinder(r1  = (Top_Diameter + Cylinder_Thickness) / 2,
               r2  = (Added_Diameter + Cylinder_Thickness) / 2,
               h   = Added_Height + fudge,
               $fn = outer_fn);
      translate([0, 0, fudge / -2])
        cylinder(r1  = Top_Diameter / 2,
                 r2  = Added_Diameter / 2,
                 h   = Added_Height + 2 * fudge,
                 $fn = outer_fn);
    }
}

module screw_elipse_hole() {
  translate([0, 0, Cylinder_Height / -2]) linear_extrude(height = Cylinder_Height) hull() {
    translate([0, Screw_Center / -2, 0]) circle(r = A_Screw_Radius, $fn = 72);
    translate([0, Screw_Center / 2, 0]) circle(r = A_Screw_Radius, $fn = 72);
  }
}

module inner_cylinder_bottom() {
  cylinder(r = (Bottom_Diameter + Cylinder_Thickness) / 2, h = Bottom_Thickness, $fn = 72);
  translate([0, 0, Bottom_Thickness - fudge])
    intersection() {
      cylinder(r = (Bottom_Diameter + Cylinder_Thickness) / 2, h = Box_Height + fudge, $fn = 72);
	 translate([Box_Width / -2, - Bottom_Diameter, 0])
        cube([Box_Width, Bottom_Diameter * 2, Box_Height + fudge]);
    }
}

module inner_cylinder_bottom_with_holes() {
  difference() {
    inner_cylinder_bottom();
    translate([0, Screw_Spacing / -2, 0]) screw_elipse_hole();
    translate([0, Screw_Spacing / 2, 0]) screw_elipse_hole();

    rotate([0, 0, -90]) {
      translate([0, Screw_Spacing / -2, 0]) rotate([0, 0, 90]) bigger_elipse_hole();
      translate([0, Screw_Spacing / 2, 0])  rotate([0, 0, 90]) bigger_elipse_hole();
    }

  }
}

module inner_plain_with_tycka(tycka_type = 1) {
  inner_fn = 72;
  cube_xy  = Screw_Spacing / 2 - 2 * A_Screw_Radius + fudge;
  cube_hl  = cube_xy - 2 * A_Screw_Radius;
  difference() {
    rotate([0, 0, 90]) union() {
      inner_plain_bottom_with_holes();
      translate([- cube_xy, - cube_xy, 0])
        cube([2 * cube_xy, 2 * cube_xy, Cylinder_Height / 3 + Cylinder_Thickness]);

      translate([- cube_xy, - Bottom_Diameter / 2 + Cylinder_Thickness, 0])
        difference() {
          cube([cube_hl, Bottom_Diameter - 2 * Cylinder_Thickness, Cylinder_Height / 2 - fudge]);
          translate([-fudge, Bottom_Diameter / 2 - 2 * cube_xy, cube_xy]) hull() {
            rotate([0, 90, 0]) cylinder(r = 1, h = cube_hl + 2 * fudge, $fn = inner_fn);
            translate([0, 0, Cylinder_Height / 2])
              rotate([0, 90, 0])
                cylinder(r = 3, h = cube_hl + 2 * fudge, $fn = inner_fn);
          }
          translate([-fudge, Bottom_Diameter - 2 * cube_xy, cube_xy]) hull() {
            rotate([0, 90, 0]) cylinder(r = 1, h = cube_hl + 2 * fudge, $fn = inner_fn);
            translate([0, 0, Cylinder_Height / 2])
              rotate([0, 90, 0])
                cylinder(r = 3, h = cube_hl + 2 * fudge, $fn = inner_fn);
          }
        }
      translate([cube_xy - cube_hl, - Bottom_Diameter / 2 + Cylinder_Thickness, 0])
        difference() {
          cube([cube_hl, Bottom_Diameter - 2 * Cylinder_Thickness, Cylinder_Height / 2 - fudge]);
          translate([-fudge, Bottom_Diameter / 2 - 2 * cube_xy, cube_xy]) hull() {
            rotate([0, 90, 0]) cylinder(r = 1, h = cube_hl + 2 * fudge, $fn = inner_fn);
            translate([0, 0, Cylinder_Height / 2])
              rotate([0, 90, 0])
                cylinder(r = 3, h = cube_hl + 2 * fudge, $fn = inner_fn);
          }
          translate([-fudge, Bottom_Diameter - 2 * cube_xy, cube_xy]) hull() {
            rotate([0, 90, 0]) cylinder(r = 1, h = cube_hl + 2 * fudge, $fn = inner_fn);
            translate([0, 0, Cylinder_Height / 2])
              rotate([0, 90, 0])
                cylinder(r = 3, h = cube_hl + 2 * fudge, $fn = inner_fn);
          }
        }
    }
    if (tycka_type == 1) {
      translate([0, - (Bottom_Diameter + Cylinder_Thickness + fudge) / 2, Cylinder_Height / 4]) rotate([0, 90, 90]) cylinder(r = Rod_Diameter / 2 + fudge, h = Bottom_Diameter + Cylinder_Thickness + fudge, $fn = inner_fn);
	} else {
       translate([0, - (Bottom_Diameter + Cylinder_Thickness + fudge) / 2, Cylinder_Height / 4]) rotate([0, 90, 90]) cylinder(r = Rod_Diameter / 2 + fudge, h = (Bottom_Diameter + Cylinder_Thickness + fudge) / 2 + cube_xy - cube_hl, $fn = inner_fn);
     }
  }
}

module lampicka() {
  inner_cylinder();
  inner_cylinder_bottom_with_holes();
  outer_cylinder();
}

module lampicka_modifier() {
  intersection() {
    lampicka();
    translate([0, 0, Screws_Height + fudge]) cylinder(r = Added_Diameter + fudge, h = Added_Height + Cylinder_Height);
  }
}

// lampicka_modifier();
// lampicka();

if (what == 0) {
  inner_plain_with_tycka(1);
} else if (what == 1) {
  inner_plain_with_tycka(2);
} else {
  lampicka();
}


// translate([0, - 200, Cylinder_Height / 4]) rotate([0, 90, 90]) cylinder(r = Rod_Diameter / 2 + fudge, h = 400, $fn = 72);