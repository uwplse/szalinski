/* 2-tiered Essential oil wall rack for 5ml bottles
The second row is high enough to be able to read the label

I print with 15% infill
Created by Joe Rothrock 10/29/2018
*/
// Number of bottles wide
bottle_count = 8;// [2:10]
// Bottle diameter
dia = 25;// [15:40]
// bottle spacing
spacing = dia-1.7;
// inside width
width = spacing * (bottle_count-1) + dia;

difference() {
	$fn = 40;
	cube([dia*2+7,width+4,100]);
	// bottom row bottle pockets
	for(y = [dia/2+2:spacing:spacing*bottle_count+2]) {
		translate([(dia+5)+dia/2,y,3]) cylinder(d=dia,h=60);
	}
	// trim excess height from bottom shelf
	translate([dia+5,2,15]) cube([dia+10,width,100]);
	// top row bottle pockets
	for(y = [dia/2+2:spacing:spacing*bottle_count]) {
		translate([3+dia/2,y,48]) cylinder(d=dia,h=60);
	}
	// trim excess height from top shelf
	translate([3,2,60]) cube([dia+10,width,100]);
	// angle front
	translate([dia*2+7,-1,15]) rotate([0,-20,0]) cube(width+10);
	// add mounting holes
	translate([-1,dia,90]) rotate([0,90,0]) cylinder(d=4,h=10);
	translate([-1,width-dia+2,90]) rotate([0,90,0]) cylinder(d=4,h=10);
}