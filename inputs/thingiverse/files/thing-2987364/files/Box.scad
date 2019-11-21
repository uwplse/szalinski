$fn = 100;
/* Examine carefully the layers before printing
 for the case some part is missing if measures 
 doesn't match. */

/* Basic parameters */
width = 20;
depth = 20;
topHeight = 6;
bottomHeight = 15-topHeight;
wallThickness = 2;

/* Fine parameters */
fingerSize = 4.5;

/* Finest parameters */
hingeOuter = 5; // Less than topHeight
hingeInner = 2; // Less or same as (hingeOuter - 3)
fingerLength = hingeOuter/1.65;
topFingerSize = fingerSize;

// Adjust for good printing. Pieces should be very close but not fused together.
hingeInnerSlop = .1;
hingeFingerSlop = .2;

latchWidth = 10;
latchThinkness = wallThickness;

innerBorderHeight=1;
innerBorderWitdh=wallThickness/2;

debugClosed=false;

if (debugClosed) {
   translate([0, 0, + (topHeight + bottomHeight)]) rotate([0,-180,0]) top();
} else {
   translate([0, 0, bottomHeight - topHeight]) top();
}
bottom();

module bottom() {
	union() {
		// main box and cutout
		difference() {
            union() {
                // Body
                translate([-width - fingerLength, -depth/2, 0]) {
                    cube([width,depth,bottomHeight]);
                }
                // Inner border
                translate([-width+innerBorderWitdh - fingerLength, -depth/2+innerBorderWitdh, bottomHeight]) {
                    cube([width-innerBorderWitdh*2,depth-innerBorderWitdh*2,innerBorderHeight]);
                }
            }
    
			translate([(-width - fingerLength) + wallThickness, -depth/2 + wallThickness, wallThickness]) {
				cube([width - (wallThickness * 2), depth - (wallThickness * 2), bottomHeight]);
			}

			// latch cutout
			translate([-width - fingerLength + (wallThickness*2/3), (-latchWidth/2) - (hingeFingerSlop/2) - .25, bottomHeight-4.5]) {
				cube([wallThickness/2 + .1, latchWidth + hingeFingerSlop + .5, bottomHeight]);
			}

						
		}

		//latch cylinder
		difference() {
			translate([-width - fingerLength + (wallThickness/2) - 0.1, -latchWidth/2 - .25, bottomHeight - 1 - 0.2]) {
				rotate([-90,0,0]) {
					cylinder(r = 1, h = latchWidth + .5);
				}
			}
			// front wall wipe
			translate([-width - fingerLength - 5, -depth/2,0]) {
				cube([5,depth,bottomHeight]);
			}
		}

		difference() {
			hull() {
				translate([0,-depth/2,bottomHeight]) {
					rotate([-90,0,0]) {
						cylinder(r = hingeOuter/2, h = depth);
					}
				}
				translate([-fingerLength - .1, -depth/2,bottomHeight - hingeOuter]){
					cube([.1,depth,hingeOuter]);
				}
				translate([-fingerLength, -depth/2,bottomHeight-.1]){
					cube([fingerLength,depth,.1]);
				}
				translate([0, -depth/2,bottomHeight]){
					rotate([0,45,0]) {
						cube([hingeOuter/2,depth,.01]);
					}
				}
			}
			// finger cutouts

			for  (i = [-depth/2 + fingerSize:fingerSize*2:depth/2]) {
				translate([-fingerLength,i - (fingerSize/2) - (hingeFingerSlop/2),0]) {
					cube([fingerLength*2,fingerSize + hingeFingerSlop,bottomHeight*2]);
				}
			}
		}

		// center rod
		translate([0, -depth/2, bottomHeight]) {
			rotate([-90,0,0]) {
				cylinder(r = hingeInner /2, h = depth);
			}
		}
	}
}

module top() {
    union() {
		difference() {
			// Body
            translate([fingerLength, -depth/2, 0]) {
				cube([width,depth,topHeight - .1]);
			}
            // Inner border
            translate([fingerLength+innerBorderWitdh, -depth/2+innerBorderWitdh, topHeight - innerBorderHeight - 0.6]) {
                cube([width-innerBorderWitdh*2,depth-innerBorderWitdh*2,innerBorderHeight + 1]);
            }
			translate([fingerLength + wallThickness, -depth/2 + wallThickness, wallThickness]) {
				cube([width - (wallThickness * 2), depth - (wallThickness * 2), topHeight]);
			}

			
		}

		//latch
		translate([width + fingerLength - wallThickness - latchThinkness, (-latchWidth/2), 0]) {
			cube([latchThinkness, latchWidth, topHeight - .5 + 4]);
		}
		translate([width + fingerLength - wallThickness, -latchWidth/2, topHeight - .5 + 3 + 0.1]) {
            intersection() {
                rotate([-90,0,0]) {
                    cylinder(r = 1 - 0.1, h = latchWidth);
                }
                rotate([0, -15, 0]) translate ([-1.3, 0, -1]) cube([2,latchWidth,2]);
            }
		}

		difference() {
			hull() {
				translate([0,-depth/2,topHeight]) {
                    rotate([-90,0,0]) {
                        cylinder(r = hingeOuter/2, h = depth);
                    }
				}
				translate([fingerLength, -depth/2,topHeight - hingeOuter - .5]){
					cube([.1,depth,hingeOuter - .5]);
				}
				translate([-fingerLength/2, -depth/2,topHeight-.1]){
					cube([fingerLength,depth,.1]);
				}
				translate([0, -depth/2,topHeight]){
					rotate([0,45,0]) {
						cube([hingeOuter/2,depth,.01]);
					}
				}
			}
			// finger cutouts
			for  (i = [-depth/2:fingerSize*2:depth/2 + fingerSize]) {
				translate([-fingerLength,i - (fingerSize/2) - (hingeFingerSlop/2),0]) {
					cube([fingerLength*2,fingerSize + hingeFingerSlop,topHeight*2]);
				}
				if (depth/2 - i < (fingerSize * 1.5)) {
					translate([-fingerLength,i - (fingerSize/2) - (hingeFingerSlop/2),0]) {
						cube([fingerLength*2,depth,topHeight*2]);
					}
				}
			}

			// center cutout
			translate([0, -depth/2, topHeight]) {
				rotate([-90,0,0]) {
					cylinder(r = hingeInner /2 + hingeInnerSlop, h = depth);
				}
			}
		}
	}
}
