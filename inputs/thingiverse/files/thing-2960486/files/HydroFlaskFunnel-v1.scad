/*
 *  Name: HydroFlaskFunnel.scad
 *  Description: Funnel for HydroFlask
 *  Author: Anhtien Nguyen
 *  Date: June 13, 2018
 */

//
//*********************************************************************
// hydro-flask diameter (smallest)
hd = 53.64; // 40oz hydro-flask
// clearance
clearance= 2;
// thickness
wall = 3;
// funnel height
ht = 80;
// bottom diameter (largest)
bd = 120;
or = hd/2-clearance; // outer radius top
x0 = bd/2-or; // radius  bottom

ir = or - wall; // inner radius, top

function sqr(x) = x * x;
xc = (sqr(ht) + sqr(x0)) / (2 * x0);

makeFunnel();

module makeFunnel()
{
	$fn = 240;

	rotate_extrude()
	translate([ir, 0])
	intersection() {
		difference() {
			square([x0 + wall, ht]);
			translate([xc + wall, ht]) circle(xc);
		}
		translate([xc + wall, ht]) circle(xc + wall);
	}
	//  ring at bottom
	difference() {
		cylinder(h = 2, r = x0+or+((x0+or)/15));
		translate([0, 0, -1])
		cylinder(h = 4, r = x0+or-3);
	}

	// Half moon lip
	translate([-x0-or,0,0]){
		difference() {
			cylinder(r=20, h=2);
			translate([25,0,0]) cube(50, center=true);
		}
	}
}
