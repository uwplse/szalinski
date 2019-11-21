
// part type, you will need a top and bottom piece
_part = "bottom"; //[top, bottom]

// 6(L)R61	PP3	RC22	47,5 mm × 25,5 mm × 16,5 mm
// Length 26 : battery fit too tight
// Width 17 : battery fit too tight
_batteryLength = 27;
_batteryWidth = 18;

// height of the battery recess (height of top and bottom piece should be equal to or slightly larger than the battery height)
// used 35 for bottom
// and 13 for top : OK
_insideHeight = 35;

// number of batteries across
_columns = 4; // [1:50]

// number of batteries deep
_rows = 1; // [1:50]

// thickness of the inside walls
_walls = 1;

// thickness of the bottom layer
_base = 1.5;

// height of the lip where the parts overlap, increase the value for a more secure fit
_lipHeight = 2.5;

// gap between the top and bottom pieces, decrease the value for a tighter fit.
_fitGap = 0.1;



// depth of the label (negative values to emboss, positive values to extrude)
_labelDepth = -0.8;


///////////////////////////////////////////////////////////////////////////

/*Text Varibles*/
font = "Impact";
letter_size = 15;
letter_height = 2.5;
letter_line_space = 5;
letter_text_line1 = "4x";
letter_text_line2 = "9V";

y=-10;
x=0;





module multiLine(letter_size, letter_line_space){
  union(){
    for (i = [0 : $children-1])
      translate([0 , -i * (letter_size+letter_line_space), 0 ]) children(i);
  }
}

module drawtext(letter_text_line1, letter_text_line2,x,y,_labelDepth, letter_height, font, letter_size, letter_line_space) { 
    rotate(a=180, v=[0,1,0])
      translate([y,x,_labelDepth])
        linear_extrude(height = 3){
            rotate([0,0,90]) translate([0,0,5]) 
            
            multiLine(letter_size, letter_line_space) {
                text(letter_text_line1, font=font, valign="center", halign="center", size=letter_size);
                text(letter_text_line2, font=font, valign="center", halign="center", size=letter_size);
            }
        }
}

module cylinderAt(r, h, x, y, z) {
	translate([x,y,z]) {
		cylinder(r=r, h=h, center=true);
	}
}

module cubeAt(xyh, x, y) {
	translate([x,y,0]) {
		cube(xyh);
	}
}

module roundRectAt(width, depth, height, rounding, x, y) {
    translate([x,y,0]) {
        roundRect(width, depth, height, rounding);
    }
}
module roundRect(width, depth, height, rounding) {
    translate([rounding,rounding,0])
	minkowski()
	{
        cube([width-rounding, depth-rounding, height-1]);
		cylinder(r=rounding, h=1);
	}
}

module batteryGrid(width, length, height, wall, rows, columns) {

	eps = 0.01;
    wallmultip = 3;

	union() {
        // cylinder
        for (x=[0:1:columns-1]) {
            for (y=[0:1:rows-1]) {
                cubeAt([width, length, height], (x*(width+wall)), (y*(length+wall)));
            }
        }
        for (x=[0:1:columns-1]) {
            for (y=[0:1:rows]) {
                cubeAt([width-(2*wallmultip*wall), wall+2*eps, height], (x*(width+wall))+(wallmultip*wall), (y*(length+wall))-wall-eps);
            }
        }
        for (x=[0:1:columns]) {
            for (y=[0:1:rows-1]) {
                cubeAt([wall+2*eps, length-(2*wallmultip*wall), height], (x*(width+wall))-wall-eps, (y*(length+wall))+(wallmultip*wall));
            }
        }


	}
}

module makeTray(bwidth, blength, height, rows, columns, wall, base, lipHeight, fitGap, label, lfont, ldepth, lheight, letter_height, x, y, letter_line_space) {
    eps = 0.01;
    gridHeight = (lipHeight > 0) ? height + lipHeight - fitGap : height;
    rounding = 1;
    width = (bwidth+wall) * columns + wall;
    depth = (blength+wall) * rows + wall;
    widthwall = width + wall;
    depthwall = depth + wall;
    difference() {
        union() {
            difference() {
                roundRect(widthwall, depthwall, height+base, rounding);
				if (lipHeight < 0) {
                    echo (lipHeight);
                    translate([rounding/2+wall/2-fitGap/2, rounding/2+wall/2-fitGap/2,height+base+lipHeight])
					cube([width+fitGap,depth+fitGap,-lipHeight+eps]);
				}
            }
            cubeAt([width-eps,depth-eps,height+base+lipHeight-fitGap], rounding/2+wall/2, rounding/2+wall/2);
        }
        translate([wall+rounding/2+wall/2,wall+rounding/2+wall/2,base]) batteryGrid(bwidth, blength, gridHeight+eps, wall, rows, columns);

    
        if (ldepth < 0) {
            translate([widthwall/2,depthwall/2,0]) addLabel(label, (-ldepth+eps)/2 - eps, ldepth, lheight, lfont, letter_height, x, y, letter_line_space);
        }
		
		if (ldepth > 0) {
			translate([widthwall/2,depthwall/2,0]) addLabel(label, -(ldepth+eps)/2 + eps, ldepth, lheight, lfont, letter_height, x, y, letter_line_space);
        }
    }
}

module addLabel(label, zoffset, depth, height, font, letter_height, x, y, letter_line_space) {
    if (len(label)>0) {
		if (label[0] != "") {
			drawtext(label[0], label[1], x, y, depth, zoffset, font, height, letter_line_space);
		}
	}
}


module make($fn=90) {

	if (_part == "top") {
		makeTray(_batteryWidth, _batteryLength, _insideHeight, _rows, _columns, _walls, _base, -_lipHeight, _fitGap,
					[letter_text_line1, letter_text_line2], font, _labelDepth, letter_size, letter_height, x, y, letter_line_space);
	} else {
		makeTray(_batteryWidth, _batteryLength, _insideHeight, _rows, _columns, _walls, _base, _lipHeight, _fitGap,
					[letter_text_line1, letter_text_line2], font, _labelDepth, letter_size, letter_height, x, y, letter_line_space);
	}
}


make();