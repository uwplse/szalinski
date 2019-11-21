// Author: Jean-Charles Marteau
// Porte torchon - Towel hook
// Thing: https://www.thingiverse.com/thing:3900441
// Remix of: https://www.thingiverse.com/thing:2984714

$fn=100;

plateDiam = 34;
plateLength = 54;
plateThickness = 3;
passThrouhDiam=21;
rainureDiam=11;

blockerHeight = 19.5;
blockerOverlap = 1;

holderMinDiam=7;
holderMaxDiam=14;
holderHeight=15;

// Change this if you want the handle or the towel hook
withTowel=false;

// For rendering the hook, you must download the stl from the remix and call it thing-2984714.stl in the same folder as the scad file.

module smooth(rounding) {
    offset(rounding) { offset(-rounding) { offset(-rounding) { offset(rounding) {
        children(0);
    }}}}
}

// plate with hole
linear_extrude(plateThickness) {
	difference() {
		hull() {
			translate([0,(plateLength-plateDiam)/2,0]) { circle(d=plateDiam); }
			translate([0,-(plateLength-plateDiam)/2,0]) { circle(d=plateDiam); }
		}
		translate([0,0,0]) { circle(d=passThrouhDiam); }
		hull() {
			translate([0,0,0]) { circle(d=rainureDiam); }
			translate([0,(plateLength-plateDiam)/2,0]) { circle(d=rainureDiam); }
			}
	}
}

// Blocker
linear_extrude(blockerHeight) {
	translate([0,(plateLength-plateDiam)/2,0]) { 
		difference() {
			circle(d=rainureDiam+plateThickness);
			circle(d=rainureDiam);
			translate([0,-rainureDiam/2-blockerOverlap,0]) { square([rainureDiam+plateThickness*2, rainureDiam], center = true); }
		}
	}
}	

if (withTowel) {
	translate([0,-52.5,0]) {
      import("thing-2984714.stl", convexity=6);
	}
} else {
	// holder
	translate([0,-plateLength*0.38,0]) {
		rotate([0,0,0]) {
			rotate_extrude(angle = 360, convexity = 6) {
				difference () {
					smooth(0.3) {
						polygon([[holderMinDiam/2,0], [holderMinDiam/2,holderHeight*0.5],[holderMaxDiam/2,holderHeight*0.8],[holderMaxDiam/2,holderHeight*1.0],
						[-holderMaxDiam/2,holderHeight*1.0],
						[-holderMaxDiam/2,holderHeight*0.8],
						[-holderMinDiam/2,holderHeight*0.5],
						[-holderMinDiam/2,0]]);
					}
					// Cutting half for rotate_extrude 
					square([holderMinDiam, holderHeight+1]);
				}
			}
		}
	}
}