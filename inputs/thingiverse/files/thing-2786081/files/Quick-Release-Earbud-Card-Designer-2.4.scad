// Remixed from https://www.thingiverse.com/thing:2459939 
//     Brett Beauregard's https://www.thingiverse.com/thing:8528 was the inspiration for this.
//     I added 2 holes in the card so you can string the cord while using the earbuds so you don't lose
//     the card.
// 
// Download libraries Write and building_plate from Thingiverse.

// Version 2.0 Green Ellipsis LLC added customizer setup and lots of customizability. Thanks also to <tjw-scad/spline.scad>, which I copied in a subset of.
// Version 2.1 Green Ellipsis LLC 
//     Changed jackNotch to "T" shape in the middle and flipped at the top.
//     Added jackNotches to opposite side to take up extra cord length.
//     Added slope to winding side for easier removal.
//     Reorganized customizations.
// Version 2.2 Green Ellipsis LLC added text option.
// Version 2.3 
//  Adjusted OnePlus presets: larger slots (from 3.3 to 3.5)
//  New extra feature: Added a tab to the slide notch
//  New extra feature: Added minor winding notches.
//  Moved slide notch to Extras
// Version 2.4
//  Adjusted OnePlus presets:
//    Increase slot_width to 3.7 for OnePlus
//    Decrease earbud radius substantially
//  Smaller tab on slide notch
//  MoreWindingSlots are deeper.
//  Bugfix: only printing half a card
//  

// TODO: add lead-ins at slots (and lead out for earbud slots?)

/* [Preset] */
// presets for specific earbuds. Use Custom to customize.
preset = "Default"; // [Default,Custom,OnePlus Bullets V2 (Credit Card)]

/* [Card Size] */

// overall size of the card. 
card_size = "Custom"; // [Business Card,Credit Card,Custom]

// (mm) Dimension on which cord is wrapped. 
custom_height = 80; // [65:0.5:180]

// (mm)  
custom_width = 50; // [50:0.5:105]

// (mm) 
custom_corner_radius = 3.4; // [0:0.1:7]

/* [Custom Card Size] */

// location of notch relative to earbud holes. 
winding_notch_location = "Right"; //[Left,Middle,Right]

// (mm) width of slots for the cord. 
slot_width = 3.3; // [2:0.05:4]

// (mm) radius of earbud holes. 
earbud_radius = 6.3; //[4:0.1:10]

/* [Extras] */

// Add two smaller winding notches 
more_winding_notches = false;

// a notch for the slide-off side of the winding
slide_notch = "None"; //[None,Straight,Angled] 

// a tab on the slide-off notch 
slide_notch_tab = false;

// include temporary storage holes in center
center_holes = false;

// extra notches to take up more cord
extra_jack_notches = false; 

// text to display on card
card_text = ""; // 

// font of card text
font = "Letters"; // [BlackRose,braille,knewave,Letters,orbitron]
 
/* [Hidden] */

mmPerInch = 25.4;

 use <utils/build_plate.scad>
 use <write/Write.scad>
 
// process Customizer variables and presets
// card size
cardSize = (preset == "Default" ? "Business Card" :
    (preset == "OnePlus Bullets V2 Credit Card" ? "Credit Card" : card_size));

totalWidth = (cardSize == "Business Card" ? 50.8 : 
    (cardSize == "Credit Card" ? 53.98 : custom_width)); // 53.98 is credit card in accordance with ISO/IEC 7810#ID-1
totalHeight = (cardSize == "Business Card" ? 88.9 : 
    (cardSize == "Credit Card" ? 85.6 : custom_height)); // 85.6 is credit card in accordance with ISO/IEC 7810#ID-1
cornerRadius = (cardSize == "Business Card" ? 6.35 : 
    (cardSize == "Credit Card" ? 3.4 : custom_corner_radius)) ;
      
slotWidth = (preset == "Default" ? inch(1/8): 
    (preset == "OnePlus Bullets V2 Credit Card" ? 3.7: slot_width));
earbudRadius = (preset == "Default" ? inch(5/16): 
    (preset == "OnePlus Bullets V2 Credit Card" ? 4.3: earbud_radius));
WindingNotchLocation = (preset == "Default" ? "Left" :
    (preset == "OnePlus Bullets V2 Credit Card" ? "Left" : winding_notch_location));
moreWindingNotches = more_winding_notches;
slideNotch = slide_notch;
slideNotchTab = slide_notch_tab;    
slideInset = (slideNotch == "Straight" ? 2 :
  (slideNotch == "Angled" ? 2 : 0)); // size cut to be angled toward windingNotch
slideAngle = asin((totalWidth/6)/(totalHeight/2));
slideLength = (slideNotch == "Straight" ? slideInset :
(slideNotch == "Angled" ? (totalWidth/2)/cos(slideAngle) : 0));
usableHeight = totalHeight - inch(17/16) - earbudRadius - slideInset - slideLength*sin(slideAngle); 
centerHoles = center_holes;
centerHoleRadius = inch(1/4);
$fn=24;

function inch(mm) = mm * mmPerInch;

echo ("preset", preset);
echo ("centerHoles", centerHoles);
echo ("cardSize", cardSize);
echo ("totalHeight", totalHeight);
echo ("totalWidth", totalWidth);
echo ("cornerRadius", cornerRadius);
    echo("slideLength",slideLength);

// Rounded 2-D corner at the edge of the card.
module cardCorner() {
    difference() {
        square(cornerRadius);
        translate([cornerRadius, cornerRadius]) {
            circle(cornerRadius);
        }
    }
}

// a 2-D business card with all corners rounded.
module cardBlank() {
  difference() {
    difference() {
      square([totalWidth, totalHeight]);
      translate([totalWidth, 0]) {
        rotate([0, 0, 90]) {
          cardCorner();
        }
      }
      // slide notch
      if (slideNotch == "Straight") {
          translate([0,totalHeight-slideInset,0]) 
            square([totalWidth/2,slideInset]);
          translate([totalWidth/2,totalHeight-slideInset,0])
            rotate([0,0,45])
                square(slideInset*sqrt(2)+0.001);
          if (!slideNotchTab) {
              translate([0, totalHeight-slideInset]) {
                rotate([0, 0, -90]) 
                  cardCorner();
              }
          }
      } else if (slideNotch == "Angled") {
            //translate([0,totalHeight-sin(slideAngle)*totalWidth/2-slideInset-slideInset,0])
    translate([0,totalHeight-slideLength*sin(slideAngle)-slideInset,0])
            rotate([0,0,slideAngle])
                translate([0,0,0]) square(slideLength, false);
          translate([totalWidth/2,totalHeight-slideInset])
            rotate([0,0,45])
                square(slideInset*sqrt(2)+0.001);
          if (!slideNotchTab) {
              translate([0, totalHeight-slideLength*sin(slideAngle)-slideInset+cornerRadius*tan(slideAngle)]) {
                rotate([0, 0, -90]) 
                 cardCorner();
              }
          }
      } else {
          translate([0, totalHeight-slideInset]) {
            rotate([0, 0, -90]) 
             cardCorner();
          }
      }
      
      translate([totalWidth, totalHeight]) {
        rotate([0, 0, 180]) {
          cardCorner();
        }
      }
      cardCorner();      
    }
  }
}

// One of the jack notches.
module jackNotch() {
square([slotWidth*2, slotWidth]);
  translate([slotWidth, -slotWidth]) {
    square([slotWidth, slotWidth]);
    translate([slotWidth/2, 0]) {
      circle(slotWidth/2, $fn=12);
    }
  }
}

// Diagonal notch at the bottom of the card.
module bottomNotch() {
  square([slotWidth, inch(1)+slotWidth]);
  translate([slotWidth/2, inch(1)+slotWidth]) {
   circle(slotWidth/2, $fn=12);
  }
}

module jackNotchesRow() {
        // run as many jack notches as we have room for
    jackNotch_spacing = inch(3/4);
    jackNotches = (usableHeight)/(jackNotch_spacing);
    // first jack notch faces up
    translate([0, 0]) {
            mirror([0,1,0]) jackNotch();
    }
    if (jackNotches > 2) {
        for (i=[1:jackNotches-1]) {     
            translate([0, i*jackNotch_spacing +slotWidth*4/8]) {
                    mirror([0,1,0]) jackNotch();
            }
            translate([0, i*jackNotch_spacing -slotWidth*4/8]) {
                    jackNotch();
            }
        }
    }
    translate([0, floor(jackNotches)*jackNotch_spacing]) {
            jackNotch();
    }
}

module SlideNotchTab() {
    if (slideNotch == "Straight") {
        //add a semicircular notch the same radius as the slots
        translate([slotWidth/2, totalHeight-slideInset]) {
            scale([1,0.5]) circle(slotWidth/2);
        }
    } else if (slideNotch == "Angled") {
         translate([slotWidth/2, totalHeight-slideLength*sin(slideAngle)-slideInset]) {
            scale([1,.75]) circle(slotWidth/2);
             //            translate([0,-cornerRadius/2,10])
               // color("red") square([slotWidth, cornerRadius], center=true);

        }
    }
}

module windingNotch(left_ear_x, right_ear_x, location) {
    notchDepth = inch(3/16);
    winding_notch_x_begin = (location == "Left" ? left_ear_x + slotWidth*3/4 : 
        (location == "Right" ? cornerRadius : right_ear_x + slotWidth*3/4));
    winding_notch_x_end  = (location == "Left" ? totalWidth-cornerRadius : 
        (location == "Right" ? right_ear_x - slotWidth*3/4: left_ear_x - slotWidth*3/4));
    hull() 
        spline_ribbon([[winding_notch_x_begin,0],
            [(winding_notch_x_begin + winding_notch_x_end)/2,notchDepth],
            [winding_notch_x_end,0]],width=0.001,divisions=6,loop=true); 
}
// FIXME this needs modified--seems to be working for right notch--just add the others and test some more.
module MoreWindingNotch(left_ear_x, right_ear_x) {
    if (WindingNotchLocation != "Right") {
            SmallWindingNotch(cornerRadius, right_ear_x-slotWidth);
    }
    if (WindingNotchLocation != "Center") {
            SmallWindingNotch(right_ear_x+slotWidth, left_ear_x-slotWidth);
    }
    if (WindingNotchLocation != "Left") {
            SmallWindingNotch(left_ear_x+slotWidth, totalWidth-cornerRadius);
    }
}
module SmallWindingNotch(winding_notch_x_begin, winding_notch_x_end) {
    width = abs(winding_notch_x_begin-winding_notch_x_end);
    if (width >= slotWidth) {
        notchDepth = min(inch(3/16),width);
        hull() 
            spline_ribbon([[winding_notch_x_begin,0],
                [(winding_notch_x_begin + winding_notch_x_end)/2,notchDepth],
                [winding_notch_x_end,0]],width=0.001,divisions=6,loop=true); 
    }
}

// 2-D version of the original SVG file, with 2 additional holes in the center of the card.
module cardWrapFlat() {
  difference() {
    union() {
        cardBlank();
        if (slideNotch != "None" &&slideNotchTab) SlideNotchTab();
    }
    // right ear
    right_ear_x = (WindingNotchLocation == "Right" ? totalWidth - inch(1+5/16) : earbudRadius + 5);
    translate([right_ear_x-slotWidth*(3/2)/2, inch(-1/8)]) {
       square([slotWidth*3/2, inch(3/8)+earbudRadius]);
    }
    translate([right_ear_x, inch(1/2)]) {
      circle(earbudRadius);
    }
    
    // left ear
    left_ear_x = (WindingNotchLocation == "Left" ? inch(1+5/16) : (totalWidth - earbudRadius - 5));
    translate([left_ear_x-slotWidth*(3/2)/2, inch(-1/8)]) {
       square([slotWidth*3/2, inch(3/8)+earbudRadius]);
    }
    translate([left_ear_x, inch(1/2)]) {
      circle(earbudRadius);
    }
    
    // winding notch
    windingNotch(left_ear_x, right_ear_x, location=WindingNotchLocation);
    
    // small winding notches
    if (moreWindingNotches) {
        MoreWindingNotch(left_ear_x, right_ear_x);
    }
    
    // jack notches
    translate([0, inch(13/16) + earbudRadius]) jackNotchesRow();
    if (extra_jack_notches) {
        echo("extra jack notches");
        translate([totalWidth, inch(13/16) + earbudRadius]) mirror([1,0,0]) jackNotchesRow();
    }
    translate([totalWidth, totalHeight+inch(2/4)]) {
      rotate([0, 0, 180-45]) {
        bottomNotch();
      }
    }
    
    // center holes
    if (centerHoles) {
        if(totalHeight >= 80) {
            translate([(totalWidth-centerHoleRadius/2)/2, -centerHoleRadius*2 + (totalHeight)/2]) {
            circle(centerHoleRadius);
            }
        }
        translate([(totalWidth-centerHoleRadius/2)/2, centerHoleRadius*2 + (totalHeight)/2]) {
         circle(centerHoleRadius);
        }
    }
    
  } // difference
}

// Make it 3D, in the positive Z direction.
module cardHalf() {
// Rather than a straight extrude, do 3, with a shrink factor to chamfer the edges.
// The card is centered at [0,0] so the tapered extrusion will have a symmetric taper.
  linear_extrude(0.5, scale=1) {
    translate([-totalWidth/2, -totalHeight/2]) {
     cardWrapFlat();
    }
  }
  translate([0, 0, 0.5]) {
    linear_extrude(0.25, scale=0.99) {
      translate([-totalWidth/2, -totalHeight/2]) {
       cardWrapFlat();
      }
    }
  }
  translate([0, 0, 0.75]) {
    linear_extrude(0.25, scale=0.98) {
      translate([-totalWidth/2, -totalHeight/2]) {
       cardWrapFlat();
      }
    }
  }
}


module emboss() {
    if (card_text != "") {
        textHeightMax = ((totalWidth/2-slotWidth*2) - centerHoleRadius);
        centerline = (centerHoles ? -(textHeightMax/2) - centerHoleRadius : 0);
        translate([-centerline,inch(1/8),1]) 
            rotate([0,0,-90])
                resize([usableHeight,0,1], auto = true)
                    write(card_text, center=true, font=str(font, ".dxf")); 
    }
}

// shameless paste of:
/* Catmull-Rom splines.
  An easy way to model smooth curve that follows a set of points.
  Do "use <tjw-scad/spline.scad>", probably works better than "include".
  Read the module comments below; basic usage is to pass an array of 2D points,
  and specify how many levels of subdivisions you want (more is smoother,
  and each level doubles the number of points) and whether you want a closed loop
  or an open-ended path.

  Issues:
    Many of my models using 'noodles' won't final-render due to internal OpenSCAD issues.
      particularly with Boolean operations.
    Udon example has rough elbows
      do we need to use quaternion interpolation? but there are inherent orientation issues in the example...
      Specifying orientation per-path-vertex may be the only complete solution.

  To do:
    make the cross-section a parameter
      and it could be made from a spline
      and it could interpolate (loft) between several splines, twist, scale
        mustache
    make a version that passes the diameter along with the vector of points
      interpolate it with the same function as for the points
    spline surface
    Consider whether the iterative refinement is appropriate
      Is control over "ease" or "tightening" around control points feasible/desirable?

  Spline implementation based on Kit Wallace's smoothing, from:
  http://kitwallace.tumblr.com/post/84772141699/smooth-knots-from-coordinates
  which was in turn from Oskar's notes at:
  http://forum.openscad.org/smooth-3-D-curves-td7766.html
  See also https://en.wikipedia.org/wiki/Spline_interpolation,
    https://en.wikipedia.org/wiki/Cubic_Hermite_spline,
    https://en.wikipedia.org/wiki/Centripetal_Catmull%E2%80%93Rom_spline - but didn't implement from those.
*/

// ================================================================================
// Spline functions - mostly convenience calls to lower-level primitives.

// Makes a 2D shape that interpolates between the points on the given path,
// with the given width, in the X-Y plane.
module spline_ribbon(path, width=1, subdivisions=4, loop=false)
{
  ribbon(smooth(path, subdivisions, loop), width, loop);
}


// ================================================================================
// Rendering paths and loops

// Makes a 2D shape that connects a series of 2D points on the X-Y plane,
// with the given width.
// If loop is true, connects the ends together.
// If you output this as is, OpenSCAD appears to extrude it linearly by 1 unit,
// centered on Z=0.
module ribbon(path, width=1, loop=false)
{
  union() {
    for (i = [0 : len(path) - (loop? 1 : 2)]) {
      hull() {
        translate(path[i])
          circle(d=width);
        translate(path[(i + 1) % len(path)])
          circle(d=width);
      }
    }
  }
}

// ==================================================================
// Interpolation and path smoothing

// Takes a path of points (any dimensionality),
// and inserts additional points between the points to smooth it.
// Repeats that n times, and returns the result.
// If loop is true, connects the end of the path to the beginning.
function smooth(path, n, loop=false) =
  n == 0
    ? path
    : loop
      ? smooth(subdivide_loop(path), n-1, true)
      : smooth(subdivide(path), n-1, false);

// Takes an open-ended path of points (any dimensionality), 
// and subdivides the interval between each pair of points from i to the end.
// Returns the new path.
function subdivide(path) =
  let(n = len(path))
  flatten(concat([for (i = [0 : 1 : n-1])
    i < n-1? 
      // Emit the current point and the one halfway between current and next.
      [path[i], interpolateOpen(path, n, i)]
    :
      // We're at the end, so just emit the last point.
      [path[i]]
  ]));

// Takes a closed loop points (any dimensionality), 
// and subdivides the interval between each pair of points from i to the end.
// Returns the new path.
function subdivide_loop(path, i=0) = 
  let(n = len(path))
  flatten(concat([for (i = [0 : 1 : n-1])
    [path[i], interpolateClosed(path, n, i)]
  ]));

weight = [-1, 8, 8, -1] / 14;
weight0 = [6, 11, -1] / 16;
weight2 = [1, 1] / 2;

// Interpolate on an open-ended path, with discontinuity at start and end.
// Returns a point between points i and i+1, weighted.
function interpolateOpen(path, n, i) =
  i == 0? 
    n == 2?
      path[i]     * weight2[0] +
      path[i + 1] * weight2[1]
    :
      path[i]     * weight0[0] +
      path[i + 1] * weight0[1] +
      path[i + 2] * weight0[2]
  : i < n - 2?
    path[i - 1] * weight[0] +
    path[i]     * weight[1] +
    path[i + 1] * weight[2] +
    path[i + 2] * weight[3]
  : i < n - 1?
    path[i - 1] * weight0[2] +
    path[i]     * weight0[1] +
    path[i + 1] * weight0[0]
  : 
    path[i];

// Use this to interpolate for a closed loop.
function interpolateClosed(path, n, i) =
  path[(i + n - 1) % n] * weight[0] +
  path[i]               * weight[1] +
  path[(i + 1) % n]     * weight[2] +
  path[(i + 2) % n]     * weight[3] ;
// ==================================================================
// Modeling a noodle: extrusion tools.
// Mostly from Kris Wallace's knot_functions, modified to remove globals
// and to allow for non-looped paths.

// Given a three-dimensional array of points (or a list of lists of points),
// return a single-dimensional vector with all the data.
function flatten(list) = [ for (i = list, v = i) v ]; 

difference() {
    union() {cardHalf();
    // Mirror reflect the bottom half.
        scale([1,1,-1]) {
            cardHalf();
        }
    }    
    // engrave text
    emboss();
}
