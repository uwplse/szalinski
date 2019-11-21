// The width of the spool in mm
spool_width = 68.5; // [1:100]
// Clearance between the spool and the holder in mm
clearance = 2; // [1:10]


module side(){
	difference(){
		cube([56,12,5],center=true);
		cube([8.3,3.8,6],center=true);
		translate([0,-2,0])cube([3.8,10,6],center=true);
	}
	translate([-35.7/2-5.7/2,-8.5,0])cube([5.7,5,,5],center=true);
	translate([35.7/2+5.7/2,-8.5,0])cube([5.7,5,,5],center=true);
}
width=spool_width + clearance;
translate([0,-width/2+6,0]){
	side();
	translate([0,width-12,0])rotate(180)side();
}
translate([56/2-10/2,0,0])cube([10,width,5],center=true);
translate([-56/2+10/2,0,0])cube([10,width,5],center=true);

