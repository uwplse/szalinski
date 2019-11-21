/* [Hidden] */
// Kossel mains inlet panel and Duet mount

/* [Options] */

// Which type of Duet will you be using?
Wifi=0;		// [0: Ethernet Duet 0.8.5 or Duet 0.6,1:Duet WiFi]

/* [Hidden] */

length=280;
height=60;
thickness=2.4;	// change to be a multippe of your printing latewr height

// The reference point for all of the following is the top side of the corner of the PCB that is
// closest to the extruder heater connector(s).
// xxxOffset is the height of the bottom of the cutout above the top surface of the PCB.
// xxxPos is the distance from the centre of the cutout to the corner of the board.

inletOffset=220-(355-280)/2;
duetYOffset=81 - (355-length)/2;
duetTopXOffset=-10+5.5;

pbHeight=2.4;
pbWidth=3;
pbOffset=-0.2;
pbPos1=29.855;
pbPos2=38.11;

usbHeight=5;
usbWidth=9;
usbOffset=-1;
usbPos=47.2;

sdHeight= 3.5;
sdWidth=13;
sdOffset=0;
sdPos=62.75;

ethernetHeight=14;
ethernetWidth=16;
ethernetOffset=0;
ethernetPos=84.6;

wifiHeight=1.8;
wifiWidth=18;
wifiOffset=-0.2;
wifiPos=81.6;

ribThickness=3;
ribHeight=4;
pcbThick=1.6;
pcbClear=0.1;
pcbWidth=100;
pcbWclear=0.5;

round=5;
m4ClearRad=2.1;

overlap=0.02;

module fuseCutout() {
	translate([0,0,-overlap])
		difference() {
			cylinder(r=6.8,h=thickness+2*overlap,$fn=32);
			translate([5.5,-10,-overlap]) cube([20,20,thickness+4*overlap]);
		}
}

module switchCutout() {
	union() {
		cube([13,19,10], center=true);
	}
}

module inletCutout() {
	union() {
		cube([19.5,27,10], center=true);
	}
}

// Finger guard is aligned with right side at Y=0
module fingerGuard() {
	translate([-9,-10,0])
		difference() {
			cube([18,10,15+overlap]);
			translate([-1,-10,0]) rotate([-25,0,0]) cube([20,10,50]);
		}
}

module roundCorner(radius, height) {
	difference() {
		cube([radius+2,radius+2,height]);
		translate([0,0,-overlap]) cylinder(r=radius,h=height+2*overlap,$fn=32);
	}
}

// Duet connector cutout, referenced to the bottom corner and the top of the PCB
module duetCutouts() {
	// push buttons
	translate([pbOffset + pbHeight/2,pbPos1,-overlap]) cube([pbHeight,pbWidth,10], center=true);
	translate([pbOffset + pbHeight/2,pbPos2,-overlap]) cube([pbHeight,pbWidth,10], center=true);
	// USB connector
	translate([usbOffset + usbHeight/2,usbPos,-overlap]) cube([usbHeight,usbWidth,20], center=true);
	// SD card
	translate([sdOffset + sdHeight/2,sdPos,-overlap]) cube([sdHeight,sdWidth,10], center=true);
	// Ethernet or Wifi
	if (Wifi) {
		translate([wifiOffset + wifiHeight/2,wifiPos,-overlap])
			cube([wifiHeight,wifiWidth,10], center=true);
	} else {
		translate([ethernetOffset + ethernetHeight/2,ethernetPos,-overlap])
			cube([ethernetHeight,ethernetWidth,10], center=true);
	}
	// LEDs
	translate([0,7,0.6]) cube([4,20,10]);
	// Board
	translate([-pcbThick-pcbClear,-pcbWclear,2.0])
		cube([pcbThick+2*pcbClear,pcbWidth+2*pcbWclear, 10]);
	// Ventilation holes
	for(y=[1:6:40])
		for(x=[-8,7])
			translate([x,y,-overlap])
				cube([3,3,10]);
}

module duetRibs() {
	translate([-pcbThick-pcbClear-ribThickness,-overlap,thickness-overlap])
		cube([ribThickness,pcbWidth+pcbWclear+2*overlap,ribHeight+overlap]);

	translate([-ribThickness-pcbThick-pcbClear,-ribThickness-pcbWclear,thickness-overlap])
		cube([pcbThick+2*ribThickness+2*pcbClear,6+ribThickness,ribHeight+overlap]);
	translate([-ribThickness-pcbThick-pcbClear,pcbWidth+pcbWclear-6,thickness-overlap])
		cube([pcbThick+2*ribThickness+2*pcbClear,6+ribThickness,ribHeight+overlap]);
}

difference() {
	union() {
		translate([-height/2,0,0]) cube([height,length,thickness]);
		translate([duetTopXOffset,duetYOffset, 0]) duetRibs();
		translate([0,length,thickness-overlap]) fingerGuard();
	}
	translate([0,inletOffset,0]) inletCutout();
	translate([0,inletOffset+30,0]) fuseCutout();
	translate([0,inletOffset+55,0]) switchCutout();

	translate([duetTopXOffset,duetYOffset,0]) duetCutouts();

	// Screw holes
	translate([20,10,-overlap]) cylinder(r=m4ClearRad,h=thickness+2*overlap, $fn=16);
	translate([-20,10,-overlap]) cylinder(r=m4ClearRad,h=thickness+2*overlap, $fn=16);
	translate([20,length/2,-overlap]) cylinder(r=m4ClearRad,h=thickness+2*overlap, $fn=16);
	translate([-20,length/2,-overlap]) cylinder(r=m4ClearRad,h=thickness+2*overlap, $fn=16);
	translate([20,length-10,-overlap]) cylinder(r=m4ClearRad,h=thickness+2*overlap, $fn=16);
	translate([-20,length-10,-overlap]) cylinder(r=m4ClearRad,h=thickness+2*overlap, $fn=16);

	// Corners
	translate([-height/2+round,round,-overlap])
		rotate([0,0,180]) roundCorner(round,thickness+2*overlap);
	translate([height/2-round,round,-overlap])
		rotate([0,0,-90]) roundCorner(round,thickness+2*overlap);
	translate([-height/2+round,length-round,-overlap])
		rotate([0,0,90]) roundCorner(round,thickness+2*overlap);
	translate([height/2-round,length-round,-overlap])
		rotate([0,0,0]) roundCorner(round,thickness+2*overlap);
}


