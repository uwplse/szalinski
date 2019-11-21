// RebeliX
//
// spool-center
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz

// Prumer otvoru v civce
spool_hole_biggest = 52.5; // "Fillamentum"
spool_hole_big = 50.1; // "plasty Mladec"
spool_hole_small = 32; // "MK Floria"

union() {
    difference()
    {
	    union ()
	    {
            cylinder(h=1.5, r=(spool_hole_biggest/2)+4,$fn=64);
		    cylinder(h=4.5,r=(spool_hole_biggest/2),$fn=64);
            cylinder(h=7.5,r=(spool_hole_big/2),$fn=64);
		    cylinder(h=12,r=(spool_hole_small/2),$fn=64);
	    }
	    translate([0,0,-0.1]) cylinder (h=13,r=4.4,$fn=30);
		for ( i = [0 : 45 : 360] ){
		  rotate([0,0,i]) {
			translate([spool_hole_big/2 - 5,0,0]) cylinder(r=spool_hole_big/8.5,h=30, $fn=32,center=true);
			translate([spool_hole_big/2 + spool_hole_big/8.5 - 5,0,0]) cube([2*(spool_hole_big/8.5),2*(spool_hole_big/8.5),20],center=true);
			translate([spool_hole_big/2 + 4,- 5,0]) rotate([0,0,45]) cube([5,5,5],center=true);
			translate([spool_hole_big/2 + 4,+ 5,0]) rotate([0,0,45]) cube([5,5,5],center=true);
		  }
		}		
		translate([0,0,3]) cylinder(h=10,r=(spool_hole_small-12)/2);
    }
}
