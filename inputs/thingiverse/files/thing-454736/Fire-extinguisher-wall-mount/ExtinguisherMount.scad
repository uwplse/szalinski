/* [ Basics ] */
// Which one would you like to see?
part = "Base"; // [Base:The bottom of the bracket,Arms:The arms to hold the extinguisher]

//The Diameter of your extinguisher (mm)
extinguisher_diameter = 80;
/* [ Extras ] */
// The width of the walls of the bracket (mm). Most parts scale with this value.
bracket_width = 4;
// The diameter of the screw hole (mm). The countersinking scales with this.
screw_hole_diameter = 3;
// The size of the gap in the arms (degrees).
arm_angle = 120; // [90:180]

/* [Hidden] */
// All done. Customizer doesn't need to see all this


$fn=50;
ext_r = extinguisher_diameter/2;
screw_r = screw_hole_diameter/2;
back_width = ext_r*1.5;
arm_angle = 120;

angle = (arm_angle - 90 )/2;
back_height = 8*bracket_width+screw_hole_diameter;

cube_size = 10; // [1:100]
cylinder_size = 10; // [1:100]

print_part();

module print_part() {
	if (part == "Base") {
		base();
		back_plate();
	} 
	else {
		back_plate();
		arms();
	}
}

module base(){
difference(){
cylinder(r = ext_r+bracket_width, h = 4*bracket_width);
translate([-0,0,bracket_width])cylinder(r = ext_r, h = 4*bracket_width);
translate([0,0,-bracket_width/2])cylinder(r = ext_r-3*bracket_width, h = 2*bracket_width);
}
}
//translate([0,ext_r-bracket_width,4*bracket_width])cube(back_height-4*bracket_width);

module arms(){
difference(){
cylinder(r = ext_r+bracket_width, h = 4*bracket_width);
translate([0,0,-bracket_width])cylinder(r = ext_r, h = 8*bracket_width);
rotate([0,0,angle])rotate([0,0,45+180])translate([0,0,-.01])cube(back_width);
rotate([0,0,-angle])rotate([0,0,45+180])translate([0,0,-.01])cube(back_width);
}
rotate([0,0,arm_angle/2])
translate([0,-(ext_r+bracket_width),0])cylinder(r = bracket_width, h = 4*bracket_width);
rotate([0,0,-arm_angle/2])
translate([0,-(ext_r+bracket_width),0])cylinder(r = bracket_width, h = 4*bracket_width);

}

module back_plate(){
difference(){
translate([-back_width/2,bracket_width,0])cube([back_width, ext_r,back_height]);
translate([0,0,-.01])cylinder(r = ext_r, h = back_width*2);
translate([back_width/2-2*bracket_width-screw_r,0,0])screw_hole();
translate([-(back_width/2-2*bracket_width-screw_r),0,0])screw_hole();
}
}


module screw_hole(){
translate([0,ext_r,6*bracket_width+screw_r])rotate([-90,0,0])
union(){
cylinder(r = screw_r, h = extinguisher_diameter);
translate([0,0,-screw_r+.01])cylinder(r2 = screw_r, r1 = screw_r*3, h = screw_r);
translate([0,0,-screw_r-ext_r+.02])cylinder(r = screw_r*3, h = ext_r);
}
}
