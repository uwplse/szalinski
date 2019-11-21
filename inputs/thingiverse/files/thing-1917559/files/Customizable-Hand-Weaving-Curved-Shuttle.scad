// Customizable Hand-Weaving Curved Shuttle
// Author: Alexander Smith
// License: CC BY-SA <https://creativecommons.org/licenses/by-sa/4.0/>
//
// This file incorporates a Bezier library, below, which is from the public domain. (The Makerbot Customizer does not support include files.)

// This OpenSCAD file is formatted for use by the Makerbot Customizer.

// preview[view:south, tilt:top]

use <utils/build_plate.scad>;

/* [Basic] */

shuttle_length = 127;   // [0:0.1:200]
shuttle_width = 18;     // [0:0.1:50]
shuttle_height = 3.5;    // [0:0.1:20]
notch_length = 31.75; // [0:0.1:100]
notch_width = 5.5;   // [0:0.1:30]

// The gap between the tips at the ends of the shuttle.
tip_gap = 3; // [0:0.1:25]

// If you make multiple of these, you might want to label the sizes.
etch_text = "5 in";

// The radius used to round the edges of the shuttle. CAUTION: setting this to a value greater than zero will take SEVERAL MINUTES to render! You should set this to zero and adjust all the other parameters first. When you are happy with the size and shape of the shuttle, then set this value for your final output. Values in the range 0.5-1.0 mm produce good results.
rounding = 0;   // [0:0.1:2]


/* [Advanced] */
// Approximate text height from baseline to ascender. 0 = automatic. 
text_height = 0;    // [0:0.1:50]

// How deeply to etch the text.
etch_depth = 1;     // [0:0.1:20]

// This determines how sharply the tips close. Larger values give gentler curves.
tip_scaling = 0.75;  // [0:0.1:1]


/* [Printing Assistance] */
// Because the shuttle is long and thin, the edges may curl off the print bed. This option will generate thin pads attached to the ends of the shuttle which you can snap off after printing. You should set this to a value that will equal about two layers after slicing. Alternatively, print with a raft or brim.
pad_height = 0;     // [0:0.05:1]

// This cuts the pads off at 45 degrees. This makes them less effective. However, if you're printing a large version close to the limits of your printable area, this might help you fit the model on your print bed.
cut_pad_corners = 0;    // [0:No, 1:Yes]

rotate_model = 0;   // [-180:1:180]

build_plate_preview = -1; //[-1: None, 0:Makerbot Replicator 2, 1: Makerbot Replicator, 2:Makerbot Thingomatic, 3: M3D Micro]


/* [Hidden] */
// The fraction of the vertical distance from the notch to the edge at which to put one of the control points determing the curve of the top.
top_cpt_fraction = 1/3;



// Shorter aliases, used for calculations. Some basic input sanitization.
input_L = max(0, shuttle_length);
input_W = max(0, shuttle_width);
input_H = max(0, shuttle_height);
input_Wg = max(0, tip_gap);
input_Ls = max(0, notch_length);
input_Ws = max(0, notch_width);
input_ts = max(0, min(1, tip_scaling)); // clamp to [0, 1]
input_f_top = max(0, min(1, top_cpt_fraction));
input_r = max(0, rounding);
input_He = max(0, etch_depth);
input_Htext = max(0, text_height);
eps = min(0.01, input_ts*min(input_W, input_W - input_Ws)/3);
input_pad_height = max(0, pad_height);



//=======================================
// Begin Bezier library
//=======================================
// This is from the Bezier library at <http://www.thingiverse.com/thing:8443>, which is created by William Adams and palced by him in the public domain.
gSteps = 10;
gHeight = 4;

function BEZ03(u) = pow((1-u), 3);
function BEZ13(u) = 3*u*(pow((1-u),2));
function BEZ23(u) = 3*(pow(u,2))*(1-u);
function BEZ33(u) = pow(u,3);

function PointAlongBez4(p0, p1, p2, p3, u) = [
	BEZ03(u)*p0[0]+BEZ13(u)*p1[0]+BEZ23(u)*p2[0]+BEZ33(u)*p3[0],
	BEZ03(u)*p0[1]+BEZ13(u)*p1[1]+BEZ23(u)*p2[1]+BEZ33(u)*p3[1]];

module BezQuadCurve(c, focalPoint, steps=gSteps, height=gHeight)
{
	for(step = [steps:-1:1])
	{
		linear_extrude(height = height, convexity = 10) 
		polygon(
			points=[
				focalPoint,
				PointAlongBez4(c[0], c[1], c[2],c[3], step/steps),
				PointAlongBez4(c[0], c[1], c[2],c[3], (step-1)/steps)],
			paths=[[0,1,2,0]]
		);
	}
}
//=======================================
// End Bezier library
//=======================================



// Render the word "ERROR" to show the user something went wrong.
// This is rendered in debug mode (%) so that it doesn't affect the actual model.
module renderError()
{
    translate([0, 0, 25])
        %linear_extrude(0.5)
        text(text="ERROR", size=10, halign="center", valign="center");
}


// Performing a Minkowski sum on large, complex objects is very expensive. When possible, it is faster to perform the sum on smaller sub-objects and then union them together.
module smooth_all(r)
{
    if (r > 0.0) {
        for ( i= [0:1:$children-1]) {
            minkowski() {
                children(i);
                sphere(r, $fn=min(50, 20*r));
            }
        }
    } else {
        // no rounding; do nothing
        children();
    }
}
        

// The part of the tip that closes at the tip of the notch.
module tip_bottom(H, Ls, Ws, Wg, D, r)
{
    ws = Ws/2;
    wg = Wg/2;
    
    P1 = [0 + r, ws + r];
    P2 = [D + r, ws + r];
    P3 = [D + r, wg + r];
    P4 = [2*D, wg + r];
    P5 = [3*D - r, wg + r];
    P6 = [3*D - r, ws + r];
    
    smooth_all(r) {
        BezQuadCurve([P1, P2, P3, P4], [2*D + eps, ws + r + eps], 20, H - 2*r);
        BezQuadCurve([P4, P5, P5, P6], [2*D - eps, ws + r + eps], 15, H - 2*r);
    }
}


// The rest of the tip.
module shuttle_head_top(W, H, Ls, Ws, D, f_top, r)
{
    w = W/2;
    ws = Ws/2;
    
    k = 4*(sqrt(2)-1)/3; // for approximating circles with Bezier control points
    
    P1 = [0 - r, 0];
    P2 = [0 - r, k*ws + r];
    P3 = [(1-k)*(ws) - r, ws + r];
    P4 = [ws + r, ws + r];
    P5 = [Ls - r, ws + r];
    P6 = [Ls - r, ws + f_top*(w - ws) - r];
    P7 = [max(Ls - 3*D - r, D - r + ws), w - r];
    P8 = [D - r, w - r];
    
    smooth_all(r) {
        BezQuadCurve([P1, P2, P3, P4], [0 - r - eps, ws + r], 15, H - 2*r);
        BezQuadCurve([P5, P6, P7, P8], [0 - r - eps, ws + r], 30, H - 2*r);
        translate([0 - r - eps, ws + r, 0]) cube([D + r + eps, w - ws - 2*r, H - 2*r]);
    }
}


// Both parts of the tip. Two of these, mirrored over the x axis, form the notch.
module shuttle_head(L, W, H, Ls, Ws, Wg, D, f_top, r)
{
    w = W/2;
    ws = Ws/2;
    
    shuttle_head_top(W, H, Ls, Ws, D, f_top, r);
    translate([Ls - 3*D, 0]) tip_bottom(H, Ls, Ws, Wg, D, r);
}


// The entire shuttle.
module shuttle(L, W, H, Ls, Ws, Wg, ts, f_top, r)
{
    D = ts*min(Ws, (W-Ws));

    if ((L == undef) || (W == undef) || (H == undef) || (Ls == undef) || (Ws == undef) || (Wg == undef) || (ts == undef) || (f_top == undef) || (r == undef)) {
        echo("Error: One or more of the input paramaeters is invalid or undefined.");
        renderError();
        
    } else if (ts < 0) {
        echo("Error: tip_scaling must be >= 0.");
        shuttle(L, W, H, Ls, Ws, Wg, 0, f_top, r);
        
    } else if (ts > 1) {
        echo("Error: tip_scaling must be < 1.");
        shuttle(L, W, H, Ls, Ws, Wg, 1, f_top, r);
        
    } else if (f_top < 0) {
        echo("Error: top_cpt_fraction must be >= 0.")
        shuttle(L, W, H, Ls, Ws, Wg, ts, 0, r);
        
    } else if (f_top > 1) {
        echo("Error: top_cpt_fraction must be <= 1.")
        shuttle(L, W, H, Ls, Ws, Wg, ts, 1, r);
        
    } else if (W < 2*r) {
        echo("Error: shuttle_width must be >= 2*rounding.");
        shuttle(L, 2*r, H, Ls, Ws, Wg, ts, f_top, r);
        
    } else if (H < 2*r) {
        echo("Error: shuttle_height must be >= 2*rounding.");
        shuttle(L, W, 2*r, Ls, Ws, Wg, ts, f_top, r);
        
    } else if (Ws < 2*r) {
        echo("Error: notch_width must be >= 2*rounding.");
        shuttle(L, W, H, Ls, 2*r, Wg, ts, f_top, r);
        
    } else if (Ws > W - 2*r) {
        echo("Error: notch_width must be < shuttle_width - 2*rounding.");
        shuttle(L, W, H, Ls, W - 2*r, Wg, ts, f_top, r);
        
    } else if (Wg < 0) {
        echo("Error: tip_gap must be >= 0.");
        shuttle(L, W, H, Ls, Ws, 0, ts, f_top, r);
        
    } else if (Wg > Ws) {
        echo("Error: tip_gap must be <= notch_width.");
        shuttle(L, W, H, Ls, Ws, Ws, ts, f_top, r);
        
    } else if (Ls < r + Ws/2 + 3*D) {
        if (W < W-Ws) {
            echo("Error: notch_length must be >= rounding + notch_width/2 + 1.5*tip_scaling*shuttle_width.");
        } else {
            echo("Error: notch_length must be >= rounding + notch_width/2 + 1.5*tip_scaling*(shuttle_width - notch_width).");
        }
        shuttle(L, W, H, r + Ws/2 + 3*D, Ws, Wg, ts, f_top, r);
        
    } else if (L < 2*Ls + 2*r) {
        echo("Error: shuttle_length must be >= 2*notch_length + 2*rounding.");
        shuttle(2*Ls + 2*r, W, H, Ls, Ws, Wg, ts, f_top, r);
        
    } else {
        union() {
            for (sx = [-1:2:1]) {
                for (sy = [-1:2:1]) {
                    scale([sx, sy, 1])
                        translate([L/2 - Ls, 0, 0]) shuttle_head(L, W, H, Ls, Ws, Wg, D, f_top, r);
                }
            }

            smooth_all(r) {
                translate([-(L - 2*Ls)/2 + r, -W/2 + r, 0])
                cube([L - 2*Ls - 2*r, W - 2*r, H - 2*r]);
            }
        }
    }
}


// This returns a text object that can be subtracted from the shuttle to etch text into it. If Htext is zero, then a default height will be calcualted.
module shuttle_etch_text(text, H, W, Ws, He, Htext = 0)
{
    if ((H == undef) || (W == undef) || (Ws == undef) || (He == undef)) {
            echo("Error: One or more of the input arguments is invalid or undefined.");
            renderError();
        
    } else if ((Htext == 0) || (Htext == undef)) {
        shuttle_etch_text(text, H, W, Ws, He, 0.75*Ws + 0.25*W);
        
    } else {
        translate([0, 0, H - He])
            linear_extrude(2*He)
                text(text=text, font="Helvetica:style=Bold", size=Htext, halign="center", valign="center");
    }
}


// Because the shuttle is long and thin, there is a risk of the ends curling off the print bed when 3D printing it. This generates thin, flat pads attached to the ends of the shuttle which should be easy to snap off. You should set padH to be the height of 2 or 3 layers.
module pads(L, W, Ls, Ws, r, padH)
{
    if ((L == undef) || (W == undef) || (Ls == undef) || (Ws == undef) || (r == undef) || (padH == undef)) {
        echo("Error: One or more of the input paramaeters is invalid or undefined.");
        renderError();
        
    } else {
        l = L/2;
        w = W/2;
        ws = Ws/2;

        padR = W - Ws;
        
        P1 = [l - Ls - r, w];
        P2 = [l - r, ws + r];
        P3 = 0.5*(P1 + P2);
        alpha = atan2(P2[1]-P1[1], P2[0]-P1[0]);
        sep = (w - ws)/2;
        
        for (sx = [-1:2:1]) {
            for (sy = [-1:2:1]) {
                scale([sx, sy, 1])
                difference() {
                    translate(P2)
                    rotate([0, 0, alpha])
                    translate([-padR, 0, 0]) {
                        translate([-padR, 0, 0]) cube([2*padR, sep, padH]);
                        difference() {
                                translate([0, sep, 0]) cylinder(padH, padR, padR);
                                translate([-padR-1, 0, -1]) scale([1, -1, 1]) cube([2*padR+2, padR, padH+2]);
                        }
                    }
                    
                    if ((cut_pad_corners != 0) && (cut_pad_corners != false)) {
                        // Cut off the pads at 45 degrees.
                        translate([l, ws + sep, -1])
                        rotate([0, 0, 45])
                        translate([0, -padR, 0])
                        cube([3*padR, 4*padR, padH+2]);
                    }
                }
            }
        }
    }
}


rotate([0, 0, rotate_model]) {
    difference() {
        translate([0, 0, input_r]) shuttle(input_L, input_W, input_H, input_Ls, input_Ws, input_Wg, input_ts, input_f_top, input_r);

        // Optionally etch text into the shuttle.
        if (len(etch_text) > 0) {
            shuttle_etch_text(etch_text, input_H, input_W, input_Ws, input_He, input_Htext);
        }
    }

    // Optionally add pads to prevent the ends from curling.
    if (input_pad_height > 0) {
        pads(input_L, input_W, input_Ls, input_Ws, input_r, input_pad_height);
    }
}

// Show the build plate. This only appears in the preview, not in the final model. 109x113 are the M3D micro's specs. The last two parameters are only used if the first parameters is 3 (manual).
build_plate(build_plate_preview, 109, 113);
