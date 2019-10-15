// Y-belt retainer/tensioner
// May 2012 John Newman

// This parameter deterimes how far the belt is held above the deck
/*rise*/
dRise = 10;			// Added to the depth to make the belt run horizontal
belt=1; // [0:T2.5,1:T5]

	
// Belt dimensions - These are for T2.5, see below for T5
tBase = (belt==1) ? 1.5 : 1.25;		// Thickness of belt base
tFull = (belt==1) ? 2.7:2;			// Thickness of Belt at teeth
wTooth = (belt==1) ? 2.6:1.4;		// Width of tooth (not actual, req)
wSpace = (belt==1) ? 2.4:1.1;		// Width of space
wBelt = (belt==1) ? 6.2:6.2;		// Width of belt

// Misc params
wHex = 6.9;		// Width of trap for hex nut
dHex	= 2.5;			// Depth of trap for hex nut
rM3 = 1.7;			// Radius of M3 bolt hole
sDrop = wHex/2-0.5; //2.8;		// Driver screw drop from base of slider
Adjust = 0.5;		// Spacing for things to fit inside other things!
pWidth = 9;			// Screw platform width
pHeight = 5;		// Screw platform height

// Base parameters
bwExt = 20;		// Widest part of base
bwInt = 15;			// inside width, where slider goes
blExt = 30;			// Overall length of base
blHed = 6;			// Head of base whch takes the strain !
bdExt = 12.5;		// This included a minimum floor thickness of 2mm (?)
bRoof = 2.2;		// The thickness of the roof which holds the slider in
bFloor = 1;			// The thickness of the floor under the slider (minimum)
bdSoc = bdExt-(bRoof+bFloor);		// 'Socket' depth for slider to go in

// Slider parameters
swMax = bwInt - Adjust;	// Wide part of slider
sdMax = bdSoc-Adjust;		// Height of slider

lBelt = blExt*2;		// Length of a bit of belt!
rMsk = blExt/3 ;		// Radius of part of mount masking...


// Print the parts as req.
translate([0,15+dRise,blExt/2]) rotate([0,90,90]) basepart();
translate([0,-10,(sdMax)/2]) rotate([0,180,0]) sliderpart();


module sliderpart() {
	difference() {
		cube([blExt-blHed,swMax,sdMax],center=true);
		// Make a hole for the bolt end
		translate([(blExt-blHed)/2-2,0,(sdMax/2)-sDrop]) rotate([30,0,0]) rotate([0,90,0]) cylinder(10,rM3+0.5,rM3+0.5,$fn=6);
		// Make a fracture to cause fill
		translate([(blExt-blHed)/2-4.2,0,(sdMax-tFull)/2+1]) cube([0.05,swMax-4.4,sdMax],center=true) ;
		// Finally indent for belt
		translate([-lBelt/2,-wBelt/2,-sdMax/2-0.1]) belt();
	}
}

// Note this is positioned so that the slider is centered on the XY plane
module basepart() {
	union() {
		difference() {
			translate([0,0,-dRise/2]) cube([blExt,bwExt,bdExt+dRise],center=true);
			// Remove the space for the slider
			translate([-blHed,0,(bFloor-bRoof)/2]) cube([blExt,bwInt,bdSoc],center=true);
			// Remove a hole for the bolt
			translate([(blExt/2-9),0,bFloor+sDrop-bdExt/2]) rotate([30,0,0]) rotate([0,90,0]) cylinder(15,rM3,rM3);
			// An indentation for the bolt head
			translate([(blExt/2)-(blHed+5-dHex),0,bFloor+sDrop-bdExt/2]) rotate([30,0,0]) rotate([0,90,0]) cylinder(5,wHex/2,wHex/2,$fn=6);
			// A slot for the belt to come through
			translate([blExt/2-blHed,0,(bdExt-tFull-0.61)/2-bRoof]) cube([15,wBelt+2,tFull+0.6],center=true);
		}
		for (m=[[0,0,0],[0,1,0]]) mirror(m) translate([0,bwExt/2-.1 + (pWidth/2-0.01),-dRise-bdExt/2+pHeight/2]) screwmount() ;
	}
}

module belt() {
	cube([lBelt,wBelt,tBase]) ;
	for (inc = [0:(wTooth+wSpace):lBelt-wTooth]) translate([inc,0,tBase-0.01]) cube([wTooth,wBelt,(tFull-tBase)]) ;
}

module screwmount() {
	difference() {
		cube([blExt,pWidth,pHeight],center=true);
		// Bolt holes
		translate([(blExt-pWidth)/2,0,-(pHeight/2+1)]) rotate([0,0,30]) cylinder(pHeight+2,rM3,rM3,$fn=6);
		translate([-(blExt-pWidth)/2,0,-(pHeight/2+1)]) rotate([0,0,30]) cylinder(pHeight+2,rM3,rM3,$fn=6);
		// Nut traps
		translate([(blExt-pWidth)/2,0,pHeight/2-dHex-0.01]) rotate([0,0,30]) cylinder(5,wHex/2,wHex/2,$fn=6);
		translate([-(blExt-pWidth)/2,0,pHeight/2-dHex-0.01]) rotate([0,0,30]) cylinder(5,wHex/2,wHex/2,$fn=6);
	}
}
