/* [Spool Collet] */

lip_extention = 5;//[5:120]
spindle_depth =10;//
spindle_diameter = 32;
lip_height = 2;

/* [Hidden] */
//Awesaversal  Spool Gear Bearing Collet by funkshin (customizable)
//Derived from thingiverse things:
//53451	Gear Bearing by emmet
//72069	1kg Spool Holder with Gear Bearing by daprice
// Tolerance Padding
TP = .5;
// Padding
Pa = .1;
//  Track Padding Insurance
N = 2;
// Inner Diameter (must mate with master gearbearing OD)
rD = 28 + TP ;
// Thickness of the collet wall
CW = N + 1.7 - 32 + spindle_diameter;
// Lip Diameter
LD = rD + CW;
// Aliases
LH = lip_height;
LE = lip_extention;
SD = spindle_depth + LH;


module collet($fn= 70){
	difference() {
	union() {
	cylinder(r=LD/2, h=SD);
	cylinder(r=LD/2+LE, LH);
			}
		translate([0,0,-Pa/2]){
		cylinder(r=rD/2, SD+Pa*2);
		dimples();
		trackend();
		track();
		}
	}
}

module dimples($fn=30){
		for (i = [0:5]) {
		translate([sin(360*i/6)*rD/2, cos(360*i/6)*rD/2, 7.1])

sphere(r = 1);
	}
}


module trackend($fn=30){
		for (i = [0:5]) {
		translate([sin(360*i/6)*rD/2, cos(360*i/6)*rD/2, 5.3])

sphere(r = 1);
	}
}

module track($fn=30){
		
		for (i = [0:5]) {
		translate([sin(360*i/6)*rD/2, cos(360*i/6)*rD/2 ])
cylinder(h = 5.3,r=1);
		}
}
collet();	
