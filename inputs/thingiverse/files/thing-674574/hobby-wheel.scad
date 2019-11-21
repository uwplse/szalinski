// Hobby_wheel.scad
// Hobby store wooden wheels are expensive. Well, now you can create your own in any size you want!
// Licence is: Creative Commons - Attribution - Share Alike
// You can fulfil the "attribution" legal requirement by linking back to:
//		http://www.thingiverse.com/thing:674574
 
 /* [main] */
 
// The outer diameter of the wheel.
od=30;

// The diameter of the axle hole in the wheel.
id=7.5;

// How thick the round part of the wheel is
wheel_thick=6;

// How thick the hub part of the wheel is.
hub_thick=4;

// How big around the flat part of the hub is.
hub_dia=10;

// How thin the concavity of the wheel is at its thinnest point. Set this to min(hub_thick,wheel_thick) for no concavity.
concave_min_thick=2;

// the resolution of the small, cross-sectional circle of the wheel.
small_fn=24;

// The resolution of the overall wheel.
large_fn=128;

// Cut the wheel in half.  Otherwise, you may need to use support material in some circumstances.
half=0; // [0:no,1:yes]

/* [hidden] */

hmax=od/2-id/2-wheel_thick/2;
hub_overlap=hub_dia/2-id/2;

scoche=0.001;
halfscoche=scoche/2;

module concave_thing(){
	thick=od/2-id/2-wheel_thick+hub_overlap; // distance between hub and wheel
	cen=thick/2+id/2; // centred between the hub and the wheel
	translate([cen,-concave_min_thick/2,0]) square([0.1,concave_min_thick]);
}

difference(){
	rotate_extrude($fn=large_fn)
	{
		hull(){
			translate([od/2-wheel_thick/2,0,0]) circle(r=wheel_thick/2,$fn=small_fn);
			concave_thing();
		}
		hull(){
			translate([id/2,-hub_thick/2,0]) square([hub_overlap,hub_thick]);
			concave_thing();
		}
	}
	if(half==1){
		translate([-(od+scoche)/2,-(od+scoche)/2,-(max(wheel_thick,hub_thick)+scoche)]) cube([od+scoche,od+scoche,max(wheel_thick,hub_thick)+scoche]);
	}
}