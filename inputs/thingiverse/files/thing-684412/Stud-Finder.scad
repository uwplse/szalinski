$fa=.5;
$fs=.5;
magnet_height=6; //[1:11]
magnet_diameter=12; //[1:17]
module GSLogo(){
cube([15,3,2]);   //The G
cube([3,12,2]);
translate([0,12,0])cube([5,3,2]);
translate([15,0,0])cube([3,12,2]);
translate([9,12,0])cube([9,3,2]);
translate([9,9,0])cube([3,5,2]);
	translate([0,18,0])cube([3,12,2]);  //The S
	translate([0,18,0])cube([9,3,2]);
	translate([9,18,0])cube([3,12,2]);
	translate([9,27,0])cube([9,3,2]);
	translate([15,18,0])cube([3,12,2]);
}


difference()
{
	union()
	{
	color("blue"){
	cube([18,25,15]);
	translate([9,0,0])cylinder(h=15,r=9);
	translate([9,25,0])cylinder(h=15,r=9);
	}
	color("red")translate([6,8,15])scale(v=[.3,.3,.3])GSLogo();
	
}
translate([9,0,1])cylinder(h=magnet_height,d=magnet_diameter);
translate([9,0,-1])cylinder(h=3,d=3);
translate([9,25,3])cylinder(h=magnet_height,d=magnet_diameter);
translate([9,25,-1])cylinder(h=3,d=3);
translate([-3,12.5,-1])cylinder(h=17, r=7.5);
translate([21,12.5,-1])cylinder(h=17, r=7.5);
}