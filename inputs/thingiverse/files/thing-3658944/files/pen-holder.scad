$fn = 100;

screw_diameter = 5;
hole_diameter = 20;
cylinder_height = 100;
cylinder_inner_radius = 25;
wall_thickness = 1;

module positive() {
     difference() {
	  cylinder(h=cylinder_height, r=cylinder_inner_radius+wall_thickness);
	  union() {
	       translate([0,0,wall_thickness]) cylinder(h=cylinder_height, r=cylinder_inner_radius);
	       translate([-cylinder_inner_radius-wall_thickness,0,0]) cube([2*(cylinder_inner_radius+wall_thickness), cylinder_inner_radius+wall_thickness,cylinder_height+1]);
	  }
     }
     translate([-cylinder_inner_radius-wall_thickness,0,0])
	  cube([2*(cylinder_inner_radius+wall_thickness),wall_thickness,cylinder_height]);
}

difference() {
     positive();
     union() {
	  translate([0,2,cylinder_height/3]) rotate([90,0,0]) # cylinder(r=screw_diameter/2,h=wall_thickness+2);
	  translate([0,-cylinder_inner_radius/2,cylinder_height/3]) rotate([90,0,0]) # cylinder(r=hole_diameter/2,h=cylinder_inner_radius+2);

	  translate([0,2,2*cylinder_height/3]) rotate([90,0,0]) # cylinder(r=screw_diameter/2,h=wall_thickness+2);
	  translate([0,-cylinder_inner_radius/2,2*cylinder_height/3]) rotate([90,0,0]) # cylinder(r=hole_diameter/2,h=cylinder_inner_radius+2);
     }
}
