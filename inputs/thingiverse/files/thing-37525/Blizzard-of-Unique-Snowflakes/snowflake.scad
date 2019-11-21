// Parametric Snowflakes
// (c) 2012 Laird Popkin

// Randomly generate snowflakes. The basic approach is to draw six
// radial arms out from the center, then recursively draw arms out from 
// the ands of the first arms, and so on. For a random number of
// layers of recursion. Also, randomly draw hexagons.

// Arrays of parameters. Foo[0] is center, [1] is first layer out, [2] is
// second layer, etc.

// Snowflake number
seed=1; //[0:1000000]
echo(str("Seed ",seed));

seeds=rands(0,1000000,7,seed);
echo(str("Seeds ",seeds));

hex = rands(0,1,6,seeds[0]);			// Should this layer have hexagons? >0.5 = yes.
echo("hex ",hex);
hsolid = rands(0,1,6,seeds[1]);		// should hexagons be solid? >0.5 = yes.
echo("hex solid ",hsolid); 
hhex = rands(0,1,6,seeds[2]);			// Should there be an inner hexagon? >0.5 = yes.
echo("hhex ",hhex);
length = rands(5,20,6,seeds[3]);		// length of lines for this layer
echo("length ",length);
width = rands(0.2,2,6,seeds[4]);		// width of lines for this layer
echo("width ",width);
angle = rands(60,120,6,seeds[5]);	// angle for arms for next layer
echo("angle ",angle);

depth = rands(1,4,1,,seeds[6])[0];	// number of layers to draw.
echo("depth ",depth);

scaleh=0.8 * 1;						// each layer is 0.9x previous layer height
// Height
height0=2 * 1;						// height of snowflake in mm
height=[height0,height0*scaleh,height0*pow(scaleh,2), height0*pow(scaleh,3), height0*pow(scaleh,4), height0*pow(scaleh,5), height0*pow(scaleh,6)];
//echo("height ",height);


if (hex[0]) drawhex(length[1], height[1], hsolid[1]);

for (angle1 = [0 : 60 : 359]) {	// then six radial arms
	rotate(angle1)arm();
	}

module arm() {
	translate ([0,-width[1]/2,0]) {
		cube([length[1],width[1],height[1]]);
		translate ([length[1],width[1]/2,0]) {
			if (hex[1]>.5) drawhex(length[2], height[2], hsolid[2]);
			if (hhex[1]>.5) drawhex(length[2]/2, height[2], hsolid[2]);
			if (depth>1) {
				rotate(-angle[1]) arm2();
				arm2();
				rotate(angle[1]) arm2();
				}
			}
		}
	}

module arm2() {
	translate ([0,-width[2]/2,0]) {
		cube([length[2],width[2],height[2]]);
		translate ([length[2],width[2]/2,0]) {
			if (hex[2]>.5) drawhex(length[3], height[3], hsolid[3]);
			if (hhex[2]>.5) drawhex(length[3]/2, height[3], hsolid[3]);
			if (depth>2) {
				rotate(-angle[2]) arm3();
				arm3();
				rotate(angle[2]) arm3();
				}
			}
		}
	}

module arm3() {
	translate ([0,-width[3]/2,0]) {
		cube([length[3],width[3],height[3]]);
		translate ([length[3],width[3]/2,0]) {
			if (hex[3]>.5) drawhex(length[4], height[4], hsolid[4]);
			if (hhex[3]>.5) drawhex(length[4]/2, height[4], hsolid[4]);
			if (depth>3) {
				rotate(-angle[3]) arm4();
				arm4();
				rotate(angle[3]) arm4();
				}
			}
		}
	}

module arm4() {
	translate ([0,-width[4]/2,0]) {
		cube([length[4],width[4],height[4]]);
		translate ([length[4],width[4]/2,0]) {
			if (hex[4]>.5) drawhex(length[5], height[5]);
			if (hhex[4]>.5) drawhex(length[5]/2, height[5]);
			}
		}
	}

module drawhex(size, height, s) {
	translate([0,0,height/2]) difference() {
		hexagon(size, height);
		if (s>0.5) translate([0,0,-0.5]) hexagon(size-height, height+1);
		}
	}

// size is the XY plane size, height in Z
module hexagon(size, height) {
	boxWidth = size/1.75;
	for (r = [-60, 0, 60]) rotate([0,0,r]) 
		cube([boxWidth, size, height], true);
	}
