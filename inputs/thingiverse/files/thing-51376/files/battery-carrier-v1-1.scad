use <write/Write.scad>

// AA-14.6mm, AAA-10.7mm, 123A-16.9mm, CR2-15.6mm
_1a_batteryDiameter = 14.6;

// height of the battery recess (height of top and bottom piece should be equal to or slightly larger than the battery height)
_1b_insideHeight = 12;

// number of batteries across
_2a_columns = 2; // [1:50]

// number of batteries deep
_2b_rows = 2; // [1:50]

// thickness of the sides
_3a_walls = 0.8;

// thickness of the bottom layer
_3b_base = 0.8;


// magnet cutouts only appear if there are at least 2 x 2 batteries
_4a_magnetType = "cylinder"; // [cylinder, cube]

_4b_magnetDiameter = 3.1;

_4c_magnetHeight = 3.1;

// rendered on top of the lid or on the bottom of the base (you'll need to rotate the tray to see the text)
_5a_labelText = "";

// font used to render the label
_5b_labelFont = "write/orbitron.dxf"; // ["write/orbitron.dxf":Orbitron, "write/letters.dxf":Basic, "write/knewave.dxf":KneWave, "write/BlackRose.dxf":BlackRose, "write/braille.dxf":Braille]

// depth of the label (negative values to emboss, positive values to extrude)
_5c_labelDepth = -0.3;

// height of the label in mm
_5d_labelHeight = 8;


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


module magnetCubeAt(xy, h, x, y, z) {
	translate([x,y,z]) {
		rotate([0,0,45]) {
			cube(size=[xy,xy,h], center=true);
		}
	}
}

module batteryGrid(diameter, height, rows, columns, mtype, mdiameter, mheight) {
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

		// magnets
		if (rows > 1 && columns > 1) {	
			for (x=[-xstart+r:diameter:xstart-r+eps])
			for (y=[-ystart+r:diameter:ystart-r+eps]) {
				if (mtype == "cylinder") {
					cylinderAt(mdiameter/2, mheight, x, y, height/2-mheight/2);
				} else if (mtype == "cube") {
					magnetCubeAt(mdiameter, mheight, x, y, height/2-mheight/2);
				}
			}
		}
	}
}


module makeTray(diameter, height, rows, columns, wall, base, mtype, mdiameter, mheight, label, lfont, ldepth, lheight) {
	eps = 0.1;
	rounding = diameter/2 + wall;
	width = diameter * columns + wall*2;
	depth = diameter * rows + wall*2;

	union() {
		difference() {
	
			hull()
			for (x=[-width/2 + rounding, width/2 - rounding])
			for (y=[-depth/2 + rounding, depth/2 - rounding]) {
				translate([x,y])
				cylinder(r=rounding, h=height+base);
			}	

			translate([0,0,height/2 + base]) {
				batteryGrid(diameter, height+eps, rows, columns, mtype, mdiameter, mheight+eps);
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

makeTray(_1a_batteryDiameter, _1b_insideHeight, 
			_2b_rows, _2a_columns, 
			_3a_walls, _3b_base, 
			_4a_magnetType, _4b_magnetDiameter, _4c_magnetHeight, 
			_5a_labelText, _5b_labelFont, _5c_labelDepth, _5d_labelHeight,
			$fn=90);
