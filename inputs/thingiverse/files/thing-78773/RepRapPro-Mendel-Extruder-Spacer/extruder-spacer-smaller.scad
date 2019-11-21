/**
 * extruder bar mount
 * allows standard extruder to be mounted at an angle to the frame for a bit more z height
 */ 

m8_diameter = 8.4;
m3_diameter = 3.1;
arm_length = 40;

module barclamp(){
outer_diameter_y = (m8_diameter-0.0)/2+3;
outer_diameter_z = outer_diameter_y;
//outer_diameter_z = 5;

difference(){
	union(){
		
		translate([outer_diameter_y, outer_diameter_y, 0])cylinder(h =10, r = outer_diameter_y, $fn = 20);
		translate([outer_diameter_y, 0, 0])cube([outer_diameter_y+10,outer_diameter_y*2,10]);
		//translate([18, 2*outer_diameter_y, outer_diameter_z])rotate([90, 0, 0]) rotate([0, 0, 0])
		//nut(outer_diameter_z*2,outer_diameter_y*2,false);
	}


	translate([19, outer_diameter_y, 9]) #cube([19,5,20], center=true);
	translate([outer_diameter_y, outer_diameter_y, -1]) cylinder(h =20, r = m8_diameter/2, $fn = 18);
	translate([17, 17, 5]) rotate([90, 0, 0]) cylinder(h =80, r = m3_diameter/2, $fn = 20);
}
}

rotate(a=[0,0,90]){
translate([-23,0,0]) barclamp();
}
rotate(a=[0,270,0]){
difference()
{
union(){
cube([10,arm_length,2]);
//translate([5,1,0]) cylinder(2,5,5);
translate([5,arm_length,0])cylinder(2,5,5);
}
//translate([5,1,0]) cylinder(4,1.7,1.7);
translate([5,arm_length,0]) cylinder(4,m3_diameter/2,m3_diameter/2,$fn=18);
}
}