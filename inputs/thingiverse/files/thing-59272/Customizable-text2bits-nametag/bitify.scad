//Characters to convert to bits
text = "JS";		

bit_style = "bevel"; //[bevel,flat,circle,hexagon,round]

base_style = "bevel"; //[bevel,flat]

//%
bit_size = 100; // [50:150]

//(in mm)
base_length = 70; //	[40:150]

bail = "side";	//[side,top,none]

//%
bail_size = 100; //[50:150]

//If yes, bits will be written from right to left
reverse_bit_direction = "no"; //[no,yes]

//Add an extra zero to make a whole byte, you know, as God intended.
extra_bit = "no"; //[no,yes]

// preview[view:south, tilt:top]

//----------------------------------------------------

TXT= text;

HEIGHT=.5*1;
BITMODE = bit_style;
BASEMODE = base_style;
BITSCALE = 1.4*bit_size/100;
NBITS=	extra_bit == "yes" ? 8 : 7;
NCHARS=len(TXT);
REVERSEBITS = reverse_bit_direction == "yes";
PENDENT=bail;
PENDENTSCALE = 1.5*bail_size/100;
SIZEMMS = base_length;

module simple_innie_outie() {
	union() {
		difference() {
			basis();
			allzeros();
		}
		allones();
	}
}

module allones() {
	for (i=[0:NCHARS-1]) {
		translate([0,line_position_y(i)]) ones(char2bits(TXT[i]));
	}
}

module allzeros() {
	for (i=[0:NCHARS-1]) {
		translate([0,line_position_y(i)]) zeros(char2bits(TXT[i]));
	}
}

module zeros(bits) {
	for (i=[0:NBITS-1]) {
		if (bits[i]=="0") {
			translate([bit_position_x(i),0,HEIGHT-0.01]) scale([BITSCALE,BITSCALE,HEIGHT]) bit();
		} 
	}
}

module ones(bits) {
	for (i=[0:NBITS-1]) {
		if (bits[i]=="1") {
			translate([bit_position_x(i),0,HEIGHT-0.01]) scale([BITSCALE,BITSCALE,HEIGHT]) bit();
		} 
	}
}

module bit() {
	if (BITMODE=="flat") {
		cube([1,1,1],center=true);

	} else if (BITMODE=="circle") {
		hull() {
		cylinder(r1=.5,r2=.4,h=0.5,center=false,$fn=30);
		translate([0,0,-.5]) cylinder(r1=.4,r2=.5,h=0.5,center=false,$fn=30);
		}

	} else if (BITMODE=="round") {
		translate([-0.2,-0.2,-0.5])
		minkowski() {
			cube([0.4,0.4,.5]);
			cylinder(r=0.3,h=.5,$fn=20);
		}
	} else if (BITMODE=="bevel") {
		translate([-0.5,-0.5,-0.5]) makebevel(1,1,1,.4);

	} else if (BITMODE=="hexagon") {
		hull() {
		cylinder(r1=.5,r2=.4,h=0.5,center=false,$fn=6);
		translate([0,0,-.5]) cylinder(r1=.4,r2=.5,h=0.5,center=false,$fn=6);
		}
	}
}

module makebevel(sx,sy,sz,r) {
	hull() {
		translate([r, 		r, 		r 	]) sphere(r=r,$fn=20);
		translate([sx-r,	r, 		r 	]) sphere(r=r,$fn=20);
		translate([r, 		sy-r,	r 	]) sphere(r=r,$fn=20);	
		translate([sx-r,	sy-r,	r 	]) sphere(r=r,$fn=20);
		translate([r, 		r, 		sz-r]) sphere(r=r,$fn=20);
		translate([sx-r,	r, 		sz-r]) sphere(r=r,$fn=20);
		translate([r, 		sy-r,	sz-r]) sphere(r=r,$fn=20);
		translate([sx-r,	sy-r,	sz-r]) sphere(r=r,$fn=20);
	}
}

module basis() {
	union() {
		if (BASEMODE == "flat") {
			cube([NBITS*2+1,NCHARS*2+1,HEIGHT]);
		} else if (BASEMODE == "bevel") {
			makebevel(NBITS*2+1,NCHARS*2+1,HEIGHT,.25);
		}
		if (PENDENT == "side") {
			translate([NBITS*2+1,(NCHARS*2+1)/2,0.01]) pendent();
		} else if (PENDENT == "top") {
			translate([(NBITS*2+1)/2,(NCHARS*2+1)-.3*PENDENTSCALE,0.01]) rotate(90) pendent();
		}

	}
}

module pendent() {
	scale([PENDENTSCALE,PENDENTSCALE,.3])
	translate([0,0,HEIGHT/2])
	difference() {
		cube([2,1,HEIGHT],center=true);
		cube([1.6,.6,HEIGHT*3],center=true);
	}
}

function bit_position_x(i) = REVERSEBITS? 1 + (NBITS-1 -i)*2 + 0.5: 1 + i*2 + 0.5 ;
function line_position_y(i) = 1.5 + (NCHARS-1-i)*2;

ascii_table= [[" ","0100000"],["!","0100001"],["\"","0100010"],["#","0100011"],["$","0100100"],["%","0100101"],["&","0100110"],["'","0100111"],["(","0101000"],[")","0101001"],["*","0101010"],["+","0101011"],[",","0101100"],["-","0101101"],[".","0101110"],["/","0101111"],["0","0110000"],["1","0110001"],["2","0110010"],["3","0110011"],["4","0110100"],["5","0110101"],["6","0110110"],["7","0110111"],["8","0111000"],["9","0111001"],[":","0111010"],[";","0111011"],["<","0111100"],["=","0111101"],[">","0111110"],["?","0111111"],["@","1000000"],["A","1000001"],["B","1000010"],["C","1000011"],["D","1000100"],["E","1000101"],["F","1000110"],["G","1000111"],["H","1001000"],["I","1001001"],["J","1001010"],["K","1001011"],["L","1001100"],["M","1001101"],["N","1001110"],["O","1001111"],["P","1010000"],["Q","1010001"],["R","1010010"],["S","1010011"],["T","1010100"],["U","1010101"],["V","1010110"],["W","1010111"],["X","1011000"],["Y","1011001"],["Z","1011010"],["[","1011011"],["\\","1011100"],["]","1011101"],["^","1011110"],["_","1011111"],["`","1100000"],["a","1100001"],["b","1100010"],["c","1100011"],["d","1100100"],["e","1100101"],["f","1100110"],["g","1100111"],["h","1101000"],["i","1101001"],["j","1101010"],["k","1101011"],["l","1101100"],["m","1101101"],["n","1101110"],["o","1101111"],["p","1110000"],["q","1110001"],["r","1110010"],["s","1110011"],["t","1110100"],["u","1110101"],["v","1110110"],["w","1110111"],["x","1111000"],["y","1111001"],["z","1111010"],["{","1111011"],["|","1111100"],["}","1111101"],["~","1111110"]];

function char2bits(c) = str(NBITS==8? "0" : "",ascii_table[search(c,ascii_table,0,0)[0][0]][1]);

//echo("NCHARS",NCHARS);
//echo(char2bits("a"));

scale(SIZEMMS/(NBITS*2+1))
translate([-(NBITS*2+1)/2, -(NCHARS*2+1)/2])
simple_innie_outie();

//cube([SIZEMMS,1,1]);


