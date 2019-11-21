line_1 = "TYPE";
line_2 = "Color Name";
line_3 = "Company";
fontSize = 5;

// (mm)
depth = 0.8;

// (mm)
brimDepth = 1.4;

// (mm)
textDepth = 1.4;

// Thickness tests depth (mm). Empty vector [] for uniform bottom
steps = [0.2, 0.4];


/*[Dimensions override]*/

// default 2"
width = 50.8;

// default 1⅛"
height = 28.575;


// default 1/16"
brimWidth = 1.5875;

// default ⅛"
holeDiameter = 3.175;

/*[Other]*/

font = "Saira Condensed:bold"; // [Saira Condensed:bold, Saira Extra Condensed:bold, Archivo:bold, Pathway Gothic One, Voltaire, Oswald, Oswald:bold, PT Sans Narrow:style=bold]

// overrides the above. use Google Fonts
customFont = "";

// Render rounded edges
hq = false;//[false,true]

// Fraction of width at which to start thickness samples
stepsFrom = 0.61803398875;


/* [Hidden] */
//-------------------------------------------------------------------------------

brimFilletRadius = 0.35;
filletResolution = 9;

// Quality
$fn = hq ? 15 : 30;
fontResolution = 30;
holeResolution = 60;
textLeftMargin = brimWidth*3 + holeDiameter;


module baseShape() {
	bezier_polygon([[[144.0, -40.568], [144.0, -30.123999999999995], [140.348, -18.198999999999998], [135.279, -10.680999999999997]], [[135.279, -10.680999999999997], [130.21099999999998, -3.1629999999999976], [126.011, -0.3839999999999968], [117.064, -0.20199999999999818]], [[117.064, -0.20199999999999818], [109.216, -0.04299999999999818], [34.782, -0.04299999999999818], [26.935999999999993, -0.20199999999999818]], [[26.935999999999993, -0.20199999999999818], [17.987, -0.385], [13.788, -3.164], [8.72, -10.682]], [[8.72, -10.682], [3.652, -18.199], [0.0, -30.125], [0.0, -40.568]], [[0.0, -40.568], [0.0, -40.573], [0.001, -40.577], [0.001, -40.582]], [[0.001, -40.582], [0.001, -40.588], [0.0, -40.592], [0.0, -40.597]], [[0.0, -40.597], [0.0, -51.04], [3.652, -62.966], [8.72, -70.483]], [[8.72, -70.483], [13.788, -78.0], [17.987000000000002, -80.78], [26.936, -80.96300000000001]], [[26.936, -80.96300000000001], [34.782, -81.12100000000001], [109.21600000000001, -81.12100000000001], [117.064, -80.96300000000001]], [[117.064, -80.96300000000001], [126.011, -80.77900000000001], [130.20999999999998, -78.00000000000001], [135.279, -70.483]], [[135.279, -70.483], [140.348, -62.965999999999994], [144.0, -51.04], [144.0, -40.597]], [[144.0, -40.597], [144.0, -40.592], [143.999, -40.588], [143.999, -40.582]], [[143.999, -40.582], [143.999, -40.577], [144.0, -40.573], [144.0, -40.568]], [[144.0, -40.568], [144.0, -40.568], [144.0, -40.568], [144.0, -40.568]], [[144.0, -40.568], [144.0, -40.568], [144.0, -40.568], [144.0, -40.568]]]);
}

module base(w = width, h = height, shrink = 0, d = depth) {
	translate([shrink, -shrink, 0])
		resize([w - shrink*2, h - shrink*2, d])
			linear_extrude(height = 1)
				baseShape();
}

module brim() {
	difference() {
		base(d = brimDepth);
		translate([0, 0, -1])
			base(shrink = brimWidth, d = brimDepth+2);
	}
}

module brim_hq() {
	module track() {
		difference() {
			translate([0, 0,  brimFilletRadius])
				base(shrink = brimFilletRadius, d = brimDepth - brimFilletRadius*2);
			base(shrink = brimWidth - brimFilletRadius, d = brimDepth);
		}
	}

	module trackQuater() {
		intersection() {
			translate([0, -height/2, 0])
				cube([width/2, height/2, 1]);
			track();
		}
	}

	module brimTool() {
		sphere(r = brimFilletRadius, $fn = 9);
	}

	module brimQuater() {
		minkowski() {
			trackQuater();
			brimTool();
		}
	}

	module brimHalf() {
		union() {
			brimQuater();
			translate([0, -height, 0])
				mirror([0, 1, 0])
					brimQuater();
		}
	}

	union() {
		brimHalf();
		translate([width, 0, 0])
			mirror([1, 0, 0])
				brimHalf();
	}
}


module insides() {
	function opacity (t) = min(t, 1);
	l = len(steps);

	module baseFragment(fragmentDepth, start, end) {
		color([0.95, 0.95, 0.95], opacity(fragmentDepth))
		intersection() {
			translate([width*start, -height, 0])
				cube([width*(end-start), height, fragmentDepth]);
			base(shrink = brimFilletRadius, d = depth+1);
		}
	}

	module stepsFragments() {
		if (l > 0) {
			stepsWidth = 1-stepsFrom;
			for(s = [1:l]) {
				d = steps[l-s];
				start = stepsFrom + ((s-1)/l)*stepsWidth;
				end = stepsFrom + (s/l)*stepsWidth;
				baseFragment(d, start, end);
			}
		}
	}

	module texts() {
		verticalSpacing = height*0.25;

		module styledText(content, margin) {
			linear_extrude(height = textDepth)
				translate([0, -verticalSpacing*margin, 0])
					text(content, fontSize, customFont ? customFont : font, $fn = fontResolution);
		}
		
		translate([textLeftMargin, -height*0.33, 0])
			union () {
				styledText(line_1, 0);
				styledText(line_2, 1);
				styledText(line_3, 2);
			}
	}

	union() {
		baseFragment(depth, 0, l > 0 ? stepsFrom : 1);
		stepsFragments();
		texts();
	}
}

module hole() {
	translate([brimWidth*1.5 + holeDiameter/2, -height/2, -1])
		cylinder(d = holeDiameter, h = brimDepth+2, $fn = holeResolution);
}

module dog_tag() {
	union() {
		difference() {
			insides();
			hole();
		}
		if (hq) {
			brim_hq();
		} else {
			brim();
		}
	}
}

dog_tag();

// ============================================================================
/**
 * Stripped down version of "bezier_v2.scad".
 * For full version, see: https://www.thingiverse.com/thing:2170645
 */

function BEZ03(u) = pow((1-u), 3);
function BEZ13(u) = 3*u*(pow((1-u),2));
function BEZ23(u) = 3*(pow(u,2))*(1-u);
function BEZ33(u) = pow(u,3);

function bezier_2D_point(p0, p1, p2, p3, u) = [
	BEZ03(u)*p0[0]+BEZ13(u)*p1[0]+BEZ23(u)*p2[0]+BEZ33(u)*p3[0],
	BEZ03(u)*p0[1]+BEZ13(u)*p1[1]+BEZ23(u)*p2[1]+BEZ33(u)*p3[1]
];

function bezier_coordinates(points, steps) = [
	for (c = points)
		for (step = [0:steps])
			bezier_2D_point(c[0], c[1], c[2],c[3], step/steps)
];

module bezier_polygon(points) {
	steps = $fn <= 0 ? 30 : $fn;
	polygon(bezier_coordinates(points, steps));
}
