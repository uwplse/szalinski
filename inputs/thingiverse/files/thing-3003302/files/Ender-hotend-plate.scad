/*
 * Module Ender-hotend_plate.scad
 * Author: Anhtien Nguyen
 * Date created: Jun 23, 2018
 */
 
 gap=0.25;
 width=64.2;
 length=46.1;
 thickness=4;
 vslot_hole_dia= 5; // M5
 sml_hole_dia=3; // M3

// turn it upside down to print
translate([0,0,thickness/2]) rotate([180,0,0]) 
DrawPlate();

/*
 * Draw the plate and all the M5 and M3 holes
 */
module DrawPlate(){
     $fn=64;
     difference() {
        // draw the rectangle and cut the hole at top left & right
         union() {
         difference() {
              cube([width,length,thickness],center=true);
              translate([width/2,length/2,0]) cylinder(r=6,h=thickness+2,center=true);
              translate([-width/2,length/2,0]) cylinder(r=6,h=thickness+2,center=true);
         }
         // now fill the top left & right with round corner 6mm radius
         translate([0,0,-thickness/2]) roundedRect([width,length,thickness],6);
        }
         //left M5 hole
         translate([-width/2+12,length/2-12,0]) cylinder(r=vslot_hole_dia/2+gap,h=thickness+2,center=true);
        // right M5 hole
         translate([width/2-12,length/2-12,0]) cylinder(r=vslot_hole_dia/2+gap,h=thickness+2,center=true);
        // M3#1 is between those two M5 holes
        translate([0,length/2-14.3,0]) cylinder(r=sml_hole_dia/2+gap,h=thickness+2,center=true);
        // M3#2 is bottom right of M3#1
        translate([10.9,length/2-24.85,0]) cylinder(r=sml_hole_dia/2+gap,h=thickness+2,center=true);
        // M3#3 is at the right side of M3#2
        translate([10.9+14,length/2-24.85,0]) cylinder(r=sml_hole_dia/2+gap,h=thickness+2,center=true);
        // M3#4 is right below left M5
        translate([-17.75,length/2-14.3-19,0]) cylinder(r=sml_hole_dia/2+gap,h=thickness+2,center=true);
        } 
 /*
  * Add the R12 area at the bottom of the rectangle with the M5 hole in there
  */
    translate([0,-length/2-6.08,0]) difference() {
        union() {
        cylinder(r=12,h=thickness,center=true);       
        translate([-12,+gap,-thickness/2])cube([24,6,thickness]);
        }
        // link the R12 circle to the edge, hole is actuall M7 for eccentric nuts
        cylinder(r=(vslot_hole_dia+2)/2+gap,h=thickness+2,center=true);
    }
/*
 * Add the left and right tabs
 */
    translate([-width/2,-length/2-3,-20+thickness/2])cube([17,3,20]);
    translate([width/2-17,-length/2-3,-20+thickness/2])cube([17,3,20]);
}

module roundedRect(size, radius)
{
	x = size[0];
	y = size[1];
	z = size[2];

	linear_extrude(height=z)
	hull()
	{
		// place 2 circles at two ends, with the given radius
		translate([(-x/2)+(radius), (y/2)-(radius), 0])
		circle(r=radius);
		translate([(x/2)-(radius), (y/2)-(radius), 0])
		circle(r=radius);
	}
}