// Customizable Hand-Weaving Straight Shuttle
// Author: Alexander Smith
// License: CC BY-SA <https://creativecommons.org/licenses/by-sa/4.0/>

// This OpenSCAD file is formatted for use by the Makerbot Customizer.

// preview[view:south, tilt:top]

use <utils/build_plate.scad>;

/* [Basic] */
shuttle_length = 127;   // [0:0.1:200]
shuttle_width = 12;     // [0:0.1:50]
shuttle_height = 3;    // [0:0.1:20]
notch_length = 31.75; // [0:0.1:100]

// The width of the notch at its deepest point.
notch_width = 3;   // [0:0.1:30]

// The width of the tips at the ends of the shuttle.
tip_width = 3; // [0:0.1:25]

// If you make multiple of these, you might want to label the sizes.
etch_text = "5 in";

// The radius used to round the edges of the shuttle. CAUTION: setting this to a value greater than zero will greatly slow down the rendering time. You should set this to zero and adjust all the other parameters first. When you are happy with the size and shape of the shuttle, then set this value for your final output. Values in the range 0.5-1.0 mm produce good results.
rounding = 0;   // [0:0.1:2]


/* [Advanced] */
// Approximate text height from baseline to ascender. 0 = automatic. 
text_height = 0;    // [0:0.1:50]

// How deeply to etch the text.
etch_depth = 1;     // [0:0.1:20]


/* [Printing Assistance] */
// Because the shuttle is long and thin, the edges may curl off the print bed. This option will generate thin pads attached to the ends of the shuttle which you can snap off after printing. You should set this to a value that will equal about two layers after slicing. Alternatively, print with a raft or brim.
pad_height = 0;     // [0:0.05:1]

// This cuts the pads off at 45 degrees. This makes them less effective. However, if you're printing a large version close to the limits of your printable area, this might help you fit the model on your print bed.
cut_pad_corners = 0;    // [0:No, 1:Yes]

rotate_model = 0;   // [-180:1:180]

build_plate_preview = -1; //[-1: None, 0:Makerbot Replicator 2, 1: Makerbot Replicator, 2:Makerbot Thingomatic, 3: M3D Micro]


/* [Hidden] */
// Some lengths are enforced to be > 0. They are set to this minimum size.
eps = 0.001;



// Shorter aliases, used for calculations. Some basic input sanitization.
input_L = max(0, shuttle_length);
input_W = max(0, shuttle_width);
input_H = max(0, shuttle_height);
input_Wt = max(0, tip_width);
input_Ls = max(0, notch_length);
input_Ws = max(0, notch_width);
input_r = max(0, rounding);
input_He = max(0, etch_depth);
input_Htext = max(0, text_height);
input_pad_height = max(0, pad_height);


// Render the word "ERROR" to show the user something went wrong.
// This is rendered in debug mode (%) so that it doesn't affect the actual model.
module renderError()
{
    translate([0, 0, 25])
        %linear_extrude(0.5)
        text(text="ERROR", size=10, halign="center", valign="center");
}


// This creates the shuttle. The result is centered in and sitting on the xy plane.
module shuttle(L, W, H, Ls, Ws, Wt)
{
    if ((L == undef) || (W == undef) || (H == undef) || (Ls == undef) || (Ws == undef) || (Wt == undef)) {
        echo("Error: One or more of the input paramaeters is invalid or undefined.");
        renderError();
        
    } else if ((L < 0) || (W < 0) || (H < 0) || (Ls < 0) || (Ws < 0) || (Wt < 0)) {
        // Clamp all lengths to be >= 0. L, W, and H must be > 0.
        shuttle(max(L,eps), max(W,eps), max(H, eps), max(Ls,0), max(Ws,0), max(Wt,0));
        
    } else if (Wt > W/2) {
        echo("tip_width must be <= shuttle_width/2");
        shuttle(L, W, H, Ls, Ws, W/2);
        
    } else if (Ls > L/2) {
        echo("notch_length must be <= shuttle_length/2");
        shuttle(L, W, H, L/2, Ws, Wt);
        
    } else if (Ws > W - 2*Wt) {
        echo("notch_width must be <= shuttle_width - 2*tip_width");
        shuttle(L, W, H, Ls, W - 2*Wt, Wt);
        
    } else {
        // Parameters are ok.

        // We mostly need the input values each divided by 2.
        l = L/2;
        w = W/2;
        ls = Ls/2;
        ws = Ws/2;
        
        P1 = [l-Ls, ws];
        P2 = [l, w-Wt];
        P3 = [l, w];
        
        linear_extrude(H)
        polygon([
            P1,
            P2,
            P3,
            [-P3[0], P3[1]],
            [-P2[0], P2[1]],
            [-P1[0], P1[1]],
            -P1,
            -P2,
            -P3,
            [P3[0], -P3[1]],
            [P2[0], -P2[1]],
            [P1[0], -P1[1]]
        ]);
    }
}


// For rounded corners, we  take a Minkowski sum of the shuttle with a sphere. Doing so makes the output larger by the diameter of the sphere. Therefore, in order to get the correct size output, we must shrink the dimensions of the shuttle. This function calls shuttle() with suitable values for use with a sphere of radius 'r'.
module shuttle_minkowski_base(r, L, W, H, Ls, Ws, Wt)
{
    if (r == undef) {
        echo("rounding is undefined");
        renderError();
        
    } else {
        shuttle(L - 2*r, W - 2*r, H - 2*r, Ls + r, Ws + 2*r, Wt - 2*r);
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
module pads(L, W, r, padH = 0.4, padR = 15, padSep = 5)
{
    if ((L == undef) || (W == undef) || (r == undef) || (padH == undef) || (padR == undef) || (padSep == undef)) {
        echo("Error: One or more of the input paramaeters is invalid or undefined.");
        renderError();
        
    } else {
        l = L/2;
        w = W/2;
        
        for (sx = [-1:2:1]) {
            for (sy = [-1:2:1]) {
                scale([sx, sy, 1])
                difference() {
                    union() {
                        translate([l - padR - r, w + padSep, 0])
                            cylinder(padH, padR, padR);
                        translate([l - 2*padR - r, w - r, 0])
                            cube([2*padR, padSep + r, padH]);
                    }
                    
                    translate([l - 2*padR - r, -padR-1, -1])
                        cube([2*padR, padR + 1 + w-r, padH+2]);
                    
                    if ((cut_pad_corners != 0) && (cut_pad_corners != false)) {
                        // Cut off the pads at 45 degrees.
                        D = padSep + 2*padR;
                        translate([-r, 0, -1])
                            linear_extrude(padH+2)
                            polygon([
                                [l, padSep/2 + w],
                                [l, padSep/2 + w + D],
                                [l - D, padSep/2 + w + D]
                            ]);
                    }
                }
            }
        }
    }
}


rotate([0, 0, rotate_model])
if (input_r == undef) {
    echo("rounding is invalid or undefined.");
    renderError();
    
} else {
        $fs = max(0.01, min(1, input_r/10));
        $fa = 1;
    
    // Render the shuttle and optionally round edges.
    difference() {
        if (input_r > 0) {
            minkowski() {
                // Use a sphere to round out all corners and edges.
                // We translate it to sit on the xy plane, so that the result also stays sitting on the xy plane. (This is already the case for the shuttle base.)
                translate([0, 0, input_r])
                    sphere(input_r);
                
                shuttle_minkowski_base(input_r, input_L, input_W, input_H, input_Ls, input_Ws, input_Wt);
            }
            
        } else {
            // No rounding. Just render the shuttle.
            shuttle(input_L, input_W, input_H, input_Ls, input_Ws, input_Wt);
        }
        
        // Optionally etch text into the shuttle.
        if (len(etch_text) > 0) {
            shuttle_etch_text(etch_text, input_H, input_W, input_Ws, input_He, input_Htext);
        }
    }
    
    // Optionally add pads to prevent the ends from curling.
    if (input_pad_height > 0) {
        pads(input_L, input_W, input_r, input_pad_height);
    }
}

// Show the build plate. This only appears in the preview, not in the final model. 109x113 are the M3D micro's specs. The last two parameters are only used if the first parameters is 3 (manual).
build_plate(build_plate_preview, 109, 113);
