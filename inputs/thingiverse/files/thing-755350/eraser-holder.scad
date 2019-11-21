// Laurie Gellatly
// Erase holder
use <write/Write.scad>;


//CUSTOMIZER VARIABLES

//(max 26 characters)
message = "Yvonne`s Board";
// to use
font = "write/orbitron.dxf"; // [write/Letters.dxf,write/BlackRose.dxf,write/orbitron.dxf,write/knewave.dxf,write/braille.dxf]

// Wall thickness
wt=2/1;
// overall of holder
xwidth = 200;	// [50:200]
// overall of holder
ydepth = 70;	// [50:100]
fheight = 15/1;	// front height
rheight = 30/1;	// rear height
// for pens
Hole_diameter = 16;	// [10:20]
hr = Hole_diameter/2;			// hole radius

Whiteboard_edge_thickness = 17;		//[10:30]
gap = Whiteboard_edge_thickness/1;		// gap to fit board


translate([xwidth/-2, gap+ydepth/2-wt,0]) cube ([xwidth, wt, rheight]);		// Rear plate
translate([xwidth/-2,     ydepth/2-2*wt,0]) cube ([xwidth, wt, rheight]);		// Rear plate
difference(){
	union(){
	translate([xwidth/-2, ydepth/-2,0]) cube ([xwidth, wt, fheight]);			// Front plate
	translate([gap+xwidth/-2, gap+ydepth/2-(2+wt),gap+2*wt+1]) cube ([xwidth/4, 2+wt, 3+wt]); // Clip
	for(i=[gap+xwidth/-2:4.4:gap+xwidth/-4]) translate([i,.4+gap+ydepth/2-(2+wt), gap+2*wt+1.6]) rotate([45-180,0,0]) cube([.6,.6,5]);
	translate([xwidth/4-gap , gap+ydepth/2-(2+wt),gap+2*wt+1]) cube ([xwidth/4, 2+wt, 3+wt]);
	for(i=[xwidth/4-gap:4.4:xwidth/2-gap]) translate([i,.4+gap+ydepth/2-(2+wt), .6+gap+2*wt+1]) rotate([45-180,0,0]) cube([.6,.6,5]);
	translate([gap+xwidth/-2,     ydepth/2-2*wt    ,gap+2*wt+1]) cube ([xwidth/4, 2+wt, 3+wt]); // Clip
	for(i=[gap+xwidth/-2:4.4:gap+xwidth/-4]) translate([i,ydepth/2, gap+2*wt+1]) rotate([45-270,0,0]) cube([.6,.6,5]);
	translate([xwidth/4-gap ,     ydepth/2-2*wt    , gap+2*wt+1]) cube ([xwidth/4, 2+wt, 3+wt]);
	for(i=[xwidth/4-gap:4.4:xwidth/2-gap]) translate([i,ydepth/2, gap+2*wt+1]) rotate([45-270,0,0]) cube([.6,.6,5]);
	translate([xwidth/-2, ydepth/-2,0]) cube ([xwidth, ydepth+gap, wt]);
 	translate([0, ydepth/-2,(fheight)/2-.4]) rotate([90,0,0]) write(message,t=.5,h=fheight-2,font="orbitron.dxf",center=true);	// font can be: Letters, orbitron, knewave, BlackRose or braille
	}
	translate([xwidth/-2 +1.5*hr, ydepth/-2+hr+9,-.1]) cylinder (r=hr,h=wt+.2);
	translate([xwidth/ 2 -1.5*hr, ydepth/-2+hr+9,-.1]) cylinder (r=hr,h=wt+.2);
	translate([xwidth/-2 +1.5*hr, ydepth/ 2-(hr+9),-.1]) cylinder (r=hr,h=wt+.2);
	translate([xwidth/ 2 -1.5*hr, ydepth/ 2-(hr+9),-.1]) cylinder (r=hr,h=wt+.2);
	translate([xwidth/-2-.1, gap+ydepth/2-(2+wt),gap+2*wt+1]) rotate([45,0,0]) cube ([xwidth+.2, 4+wt, 3+wt]);
	translate([xwidth/-2-.1,     ydepth/2+2-wt,gap+2*wt+1]) rotate([45,0,0]) cube ([xwidth+.2, 4+wt, 4+wt]);
}
