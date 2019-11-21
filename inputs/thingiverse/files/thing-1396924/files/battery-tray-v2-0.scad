// extended version of the battery tray script that allows two groups of batteries - same or different size
// first group: enter values _diameter1, _columns1, _rows1
// second group: enter values _diameter2, _columns2, _rows2

// height of the tray
_height = 8; // [1:80]

// battery diameter (AA-14.5, AAA-10.6 123A-16.8 CR2-15.5)
_diameter1 = 14.5;
_diameter2 = 10.6;

// number of battery clusters across
_columns1 = 3; // [1:12]
_columns2 = 3; // [1:12]

// number of battery clusters deep
_rows1 = 2; // [1:12]
_rows2 = 2; // [1:12]

// padding between the clusters of batteries (also affects padding along the edges)
_spacing = 1.2;

// padding between the two group of batteries
_groupspacing = 5.0;

// alignment of battery groups (0 = centered, 1 = starting at edge)
_alignment = 1;

// thickness of the base under the batteries
_base = 0.5;

// radius of corner rounding
_cornerRounding = 4.0;


module batteryQuad(diameter) {
	angle = 35;
	r = diameter/2;
	cut = 2*r*sin(angle);
	tan = tan(angle);
	filletCenter = r - r * tan;
	filletCenter2 = r + r * tan;
	filletOffset = r * tan;
	filletRadius = r/cos(angle) - r;

	eps = 0.1;

	difference() {
		union() {
			for (x=[-r,r]) {
				for (y=[-r,r]) {
					translate([x,y,0]) {
						circle(r=r, center=true);
					}
				}
			}
			for (t=[ [ r, 0, 0],
					[-r, 0, 0],
					[ 0, r, 0],
					[ 0,-r, 0] ]) {
				translate(t) {
					square(size=[cut,cut], center=true);
				}
			}
		}
		// round
		for (z=[0:90:270]) {
			rotate([0,0,z]) {
				for(y=[filletOffset, -filletOffset]) {
					translate([0, r+y,0]) {
						circle(r=filletRadius, center=true, $fn=30);
					}
				}	
			}
		}
	}
}

module makeTray(height, diameter1, rows1, columns1, diameter2, rows2, columns2, spacing, groupspacing, alignment, base, rounding) {
	eps = 0.1;
	rounding = min(min(rounding, diameter1/2 + spacing*2), diameter2/2 + spacing*2);
    
	quadSize1 = 2 * diameter1;
	width1 = (quadSize1 + spacing) * columns1 + spacing*2;
	depth1 = (quadSize1 + spacing) * rows1 + spacing*2;
	
    quadSize2 = 2 * diameter2;
	width2 = (quadSize2 + spacing) * columns2 + spacing*2;
	depth2 = (quadSize2 + spacing) * rows2 + spacing*2;
    
    width = max(width1, width2);
    depth = depth1 + depth2 - spacing + groupspacing;
    xstart1 = -max(alignment*width, width1)/2 + spacing*1.5 + quadSize1/2;
    xstart2 = -max(alignment*width, width2)/2 + spacing*1.5 + quadSize2/2;
    ystart1 = -depth/2 + spacing*1.5 + quadSize1/2;
    ystart2 = -depth/2 + depth1 + quadSize2/2 + groupspacing;

	difference() {
		hull()
		for (x=[-width/2 + rounding, width/2 - rounding])
		for (y=[-depth/2 + rounding, depth/2 - rounding]) {
			translate([x,y])
			cylinder(r=rounding, h=height);
		}
		translate([0,0,base]) linear_extrude(height) {
			for (x=[0:1:columns1-1])
			for (y=[0:1:rows1-1]) {
				translate([xstart1 + (quadSize1 + spacing)*x, ystart1 + (quadSize1 + spacing)*y, 0]) {
					batteryQuad(diameter1);
				}
			}
   			for (x=[0:1:columns2-1])
			for (y=[0:1:rows2-1]) {
				translate([xstart2 + (quadSize2 + spacing)*x, ystart2 + (quadSize2 + spacing)*y, 0]) {
					batteryQuad(diameter2);
				}
			}
		}
	}
}

makeTray(_height, _diameter1, _rows1, _columns1, _diameter2, _rows2, _columns2, _spacing, _groupspacing, _alignment, _base, _cornerRounding, $fn=90);
