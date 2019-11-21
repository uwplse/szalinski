//
// Create augers for drills, automatic dispensers, Archimedes pumps, even ACME threaded rods! :)
//
// Licenced under CreativeCommons-Attribution-ShareAlike licence
//		For the "attribution", please link to http://www.thingiverse.com/thing:685253


/* [main] */

// The length of the auger
length=50;

// How many full rotations the thread makes (hint: you can convert from threads-per-inch by multiplying by length)
rotations=3;

// How big the outside of the auger will be
outer_dia=20;

// How big the inside of the auger will be
inner_dia=5;

// How thick the auger paddles will be (useful for creating ACME threaded rods!)
auger_thickness=2;

// Whether or not there will be a shaft at inner_dia, or just a hole
inner_shaft=true;

// If you want an outer shaft, like an Archimedes screw pump (set to 0 to disable)
outer_shaft_thickness=0;

// Cut in half lengthwise for easier printability (may not always work, for instance, without a shaft)
cut_in_half=false;

/* [hidden] */
scoche=0.01;
halfscoche=scoche/2;
pi=3.14159265358979323846264338327950288;

module helix(length,thickness,id,od,rotations=1,slices=500){
	helix_width=od/2-id/2;
	minq=0.75;
	q=minq+(thickness-floor(thickness/minq)*minq)/floor(thickness/minq);
	c=pi*od;
	angle=c/q*360;
	union() for(n=[0:q:thickness]){
		rotate([0,0,-n*6]) linear_extrude(height=length,convexity=10,twist=360*rotations,slices){
			translate([id/2,-q/2,0]) square([helix_width,q]);
		}
	}
}

module auger(){
	helix_hole_dia=inner_shaft?inner_dia*0.75:inner_dia;
	helix(length,auger_thickness,helix_hole_dia,outer_dia,rotations);
	union() {
		if(inner_shaft){
			cylinder(r=inner_dia/2,h=length,$fn=32);
		}
		if(outer_shaft_thickness>0) difference(){
			cylinder(r=outer_dia/2+outer_shaft_thickness,h=length);
			translate([0,0,-halfscoche]) cylinder(r=outer_dia/2,h=length+scoche);
		}
	}
}

if (cut_in_half)
{
	translate([-length/2,2+outer_dia/2,0]) rotate([0,90,0]) difference(){
		auger();
		translate([0,-outer_dia/2-halfscoche,-halfscoche]) cube([outer_dia+scoche,outer_dia+scoche,length+scoche]);
	}
	translate([length/2,-(2+outer_dia/2),0]) rotate([0,-90,0]) difference(){
		auger();
		translate([-(outer_dia+scoche),-outer_dia/2-halfscoche,-halfscoche]) cube([outer_dia+scoche,outer_dia+scoche,length+scoche]);
	}
}
else
{
	auger();
}