// Parametric Snowflake Ornaments
// (c) 2013 Laird Popkin

// Randomly generate snowflakes. The basic approach is to draw six
// radial arms out from the center, then recursively draw arms out from 
// the ands of the first arms, and so on. For a random number of
// layers of recursion. Also, randomly draw hexagons.

// Arrays of parameters. Foo[0] is center, [1] is first layer out, [2] is
// second layer, etc.

// For a good time, use seed = rands(0,1000000,1)[0];

use <write/Write.scad>
use <utils/build_plate.scad>

/* [Snowflake] */
// Snowflake Number. It can be any number up to 99999999! Try your birthdate (DDMMYYYY), postal code or phone number.
seed=1;

// What part do you want to see? Preview assembled, and Plate to adjust layout
part="SnowflakeOrnament"; //[Preview:Preview assembled snowball, Plate:Plate for printing, Snowball1:Snowball part 1, Snowball2:Snowball part 2, Snowball3:Snowball part 3, Snowflake:Snowflake, SnowflakeOrnament:Snowflake Ornament]

// Litho:Lithophane of snowflake removed to speed rendering of snowflakes and snowballs

/* [Tweaks] */
// adjust spacing between snowflakes on build plate. Negative makes them closer, positive makes them further apart (mm).
adjust=0;

// Set to trim the ends of the guides by this much (mm) if they are too long. 0 to not trim.
trim=0;

// inner radius of ring (mm)
ring=10;

// clip thickness (mm)
clip=2;

// thinnest thickness (mm). 0.4 allows single lines, 1.0 is double, larger is filled.
minthickness = 1;

// Scale to fit on build plate, if needed. Does not scale thickness. Normally leave at 1.0.
scale=1.0;

// clearance. If the pieces are too hard to slide together, make this larger.
g=0.2;

// Layer height, used for Lithophane for the thinnest part
layer=0.3;

/* [Build Plate] */
//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

/* [Hidden] */
scaleh=0.8;						// each layer is 80% previous layer height
height0=2;						// height of center of snowflake in mm
a=60; // angle of bevels
seeds=rands(0,1000000,7,seed);
//echo(str("Seeds ",seeds));
height=[height0,height0*scaleh,height0*pow(scaleh,2), height0*pow(scaleh,3), height0*pow(scaleh,4), height0*pow(scaleh,5), height0*pow(scaleh,6)];
//echo("height ",height);
hex = rands(0,1,6,seeds[0]);			// Should this layer have hexagons? >0.5 = yes.
hhex = rands(0,1,6,seeds[1]);			// Should this layer have hexagons? >0.5 = yes.
hsolid = rands(0,1,6,seeds[2]);			// Should this layer have hexagons? >0.5 = yes.
//echo("hhex ",hhex);
length = rands(5,20,6,seeds[3]);		// length of lines for this layer
width = rands(.5,3,6,seeds[4]);		// width of lines for this layer
angle = rands(60,120,6,seeds[5]);	// angle for arms for next layer
depth = rands(1,4,1,,seeds[6])[0];	// number of layers to draw.
//echo("depth ",depth);
sides = rands(0,4,6,seeds[0]+1);			// number of sides for 'hexagons' for this layer
hthick = rands(0,2,6,seeds[1]+1);			// extra thickness of 'hexagons' for this layer

echo("sides ",sides);

//echo("length ",length);
//echo(depth);

labelString=str( floor(seed/10000000)%10, floor(seed/1000000)%10, floor(seed/100000)%10, floor(seed/10000)%10, floor(seed/1000)%10, floor(seed/100)%10, floor(seed/10)%10, floor(seed/1)%10);

echo(str("*** Snowflake ",labelString));

// size of ornament, used to position clips, space on place, etc.
max=(length[1]+length[2]+length[3]+length[4])*(depth+1)/4;
//echo(max);

//part="Snowball3";
//part="SnowflakeOrnament";

if (part=="Preview") scale([scale,scale,1]) snowball(0);
if (part=="Preview1") scale([scale,scale,1]) snowball(1);
if (part=="Preview2") scale([scale,scale,1]) snowball(2);
if (part=="Preview3") scale([scale,scale,1]) snowball(3);
if (part=="Preview4") scale([scale,scale,1]) snowball(4);
if (part=="Plate") scale([scale,scale,1]) snowplate();
if (part=="Snowball1") scale([scale,scale,1]) rotate([0,0,90]) snowflake(1);
if (part=="Snowball2") scale([scale,scale,1]) rotate([0,0,90]) snowflake(2);
if (part=="Snowball3") scale([scale,scale,1]) rotate([0,0,90]) snowflake(3);
if (part=="Snowflake") scale([scale,scale,1]) rotate([0,0,90]) snowflake(0);
if (part=="SnowflakeOrnament") scale([scale,scale,1]) rotate([0,0,90]) snowflake(4);
if (part=="Litho") scale([scale,scale,1]) rotate([0,0,180]) litho();

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

/* Functions */

module label(s,z) {
	translate([0,z,0]) {
		translate([0,0,.5]) write(s,center=true,h=10);
		translate([0,0,.35]) cube([60,1,.7],center=true);
		translate([0,-4,.35]) cube([60,1,.7],center=true);
		translate([0,4,.35]) cube([60,1,.7],center=true);
		}
	}

// draw snowflake ornament being assembled. Steps are:
//
// 0 = complete
// 1 = first two start
// 2 = first two complete
// 3 = third start

module snowball(step) {
	translate([0,0,max+ring]) rotate([0,-90,90]) {
		if (step==0) {
			translate([0,0,-height[1]/2]) snowflake(1);
			rotate([a,0,0]) translate([0,0,-height[1]/2]) snowflake(2);
			rotate([-a,0,0]) translate([0,0,-height[1]/2]) snowflake(3);
			}
		if (step==1) {
			translate([0,0,-height[1]/2]) snowflake(1);
			color("blue") translate([30,0,0]) rotate([a,0,0]) translate([0,0,-height[1]/2]) snowflake(2);
			//rotate([-a,0,0]) translate([0,0,-height[1]/2]) snowflake(3);
			}
		if (step==2) {
			translate([0,0,-height[1]/2]) snowflake(1);
			color("blue") rotate([a,0,0]) translate([0,0,-height[1]/2]) snowflake(2);
			//rotate([-a,0,0]) translate([0,0,-height[1]/2]) snowflake(3);
			}
		if (step==3) {
			translate([0,0,-height[1]/2]) snowflake(1);
			rotate([a,0,0]) translate([0,0,-height[1]/2]) snowflake(2);
			color("blue") translate([30,0,0]) rotate([-a,0,0]) translate([0,0,-height[1]/2]) snowflake(3);
			}
		if (step==4) {
			translate([0,0,-height[1]/2]) snowflake(1);
			rotate([a,0,0]) translate([0,0,-height[1]/2]) snowflake(2);
			color("blue") rotate([-a,0,0]) translate([0,0,-height[1]/2]) snowflake(3);
			}
		}
	}

module snowplate() {
	translate([-2*max-adjust,0,0]) rotate([0,0,90]) snowflake(1);
	translate([0,0,0]) rotate([0,0,90]) snowflake(2);
	translate([2*max+adjust,0,0]) rotate([0,0,90]) snowflake(3);
	}

module litho() {
	translate([0,0,height[1]+layer]) rotate([180,0,0]) difference() {
		translate([0,0,.1]) cylinder(r=max+ring+10,h=height[1]+layer-.1, $fn=6);
		//translate([-max-ring,-max-ring,0]) cube([2*(max+ring),2*(max+ring),height[1]]);;
		translate([0,0,0]) snowflake();
		translate([0,-max,.1]) write(labelString,center=true,h=10);
		//translate([-max-ring,0,-5]) cube([2*(max+ring),2*(max+ring),10]);
		}
	}

module snowflake(c) {
	echo ("snowflake shape ",c);
	color("blue") difference() {
		union() {
			if (hex[0]<.5) drawhex(length[1], height[1], 0, 6, 0); // center hexagon

			for (angle1 = [0 : 60 : 359]) {	// then six radial arms
				rotate(angle1) arm();
				}

			if (c==0) {
				label(labelString,max+ring);//str(seed),max+ring);
				}
			if (c==1) {
				translate([0,-30-ring,0]) rotate([0,0,-90]) label(labelString, max+ring+ring);
				translate([-length[1]/4-clip-g,0,0]) clip(max+ring+length[1]/4+clip);
				translate([max+ring+ring,0,0]) cylinder(r=ring+clip, h=height[1]);
				}
			if (c==2) {
				translate([length[1]/4-clip,0,0]) clip(max-trim);
				rotate([0,0,180]) translate([length[1]/4-clip,0,0]) clip(max-trim);
				translate([0,0,height[1]/2]) cube([height[1],length[1]/2,height[1]],center=true);
				}
			if (c==3) rotate([0,0,180]) 
				translate([-length[1]/4-clip-g,0,0]) clip(max+length[1]/2-trim);
			if (c==4) {
				translate([0,-30-ring,0]) rotate([0,0,-90]) label(labelString, max+ring+ring);
				translate([0,0,0]) scale([1,.5,1]) clip(max+ring+length[1]/4+clip);
				translate([max+ring+ring,0,0]) cylinder(r=ring+clip, h=height[1]);
				}
			} // union
		if (c==1) {
			translate([-length[1]/4,0,0]) slot(max+ring+ring++length[1]/4);
			translate([max+ring+ring,0,-1]) cylinder(r=ring, h=height[1]+2);
			translate([max+ring,clip+height[1],height[1]/2]) cube([3*clip, 1, height[1]+2],center=true);
			}
		if (c==3) {
			rotate([0,0,180]) translate([-length[1]/4,0,0]) slot(max+length[1]/2+10);
			//if (trim>0) rotate([0,0,-90]) translate([-7,-max-length[1]/4+clip-1,-1]) cube([14,trim+1,height[1]*3]);
			}
		if (c==2) {
			translate([length[1]/4,0,0]) slot(max+10);
			rotate([0,0,180]) translate([length[1]/4,0,0]) slot(max+10);
			//if (trim>0) rotate([0,0,-90]) translate([-7,-max-length[1]/4+clip-1,-1]) cube([14,trim+1,height[1]*3]);
			//if (trim>0) rotate([0,0,90]) translate([-7,-max-length[1]/4+clip-1,-1]) cube([14,trim+1,height[1]*3]);
			}
		if (c==4) {
			//translate([-length[1]/4,0,0]) slot(max+ring+ring++length[1]/4);
			translate([max+ring+ring,0,-1]) cylinder(r=ring, h=height[1]+2);
			translate([max+ring,clip+height[1],height[1]/2]) cube([3*clip, 1, height[1]+2],center=true);
			}
		} // difference
	} // module

module clip(l) {
	translate([0,-height[1]/2-clip,0]) cube([l,height[1]+clip+clip,height[1]]);	
	}

module slot(l) {
	translate([0,-height[1]/2-g,-1]) {
		translate([0,0,-1/2]) cube([l,height[1]+g,height[1]+3]);
		translate([0,0,(height[1]+2)/2]) 
			rotate([a/2,0,0]) translate([0,0,-1-(height[1]+2)/2]) 
				cube([l,height[1]+g,height[1]+3]);
		translate([0,0,(height[1]+2)/2]) 
			rotate([-a/2,0,0]) translate([0,0,-(height[1]+2)/2]) 
				cube([l,height[1]+g,height[1]+3]);
		}
	}

module arm() {
	translate ([0,-min(minthickness,width[1])/2,0]) 
		cube([length[1],min(minthickness,width[1]),height[1]]);
	translate ([length[1],0,0]) {
		if (hex[1]>.5) drawhex(length[2], height[2], hsolid[2], 3+floor(sides[2]), hthick[2]);
		if (hhex[1]>.5) drawhex(length[2]/2, height[2], hsolid[2],3+floor(sides[2]), hthick[2]);
		if (depth>1) {
			rotate(-angle[1]) arm2();
			arm2();
			rotate(angle[1]) arm2();
			}
		}
	}

module arm2() {
	translate ([0,-min(minthickness,width[2])/2,0]) 
		cube([length[2],min(minthickness,width[2]),height[2]]);
	translate ([length[2],0,0]) {
		if (hex[2]>.5) drawhex(length[3], height[3], hsolid[3], 3+floor(sides[3]), hthick[3]);
		if (hhex[2]>.5) drawhex(length[3]/2, height[3], hsolid[3], 3+floor(sides[3]), hthick[3]);
		if (depth>2) {
			rotate(-angle[2]) arm3();
			arm3();
			rotate(angle[2]) arm3();
			}
		}
	}

module arm3() {
	translate ([0,-min(minthickness,width[3])/2,0])
		cube([length[3],min(minthickness,width[3]),height[3]]);
	translate ([length[3],0,0]) {
		if (hex[3]>.5) drawhex(length[4], height[4], hsolid[4], 3+floor(sides[4]), hthick[4]);
		if (hhex[3]>.5) drawhex(length[4]/2, height[4], hsolid[4], 3+floor(sides[4]), hthick[4]);
		if (depth>3) {
			rotate(-angle[3]) arm4();
			arm4();
			rotate(angle[3]) arm4();
			}
		}
	}

module arm4() {
	translate ([0,-min(minthickness,width[4])/2,0])
		cube([length[4],min(minthickness,width[4]),height[4]]);
	translate ([length[4],0,0]) {
		if (hex[4]>.5) drawhex(length[5], height[5], hsolid[5], 3+floor(sides[5]), hthick[5]);
		if (hhex[4]>.5) drawhex(length[5]/2, height[5], hsolid[5], 3+floor(sides[5]), hthick[5]);
		}
	}

module drawhex(size, height, solid, sides, thick) {
	//echo(size,height,solid,sides);
	offset = max(height+min(thick-1,0), minthickness);
	translate([0,0,height/2]) difference() {
		hexagon(size, height, sides);
		if (solid>0.5) translate([0,0,-0.5]) hexagon(size-offset, height+1.1, sides);
		}
	}

// size is the XY plane size, height in Z
module hexagon(size, height, sides) {
	boxWidth = size/1.75;
	if (sides == 5) {	// inverted triangle
		rotate([0,0,180]) translate([0,0,-height/2]) cylinder(r=boxWidth,h=height,$fn=3);
		}
	else {
		translate([0,0,-height/2]) cylinder(r=boxWidth,h=height,$fn=sides); // suggested by Micheal@Oz
		}
	//for (r = [-60, 0, 60]) rotate([0,0,r]) 
	//	cube([boxWidth, size, height], true);
	}

echo("Version ",version());