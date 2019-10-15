/* [Measurements] */
// See Measurement Guide at:
// https://docs.google.com/a/popk.in/document/d/1LX3tBpio-6IsMMo3aaUdR-mLwWdv1jS4ooeEHb79JYo for details.
// The default values are the ones from the photo in that document.

// e-NABLE measurement 5, Wrist Joint distance from lateral to medial side
wrist = 35.97;
// Length of gauntlet, e.g. half distance from elbow to wrist.
len = 100;
// Distance between lateral and medial side of the middle forearm (end of gauntlet closest to elbow)
width = 46.35;
// height of side rail
rail = 10; 
// thickness of side rails
thick=5; 
// thickness of rest of gauntlet
thin=2; 
// thickness of padding
padding = 5;
// spacing of bars
spacing = 10;
// thickness of bars
bar=5;
// diameter of bolt for wrist pivot
bolt = 5;
// Length of slots
slotLen = 25;
// Height of slots
slotH = 2;

/* [hidden] */

pi=3.1415926;

wristX = (wrist+2*padding)*pi/2-rail/2;
wideX = (width+2*padding)*pi/2-rail/2;

diff = wideX-wristX;
angle = atan(diff/len);
echo(diff,angle);

echo(len, wristX, wideX);

difference() {
union() {
difference() {
	union() {
		hull() {
			translate([wristX,0]) cylinder(d=rail, h=thick);
			translate([wideX,-len]) cylinder(d=rail, h=thick);
			}
		hull() {
			translate([-wristX,0]) cylinder(d=rail, h=thick);
			translate([-wideX,-len]) cylinder(d=rail, h=thick);
			}
		scale([3,1,1])hull() {
			translate([0,-(wristX)]) cylinder(d=rail, h=thin);
			translate([0,-len]) cylinder(d=rail, h=thin);
			}
		difference() {
			hull() {
				translate([wristX,-bar]) cylinder(d=rail, h=thin);
				translate([wideX,-len]) cylinder(d=rail, h=thin);
				translate([-wristX,-bar]) cylinder(d=rail, h=thin);
				translate([-wideX,-len]) cylinder(d=rail, h=thin);
				}
			translate([0,0,-1]) cylinder(r=wristX-rail/2, h=thick+2);
			translate([0,0,-.5]) for (r=[wristX-rail/2+bar:spacing:len+3*spacing]) {
				core(r,bar,thin+1);
				}
			}
		}
	}

hull() {
	translate([-wideX,-len]) cylinder(d=rail, h=thin);
	translate([wideX,-len]) cylinder(d=rail, h=thin);
	}
}
	translate([wristX,0,-2]) cylinder(d=bolt, h=thick+4);
	translate([-wristX,0,-2]) cylinder(d=bolt, h=thick+4);
	translate([wideX,-len,-1]) rotate([0,0,angle]) cube([2,25,thick+2]);
	translate([-wideX-slotH,-len,-1]) rotate([0,0,-angle]) cube([2,25,thick+2]);
	translate([wideX-diff/3,-len*.67,-1]) rotate([0,0,angle]) cube([slotH,25,thick+2]);
	translate([-wideX+diff/3-slotH,-len*.67,-1]) rotate([0,0,-angle]) cube([slotH,25,thick+2]);
	translate([wideX-diff*.67,-len/3,-1]) rotate([0,0,angle]) cube([slotH,25,thick+2]);
	translate([-wideX+diff*.67-slotH,-len/3,-1]) rotate([0,0,-angle]) cube([slotH,25,thick+2]);

}


module core(r,t,h) {
	difference() {
		cylinder(r=r+t, h=h);
		translate([0,0,-1]) cylinder(r=r, h=h+1);
		}
	}