use <write/Write.scad>

// part type, you will need a top and bottom piece
_part = "bottom"; //[top, bottom]

// AA-14.6mm, AAA-10.7mm, 123A-16.9mm, CR2-15.6mm
_batteryDiameter = 10.7;

// height of the battery recess (height of top and bottom piece should be equal to or slightly larger than the battery height)
_insideHeight = 30;

// number of batteries across
_columns = 3; // [1:50]

// number of batteries deep
_rows = 2; // [1:50]

// thickness of the side walls
_walls = 0.8;

// thickness of the bottom layer
_base = 0.8;

// height of the lip where the parts overlap, increase the value for a more secure fit
_lipHeight = 2;

// gap between the top and bottom pieces, decrease the value for a tighter fit.
_fitGap = 0.1;


// rendered on top of the lid or on the bottom of the base (you'll need to rotate the tray to see the text underneath)
_labelText = "";

// font used to render the label
_labelFont = "write/orbitron.dxf"; // ["write/orbitron.dxf":Orbitron, "write/letters.dxf":Basic, "write/knewave.dxf":KneWave, "write/BlackRose.dxf":BlackRose, "write/braille.dxf":Braille]

// depth of the label (negative values to emboss, positive values to extrude)
_labelDepth = -0.3;

// height of the label in mm
_labelHeight = 8;

///////////////////////////////////////////////////////////////////////////


module cylinderAt(r, h, x, y, z) {
	translate([x,y,z]) {
		cylinder(r=r, h=h, center=true);
	}
}

module cubeAt(xy, h, x, y) {
	translate([x,y,0]) {
		cube(size=[xy,xy,h], center=true);
	}
}

module roundRect(width, depth, height, rounding) {
	hull()
	for (x=[-width/2 + rounding, width/2 - rounding])
	for (y=[-depth/2 + rounding, depth/2 - rounding]) {
		translate([x,y])
		cylinder(r=rounding, h=height);
	}
}

module batteryGrid(diameter, height, rows, columns) {
	angle = 35;
	r = diameter/2;
	cut = 2*r*sin(angle);
	tan = tan(angle);
	filletCenter = r - r * tan;
	filletCenter2 = r + r * tan;
	filletOffset = r * tan;
	filletRadius = r/cos(angle) - r;
	xstart = ((columns-1) * diameter)/2;
	ystart = ((rows-1) * diameter)/2;
	eps = 0.1;

	union() {
		difference() {
			union() {
				// cylinder
				for (x=[-xstart:diameter:xstart+eps]) {
					for (y=[-ystart:diameter:ystart+eps]) {
						cylinderAt(r,height,x,y,0);
					}
				}
	
				if (rows > 1) {	
					for (x=[-xstart:diameter:xstart+eps])
					for (y=[-ystart+r:diameter:ystart-r+eps]) {
						cubeAt(cut, height, x, y);
					}
				}
	
				if (columns > 1) {	
					for (x=[-xstart+r:diameter:xstart-r+eps])
					for (y=[-ystart:diameter:ystart+eps]) {
						cubeAt(cut, height, x, y);
					}
				
				}
			}

			if (columns > 1) {	
				for (x=[-xstart+r:diameter:xstart-r+eps])
				for (y=[-ystart-r:diameter:ystart+r+eps])
				for(y2=[filletOffset, -filletOffset]) {
					cylinderAt(filletRadius,height+eps,x,r+y+y2,0);
				}
			}
	
			if (rows > 1) {	
				for (x=[-xstart:diameter:xstart+eps])
				for (y=[-ystart:diameter:ystart+eps])
				for(x2=[filletOffset, -filletOffset]) {
					cylinderAt(filletRadius, height+eps,x + x2, r+y, 0);
				}
			}
		}
	}
}


module makeTray(diameter, height, rows, columns, wall, base, lipHeight, fitGap, label, lfont, ldepth, lheight) {
	eps = 0.1;
	wall2 = wall * 2;
	rounding = diameter/2 + wall;
	width = diameter * columns + wall*2;
	depth = diameter * rows + wall*2;
	gridHeight = (lipHeight > 0) ? height + lipHeight - fitGap : height;

	union() {
		difference() {
			roundRect(width, depth, gridHeight+base, rounding);

			translate([0,0,gridHeight/2 + base + eps/2]) {
				batteryGrid(diameter, gridHeight+eps, rows, columns);
			}

			if (lipHeight < 0) { // lid
				assign(gap = min(fitGap, -0.01)) {
					translate([0,0,base+height+lipHeight]) {
						roundRect(width - 2*wall+gap, depth - 2*wall+gap, -lipHeight+eps, rounding - wall);
					}
				}
			} else if (lipHeight > 0) {
				assign(gap = max(fitGap, 0.01)) {
					translate([0,0,base+height])
					difference() {
						translate([0,0,(lipHeight+eps)/2]) {
							cube(size=[width+eps, depth+eps, lipHeight+eps], center=true);
						}

						translate([0,0,-eps]) {
							roundRect(width - 2*(wall+gap), depth - 2*(wall+gap), lipHeight + 2*eps, rounding - wall - gap);
						}
					}
			
				//	bevel
				if (lipHeight > wall) {
					for (m = [-1,1]) {
						hull()
						for (o = [0,1]) {
							translate([0,m*(depth/2 + lipHeight/2 - wall*2 + o*wall - gap), base + height + 1.5*lipHeight - o*wall - gap]) {
								cube(size=[width, lipHeight, lipHeight], center=true);
							}	
						}
						
						hull()
						for (o = [0,1]) {
							translate([m*(width/2 + lipHeight/2 - wall*2 + o*wall - gap),0, base + height + 1.5*lipHeight - o * wall - gap ]) {
								cube(size=[lipHeight, depth, lipHeight], center=true);
							}	
						}	
					}
					}
				}
			}
	
			if (ldepth < 0) {
				addLabel(label, (-ldepth+eps)/2 - eps, -ldepth+eps, lheight, lfont);
			}
		}
		if (ldepth > 0) {
			addLabel(label, -(ldepth+eps)/2 + eps, ldepth+eps, lheight, lfont);
		}
	}			
}


module addLabel(label, zoffset, depth, height, font) {
	if (label != "") {
		translate([0,0,zoffset])
		mirror([0,1,0])
		write(label, t=depth, h=height, font=font, space=1.2, center=true);
	}
}

module make($fn=90) {

	if (_part == "top") {
		makeTray(_batteryDiameter, _insideHeight, _rows, _columns, _walls, _base, -_lipHeight, _fitGap,
					_labelText, _labelFont, _labelDepth, _labelHeight);
	} else {
		makeTray(_batteryDiameter, _insideHeight, _rows, _columns, _walls, _base, _lipHeight, _fitGap,
					_labelText, _labelFont, _labelDepth, _labelHeight);
	}
}

make();