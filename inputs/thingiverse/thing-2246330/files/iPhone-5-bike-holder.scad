
// The outer width (from left to right without buttons) of the phone or bumper in millimeters
width = 63;
// The outer length (from top to bottom without buttons) of the phone or bumper in millimeters
length = 128;
// The outer height (from backside to front side) of the phone or bumper in millimeters
height = 11;
// The width of the bridges from top to bottom and from left to right in millimeters. Lower values save material, higher values make the mount more stable. 15 millimeter is a good choice.
bridgewidth = 15;
// The radius of the corners of the phone or bumper. The standard Apple bumper for iPhone 5 has a corner radius of 10 millimeter.
cornerradius = 10;
// The distance bwtween the iPhone holder and the bike's tube in millimeter. Make it larger when you have other obstacles mounted on the bike.
mountheight = 10;
// The diameter of the tube where to mount the holder in millimeters.
tubediameter = 22;
// The fininess of the cylinders. 100 is a good start.
$fn = 100;

module connector(stegwidth) {
	// plates
	translate([-stegwidth/2-2.5,-stegwidth/2-4.5,2]) cube([4.5,4,1.5]);
	translate([stegwidth/2-2,-stegwidth/2-4.5,2]) cube([4.5,4,1.5]);
	translate([-stegwidth/2-2.5,stegwidth/2+5.5,2]) cube([4.5,4,1.5]);
	translate([stegwidth/2-2,stegwidth/2+5.5,2]) cube([4.5,4,1.5]);
	// pins
	translate([-stegwidth/2-2.5,-stegwidth/2-4.5,0]) cube([2,4,2]);
	translate([stegwidth/2+0.5,-stegwidth/2-4.5,0]) cube([2,4,2]);
	translate([-stegwidth/2-2.5,stegwidth/2+5.5,0]) cube([2,4,2]);
	translate([stegwidth/2+0.5,stegwidth/2+5.5,0]) cube([2,4,2]);
}

module connectorcutout(stegwidth) {
		translate([-stegwidth/2-0.1,-stegwidth/2-5,1.5]) cube([3.1,5,1.6]);
		translate([stegwidth/2-3,-stegwidth/2-5,1.5]) cube([3.1,5,1.6]);
		translate([-stegwidth/2-0.1,stegwidth/2+5,1.5]) cube([3.1,5,1.6]);
		translate([stegwidth/2-3,stegwidth/2+5,1.5]) cube([3.1,5,1.6]);
		translate([-stegwidth/2-0.1,-stegwidth/2-10.1,-0.1]) cube([3.1,5.2,3.2]);
		translate([stegwidth/2-3,-stegwidth/2-10.1,-0.1]) cube([3.1,5.2,3.2]);
		translate([-stegwidth/2-0.1,stegwidth/2-0.1,-0.1]) cube([3.1,5.2,3.2]);
		translate([stegwidth/2-3,stegwidth/2-0.1,-0.1]) cube([3.1,5.2,3.2]);
}

module case(width, height, depth, radius, stegwidth) {
	difference() {
		// Outer hull
		hull() {
			translate([-width/2+radius, -height/2+radius, 0]) cylinder(r=radius+2, h=depth+4);
			translate([-width/2+radius, +height/2-radius, 0]) cylinder(r=radius+2, h=depth+4);
			translate([+width/2-radius, -height/2+radius, 0]) cylinder(r=radius+2, h=depth+4);
			translate([+width/2-radius, +height/2-radius, 0]) cylinder(r=radius+2, h=depth+4);
		}
		// substract iPhone itself
		hull() {
			translate([-width/2+radius, -height/2+radius, 3]) cylinder(r=radius, h=depth);
			translate([-width/2+radius, +height/2-radius, 3]) cylinder(r=radius, h=depth);
			translate([+width/2-radius, -height/2+radius, 3]) cylinder(r=radius, h=depth);
			translate([+width/2-radius, +height/2-radius, 3]) cylinder(r=radius, h=depth);
		}
		// display
		hull() {
			translate([-width/2+radius+1, -height/2+radius+1, depth+2.9]) cylinder(r=radius, h=1.2);
			translate([-width/2+radius+1, +height/2-radius-1, depth+2.9]) cylinder(r=radius, h=1.2);
			translate([+width/2-radius-1, -height/2+radius+1, depth+2.9]) cylinder(r=radius, h=1.2);
			translate([+width/2-radius-1, +height/2-radius-1, depth+2.9]) cylinder(r=radius, h=1.2);
		}
		// left and right pins
		translate([-width/2,-stegwidth/2-0.1,depth+2.9]) cube([width,stegwidth+0.2,1.2]);
		// upper left corner
		translate([-width/2-2.1, +stegwidth/2, -0.1]) cube([width/2-stegwidth/2+2.1,height/2-2.9,depth+4.2]);
		// upper right corner
		translate([+stegwidth/2, +stegwidth/2, -0.1]) cube([width/2-stegwidth/2+2.1,height/2-2.9,depth+4.2]);
		// lower left cut
		translate([-width/2-2.1, -height/2+radius, -0.1]) cube([width/2-stegwidth/2+2.1,height/2-stegwidth/2-radius,depth+4.2]);
		// lower right cut
		translate([+stegwidth/2, -height/2+radius, -0.1]) cube([width/2-stegwidth/2+2.1,height/2-stegwidth/2-radius,depth+4.2]);
		// lower connectors cut
		translate([-width/2+radius, -height/2-2.1, 3]) cube([width-radius-radius,3.2,depth+4.2]);
		// vertical connector cutouts
		connectorcutout(stegwidth);
		// horizontal connector cutouts
		rotate([0, 0, -90]) connectorcutout(stegwidth);
	}
	// Schnippel zum losmachen
	translate([-stegwidth/2,height/2,depth+3]) cube([stegwidth,2,3]);
}

module holder(height, radius, stegwidth) {
	// upper plate
	translate([-stegwidth/2-2.5,-stegwidth/2-7,0]) cube([stegwidth+5,stegwidth+14,2]);
	// ring
	difference() {
		union() {
			translate([-stegwidth/2-2.5,0,radius+height]) rotate([0,90,0]) cylinder(r=radius+2,h=stegwidth+5);
			// vertikale Stege
			translate([-1, -stegwidth/2-7, 2]) cube([2,stegwidth+14,radius+height-2]);
			translate([-stegwidth/2-2.5, -stegwidth/2-7, 2]) cube([2,stegwidth+14,radius+height-2]);
			translate([stegwidth/2+0.5, -stegwidth/2-7, 2]) cube([2,stegwidth+14,radius+height-2]);
		}
		translate([-stegwidth/2-2.6,0,radius+height]) rotate([0,90,0]) cylinder(r=radius,h=stegwidth+5.2);
		// lower ring cut
		translate([-stegwidth/2-2.6, -radius-2.1, radius+height+4]) cube([stegwidth+5.2,radius*2+4.2,radius+4]);
	}
	// connector
	translate([0,-2.5,0]) rotate([0, 180, 0]) connector(stegwidth);
}

case(width, length, height, cornerradius, bridgewidth);
rotate([90,0,0]) translate([width, tubediameter/2+2 > 14.5 ? tubediameter/2+2 : 14.5, 0]) holder(mountheight, tubediameter/2, bridgewidth);
//rotate([180,0,90]) translate([0, 2, 0]) holder(mountheight, tubediameter/2, bridgewidth);
//rotate([90,0,0]) translate([width, 14.5, 0]) holder(mountheight, tubediameter/2, bridgewidth);
