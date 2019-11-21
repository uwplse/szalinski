// The cover has a cylindrical section ("cover") and an imitation nut section ("nut")

/* [Global] */

// Internal Diameter
cover_id = 24.3;        // [24:0.1:25]
// This controls the tightness of the fit. Adjust in increments of 0.1 until you get the right fit. Lower numbers will result in a tighter fit.

/* [Hidden] */

nut_flange_od = 21.8;   // distance between flats of the nut part
nut_vertex_od = 25.2;   // distance between opposite vertices of the nut part
nut_h = 5.4;            // height of the nut section
cover_od = 26;          // outside diameter of the cover section
cover_t = 1;            // thickness of the cover section
flange_t = 0.4;         // thickness of the flange at the bottom of the cover section

cover_id_flange = cover_id-(flange_t*2);    // internal diameter of the cover section where the flange is
cover_h = 6.8;          // height of the cover section

centre_od = 11.5;         // width of centre locating pole



// A high resolution cylinder
module fine_cylinder(dia, length)
{
	cylinder(length, dia/2, dia/2, $fs = 0.5, $fa = 0.5);
}

// A six-sided cylinder that cun be subtracted from another shape to create something
// you can trap a hexagonal nut in
//
// dia is the distance from nut flat to nut flat, rather than the longer
// vertex to vertex distance. It's the distance you would naturally try to measure first,
// and the size of the socket or spanner you would use to tighten it.
module nut_capture(dia, thickness)
{
	// Convert the flat-to-flat distance to the radius of the circle that will encompass it
	// The nut can be drawn as 12 right angle triangles, each with a 30 degree angle at the 
	// centre of the nut. The adjacent size is half the flat-to-flat distance, and the hypotenuse
	// is the radius that will enclose the nut.
	rad = (dia/2)/cos(30);
	cylinder(h=thickness,r=rad, $fn=6);
}


rotate([180,0,0])
translate([0,0,-nut_h-cover_h])
union()
{
difference()
{
    union()
    {
        nut_capture(nut_flange_od, nut_h);
        translate([0,0,nut_h])
            fine_cylinder(nut_vertex_od, cover_t);
    }
    translate([0,0,cover_t])
        nut_capture(nut_flange_od-cover_t*2, nut_h*2);
}

translate([0,0,nut_h]) union()
{
    difference()
    {
        fine_cylinder(cover_od, cover_h);
        translate([0,0,cover_h/-2])
            fine_cylinder(cover_id, (cover_h*1.5)-flange_t);
        translate([0,0,cover_h-flange_t-1])
            color("red")
            fine_cylinder(cover_id_flange, cover_h);
    }
}

opp=(nut_vertex_od/2)*sin(30);
adj=nut_flange_od/2;
fine_cylinder(centre_od,cover_h+nut_h);
for(i = [0:60:300])
{
    translate([0,0,-0.001])
    rotate([0,0,i])
    polyhedron(points=[[0,0,(cover_h*0.73)+nut_h],[opp,adj,0],[-opp,adj,0],[0,0,0]],
            faces=[[0,1,2],[0,1,3],[0,2,3],[1,2,3]]);
}
}