// Circular bed leveling print version 2, for Thingiverse
// frontier204

// Major diameter of the whole object
objDiam = 137;	
// Size of the rings closest to the middle
centerRingsDiam = 50; 
// Height of the object (multiple of layer height)
height  = 0.30; 

// Thickness of the rings to place
ringthickness = 2; 

// Spacing between the rings
ringspacing = 2; 

// For cuts to clear everything
bignumber = 100000*1;

// Size of the cuts going through the pattern
cutthickness = 4;

// Number of rings near to the outside of the pattern
num_outer_rings = 3;
// Number of rings inside the pattern
num_inner_rings = 2;
// Number of cuts
num_cuts = 2; // [2,3,4,5,6]
// Angle of the initial cut
cut_angle = 45; // [0:180]
// how fine the rings should be (big numbers take longer to generate)
fn_in = 64; // [64, 128, 256, 512, 1024]


difference() {
	rings();
	cuts();
}

module rings() {
	// Major outer rings
	if( num_outer_rings > 0) {
		for(i=[0:num_outer_rings-1]) {
			ring(objDiam - (ringthickness*2+ringspacing)*i , ringthickness , height);
		}
	}

	// rings closer to the middle
	if( num_inner_rings > 0) {
		for(i=[0:num_inner_rings-1]) {
			ring(centerRingsDiam - (ringthickness*2+ringspacing)*i , ringthickness , height);
		}
	}
}

module cuts() {
	translate([0,0,height/2])
	for( rot=[0:num_cuts-1] ) {
		rotate([0,0,cut_angle+rot*(180/num_cuts)])
		
		cube([bignumber, cutthickness, bignumber*2], center=true);
	}	
}

// a single ring
module ring( diam, thickness, height ) {
	difference() {
		cylinder(r=diam/2, h=height, $fn=fn_in);
		cylinder(r=diam/2 - thickness, h=bignumber, $fn=fn_in, center=true);
	}
}