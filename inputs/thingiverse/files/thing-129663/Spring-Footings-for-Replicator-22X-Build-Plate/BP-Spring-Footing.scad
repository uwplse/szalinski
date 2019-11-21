// Build Plate Footing

/* [Dimensions] */

// the footing base height
base_height = 1;

// the footing base diameter
base_diameter = 12;

// the height of the footing inner
inner_height = 8;

// the diameter of the footing inner
inner_diameter = 6.5;

// the diameter of the footing hole
hole_diameter = 3.4;

/* [hidden] */
$fn = 20;

difference() {
 union() {
  cylinder(h=base_height, r=base_diameter/2);
  cylinder(h=inner_height-1, r=inner_diameter/2);
  translate([0,0,inner_height - 1]) cylinder(h=1, r1=inner_diameter/2, r2=inner_diameter/2-.5);
 }
 translate([0,0,-1]) cylinder(h=inner_height+2, r=hole_diameter/2);
 translate([0,0,inner_height-0.9]) cylinder(h=1, r1=hole_diameter/2, r2=hole_diameter/2+.5);
 translate([0,0,-0.1]) cylinder(h=1, r1=hole_diameter/2+0.5, r2=hole_diameter/2);
}