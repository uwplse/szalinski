//Taper Height - Set to 0 to disable taper
TAPER_HEIGHT=1.5;	

//Height of the cap
HEIGHT=8;

//Inside Diameter
ID=44;

//Outside Diameter
OD=46.5;

//Rubber Band Hole Diameter
HOLE_DIAMETER=3;

//Thickness of the endcap
BASE_THICKNESS=2;

difference() {
	cylinder(HEIGHT, d=OD, d=OD);
	translate([0,0,BASE_THICKNESS]) cylinder(HEIGHT, ID/2, ID/2);

	//Taper
	translate([0,0,HEIGHT - TAPER_HEIGHT]) cylinder(TAPER_HEIGHT + 1, ID/2, OD/2);

	//Band Holes
	translate([-1.5 * HOLE_DIAMETER,0,-.5]) cylinder(BASE_THICKNESS + 1, HOLE_DIAMETER, HOLE_DIAMETER);
	translate([1.5 * HOLE_DIAMETER,0,-.5]) cylinder(BASE_THICKNESS + 1, HOLE_DIAMETER, HOLE_DIAMETER);

}