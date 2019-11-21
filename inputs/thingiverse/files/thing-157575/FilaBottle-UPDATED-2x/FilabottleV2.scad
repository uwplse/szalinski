// FilaBottle System
//
// (c) 2013 Laird Popkin.
//
// System for using 2 Liter bottles with the FilaStruder.
//
// FilaFunnel that screws onto a 2 Liter bottle, for pouring plastic pellets into a 2 Liter bottle.
//
// FilAdapter that screws onto a 2 Liter bottle, that fits into the Filastruder hopper.

/* [General] */

part="both"; // [funnel,cap,fila,angle,comb,both,both-s]

half=0;	// 1=show cross section

clearance=0.4; // tune to get the right 'fit' for your printer

/* [Tweaks] */

$fn=64;

// Bottle params

bottleID=25.07;
bottleIR=bottleID/2;
bottleOD=27.4;
bottlePitch=2.7;
bottleHeight=9;
bottleAngle=2;
threadLen=15;
bottleNeckID = 21.74;

// holder params

holderOD=bottleOD+5;
holderOR=holderOD/2;

// funnel params

funnelOD=100;
funnelOR=funnelOD/2;
funnelWall=2;
funnelIR=bottleNeckID/2;
funnelRim = 5;

// Filastruder hopper params

filaX = 20;
filaY = 39;
filaDepth = 40;
filaHoleD = filaX-4;
filaHoleR = filaHoleD/2;
filaGap = bottleIR-filaHoleR;

// hole for plug

otherD = 3; // Diameter of plug
otherR = otherD/2;


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
		cylinder(r=holderOR,h=bottleHeight);
		bottleNeck();
		}
	}

module funnel() {
	translate([0,0,bottleHeight]) difference() {
		difference() {
			cylinder(r=holderOR, h=funnelWall);
			translate([0,0,-.1]) cylinder(r=funnelIR, h=funnelWall+.2);
			}
		}
	translate([0,0,bottleHeight+funnelWall]) difference() {
		cylinder(r1=holderOR,r2=funnelOR, h=funnelOR-bottleOD/2);
		translate([0,0,-.1]) cylinder(r1=funnelIR,r2=funnelOR-funnelWall, h=funnelOR-bottleOD/2+.2);
		}
	translate([0,0,bottleHeight+funnelOR-bottleOD/2]) difference() {
		difference() {
			cylinder(r=funnelOR, h=funnelRim);
			translate([0,0,-.1]) cylinder(r=funnelOR-funnelRim, h=funnelRim+.2);
			}
		}
	bottleHolder();
	}

module FilaBottle() {
	difference() {
		union() {
			translate([0,0,filaDepth+filaGap]) bottleHolder();
			translate([-filaX/2,-filaY/2,0]) cube([filaX,filaY,filaDepth+filaGap]);
			translate([0,0,filaDepth]) cylinder(r1=filaX/2,r2=holderOR, h=filaGap);
			}
		translate([0,-8,12]) rotate([-20,0,0]) filaCombHole();
		//translate([0,-8,12]) rotate([-20,0,0]) for (x=[-filaX/2:filaX/4:filaX/2]) {
		//	translate([x-otherR,-2-otherR,7]) rotate([-hAngle,0,0]) cube([otherD,otherD,holderZ+20]);
		//	}	//translate([0,0,filaDepth]) difference() {
		if (half) translate([1,-50,-1]) cube([120,120,120]);
		translate([0,0,-1]) cylinder(r=filaHoleR, h=filaDepth+2);
		translate([0,0,filaDepth]) translate([0,0,-.1]) cylinder(r1=filaHoleR,r2=bottleIR, h=filaGap+.2);
		echo("fila funnel ",funnelIR);
		}
	//	cylinder(r1=filaX/2,r2=holderOR, h=filaGap);
	//	translate([0,0,-.1]) cylinder(r1=filaHoleR,r2=bottleIR, h=filaGap+.2);
	//	}
	}

holderZ = filaDepth+filaGap+7;
holderY = -13;
thin = 0.5;
wide=10;
wideR=7;

hAngle=22;
hOffset=14;
hGap = 0.4;
hHandle = 10;

module FilaAngledBottle() {
	difference() {
		union() {
			translate([-filaX/2,-filaY/2,0]) cube([filaX,filaY,filaDepth+filaGap]);
			translate([0,holderY,holderZ]) rotate([45,0,0]) cylinder(r1=filaX/2,r2=holderOR, h=filaGap);
			translate([0,hOffset,-13]) rotate([hAngle,0,0]) cylinder(r=filaHoleR+2, h=holderZ+26);
			for (x=[-filaX/4:filaX/4:filaX/4]) {
				translate([x,-filaY/2,filaDepth+filaGap-wideR]) rotate([45,0,0]) cube([thin,wide,wide]);
				}
			}
		translate([0,hOffset,-13]) rotate([hAngle,0,0]) cylinder(r=filaHoleR, h=holderZ+26);
		filaCombHole();
		translate([0,holderY,holderZ]) rotate([45,0,0]) translate([0,0,-.1]) cylinder(r1=filaHoleR,r2=bottleIR, h=filaGap+.2);
		echo("fila funnel ",funnelIR);
		translate([0,holderY,holderZ]) rotate([45,0,0]) translate([0,0,filaGap]) cylinder(r=bottleIR,h=bottleHeight);
		translate([-20,-20,-20]) cube([40,50,20]);
		if (half) translate([1,-50,-1]) cube([120,120,120]);
		}
	translate([0,holderY,holderZ]) rotate([45,0,0]) translate([0,0,filaGap]) bottleHolder();
	}

module filaComb() {
	for (x=[-filaX/4:filaX/4:filaX/4]) {
			translate([x-otherR+hGap,-2-otherR+hGap,7+hGap]) rotate([-hAngle,0,0]) translate([0,0,abs(x)]) cube([otherD-hGap*2,otherD-hGap*2,holderZ-abs(x)]);
		}
	translate([-filaX/2,-2-otherR+hGap,7+hGap]) rotate([-hAngle,0,0]) translate([0,0,holderZ-hHandle])cube([filaX,otherD-hGap*2,hHandle]);
	}

module filaCombHole() {
	for (x=[-filaX/2:filaX/4:filaX/2]) {
			translate([x-otherR,-2-otherR,7]) rotate([-hAngle,0,0]) translate([0,0,abs(x)]) cube([otherD,otherD,holderZ-abs(x)]);
		}
	}

module filaCap() {
	bottleHolder();
	translate([0,0,bottleHeight]) cylinder(r=holderOR,h=thin);
	}

if (part=="threads") bottleHolder();
if (part=="neck") bottleNeck();
if (part=="funnel") funnel();
if (part=="cap") filaCap();
if (part=="fila") FilaBottle();
if (part=="angle") rotate([-90,0,0]) FilaAngledBottle();
if (part=="comb") rotate([-90,0,0]) filaComb();
if (part=="both") rotate([-90,0,0]) { FilaAngledBottle(); filaComb(); }
if (part=="both-s") { FilaBottle(); translate([0,-8,12]) rotate([-20,0,0]) filaComb(); }
