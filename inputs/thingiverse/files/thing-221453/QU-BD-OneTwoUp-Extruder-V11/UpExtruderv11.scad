// TwoUp Extruder model

/* todo:

- Add bumps/holes so two halves of parts mate together (done)
- make body more airtight to force more air to vent
- add second vent to fan (done)
- make hot end tighter (done)
- make spring shorter (done)
- move spring out slightly (done, added holder)
- move bearing away 0.5mm (done)

*/

$fn=32;
part = 0; //[0:Preview Assembled, 6:Body plated, 9:Lever plated, 10:Vent, 11:Fan vent]

/* [Spring] */

// Spring hole height (mm)
springH = 16;
// Spring hole radius (mm)
springR = 3;

/* [General] */

// lever length
ll=20;
// Lever back angle (to go around screw and meet bearing hub)
la = 10;
// box x
bx=57;
// box y
by=47.72;
// box z
bz=30.72;
// Wall thickness
wall = 5;
// Clearance
clearance = 0.4;

/* [Hot End] */

// hot end Z
hz=15.36-2;
hz=bz/2;
// Hot end X
hx = 27;
// Hot end y
hy=7;

/* [Motor] */

// motor X
mx = 21;
// motor y
my = 26.72;
// motor size (approx)
ms = by-5;
// middle width
midW = bz-2*wall-2*clearance;
// Screws X Y position
sx1 = 5.5+1;
sx2 = 37.5;
sy1 = 11.22;
sy2 = 42.22;
sr = 1.5; //M3 screws' radius

/* [Bearing] */

// Tension bearing inner diameter
bid = 9.525;
// Tension bearing outer diameter
bod = 15.875;
// Tension bearing width
bw = 3.967;
// Offset (to leave room for filament)
boff = 0.5;

bir=bid/2;
bor=bod/2;

/* [Vents] */

// Vent length
vh = 55;
// Vent into body
vin = 10;
// vent1 angle
va1 = -5;
// Vent Radius
vr = 6;
// Vent straight
vstraight=20;
// Wall thickness
vw = 2;
// Opening at bottom, width
vopenw = 7;
// Height
vopenh = 5;
// vent sphere for clearance
vhr = midW*.4;

// fan size
fs = 40;

module fan() {
	translate([bx+clearance, 5, fs]) rotate([0,90,0]) cube([fs,fs,10]);
	}

module fanScrews() {
	fso = 32/2;

	translate([bx+clearance-4, 5, fs]) rotate([0,90,0]) translate([fs/2,fs/2,0]) {
		for (x=[-fso,fso]) {
			for (y=[-fso,fso]) {
				translate([x,y,-7]) cylinder(r=sr,h=15+7);
				}
			}
		}
	}

// screw holes, enlarged so screw threads slide through
module screws () {
	//echo("screw x ",sx2-sx1);
	// echo("screw y ",sy2-sy1);
	h=bz+2+2;
	translate([0,0,-1]) {
	translate([sx1,sy1,0]) cylinder(r=sr+2*clearance, h=h);
	translate([sx2,sy1,0]) cylinder(r=sr+2*clearance, h=h);
	translate([sx1,sy2,0]) cylinder(r=sr+2*clearance, h=h);
	translate([sx2,sy2,0]) cylinder(r=sr+2*clearance, h=h);
	}
}

						cubeX = bx-2*mx-2*clearance;
						cubeY = fs-2-12;
						cubeZ = 2+fs-bz-clearance-2;

module fanVent() {
	difference() {
		union() {
			difference() {
				translate([ms+clearance,0,bz+clearance])
					translate([2.5,0,0]) difference() {
						union() {
							translate([0,-vstraight,0])
								cube([bx-ms-2*clearance-2,by+vstraight,fs-bz-clearance]);
							translate([-bx+bx-ms-2*clearance-2,0,0]) cube([bx,by,1]);
							}
						translate([1,1+11,-1])
							difference() {
								cube([cubeX,cubeY,cubeZ]);
								for (y=[cubeY/5:cubeY/5:cubeY-1])
									translate([0,y,0]) cube([cubeX,0.5,cubeZ]);
								}
						translate([-2.5-(ms+clearance),0,-(bz+clearance)]) screws();
						}
				ventHole2();
				fanScrews();
				}
			vent2();
			translate([ms+clearance,0,bz+clearance]) translate([-.73+bx-2*mx-2*clearance-1,1+11,2+fs-bz-clearance-3])
				cube([1,fs-2-12,vr*.1]);
			}
			// bisect for design
			//translate([0,-60,35]) cube([100,100,20]);
		}
	}

module fanVentPlated() {
	//rotate([0,180,0])
		translate([-(ms+clearance),0,vr*1.475-(bz+clearance)-(fs-bz-clearance)])
			fanVent();
}

// hole for hot end in body
module hotend() {
	hh=80; // how far to clear outside
	hin=12; // how far to clear inside
	gr=(16.5-2*1.25)/2; // groove radius
	gy = 7; // y position of groove center
	gh=2*1.25;
	hr = 7.94;

	translate([hx,hy+hin,hz]) rotate([90,0,0]) {
		difference() {
			cylinder(r=hr, h=hh+hin);
			translate([0,0,gy+hin-hy]) cylinder(r=hr+1,h=gh-clearance/2,center=true);
		}
		cylinder(r=gr, h=hh);
	}
}

module vent1() {
	difference() {
		rotate([0,0,va1]) translate([1+vr, vin, bz/2])
			difference() {
				vent(vh);
				//translate([vr,vr,0]) sphere(vhr);
				translate([vhr/2,vhr/2,0]) sphere(vhr);
				}
		hotend();
		}
	}

// the actual vent tube

module vent(vh) {
	vLen = 2*vr;
	difference() {
		rotate([90,0,0]) difference() {
			rotate([0,0,360/16]) {
			difference() {
				union() {
					translate([0,0,-3]) cylinder($fn=8, r=vr, h=vh+vin); // 60 mm to reach extruder, 10mm fit into extruder body
					//translate([0,0,vin]) cylinder($fn=8, r=vr+1, h=1); // 60 mm to reach extruder, 10mm fit into extruder body
					rotate([0,0,-360/16]) translate([vr,0,vh+vin-vopenh/2-1])
						rotate([0,-30,0]) cube([vLen,vopenw+2, vopenh+2], center = true);
					}
				translate([0,0,-4]) cylinder($fn=8, r=vr-vw, h=vh+vin); // 60 mm to reach extruder, 10mm fit into extruder body
				rotate([0,0,-360/16]) translate([vr,0,vh+vin-vopenh/2-1])
					rotate([0,-30,0]) cube([vLen+1,vopenw, vopenh], center = true);
				}
			}
			//translate([-(vr+0.04),0,vin]) cube([1,2*vr,3],center=true);
			}
		//hotend();
		}
	}


module vent2() {
	difference() {
		translate([(2*mx+bx)/2, vin/2-vstraight, bz+(fs-bz)/2+2-.7-1])
			difference() {
				rotate([0,0,-30]) rotate([0,360*2/8,0])
					translate([0,2,0]) vent(vh-vstraight+5);
				translate([-vh*.7,-vh,-vr+.46-10+1]) cube([vh,2*vh,10]);
				}
		hotend();
		}
	}

// hole in body to fit vent
module ventHole(){
	rotate([0,0,va1]) translate([1+vr, vin, bz/2]) rotate([90,0,0]) rotate([0,0,360/16]) {
		cylinder($fn=8, r=vr+clearance/2, h=20, center=true);
		translate([vhr/2,0,-vhr/2]) sphere(vhr);
	}
}

// hole in fan vent for vent
module ventHole2(){
	translate([0,-vstraight-3,-1]) translate([(2*mx+bx)/2+clearance, vin/2+1.1, bz+(fs-bz)/2+2+clearance-1.1]) {
		translate([0,2.5,0]) rotate([90,0,0]) rotate([0,-30,0]) rotate([0,0,360/16])
			translate([0,0,3]) cylinder($fn=8, r=vr-vw, h=14, center=true);
		translate([1.5,vstraight-3.3,0]) rotate([90,0,0]) rotate([0,0,0]) rotate([0,0,360/16])
			cylinder($fn=8, r=vr-vw, h=vstraight*1.3, center=true);
		}
	}

module ventPlate(){
	translate([bx+30,by+vin+13,1.54])
		translate([0,0,-bz/2+2*vr+.36]) rotate([0,-90,0])
			rotate([0,0,-va1]) vent1();
	}

module motorHole() {
	mz = bz+1;
	mh = bz+2;

	translate([mx,my,mz]) rotate([180,0,0]) {
		cylinder(r=16, h=mh);
		}
	}

module motor() {
	mz = bz+1;
	mh = bz+2;

	translate([mx,my,0]) {
		//rotate([180,0,0]) {
			translate([0,0,1]) cylinder(r=15, h=2);
			translate([0,0,1]) cylinder(r=6+2, h=bz-5);
			//}

		}
	translate([0,by-ms,-ms]) cube([ms,ms,ms]);
	}

module bearing() {
	echo("bearing", hx, bor, my, hz, bw, bir);
	translate([hx+bor+boff, my, hz])
	difference() {
		cylinder(r=bor,h=bw, center=true);
		cylinder(r=bir, h=bw+1, center=true);
		}
	}

module bearingHole() {
	echo("bearing hole ", hx, bor, my, hz, bw, bir, clearance);
	translate([hx+bor+boff, my, hz])
		difference() {
			cylinder(r=bor+2*clearance,h=bw+4*clearance, center=true);
			cylinder(r=bir-clearance, h=bw+4*clearance+1, center=true);
			}
	}

module bearingHub() {
	hubGuide = 3.8;
	hgOffset = 2.5;
	translate([hx+bor+boff, my, bz/2])
		cylinder(r=bir-clearance, h=midW-2*clearance, center=true);
	difference() {
		union() {
			translate([hx+bor+boff, my, hz]) {
				translate([0,0,bw/2+(bor-bir)/2]) {
					cylinder(r1=(bir+bor)/2, r2=bir-clearance, h=(bor-bir), center=true);
					translate([0,0,hgOffset])
						cylinder(r1=(bir+bor)/2+hubGuide, r2=bir-clearance, h=(bor-bir)+hubGuide, center=true);
					}
				translate([0,0,-(bw/2+(bor-bir)/2)]) {
					cylinder(r2=(bir+bor)/2, r1=bir-clearance, h=(bor-bir), center=true);
					translate([0,0,-hgOffset])
						cylinder(r2=(bir+bor)/2+hubGuide, r1=bir-clearance, h=(bor-bir)+hubGuide, center=true);
					}
				}
			}
		motor();
		}
	}

module lever(showBearing=0) {
	swing=5;

	difference() {
		union() {
			// slanted/vertical pivot
			translate([hx+bor+2.5, my+by/4, bz/2])
				rotate([0,0,-13]) cube([bor,by/2,midW-2*clearance], center=true);
			//top/lever arm
			translate([-ll,by-2*wall,wall+2*clearance])
				cube([bx*.7+ll, 3*wall, midW-2*clearance]);
			// stick down to cover open area
			translate([wall*2.5+2*clearance,by-2.5*wall,bz/2])
				cube([wall,2*wall,midW-2*clearance],center=true);
			}
		translate([-ll,by-.1+wall,wall+clearance-1])
			cube([bx+ll, 2*wall, midW+2]);
		bearingHole();
		translate([sx1,sy2,-1]) cylinder(r=sr+2*clearance, h=bz+2);
		translate([sx1,sy2+swing,-1]) cylinder(r=sr+2*clearance, h=bz+2);
		translate([sx1-sr-2*clearance,sy2,-1])
			cube([2*(sr+2*clearance),swing,bz+2]);
		filamentHole();
		screws();
		springHole();
		}
	bearingHub();
	//translate([0,by-wall,wall+clearance]) cube([bx*.7, wall, midW]);
	if (showBearing) color("yellow") bearing();
	}

// lever rotated to allow filament to enter
module rotLever(showBearing=0) {
	translate([sx2, sy2, 0]) rotate([0,0,la]) translate([-sx2, -sy2, 0]) lever(showBearing);
	}

// hole into which lever fits
module leverHole() {
	echo("lever hole ", hx, bor, my, hz, bx, by, midW);
	translate([mx, sy1+0.5, wall+clearance])
		cube([bx-15,(by+5)/2,midW]);
	translate([2-ll,by-2*wall-clearance,wall+clearance])
		cube([bx*.7+clearance+2+ll, 2*wall+2*clearance, midW]);
	translate([sx2, sy2, 0]) rotate([0,0,la]) translate([-sx2, -sy2, 0])
		translate([-11,by-2*wall-clearance,wall+clearance])
			cube([bx*.7+clearance+2+11, 2*wall+10, midW]);
	}

module box() {
	cube([bx,by,bz]);
	}

module spring() {
	translate([4, by/2+wall+.5,bz/2]) rotate([-90,0,0])
		cylinder(r=springR-clearance, h=18-2*clearance, center = true);
	}

module springHole() {
	translate([4, by/2+wall+2.5,bz/2]) rotate([-90,0,0])
		cylinder(r=springR, h=springH, center = true);
	}

module springHolder() {
	translate([4, by/2+wall,bz/2]) rotate([-90,0,0])
		cylinder(r=3+wall/2, h=springH+2+2, center = true);
	}

module holes() {
	screws();
	fanScrews();
	hotend();
	difference() {
		motorHole();
		springHolder();
		}
	filamentHole();
	leverHole();
	springHole();
	ventHole();
	ventHole2();
	}

module filament () {
	translate([hx,hy,hz]) rotate([90,0,0]) cylinder(r=1.75/2,h=2*by,center=true);
	}

module filamentHole() {
	translate([hx,hy,hz]) rotate([90,0,0]) cylinder(r=1.75/2+2,h=2*by,center=true);
	}

module assembled(tilt=0) {
	//color("yellow") translate([0,0,clearance]) LBackHanging();
	//color("orange") LFrontHanging();
	//color("green") BFrontHanging();
	//translate([0,0,clearance]) Bback();
	extruderBody();
	//%motor();
	color("red") filament();
	color("grey") screws();
	color("grey") spring();
	//%fan();
	if (tilt==1) rotLever(1);
	if (tilt==0) lever(1);
	vent1();
	//http://www.fabric8r.com/forums/showthread.php?1323-Replacement-extruder/page10
	//color("blue") vent2(); // merged into fanVent
	fanVent();
	color("black") hotend();
	}

module extruderBody() {
	difference() {
		box();
		holes();
		}
	}

module backShape() {
	splitZ = hz;
	translate([-bx/2,-1,-1]) cube([bx*2,by+2,splitZ+1]);
	for (x=[sx1,sx2]) {
		for (y=[sy1,sy2]) {
			//translate([x,y,splitZ]) cylinder(r=3,h=2, center=true);
			}
		}
	translate([(sx1+sx2)/2,sy2,hz]) rotate([0,90,0])
		cylinder(r=1.5, h=1.5*bx, $fn=8, center=true);
	translate([(sx1+sx2)/2,sy1/2,hz]) rotate([0,90,0])
		cylinder(r=1.5, h=1.5*bx, $fn=8, center=true);
	translate([sx2,by/2,hz]) rotate([0,90,90])
		cylinder(r=1.5, h=by+2, $fn=8, center=true);
	translate([bx-wall,sy2,hz]) rotate([0,90,90])
		cylinder(r=1.5, h=2*by, $fn=8, center=true);
	}

module Bback() {
	intersection() {
		extruderBody();
		backShape();
		}
	}

module Bfront() {
	translate([0,by,bz]) rotate([180,0,0]) BFrontHanging();
	}

module BFrontHanging() {
	difference() {
		extruderBody();
		backShape();
		}
	}

module Bplate() {
	Bfront();
	translate([0,by+5,0]) Bback();
	}

module Lback() {
	translate([0,0,-wall-clearance]) LBackHanging();
	}

module LBackHanging() {
	intersection() {
		lever();
		backShape();
		}
	}

module Lfront() {
	translate([0,by,bz-wall-clearance-clearance]) rotate([180,0,0])
		LFrontHanging();
	}

module LFrontHanging() {
	difference() {
		lever();
		backShape();
		}
	}

module Lplate() {
	Lfront();
	translate([0,by+5,-clearance]) Lback();
	}

module allPlated() {
	Bplate();
	translate([bx+30,0,0]) Lplate();
	translate([145,-10,0]) rotate([0,0,90]) ventPlate();
	translate([bx+vr*12-17,by-3,vr-1.6]) rotate([0,0,90]) fanVentPlated();
	}

if (part==0) assembled(0); // no tilt
if (part==1) assembled(1); // tilt
if (part==2) extruderBody();
if (part==3) lever();
if (part==4) Bback();
if (part==5) Bfront();
if (part==6) Bplate();
if (part==7) Lback();
if (part==8) Lfront();
if (part==9) Lplate();
if (part==10) ventPlate();
if (part==11) fanVentPlated();
if (part==12) allPlated();
if (part==13) {
	//extruderBody();
	lever();
	%motor();
	}
