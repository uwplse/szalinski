//	Window Width
width = 38;
//	Window height
height = 44;
//	The smaller this number the more light that will be let through
thickness= 1.5;
// The default is for modio parts printed at 100% scale
post_diameter=3;

cube([width, height, thickness], center=true);
translate([0,.5*height+2,-.5*thickness])
difference(){
translate([0,0,.75])rotate([90,0,0])cylinder(10,post_diameter/2,post_diameter/2,$fn=40,center=true);
translate([0,0,-10])cube([20,12,20],center=true);
};