// 2 Liter Bottle Holder
//
// (c) 2013 Laird Popkin, based on http://www.threadspecs.com/assets/Threadspecs/ISBT-PCO-1881-Finish-3784253-18.pdf.
// Credit to eagleapex for creating and then deleting http://www.thingiverse.com/thing:10489 
// which inspired me to create this.
//
// Respun to do http://www.thingiverse.com/thing:310961 parametrically.
//
// Screw onto jar until rim is tight against bead, and use as a mug.

// TO DO:
// - Add a label imprinted around the rim (your name, etc.)
// - Fit over bead (add bead measurement)
// = Add curve in so base of handle reaches jar? Adds another measurement

/* [Hidden] */

part="mug"; // "threads" for the part to print, "neck" for the part to subtract from your part
clearance=0.4; // tune to get the right 'fit' for your printer
jar = [[0,0,0,0],
	[25.07, 27.4, 2.7, 2, 15, 9],
	[70,70+.06*25,5,2,15,12],
	[86,86+.06*25,5,2,25,12]
	]; // 2 liter bottle

// http://en.wikipedia.org/wiki/Mason_jar

// regular mouth 2 3⁄8 in (60 mm) inner [2 3⁄4 in (70 mm) outer] diameter or 
// wide mouth 3 in (76 mm) inner [3 3⁄8 in (86 mm) outer] diameter

//standard narrow mouth canning jar:
//
//standard narrow mouth canning jar. It is 5tpi.
//The height of the 5 tpi thread is 0.060". The radius of the thread top is 0.044". The radius of the 
//base corner roots is 0.030" max. The sides of the threads are thirty degrees from vertical."

/* [Settings] */

// Pick jar size
jarNumber = 0; // [1:2 Liter bottle, 2:Narrow Canning, 3:Wide Canning, 0:Custom]
// Thickness of rim (mm)
rim = 5;
// Handle Length (mm)
handleLength = 75;
// Handle Thickness (mm)
handleThick = 20;
// Hand Space (between rim and handle)
handSpace = 25;

/* [Custom Jar] */

// Custom inner diameter (not including threads)
jarID = 70;
bottleID = jarNumber ? jar[jarNumber][0] : jarID;
echo(bottleID);
// Custom outer diameter (including threads)
jarOD=71.5;
bottleOD=jarNumber ? jar[jarNumber][1] : jarOD;
// Custom thread vertical spacing (mm)
jarPitch=5;
bottlePitch=jarNumber ? jar[jarNumber][2] : jarPitch;
// Custom angle of thread screws (degrees, 0 = level)
jarAngle=2;
bottleAngle=jarNumber ? jar[jarNumber][3] : jarAngle;
// Length of thread (mm)
jarThreadLen=15;
threadLen=jarNumber ? jar[jarNumber][4] : jarThreadLen;
// Height of rim around jar (mm) neasured from beat to top of mouth
rimHeight=12;
bottleHeight=jarNumber ? jar[jarNumber][5] : rimHeight;

echo(bottleID,bottleOD,bottlePitch,bottleAngle,threadLen,rimHeight);

/* [Holder] */


// holder params

holderOD=bottleOD+rim;
holderOR=holderOD/2;

/* [Hidden] */

// funnel params

funnelOD=100;
funnelWall=2;

// Bottle Computations

threadHeight = bottlePitch/3;
echo("thread height ",threadHeight);
echo("thread depth ",(bottleOD-bottleID)/2);

module bottleNeck() {
	difference() {
		union() {
			translate([0,0,-0.5]) cylinder(r=bottleOD/2+clearance,h=bottleHeight+1);
			}
		union() {
			rotate([0,bottleAngle,0]) translate([-threadLen/2,0,bottleHeight/2]) cube([threadLen,bottleOD,threadHeight]);
			rotate([0,bottleAngle,90]) translate([-threadLen/2,0,bottleHeight/2+bottlePitch/4]) cube([threadLen,bottleOD,threadHeight]);
			rotate([0,bottleAngle,-90]) translate([-threadLen/2,0,bottleHeight/2+bottlePitch*3/4]) cube([threadLen,bottleOD,threadHeight]);
			rotate([0,bottleAngle,180]) translate([-threadLen/2,0,bottleHeight/2+bottlePitch/2]) cube([threadLen,bottleOD,threadHeight]);
			translate([0,0,-bottlePitch]) {
				rotate([0,bottleAngle,0]) translate([-threadLen/2,0,bottleHeight/2]) cube([threadLen,bottleOD,threadHeight]);
				rotate([0,bottleAngle,90]) translate([-threadLen/2,0,bottleHeight/2+bottlePitch/4]) cube([threadLen,bottleOD,threadHeight]);
				rotate([0,bottleAngle,-90]) translate([-threadLen/2,0,bottleHeight/2+bottlePitch*3/4]) cube([threadLen,bottleOD,threadHeight]);
				rotate([0,bottleAngle,180]) translate([-threadLen/2,0,bottleHeight/2+bottlePitch/2]) cube([threadLen,bottleOD,threadHeight]);
				}
			//translate([0,0,bottleHeight/2+bottlePitch/2]) rotate([0,0,90]) cube([10,bottleOD,threadHeight], center=true);
			}
		}
	translate([0,0,-1]) cylinder(r=bottleID/2+clearance,h=bottleHeight+2);
	}

module bottleHolder() {
	difference() {
		cylinder(r=bottleOD/2+rim,h=bottleHeight);
		bottleNeck();
		}
	}

module bottleCap() {
	translate([0,0,1]) bottleHolder();
	cylinder(r=holderOR, h=1);
	}

module bottleMug() {
	bottleHolder();
	echo(bottleOD/2+rim+handSpace+handleThick);
	translate([bottleOD/2+rim+handSpace+handleThick/2,0,0]) scale([1,2*bottleHeight/handleThick,1]) cylinder(r=handleThick/2,h=handleLength);
	translate([bottleOD/2,0,0]) rotate([0,90,0]) difference() {
		cylinder(h=handSpace+rim+handleThick/2, r=bottleHeight);
		translate([0,-bottleHeight,0]) cube([bottleHeight,bottleHeight*2,handleLength]);
		}
	}

module funnel() {
	translate([0,0,bottleHeight]) difference() {
		difference() {
			cylinder(r=holderOR, h=funnelWall);
			translate([0,0,-.1]) cylinder(r=bottleID/2, h=funnelWall+.2);
			}
		}
	translate([0,0,bottleHeight+funnelWall]) difference() {
		cylinder(r1=holderOR,r2=funnelOD, h=funnelOD-bottleOD);
		translate([0,0,-.1]) cylinder(r1=bottleID/2,r2=funnelOD-funnelWall, h=funnelOD-bottleOD+.2);
		}
	bottleHolder();
	}

if (part=="threads") bottleHolder();;
if (part=="neck") bottleNeck();
if (part=="funnel") funnel();
if (part=="holder") bottleHolder();
if (part=="cap") bottleCap();
if (part=="mug") bottleMug();