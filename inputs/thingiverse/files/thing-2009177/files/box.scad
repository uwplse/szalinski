// ### CONFIGURATION ###

// For each line the box should get, add an entry
// Each entry has as many entries as there should
// be shelves. For each shelf, write the number of
// shelf elements in width. If you enter a 0, there
// will be no wall above, so you can extend the 
// one above.
config = [
	[ 2, 1 ],
	[ 0, 1, 1 ]
];

// the default size of a box
boxsize = 35;
// the height of the boxes
boxheight = 20;

// the text to appear on top of the lid
txt = ["3D-Printed Box", "Design by msrd0"];

// the thickness of the walls (outer walls will
// be twice of the thickness)
// I'd set this to twice the nozzle size
thn = 0.8;

// the part to be printed - zero to see all parts assembled
part = 0;
//part = 1;
//part = 2;

// ### END CONFIGURATION ###

// all credits for this method go to http://www.thingiverse.com/thing:59817
module drawtext(text) {
	//Characters
	chars = " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}";

	//Chracter table defining 5x7 characters
	//Adapted from: http://www.geocities.com/dinceraydin/djlcdsim/chartable.js
	char_table = [ [ 0, 0, 0, 0, 0, 0, 0],
                  [ 4, 0, 4, 4, 4, 4, 4],
                  [ 0, 0, 0, 0,10,10,10],
                  [10,10,31,10,31,10,10],
                  [ 4,30, 5,14,20,15, 4],
                  [ 3,19, 8, 4, 2,25,24],
                  [13,18,21, 8,20,18,12],
                  [ 0, 0, 0, 0, 8, 4,12],
                  [ 2, 4, 8, 8, 8, 4, 2],
                  [ 8, 4, 2, 2, 2, 4, 8],
                  [ 0, 4,21,14,21, 4, 0],
                  [ 0, 4, 4,31, 4, 4, 0],
                  [ 8, 4,12, 0, 0, 0, 0],
                  [ 0, 0, 0,31, 0, 0, 0],
                  [12,12, 0, 0, 0, 0, 0],
                  [ 0,16, 8, 4, 2, 1, 0],
                  [14,17,25,21,19,17,14],
                  [14, 4, 4, 4, 4,12, 4],
                  [31, 8, 4, 2, 1,17,14],
                  [14,17, 1, 2, 4, 2,31],
                  [ 2, 2,31,18,10, 6, 2],
                  [14,17, 1, 1,30,16,31],
                  [14,17,17,30,16, 8, 6],
                  [ 8, 8, 8, 4, 2, 1,31],
                  [14,17,17,14,17,17,14],
                  [12, 2, 1,15,17,17,14],
                  [ 0,12,12, 0,12,12, 0],
                  [ 8, 4,12, 0,12,12, 0],
                  [ 2, 4, 8,16, 8, 4, 2],
                  [ 0, 0,31, 0,31, 0, 0],
                  [16, 8, 4, 2, 4, 8,16],
                  [ 4, 0, 4, 2, 1,17,14],
                  [14,21,21,13, 1,17,14],
                  [17,17,31,17,17,17,14],
                  [30,17,17,30,17,17,30],
                  [14,17,16,16,16,17,14],
                  [30,17,17,17,17,17,30],
                  [31,16,16,30,16,16,31],
                  [16,16,16,30,16,16,31],
                  [15,17,17,23,16,17,14],
                  [17,17,17,31,17,17,17],
                  [14, 4, 4, 4, 4, 4,14],
                  [12,18, 2, 2, 2, 2, 7],
                  [17,18,20,24,20,18,17],
                  [31,16,16,16,16,16,16],
                  [17,17,17,21,21,27,17],
                  [17,17,19,21,25,17,17],
                  [14,17,17,17,17,17,14],
                  [16,16,16,30,17,17,30],
                  [13,18,21,17,17,17,14],
                  [17,18,20,30,17,17,30],
                  [30, 1, 1,14,16,16,15],
                  [ 4, 4, 4, 4, 4, 4,31],
                  [14,17,17,17,17,17,17],
                  [ 4,10,17,17,17,17,17],
                  [10,21,21,21,17,17,17],
                  [17,17,10, 4,10,17,17],
                  [ 4, 4, 4,10,17,17,17],
                  [31,16, 8, 4, 2, 1,31],
                  [14, 8, 8, 8, 8, 8,14],
                  [ 0, 1, 2, 4, 8,16, 0],
                  [14, 2, 2, 2, 2, 2,14],
                  [ 0, 0, 0, 0,17,10, 4],
                  [31, 0, 0, 0, 0, 0, 0],
                  [ 0, 0, 0, 0, 2, 4, 8],
                  [15,17,15, 1,14, 0, 0],
                  [30,17,17,25,22,16,16],
                  [14,17,16,16,14, 0, 0],
                  [15,17,17,19,13, 1, 1],
                  [14,16,31,17,14, 0, 0],
                  [ 8, 8, 8,28, 8, 9, 6],
                  [14, 1,15,17,15, 0, 0],
                  [17,17,17,25,22,16,16],
                  [14, 4, 4, 4,12, 0, 4],
                  [12,18, 2, 2, 2, 6, 2],
                  [18,20,24,20,18,16,16],
                  [14, 4, 4, 4, 4, 4,12],
                  [17,17,21,21,26, 0, 0],
                  [17,17,17,25,22, 0, 0],
                  [14,17,17,17,14, 0, 0],
                  [16,16,30,17,30, 0, 0],
                  [ 1, 1,15,19,13, 0, 0],
                  [16,16,16,25,22, 0, 0],
                  [30, 1,14,16,15, 0, 0],
                  [ 6, 9, 8, 8,28, 8, 8],
                  [13,19,17,17,17, 0, 0],
                  [ 4,10,17,17,17, 0, 0],
                  [10,21,21,17,17, 0, 0],
                  [17,10, 4,10,17, 0, 0],
                  [14, 1,15,17,17, 0, 0],
                  [31, 8, 4, 2,31, 0, 0],
                  [ 2, 4, 4, 8, 4, 4, 2],
                  [ 4, 4, 4, 4, 4, 4, 4],
                  [ 8, 4, 4, 2, 4, 4, 8] ];

	//Binary decode table
	dec_table = [ "00000", "00001", "00010", "00011", "00100", "00101",
  	            "00110", "00111", "01000", "01001", "01010", "01011",
  	            "01100", "01101", "01110", "01111", "10000", "10001",
  	            "10010", "10011", "10100", "10101", "10110", "10111",
	            "11000", "11001", "11010", "11011", "11100", "11101",
	            "11110", "11111" ];

	//Process string one character at a time
	for(itext = [0:len(text)-1]) {
		//Convert character to index
		ichar = search(text[itext],chars,1)[0];

        //Decode character - rows
        for(irow = [0:6]) {
            //Select value to draw from table
            val = dec_table[char_table[ichar][irow]];

            //Decode character - cols
            for(icol = [0:4]) {
                // Retrieve bit to draw
                bit = search(val[icol],"01",1)[0];

                if(bit) {
                    //Output cube
                    translate([icol + (6*itext), irow, 0])
                        cube([1.0001,1.0001,1]);
                }
            }
        }
	}
}


function sum(list, maxi=-1, idx=0, result=0) = idx>=(maxi==-1 ? len(list) : maxi) ? result : sum(list, maxi, idx+1, result+list[idx]);

// count the number of shelves
nx = sum(config[0]);
ny = len(config);

// calc width, depth and height
w0 = nx*boxsize + (nx+3)*thn;
d0 = ny*boxsize + (ny+3)*thn;
h0 = boxheight + 8*thn;

module prismy(c, dir=1) {
	polyhedron(
		points = [[0,0,0], [c[0],0,0], [c[0],c[1],0], [0,c[1],0], [0,dir*c[1],c[2]], [c[0],dir*c[1],c[2]]],
		faces = [[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
	);
}
module prismx(c, dir=1) {
	translate([0, c[1], 0])
	rotate([0,0,-90])
	prismy([c[1], c[0], c[2]], dir);
}
module prismzy(c, dir=1) {
	polyhedron(
		points = [[0,0,c[2]], [c[0],0,c[2]], [c[0],dir*c[1],0], [0,dir*c[1],0], [0,c[1],c[2]], [c[0],c[1],c[2]]],
		faces = [[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
	);
}
module prismzx(c, dir=1) {
	translate([0, c[1], 0])
	rotate([0,0,-90])
	prismzy([c[1], c[0], c[2]], dir);
}

module box() {
	// very bottom
	translate([0, 0, -3*thn]) {
		translate([2*thn, 2*thn, 0])
			cube([w0-4*thn, d0-4*thn, 2*thn]);
		union() {
			// left
			translate([0, 2*thn, 0])
				prismzx([2*thn, d0-4*thn, 2*thn]);
			// front
			translate([2*thn, 0, 0])
				prismzy([w0-4*thn, 2*thn, 2*thn]);
			// right
			translate([w0-2*thn, 2*thn, 0])
				prismzx([2*thn, d0-4*thn, 2*thn], 0);
			// back
			translate([2*thn, d0-2*thn, 0])
				prismzy([w0-4*thn, 2*thn, 2*thn], 0);
		}
		// left front
		intersection() {
			prismzx([2*thn, 2*thn, 2*thn]);
			prismzy([2*thn, 2*thn, 2*thn]);
		}
		// right front
		translate([w0-2*thn, 0, 0])
		intersection() {
			prismzx([2*thn, 2*thn, 2*thn], 0);
			prismzy([2*thn, 2*thn, 2*thn]);
		}
		// right back
		translate([w0-2*thn, d0-2*thn, 0])
		intersection() {
			prismzx([2*thn, 2*thn, 2*thn], 0);
			prismzy([2*thn, 2*thn, 2*thn], 0);
		}
		// left back
		translate([0, d0-2*thn, 0])
		intersection() {
			prismzx([2*thn, 2*thn, 2*thn]);
			prismzy([2*thn, 2*thn, 2*thn], 0);
		}
	}
	// bottom
	translate([0, 0, -thn])
		cube([w0, d0, thn]);
	
	// left
	difference() {
		cube([2*thn, d0, boxheight+4*thn]);
		translate([thn, -1, boxheight+thn])
			cube([thn+1, d0+2, 3*thn]);
	}
	translate([thn, 0, boxheight+2*thn+thn/2])
		prismzx([thn, d0, thn+thn/2], 0);
	translate([0, 0, boxheight+4*thn])
		prismx([2*thn, d0, 2*thn], 0);
	// right
	translate([w0-2*thn, 0, 0])
	difference() {
		cube([2*thn, d0, boxheight+4*thn]);
		translate([-1, -1, boxheight+thn])
			cube([thn+1, d0+2, 3*thn]);
	}
	translate([w0-2*thn, 0, boxheight+2*thn+thn/2])
		prismzx([thn, d0, thn+thn/2]);
	translate([w0-2*thn, 0, boxheight+4*thn])
		prismx([2*thn, d0, 2*thn]);
	// back
	translate([0, d0-2*thn, 0])
	difference() {
		cube([w0, 2*thn, boxheight+4*thn]);
		translate([thn, -1, boxheight+thn])
			cube([w0+2, thn+1, 3*thn]);
	}
	translate([0, d0-2*thn, boxheight+2*thn+thn/2])
		prismzy([w0, thn, thn+thn/2]);
	translate([0, d0-2*thn, boxheight+4*thn])
		prismy([w0, 2*thn, 2*thn]);
	// front
	cube([w0, 2*thn, boxheight]);
	
	// and now - the parts in the middle
	for (iline = [0 : len(config)-1]) {
		line = config[iline];
		newline = [for (shelf = line) shelf==0 ? 1 : shelf];
		y = d0 - 2*thn - iline*boxsize - iline*thn;
		for (ishelf = [0 : len(line)-1]) {
			shelf = line[ishelf];
			ct = ishelf==0 ? 0 : sum(newline, ishelf);
			x = 2*thn + ct*(boxsize+thn);
			translate([x-thn, y-boxsize-thn, 0])
				cube([thn, boxsize+2*thn, boxheight]);
			if (shelf != 0) {
				translate([x, y, 0])
					cube([shelf*(boxsize+thn), thn, boxheight]);
			}
		}
	}
}

module lid() {
	cube([w0-3*thn, d0-thn, thn]);
	translate([thn, 0, thn])
		cube([w0-5*thn, 2*thn, thn/2]);
	y0 = (d0-thn - len(txt)*7) / 2;
	for (iline = [0, len(txt)-1]) {
		line = txt[iline];
		x0 = (w0-2*thn - len(line)*5) / 2;
		translate([x0, y0 + (len(txt)-iline-1)*7, thn])
			scale([thn, thn, thn/2])
				drawtext(line);
	}
}

// Assemble everyting together

if (part==0 || part==1) {
	color([0.1, 0.6, 1])
		box();
}
if (part==0 || part==2) {
	color([0, 0.65, 0.3])
		translate([part==0?thn+thn/2:0, part==0?-3/4*d0:0, part==0?boxheight+thn:0])
			lid();
}
