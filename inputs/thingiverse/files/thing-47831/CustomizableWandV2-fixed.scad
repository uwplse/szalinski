// threaded wand with light
//
// rod is threaded both on the inside and the outside.
//
// There are three kinds of rod segments:
//
// Top = has a ball, and socket at bottom.
// Mid = has screw at top, socket at bottom.
// Bottom = has screw on top, tapered at the bottom.

// Parts (theoretical):
//
// 120 mm long wire, ends stripped
// LED (3v, e.g. http://www.hebeiltd.com.cn/?p=leds.9.10mm)
// 2 AAA batteries
// solder, soldering gun
// heat shrink tubing (or tape)
// ~10mm diameter spring, or metal strip folded in 'u',

// Assembly instructions (theoretical):
//
// Solder one LED lead to center of 15 mm disk (top of AA) so
// that the LED sticks up straight from the center of the disk.
// Solder wire to other LED lead, shrink wrap to avoid shorts.
// Slide LED assembly into rod, so that disk stops at top of
// battery compartment and LED is within the sphere, with wire
// trailing out of rod.

// Solder other end of wire to the spring.

// Insert AAA batteries into rod, so that + end of battery presses
// against disk, and press the spring against the - end.
//
// If the LED does not light, check your connections.
//
// If it worked when contact is made by hand, verify that it works
// when you screw another rod segment into the bottom of the top
// rod segment. The LED should light when the lower rod segment is
// screwed in tightly, and should go out when it is loosened
// or removed. The spring should go around the point of the lower
// rod's screw.

// Set various parameters below to suit your LED and switch sizes.
// Assumes AA battery. You could use a smaller battery, but
// there is plenty of room for an AA battery.

// set to 1 to leave space for battery and an LED, and to make the ball hollow.

//battery=0;	//battery turned out to be a bad idea


// parameters that control appearance of wand

// Part to print
part=6; //[1:Wand top, 2:Wand middle, 3:Wand bottom, 4:Plate top & bottom, 5:Plate 4x middle, 6:Short stack preview, 7:Long stack preview, 8:Long row]
// Height of each rod segment (your printer's vertical print area)
h=125;
// Wand radius (not counting wiggle)
cr=20;
// Wiggle (2 is subtle, 10 is dramatic)
w=5;
// number of wiggles per rod segment
nw=5;
// Spirals or counter-spirals (forming cross shapes)
c = 0;		// [0:Spirals, 1:Counter-spirals
// sphere bigger than wand by this much
sb = 5;
// Sphere vertical stretch (1=round, 1.25=egg, 2=oblong
bs = 1.5;
// Roundness (more takes longer to render)
fn=24; // [6:Chunky, 12:Medium, 24:Smooth, 64:Super-fine]
// Clearance between screw and hole. If it's too tight, increase it. Should be loose, as screw will tighten.
gap = 0.4;

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

/* [Hidden] */

half = (part>5)?1:0;

thin = 0.5;	// thickness of sphere, to make it translucent.

// override to make things a bit smaller

//w=3;
//cr=15;
//nw=5;
//sb=5;
//bs=2;

// and even smaller

//w=2;
//cr=10;
//nw=10;
//sb=5;
//bs=1;

// parameters that related to LED and battery, etc.

batteryr = 10.5/2+2*gap;	// radius of AAA battery hole
batteryh = (2*44.5)+4+gap; // len of 2 AAA batteries, plus disk, clip
ledr = 4*1; // radius of hole for LED, should be bigger than LED,
				// but smaller than the batter or disk
ledh = 1*1; // height of LED hole
wirer = 2*1; // radius of slot for wire
switchr = 5*1; // radius of switch hole, should be sized to allow
				// switch to screw into hole.

// the core of each rod segment

module core() {
	linear_extrude(height = h, center = false, convexity = 10, twist = nw*360)
		translate([w, 0, 0]) circle(r = cr, $fn=fn);
	if (c > 0) {
		linear_extrude(height = h, center = false, convexity = 10, twist = -nw*360) translate([w, 0, 0]) circle(r = cr);
		}
	if (c==2) {
		rotate([0,0,180]) {
			linear_extrude(height = h, center = false, convexity = 10, twist = nw*360)
				translate([w, 0, 0]) circle(r = cr);
			linear_extrude(height = h, center = false, convexity = 10, twist = -nw*360)
				translate([w, 0, 0]) circle(r = cr);
			}
		}
	}

// the top rod segment, which has a sphere at the top, and
// a screw hole in the bottom, room for batteries and LED.

ballr = cr+w+sb;
echo("ball radius = ", ballr);

module core_hole() {
	translate([0,0,-g]) outer(); // screw hole in other end

	// the rest should be ignored (or fixed). So battery = 0 above so this is skipped.
	if (battery) {
		difference() {
			translate([0,0,h-(bs-1)*ballr])
				scale([1,1,bs])
					difference() {
						sphere(r=ballr-thin, $fa=5); // hollow in head
						rotate([90,0,0]) circle(r=ballr, h=thin); // minus supports
						rotate([90,0,60]) circle(r=ballr, h=thin);
						rotate([90,0,-60]) circle(r=ballr, h=thin);
						}
			//translate([0,0,h]) sphere(r=ballr-thin, $fa=5); // make sphere hollow
			cylinder(r=batteryr+wirer+th, h=ih+batteryh+wirer+th);
			// cylinder around battery shaft in case it goes into ball
			}
		cylinder(r=batteryr, h=batteryh+ih, $fn=64); // hollow inside for battery
		#translate([0,0,ih]) cylinder(r=batteryr, h=batteryh, $fn=64); // hollow inside for battery
		translate([0,batteryr,0]) cylinder(r=wirer,h=batteryh+ih+wirer);
		//translate([0,0,ih+batteryh+th]) cylinder(r=batteryr+wirer, h=h-ih-batteryh-ledh-ballr); // hole for wires
		translate([0,0,batteryh+ih]) rotate([0,90,90]) cylinder(r=wirer, h=wirer+batteryr); // hole for switch
		cylinder(r=ledr, h=h+(ballr-1)*bs/2); // hole from battery to sphere
		}
	}

module top() {
	/*translate([0,0,h]) rotate([0,180,0])*/ difference() {
		union() {
			core();
			translate([0,0,h-(bs-1)*ballr])
				scale([1,1,bs])
					sphere(r=ballr, $fa=5); // cap top
			}
		core_hole();
		if (battery) {
			echo("battery height = ",h-ih);
			}
		}
	}

// middle rod segments have screws on top, and holes on the bottom

module mid() {
	difference() {
		union() {
			core();
			translate([0,0,h-g]) inner(); // screw on top end
			}
		translate([0,0,-g]) outer(); // screw hole in bottom end
		}
	}

// the bottom rod segment has a screw on top, and tapered bottom.

bh = 2*((cr+w)-(cr/2));

module bottom() {
	intersection() {
		core();
		union() {
			cylinder(r1=cr*0.7, r2=cr+w, h=bh);
			translate([0,0,bh]) cylinder(r=cr+w, h=h-bh);
			}
		}
	translate([0,0,h-g]) inner(); // screw in top end
	}

//ih = 32;	// height of the inner threaded screw
//iw=5;		// number of 'wiggles' in the height of the screw
th=1;
ir = cr-w-3*th;	// radius of thread
ih=max(2*ir, 20);
iw=ih/5;		// thread every 5 mm
echo ("ir = ",ir);

// draw the screw shape. Note the conical top, allowing it to
// fill holes that canprint without support (I hope). And it
// should make it easier to put the screws into the holes.

module inner() {
	intersection() {
		linear_extrude(height=ih, center=false, convexity=10, twist=-iw*360)
			translate([1,0,0]) circle(r=ir);
		cylinder(r1=ih, r2=0, h=ih);
		}
	}

// Shape of the hole into which the screw screws. It's identical
// to the inner shape, plus the gap added to the radius and height.

module outer() {
	intersection() {
		linear_extrude(height=ih, center=false, convexity=10, twist=-iw*360)
			translate([1,0,0]) circle(r=ir+gap);
		cylinder(r1=ih+gap, r2=gap, h=ih+gap);
		}
	}

g=0.05*1;		//tiny number, added to keep faces from aligning
				//precisely, which upsets OpenSCAD when it happens.
spacing=2*(cr+w+th+sb);	//spacing between plated rod segments.

// draw the rods next to each other for printing on a single plate.
// For TOM, it might be better to pack them more tightly, or the
// rod will be rather small.

module plated2() {
	translate([0,0,0]) bottom();
//	translate([0,0,0]) mid();
//	translate([0,0,0]) mid();
	translate([0,spacing,0]) top();
	}

module plated4() {
	translate([-spacing,spacing,0]) bottom();
	translate([-spacing,0,0]) mid();
	translate([0,0,0]) mid();
	translate([0,spacing,0]) top();
	}

vspacing = h+gap+ih+10;	// vertical spacing for 'exloded' view

// Draw the top and bottom rod segments stacked vertically,
// 'exploded' so you can see how they are assembled.

module short_stacked() {	// view lined up for perspective
	translate([0,0,vspacing]) top();
	bottom();
	}

// draw a long stack of rod pieces so you can see how they will
// look assembled.

module long_stacked() {	// view lined up for perspective
	translate([0,0,3*h]) top();
	translate([0,0,2*h]) mid();
	translate([0,0,h]) mid();
	bottom();
	}

module long_row() {	// view lined up for perspective
	translate([0,2*spacing,0]) top();
	translate([0,spacing,0]) mid();
	translate([0,0,0]) mid();
	translate([0,-1*spacing,0]) bottom();
	}
// set shape to control what you render/print.

difference() {
union() {
if (part==1) top();
if (part==2) mid();
if (part==3) bottom();
//translate([spacing,0,0]) core_hole();
if (part==4) translate([0,-spacing/2,0]) plated2();
if (part==5) translate([spacing/2,-spacing/2,0]) plated4();
if (part==6) short_stacked();
if (part==7) long_stacked();
if (part==8) long_row();
}
if (half==1) translate([0,-200,-1]) cube([100,400,600]);
}

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
