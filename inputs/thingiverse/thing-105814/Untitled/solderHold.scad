//smoothness
$fn=50;//[10:200]

//Inner diameter of spool in mm
ID=20;

//Outer diameter of spool in mm
OD=50;

//the width of the spool in mm
spool_width=42;

//wall thickness (mm). Recommended minimum 3mm
wall_thickness=3;

//The space between the spool and the walls
clearance=5;

// The dia of the hole for the solder to pass through
hole_size=1.5;

r=OD/2+clearance+wall_thickness;

difference(){
	union(){
		translate([r,r,0])cylinder(wall_thickness,r,r);
		cube([2*r,r,wall_thickness]);
		cube([2*r,wall_thickness,spool_width+wall_thickness]);
		cube([wall_thickness,r+wall_thickness,spool_width+wall_thickness]);
		translate([r,r,0])cylinder(wall_thickness+spool_width,ID/2,ID/2);
		translate([r,r,spool_width+wall_thickness+ID/4])sphere(ID/2+1);
	}
	translate([r,r,-1])cylinder(wall_thickness+spool_width+2*ID,ID/2-wall_thickness,ID/2-wall_thickness);
	translate([r-2,r-ID/2-2,wall_thickness])cube([4,ID+2+2,spool_width+ID+1]);
	translate([r,r,spool_width+wall_thickness+0.5*ID])cylinder(ID,ID/2+1,ID/2+1);
	translate([-1,r/2,spool_width/2+wall_thickness])rotate([0,90,0])cylinder(wall_thickness+2,hole_size,hole_size);
}













