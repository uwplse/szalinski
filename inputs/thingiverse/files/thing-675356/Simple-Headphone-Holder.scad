$fs=.5;
$fa=.5;
width = 40;
hole_size = 3;
back_height=100;
front_height=50;
thickness=20;
bottom_hole_height=40;
top_hole_height=80;
front_length=60;
difference()
{
	union()
	{
	cube([thickness,width,back_height]);
	cube([front_length,width,thickness]);
	translate([front_length,0,0])cube([thickness,width,front_height]);
	rotate([90,0,0])translate([thickness/2,back_height,-width/2])cylinder(h=width, r=thickness/2, center=true);
	rotate([90,0,0])translate([front_length+thickness/2,front_height,-width/2])cylinder(h=width, r=thickness/2,center=true);
}
rotate([0,90,0])translate([-bottom_hole_height,10,-1])cylinder(d=hole_size, h=thickness+2);
rotate([0,90,0])translate([-bottom_hole_height,width-10,-1])cylinder(d=hole_size, h=thickness+2);
rotate([0,90,0])translate([-top_hole_height,width-10,-1])cylinder(d=hole_size, h=thickness+2);
rotate([0,90,0])translate([-top_hole_height,10,-1])cylinder(d=hole_size, h=thickness+2);
}
