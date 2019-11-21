// Replacement band for Fitbit Flex.
//
// http://www.thingiverse.com/thing:205148
//
// (c) 2013,2014 Laird Popkin.

/* [Settings] */

// Measurement around wrist (mm).
wristLenMM = 185;
// and in inches
wristLenIn = 0;
// Part to view
part = 5; //[5: Preview, 4:Band]

// . 0:Assembled Flex (don't print), 1:Flex Band, 2:Flex Box Bottom, 3:Flex Box Top]

/* [Solid Band] */

// Ratio of wrist width to height. 1.0 = circular, 1.25 is normal.
stretch = 1.25;
// Fraction of wrist size to leave open. 1.0 is very loose, 0.8 is tight.
bandOpenRatio = 0.8;
// Band thickness (mm)
bandThick=7;
// Band 'wall' thickness (mm)
bandWall = 10;
// Generate support in model
support=0; //[0:Don't include support, 1:Include support]
// Flex adjust in/out. Positive moves towards the outside, negative moves to inside. Adjust if needed to have the Flex intersect the band as you like.
flexTweakR = 1.5;
// Flex adjust up/down. Positive moves towards the end with the lights, negative moves the other way.
flexTweakX = 0;
// Clearance around Fitbit in band, adjust for your printer. 0=none, .25=loose
clearance=.25;
clearanceFactor=clearance/10;

/* [Hidden] */

wristLength = wristLenMM + wristLenIn*24.5;
// Length of links
linkLen = 13; // [11:Tight, 12:Tight-ish, 13:Loose-ish, 14:Loose]

/* [Hidden] */
$fn=16;
linkHeight=7;
pi=3.14159; // I could go on...
wristLen = wristLength + linkHeight*3.14159; // diameter of outside of band to allow for thickness
in=24.5;
len = 1.4*in;
width=8.5/16*in;
height=3/8*in;
echo(len,width,height);
r=2;
xoff=width/2-r;
yoff=height/2-r;
thick=.5;

flexScale=1.3;
flexLScale=1.105;

blockH=10;
angle=30; // angle of face
zoff = sin(30)*5;

outerWidth=width+4.6*thick;
outerLen = len-3;
outerHeight = height+thick;

hinge_dia = outerHeight * 1000;

hingeXscale = .8;
hingeXoff=0.7;

echo("wrist band length ",wristLen);

flexAngle = 88.7; //89.2;

numLinks = floor((wristLen-outerLen-outerWidth/2)/(linkLen*2));
linksLen = numLinks*linkLen;
echo("links ",numLinks," length ",linksLen);

gap = 0.8;

echo("size ",outerWidth,outerLen,outerHeight);

module flex() {
	translate([0,0,-1]) difference() {
		translate([0,0,-zoff]) linear_extrude(scale=0.85,height=len) {
			square([width-2*r,height],center=true);
			square([width,height-2*r],center=true);

			translate([-xoff,-yoff,0]) circle(r=r);
			translate([-xoff,yoff,0]) circle(r=r);
			translate([xoff,-yoff,0]) circle(r=r);
			translate([xoff,yoff,0]) circle(r=r);
			}
		translate([0,0,-zoff]) rotate([30,0,0]) cube([2*width,2*height,5],center=true);
		}
	}

module male() {
	scale([1,1/2,1]) {
		translate([-outerWidth/8,0,0])
			cube([outerWidth/4,outerWidth/2,linkHeight]);
		translate([0,-gap,0]) cylinder(r=outerWidth/4, h=linkHeight);
		}
	}

module female() {
	scale([1,1/2,1]) difference() {
		translate([-outerWidth/2,-outerWidth/2-gap,0]) 
			cube([outerWidth,outerWidth,linkHeight]);
		translate([-outerWidth/8-gap,0,-1]) 
			cube([outerWidth/4+2*gap,outerWidth/2,linkHeight+2]);
		translate([0,0,-1]) cylinder(r=outerWidth/4+2*gap, h=linkHeight+2);
		}
	}

module FitBitBand(band=1) {
	//#translate([	outerWidth,0,0]) cube([1,wristLen,1],center=true);

	difference() {
		union() {
			// hull around Flex
			translate([0,len/2-zoff,height/2])
				rotate([flexAngle,0,0])
					scale([flexScale,flexScale,flexLScale]) flex();
			// Make 'head' thicker
			translate([0,outerLen*.43,height/2+thick/2]) cube([outerWidth,outerLen*.25,outerHeight],center=true); // around flex
			//block in middle of 'face'
			translate([0,-4,height/2+thick/2+outerHeight/4]) cube([outerWidth,outerLen*.2,outerHeight/2],center=true); // around flex
			//Make sides thicker
			translate([0,-4,height/2+thick/2])
				cube([outerWidth,outerLen,height-2*r],center=true); // around flex
			// links on both sides
			if (band) translate([0,0,outerHeight-linkHeight]) {
				for (link = [0:numLinks-1]) {
					assign (y=link*linkLen) {
//				for (y=[0:linkLen:wristLen/4+outerWidth/4]) {
					translate([hingeXoff,outerLen/2+y+linkLen/2,0]) scale([hingeXscale,1,1]) demo(linkHeight,gap/hingeXscale);
					translate([hingeXoff,-(outerLen/2+y+linkLen/2)-2,0]) scale([hingeXscale,1,1]) demo(linkHeight,gap/hingeXscale);
					}
				translate([0,-wristLen/2,0]) male();
				translate([0,wristLen/2,0]) female();
				}
				}
			}
		// carve out space for Flex
		translate([0,len/2-zoff-1,height/2]) rotate([flexAngle,0,0]) flex();
		// carve out hole on top to put Flex in
		translate([0,1,0]) cube([width,len-7,2*(r)],center=true);
		// carve out gap for pulling Flex out
		translate([0,len/2,.2]) cube([width*.75,6,2*(r+thick)], center=true);
		}

//	translate([hingeXoff,outerLen+1,0]) scale([hingeXscale,1,1]) demo(outerHeight,0.4/hingeXscale);
//	translate([hingeXoff,-outerLen-1,0]) scale([hingeXscale,1,1]) demo(outerHeight,0.4/hingeXscale);
//	translate([hingeXoff,1.75*outerLen+1,0]) scale([hingeXscale,1,1]) demo(outerHeight,0.4/hingeXscale);
//	translate([hingeXoff,-1.75*outerLen-1,0]) scale([hingeXscale,1,1]) demo(outerHeight,0.4/hingeXscale);
	//translate([hingeXoff,2.5*outerLen+1,0]) scale([hingeXscale,1,1]) demo(outerHeight,0.4/hingeXscale);
	//translate([hingeXoff,-2.5*outerLen-1,0]) scale([hingeXscale,1,1]) demo(outerHeight,0.4/hingeXscale);

	// fill gaps between ends and links
	if (band) translate([0,0,linkHeight*.9]) difference() {
		cube([outerWidth,wristLen-outerWidth/2,linkHeight],center=true);
		cube([outerWidth/.9,outerLen+2*linksLen,linkHeight+2],center=true);
		echo("gap len ",((wristLen-outerWidth/2) - (outerLen+2*linksLen))/2);
		}
	}

//flex();

module band() {
fitBitBand(0);
difference() {
	translate([0,0,outerHeight]) rotate([180,0,90]) FitBitBand();
	translate([0,0,-1]) cube([wristLen+10,outerWidth,2],center=true);
	if (part==0) rotate([90,0,0]) translate([0,0,4]) cube([wristLen+10,2*outerWidth,10],center=true);
	}
}

bandH = width+2*bandWall;

module solidBand(preview=0) {
	wristR = wristLen/pi/2/stretch;
	wristW = wristR+bandThick;
	echo ("wrist len ",wristLen," wrist R ",wristR);
	color("red") {
		difference() {
			scale([stretch,1,1]) difference() {
				translate([0,-bandThick/2,0]) 
					cylinder(r=wristR+bandThick/2, h=bandH, $fn=64);
				translate([0,-1,-1]) 
					cylinder(r=wristR, h=bandH+2, $fn=64);
				}
			difference() {
				translate([-len/2-flexTweakX,-wristR-flexTweakR,width/2+bandWall]) 
					rotate([0,-90,180]) 
						scale([1+2*clearanceFactor,
							1+clearanceFactor,
							1+0*clearanceFactor]) 
						flex();
				if (support) //for (xo=[-len/5:len/2.5:len/5]) {
					translate([0,-wristR-bandThick,0]) 
						cube([0.4,bandThick+2,width+2*r]); // loop
					//}
				}
			translate([-wristR*bandOpenRatio,0,-1]) 
				cube([2*wristR*bandOpenRatio, (wristR+bandThick),width+2*bandWall+2]);
			}
		}
		if (preview)
			translate([-len/2-flexTweakX,-wristR-flexTweakR,width/2+bandWall]) 
				rotate([0,-90,180])
					color("black") flex();

	}

module boxBottom() {
	margin = 3;
	bw = outerWidth + 2*margin;
	bl = wristLen+10 + 2*margin;
	wall = 1;

	difference() {
		translate([0,0,outerHeight/2-wall-margin]) cube([bl,bw,outerHeight],center=true);
		translate([0,0,outerHeight/2-margin]) cube([bl-2*wall,bw-2*wall,outerHeight-wall],center=true);
		if (part==0) rotate([90,0,0]) translate([0,0,9]) cube([wristLen+20,3*outerWidth,20],center=true);
		}
	}

module boxTop() {
	margin = 3;
	wall = 1;
	bw = outerWidth + 2*margin + 3*wall;
	bl = wristLen+10 + 2*margin + 3*wall;

	difference() {
		translate([0,0,outerHeight/2+wall+margin]) cube([bl,bw,outerHeight],center=true);
		translate([0,0,outerHeight/2+margin]) cube([bl-2*wall,bw-2*wall,outerHeight-wall],center=true);
		if (part==0) rotate([90,0,0]) translate([0,0,9]) cube([wristLen+20,3*outerWidth,20],center=true);
		}
	}

if ((part==0)||(part==1)) band();
if ((part==0)||(part==2)) boxBottom();
if ((part==0)||(part==3)) boxTop();
if (part==4) solidBand(0);
if (part==5) rotate([-90,0,0]) solidBand(1);

//male();
//female();

/// HINGE

// What diameter or thickness should the hinge have (in 0.01 mm units)?
//hinge_dia = 500; // [1:5000]

// How much gap should be left between separate parts (in 0.01 mm units)?
//hinge_gap = 40; // [1:2000]

module hingepair() {
	union() {
		cylinder(h=0.25, r=0.5);
		translate([0,0,0.25]) cylinder(h=0.25, r1=0.5, r2=0.25);
		translate([0,0,1]) cylinder(h=0.25, r1=0.25, r2=0.5);
		translate([0,0,1.25]) cylinder(h=0.25, r=0.5);
	}
}

module hingecore(gap) {
	union() {
		difference() {
			union() {
				cylinder(h=1.5, r=0.5);
				translate([-0.5,0,0.25+gap])
					cube(size=[1,1,1-gap-gap]);
				//translate([0,-0.5,0.25+gap])
				//	cube(size=[0.5,0.5,1-gap-gap]);
			}
			translate([0,0,0.25+gap-0.5]) cylinder(h=0.75, r1=1, r2=0.25);
			translate([0,0,1-gap]) cylinder(h=0.75, r1=0.25, r2=1);
		}
		translate([-0.5,0.5+gap,0])
			cube(size=[1,0.5-gap,1.5]);
	}
}

module hingeedge(gap) {
	union() {
		hingepair();
		translate([-0.5,-1,0])
			cube(size=[1,0.5-gap,1.5]);
		translate([-0.5,-1,0])
			cube(size=[1,1,0.25]);
		translate([-0.5,-1,1.25])
			cube(size=[1,1,0.25]);
		//translate([0,0,1.25])
		//	cube(size=[0.5,0.5,0.25]);
		//translate([0,0,0])
			//cube(size=[0.5,0.5,0.25]);
	}
}

module hinge(thick, realgap) {
	hingeedge(realgap / thick);
	hingecore(realgap / thick);
}

module demo(t, rg) { // modified to make only two hinges
	scale([t,t,t])
	translate([-2.75,0,0.5])
	rotate(a=[0,90,0])
	union() {
		//hinge(t, rg);
		translate([0,0,1.25]) hinge(t, rg);
		translate([0,0,2.5]) hinge(t, rg);
		//translate([0,0,3.75]) hinge(t, rg);
		//translate([-.5,1,1.25]) cube(size=[1,1,5.25/2+.1]);
		//translate([-0.5,-2,1.25]) cube(size=[1,1,5.25/2+.1]);
	}
}