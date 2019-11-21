// -- Uke Friction Tuner Washer Replacement -- //
// -- Simple OpenSCAD Script by Ryan Pavlik -- //

// If you're editing this by hand:
// Ignore stuff that is in brackets - that's special comments for Thingiverse Customizer to parse
// Also, sorry for the long lines in some of the comments, hopefully you're editing using the
// built-in editor in OpenSCAD or another editor with soft word-wrap. Customizer can only
// deal with one comment line per parameter.

// -- Configuration Parameters -- //
// These are what I measured for mine, but they might not be right for you.
// Calipers time! Units are mm.

// *     Define the Outside      * //
// the yellow surfaces in OpenSCAD //
/* [outside] */

// Overall height of the desired washer - measure existing washer.
height = 3.4;

// Diameter of outside of washer at base (uke head) - measure existing washer.
outerBaseDiameter = 11.4;

// Diameter of outside of washer at top (furthest from head) - measure existing washer.
outerTopDiameter = 10.3;


// *      Define the Inside Cone     * //
// (sloped green surfaces in OpenSCAD) //
/* [inside-cone] */

// height of inner sloped portion - measure on tuner key
innerHeight = 2.1;

// Diameter of inner portion at the top and presumably widest part of the key - measure on key.
innerTopDiameter = 9.9;

// Diameter of inner portion at the base and presumably narrowest part of the key - measure on key.
innerBaseDiameter = 4.35;

// *   Define the Inside Cylinder   * //
// (other green surfaces in OpenSCAD) //
/* [inside-cylinder] */

// Largest diameter of the pin that goes through this. Clearance gets added automatically. It's important that this is the *largest* diameter because the pin probably has flat sides - but we want a round hole.
pinDiameter = 4.23;

// -- shouldn't need to edit below here -- //

/* [Advanced-slash-Troubleshooting] */
// value added to pin diameter for clearance. one 0.4mm nozzle-width seemed OK to me: a little snug, but you wouldn't want it loose. You probably don't need to change this unless you printed one and you either can't fit it on the pin, or it's a sloppy fit on the pin..
pinClearance = 0.4;

/* [hidden] */
// Let's really-well approximate these circles.
$fa = 5;
$fs = 0.1;
// for Customizer - what tab is open? used to highlight.
preview_tab = "";
// For Customizer - to make messages readable, since the real geometry is radially symmetric
// preview[view:south, tilt:top]

// for messages - some unicode characters
GT = "\u003E";
LEQ = "\u2264";
GEQ = "\u2265";

// -- parameter validation and warning messages -- //
// Parameter validation: diameters of each cone.
// Outer cone flares at base.
if (outerBaseDiameter <= outerTopDiameter)
    warning("outerBaseDiameter", LEQ, "outerTopDiameter", "You may have your parameters flip-flopped. Outer cone should flare at the bottom in this design.");

// Inner cone flares at top.
if (innerTopDiameter <= innerBaseDiameter)
    warning("innerTopDiameter", LEQ, "innerBaseDiameter", "You may have your parameters flip-flopped. Inner cone should flare at the top in this design.");

// Parameter validation: heights
if (height <= innerHeight)
    warning("height", LEQ, "innerHeight", "You almost certainly have at least one of these values wrong, or the values swapped: the inner cone shouldn't be taller than the entire object overall.");

// Parameter validation: Pin vs inner base diameter - I almost made this one just modify the inner base diameter to be the same as the pin diameter, since in practice they'll be very close, but...
if (pinDiameter > innerBaseDiameter)
    warning("pinDiameter", GT, "innerBaseDiameter", "By the measuring instructions, innerBaseDiameter should be at least pinDiameter.");

// Parameter validation: Pin diameter vs other diameters that it should be definitely smaller than.
if (pinDiameter >= innerTopDiameter)
    warning("pinDiameter", GEQ, "innerTopDiameter", "At least one of these values is likely to be wrong.");
if (pinDiameter >= outerTopDiameter)
    warning("pinDiameter", GEQ, "outerTopDiameter", "At least one of these values is likely to be wrong.");
if (pinDiameter >= outerBaseDiameter)
    warning("pinDiameter", GEQ, "outerTopDiameter", "At least one of these values is likely to be wrong.");

// The actual geometry: One truncated cone, with another truncated cone and a cylinder
// subtracted from it.
// "difference()" takes the first solid as a "positive",
// and subtracts all additional solids (2 in this case) from it, as "negatives".
// Ignore the "highlight()" stuff - that's just to make Customizer on Thingiverse work better.
difference() {
    // Uses of this small "epsilon" value scattered here are just to push surfaces past each other
    // for the boolean ops, so we don't have faces coinciding when performing differences.
    // Sometimes not strictly necessary, but it makes the preview more usable and
    // the math done by the software more reliable.
    epsilon = 0.01;
    
    // This line creates the outer truncated cone.
    highlight("outside") cylinder(d1 = outerBaseDiameter, d2 = outerTopDiameter, h = height);
    
    // The remaining lines then subtract from that initial solid.
    // First, these 3 lines create a truncated cone at the top (hence translate),
    // to match the slope on the key
    highlight("inside-cone") translate([0,0, height - innerHeight + epsilon]) {
        cylinder(d1 = innerBaseDiameter, d2 = innerTopDiameter, h = innerHeight + epsilon);
    }
    // These lines create a simple (right) cylinder (not a cone) all the way through for the pin.
    // Made it taller than the positive, and translated it down, so faces don't coincide.
    highlight("inside-cylinder") translate([0,0, -epsilon]) {
        cylinder(d = pinDiameter + pinClearance, h = height + 2 * epsilon);
    }
}

// Used to highlight in Customizer preview. Ignore otherwise.
// Based on Customizer docs.
module highlight(this_tab) {
    if (preview_tab == this_tab) {
        color("red") children();
    } else {
        children();
    }
}

module warning(var1, relation, var2, details) {
    // full message only seen if not in customizer.
    condition = str(var1, " ", relation, " ", var2);
    fullmsg = str("<b>WARNING</b>: ", condition, " -- ", details);
    echo(fullmsg);
    if (preview_tab != "") {
        !translate([-15, 10, 0]) {
            text(str("WARNING: ", condition), size = 1);
        }
    }
}