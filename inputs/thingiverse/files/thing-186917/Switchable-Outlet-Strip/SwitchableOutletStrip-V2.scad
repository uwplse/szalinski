/*
OpenSCAD-File for lasercutting a switch-power-supply-box for energy savings (especially if it burns the house down or i electrucute myself - both may consume lots of power in the short run but will result in huuuuuge savings on the long run.... so don't build it, electricity is dangerous :-)

Uses write.scad 
https://www.thingiverse.com/thing:16193

and a scrolly thing from the Soft Ornaments Three font (couldn't use that :-(
http://www.dafont.com/soft-ornaments-three.font

19 Nov 2013 jth
*/

include <write/Write.scad> //customizer
//use <write.scad> //if you have your own write.scad...

/* [Layout] */
//Plug-String: Use letters for each type of plug: P euro plug, S schuko plug (both from my leftover box :-) O power outlet like: Farnell 2080447, E power entry  like: Farnell 9521631, so e.g. EOOO for one power entry and three outlets
sockets = "EOOO";

//Identifier for the plugs
id00 = "POWER";
id01 = "MONITOR";
id02 = "COMPUTER";
id03 = "RECEIVER";
id04 = "";
id05 = "";
id06 = "";
id07 = "";
id08 = "";
id09 = "";
id10 = "";
id11 = "";
id12 = "";
id13 = "";
id14 = "";
id15 = "";
id16 = "";
id17 = "";
id18 = "";
id19 = "";

/* [Parameter] */
//Material thickness [cm]
t = 0.4;

//Depth of the box (width depents on number of plugs, height fixed) [cm]
d = 10;

// Which font to use
useFont = "write/knewave.dxf"; //[write/blackrose.dxf:BlackRose,write/braille.dxf:Braille,write/knewave.dxf:Knewave,write/letters.dxf:Letters,write/orbitron.dxf:Orbitron]


//The size of the font [cm]
fontSize = 0.95;

/* [Output/View] */
//Different views
view = 0; // [0:3D View Lasercutter, 1:2D View Lasercutter, 2: DXF-Export Engrave, 3: DXF-Export Form, 4:3D Printer]
//Distance between segments in 3D View Lasercutter [cm]
displayOffset = 0.4;

/* [Hidden] */

names = [id00, id01, id02, id03, id04, id05, id06, id07, id08, id09, id10, id11, id12, id13, id14, id15, id16, id17, id18, id19];

//baseHeight = 5.7*1;
baseHeight = 5.7*1;
baseWidth  = 5.7*1;

number = len(sockets);

borderOffset = 3*t;

w = ceil(baseWidth*number+2*t);
h = 7*1; //ceil(baseHeight+2*t);

//helper values

f = 3*1; // ratio between thickness and tenonsize 
// determine number and size of tenons
numberW = ((floor(w/(t*f))%2)==1) ? floor(w/(t*f)) : floor(w/(t*f))-1;
tenonW = w/numberW;
numberH = ((floor(h/(t*f))%2)==1) ? floor(h/(t*f)) : floor(h/(t*f))-1;
tenonH = h/numberH;
numberD = ((floor(d/(t*f))%2)==1) ? floor(d/(t*f)) : floor(d/(t*f))-1;
tenonD = d/numberD;

// components

module switch () {
	cube([1.2, 1.8, 2*t], center = true);
}

module socket_schuko () {
	cylinder(r=2.1, h=2*t, center = true, $fs = 0.5);
	rotate ([0,0,45]) translate([2.9,0,0]) cylinder(r=0.33, h=2*t, center = true, $fs = 0.1);
	rotate ([0,0,225]) translate([2.9,0,0]) cylinder(r=0.33, h=2*t, center = true, $fs = 0.1);
}

module socket_euro () {
	cube([2, 2.4, 2*t], center = true);
	translate([0,1.2,0]) rotate ([0,0,45]) cube([1.414, 1.414, 2*t], center = true);
	translate([0,-1.2,0]) rotate ([0,0,45]) cube([1.414, 1.414, 2*t], center = true);
	translate([0.7,2.1,0]) cylinder(r=0.33, h=2*t, center = true, $fs = 0.1);
	translate([-0.7,-2.1,0]) cylinder(r=0.33, h=2*t, center = true, $fs = 0.1);
}

// MULTICOMP - JR-101 - EINGANG,IEC
// Farnell: 9521631
module socket_entry () {
	cube([2, 2.77, 2*t], center = true);
	translate([0,2,0]) cylinder(r=0.33, h=2*t, center = true, $fs = 0.1);
	translate([0,-2,0]) cylinder(r=0.33, h=2*t, center = true, $fs = 0.1);
}

// SCHURTER - 6600.3100 - OUTLET, IEC, F, 6600, 10A
// Farnell: 2080447
module socket_outlet () {
	cube([2.48, 3.25, 2*t], center = true);
	translate([0,2,0]) cylinder(r=0.33, h=2*t, center = true, $fs = 0.1);
	translate([0,-2,0]) cylinder(r=0.33, h=2*t, center = true, $fs = 0.1);
}

// box

module edge() {
		for(i=[0:15]) {
			rotate([0,0,90/15*i])
			translate([2*t,0,0])
			cube([0.1,0.1,t], center = true);
		}
}

module border(bWidth, bHeight) {
	translate([ (bWidth-t)/2,  (bHeight-t)/2, 0]) rotate([0,0,180]) edge();
	translate([ (bWidth-t)/2, -(bHeight-t)/2, 0]) rotate([0,0, 90]) edge();
	translate([-(bWidth-t)/2,  (bHeight-t)/2, 0]) rotate([0,0,270]) edge();
	translate([-(bWidth-t)/2, -(bHeight-t)/2, 0]) rotate([0,0,  0]) edge();

	translate([0, (bHeight-t)/2,0]) cube([bWidth-t*5, 0.1, t], center = true);
	translate([0,-(bHeight-t)/2,0]) cube([bWidth-t*5, 0.1, t], center = true);
	translate([  (bWidth-t)/2,0,0]) cube([0.1, bHeight-t*5, t], center = true);
	translate([ -(bWidth-t)/2,0,0]) cube([0.1, bHeight-t*5, t], center = true);
}

module top() {
	difference() {
		cube([w, d, t], center = true);
		group() {
			if (view !=4) {
				for (i = [0 : ((numberW-1)/2)-1]) {
					translate([(i*2-(numberW-1)/2+1)*tenonW, d/2, 0]) 	
					cube([tenonW, t*2, t*2], center = true);
					translate([(i*2-(numberW-1)/2+1)*tenonW, -d/2, 0]) 
					cube([tenonW, t*2, t*2], center = true);
				}
				for (i = [0 : ((numberD-1)/2)-1]) {
					translate([w/2, (i*2-(numberD-1)/2+1)*tenonD, 0]) 
					cube([t*2, tenonD, t*2], center = true);
					translate([-w/2, (i*2-(numberD-1)/2+1)*tenonD, 0]) 
					cube([t*2, tenonD, t*2], center = true);
				}
			}
			translate([0,0,t/2]) border(w-borderOffset,d-borderOffset);
		}
	}
}

module bottom() {
	difference() {
		cube([w-t, d-t, t], center = true);
		group() {
			for (i = [0 : number-2]) {
				translate([-baseWidth*(number-1)/2+i*baseWidth+baseWidth/2,0,0])
				cylinder(r1=0.2, r2=0.2+1.1*t, h=1.1*t, center = true, $fs = 0.2);
			}
			translate([0,0,t/2]) border(w-borderOffset,d-borderOffset);
		}
	}
}

module panel() {
	difference() {
		cube([w, h, t], center = true);
		group() {
			if (view !=4) {
				for (i = [0 : ((numberW-1)/2)]) {
					translate([(i*2-(numberW-1)/2)*tenonW, h/2, 0]) 	
					cube([tenonW, t*2, t*2], center = true);
					translate([(i*2-(numberW-1)/2)*tenonW, -h/2, 0]) 
					cube([tenonW, t*2, t*2], center = true);
				}
				for (i = [0 : ((numberH-1)/2)]) {
					translate([w/2, (i*2-(numberH-1)/2)*tenonH, 0]) 
					cube([t*2, tenonH, t*2], center = true);
					translate([-w/2, (i*2-(numberH-1)/2)*tenonH, 0]) 
					cube([t*2, tenonH, t*2], center = true);
				}
			} else {
				translate([0, h/2, -t/2]) cube([w-t, 2*t, t], center = true);
				translate([0, -h/2, -t/2]) cube([w-t, 2*t, t], center = true);
				//translate([w/2, 0, -t/2]) cube([2*t, h-t, t], center = true);
				//translate([-w/2, 0, -t/2]) cube([2*t, h-t, t], center = true);
			}
			translate([0,0,t/2]) border(w-borderOffset,h-borderOffset);
		}
	}
}

module front() {
	difference() {
		panel();
		group() {
			for (i = [0 : number-1]) {
				translate([-baseWidth*(number-1)/2+i*baseWidth,baseHeight/6,0]) 
				switch();
			}
			for (i = [0 : number-1]) {
				translate([-baseWidth*(number-1)/2+i*baseWidth,-baseHeight/6,t/2])
				write(names[i],t=t,h=fontSize,center=true, font=useFont);
			}
		}
	}

}

module back() {
	difference() {
		panel();
		group() {
			for (i = [0 : number-1]) {
				if (sockets[i] == "P") {
					translate([-baseWidth*(len(sockets)-1)/2+i*baseWidth,0,0]) socket_euro();
				} else if (sockets[i] == "S") {
					translate([-baseWidth*(len(sockets)-1)/2+i*baseWidth,0,0]) socket_schuko();
				} else if (sockets[i] == "E") {
					translate([-baseWidth*(len(sockets)-1)/2+i*baseWidth,0,0]) socket_entry();
				} else if (sockets[i] == "O") {
					translate([-baseWidth*(len(sockets)-1)/2+i*baseWidth,0,0]) socket_outlet();
				} else {
					echo("Unknown plug form");
				}
			}
		}
	}
}

module side() {
	difference() {
		cube([h, d, t], center = true);
		group() {
			if (view !=4) {
				for (i = [0 : (((numberH-1)/2)-1)]) {
					translate([(i*2-(numberH-1)/2+1)*tenonH, d/2, 0]) 	
					cube([tenonH, t*2, t*2], center = true);
					translate([(i*2-(numberH-1)/2+1)*tenonH, -d/2, 0]) 
					cube([tenonH, t*2, t*2], center = true);
				}
				for (i = [0 : ((numberD-1)/2)]) {
					translate([h/2, (i*2-(numberD-1)/2)*tenonD, 0]) 
					cube([t*2, tenonD, t*2], center = true);
					translate([-h/2, (i*2-(numberD-1)/2)*tenonD, 0]) 
					cube([t*2, tenonD, t*2], center = true);
				}
			} else {
				//translate([0, d/2, -t/2]) cube([h-t, 2*t, t], center = true);
				//translate([0, -d/2, -t/2]) cube([h-t, 2*t, t], center = true);
				translate([h/2, 0, -t/2]) cube([2*t, d-t, t], center = true);
				translate([-h/2, 0, -t/2]) cube([2*t, d-t, t], center = true);
			}
			translate([0,0,t/2]) border(h-borderOffset,d-borderOffset);
		}
	}
}

//draw

module view3D(offset) {
	translate([0, 0, (h-t+displayOffset)/2]) top();
	rotate([180, 0, 0]) translate([0, 0, (h-t+displayOffset)/2]) top();
	rotate([90, 0, 0]) translate([0, 0, (d-t+displayOffset)/2])front();
	rotate([270, 0, 0]) translate([0, 0, (d-t+displayOffset)/2])back();
	rotate([0, 90, 0]) translate([0, 0, (w-t+displayOffset)/2])side();
	rotate([0, 270, 0]) translate([0, 0, (w-t+displayOffset)/2])side();
}

module make3D() {
	translate([0, 0, (h-t)/2]) top();
	for (i = [0 : number-2]) {
		difference() {
			translate([-baseWidth*(number-1)/2+i*baseWidth+baseWidth/2,0,t/2])
			cylinder(r= 1, h=baseHeight-t, center = true, $fs = 0.5);
			translate([-baseWidth*(number-1)/2+i*baseWidth+baseWidth/2,0,-t])
			cylinder(r= 0.2, h=baseHeight, center = true, $fs = 0.5);
		}
	}
	translate([0, d+t, (h-t)/2]) bottom();
	rotate([90, 0, 0]) translate([0, 0, (d-t)/2])front();
	rotate([270, 0, 0]) translate([0, 0, (d-t)/2])back();
	rotate([0, 90, 0]) translate([0, 0, (w-t)/2])side();
	rotate([0, 270, 0]) translate([0, 0, (w-t)/2])side();
}

module view2D() {
	translate([-(w+h+t)/2, 0, 0]) top();
	translate([+(w+h+t)/2, 0, 0]) top();
	translate([-(w+h+t)/2, +(d+h+t)/2, 0])front();
	translate([+(w+h+t)/2, +(d+h+t)/2, 0])back();
	side();
	translate([0, +(d*2+t)/2, 0])side();
}

if (view == 0) {
	view3D();
} else if (view == 1) {
	view2D();
} else if (view == 2) {
	projection(cut=true) {
		translate([0,0,-t/4]) view2D();
	}
} else if (view == 3) {
	projection(cut=true) {
		translate([0,0,t/4]) view2D();
	}
} else if (view == 4) {
	make3D();
}