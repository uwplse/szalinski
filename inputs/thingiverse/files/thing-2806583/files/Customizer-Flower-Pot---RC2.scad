// Flower Pot Customizer   by Robert Wallace - Mar 2018

// All values in milimeters
// Diameter of base - minimum is set later to 10, maximum to 350
// (mm) measured from outer edge (min 10mm, max 350mm)
base_diameter = 70;

// Height of the pot - min is set later to 10, max to 350
// (mm) measured from bottom to top (min 10mm, max 350mm)
height_of_pot = 80;

// Angle of pot sides - 
// (deg) Number of degrees past vertical
pot_side_angle = 10;   //[0:30]

// Angle of rim - - 
// (deg) Number of degrees past vertical. Not > Pot Side Angle
rim_side_angle = 5;   //[0:30]

// Height of rim - 
// (mm) excluding round-over : '0' gives round rim : S/B << Height of Pot
height_of_rim = 16;   //[0:200]

// Rim thickness - 
// (mm) [0-10] '0' gives no rim
rim_thickness = 2;  

// Drain hole in the bottom? (usually "Yes" for pots)(cancels any risers)
drain_hole = "Yes";  //[Yes,No]

// Note: Drain hole == "Yes" turns off Risers.
// Risers on inside-bottom to let pot drain? (usually "Yes" for saucers) 
pot_risers = "No"; //[Yes,No]

// (mm) Thickness of the side walls [0-6.0] - if 0, software calculates based on diameter
sidewall_thickness = 0;

// (mm) Thickness of the base [0-7.0] - if 0, software calculates based on diameter
base_thickness = 0;

module fake_news()  // to stop customizer from further customizing
{
}

// The sanity ranges.  Any user input outside the min or max is changed to the min or max.
//  These were chosen based on expected use and build sizes.  If you have a huge print volume,
//  feel free to change these to suit you.  No guarantees, however.

min_dia = 10;   // the minimum diameter of the pot's base
max_dia = 350;  // the maximum diameter of the pot's base
min_ht = 8;     // the minimum height of the pot (smaller sizes normally used to make saucers)
max_ht  = 350;  // the maximum height of the pot
min_wthk = 1.0; // the minimum side wall thickness
max_wthk = 6.0; // the maximum side wall thickness
min_bthk = 1.0; // the minimum base thickness
max_bthk = 7.0; // the maximum base thickness
min_rthk = 0;   // the minimum rim thickness (0=no rim)
max_rthk = 10;  // the maximum rim thickness


// There's a lot of flailing around past this point - I reworked the algorithms
//  a half-dozen times, so there's old cruft here and there.  I intend to
//  clean it up one more time and eliminate a few intermediate variables
//  that ended up being used only once.  Even if only used once,
//  I may use a variable to hold the results of long calculations just
//  so I don't have to insert the long calculation in an argument list and
//  break lines all over the place.
//    ( I like a clean, definite right margin in my code. )

$fn = 400;  // Very smooth, but a little slower to generate

// lookup table relating base radius to wall thickness
//  (not quite linear and sets minimums and maximums)
// note: the radius==300 lookup is never reached since software limits radius to 150
wt_tab = [[0,1.25],[10,1.5],[30,2],[60,2.5],[75,3],[100,3.5],[150,4],[300,5]];

// To eliminate the need for supports, build a fillet to connect
//  the bottom of the rim to the side of the pot. The next value is
//  the angle (as measured from noon) of the edge of the fillet.
//  (55 degrees is near the limit of what an fdm printer can print unsupported.)
fill_ang = 55;  // angle of the fillet.

// convert & correct the user's customizer inputs and assign them to variables used internally.
dr_hole = (drain_hole == "Yes") ? 1 : 0;
add_risers = (pot_risers == "Yes") ? 1 : 0;

number_of_risers = 5;  // auto-arranged around the center

// the pot side angle   (note: range is specified in Customizer)
pot_ang = pot_side_angle;// pot sides angle (measured from noon, clockwise) max 43.5 deg
              //  but the fillet starts looking pretty obnoxious after 20 degrees or so
              //  fyi: can't be >= fill_ang or things blow up.

// the rim side angle - check for sanity (note: range is specified in Customizer)
rim_ang = (rim_side_angle <= pot_side_angle &&   // is rim angle <= pot angle ?
           rim_thickness > 0) ?                  // and is user want's a rim?
            rim_side_angle :                     // yes - use rim angle (degrees past vertical)
            pot_side_angle;                      // no - set to pot angle
                                                 // note: can't be < 0 or > pot_ang 
              
// limit the xtremes of user's pot height to program's specified limits
abs_pot_ht = (height_of_pot < min_ht) ? // spec'd height < minimum height?
              min_ht :                  // set to minimum height
             (height_of_pot > max_ht) ? // otherwise check to see if height > maximum height
              max_ht :                  // if it is, set to maximum height
              height_of_pot;            // otherwise use the user's specified height
                                  // this is the pot height before the rounded rim top
                                  //  is lowered to match angle of pot's top edge

pot_ht = abs_pot_ht - 1.4;  // when the rim round-over is set, it's lowered some to edge-match

// limit the extremes of user's base diameter to spec'd limits
//  and convert diameter to radius)
base_rad = (base_diameter/2 < 5) ? 5 : (base_diameter/2 > max_dia/2) ? max_dia/2 : base_diameter/2;  

// adjust user-specified wall, base, and rim thicknesses to be within the specified limits
wall_thk = (sidewall_thickness == 0 ) ? lookup(base_rad, wt_tab) :  // set to 0? then lookup value
           (sidewall_thickness <= min_wthk) ? min_wthk :            //  < min, set to min
           (sidewall_thickness >= max_wthk) ? max_wthk :            //  > max, set to max
            sidewall_thickness;                                     // all OK - use it

base_thk = (base_thickness == 0) ? wall_thk + 1 :        // set to 0? make it 1mm thicker than walls
           (base_thickness <= min_bthk) ? min_bthk :     // else check for extremes and limit them
           (base_thickness >= max_bthk) ? max_bthk :
            base_thickness;


user_rim_thk = (rim_thickness < min_rthk) ? min_rthk :  // check for extremes
              (rim_thickness > max_rthk) ? max_rthk : 
              rim_thickness;

tot_rim_thk = user_rim_thk + wall_thk;   // the total thickness of the rim (incl wall thickness)

// Some sanity settings and programmatically determined settings :

// rim_ht must be some value less than the height of the pot or things blow up
// - lets say 6mm less, but check the output carefully
rim_ht = (height_of_rim < (abs_pot_ht - 6)) ?  // how tall (above zero) is the flat top of the rim
    height_of_rim : abs_pot_ht - 6;          // ( 0 gives a tot_rim_thk cylinder rim)

// Scale the drain hole radius based on pot base radius except min is 2.5 and max is 12
drain_r = (base_rad / 7 < 2.5) ? 2.5 : (base_rad / 7 > 12) ? 12 :base_rad / 7;

bchamf = .8;  // bottom chamfer is 45-degrees -- intended to smooth any elephant-foot on bottom,
              //  this number is how far up the side of the pot the chamfer starts
              //  (larger on bigger pots?)

// Calculate how far out on X axis the top edges (inner and outer) of the pot are
//  based on the angle of the wall (pot_ang).
in_dx = tan(pot_ang) * (pot_ht - base_thk);  // inner edge: from top of base to pot_ht
in_dx2 = tan(pot_ang) * (pot_ht);            // outer edge: from bottom of base to pot_ht
out_dx = tan(rim_ang) * rim_ht;              // how far left to move the rim's top circle

// Building this as a spun polygon has its advantages and its disadvantages.
// One problem is maintaining the specified wall thickness when drawing an outline
//  as the angle of the wall changes instead of just rotating a pre-built rectangle.
//  (Another is rounding over your edges using circles and polygons - seen later.)

// To maintain the wall thickness (cross section) when we're drawing the wall shape at an angle,
//  the x points (x1 and x2) don't give us wall_thick -- that's actually (x1 and x3).  They
//  give us the hypotenuse of a right triangle. (crudely illustrated in fixed font, below.)
//  You have to calculate the distance x1-x2 based on wall_thick (x1-x3)
//
//         x1 ---------------- x2
//           /               /
//          /               / x3
//         /               /

// Actual value of x1-x2 needed to achieve specified wall thickness (x1-x3)
true_x = wall_thk / sin(90-pot_ang);

// Print out the final values used to make the shape.  Customizer won't display output from echo.
echo ("Base Diameter = ",base_diameter);
echo ("Pot Height = ", height_of_pot);
echo ("Pot Side Angle = ", pot_side_angle);
echo ("Rim Side Angle = ", rim_side_angle);
echo ("Rim Thickness = ", rim_thickness, "final rim thickness = ", user_rim_thk);
echo ("Rim Height = ", height_of_rim);
echo ("Drain Hole = ", drain_hole);
echo ("Pot Risers = ", pot_risers);
echo ("Sidewall Thickness = ", sidewall_thickness, "final sidewall thickness = ", wall_thk);
echo ("Base Thickness = ", base_thickness, "final basel thickness = ", base_thk);


// Build the shape polygon and spin it to create the finished pot/saucer/etc.

rotate_extrude()  // comment out rotate_extrude() to see the polygon that will be rotated
{
// everything beyond this point is 2-dimensional
difference()  // lop off any protrusions on the bottom from the silly fillet algorithm
{
union()
{
polygon([
        [(drain_r + base_thk/2) * dr_hole,0],           // origin at drain hole and y==0
        [(drain_r + base_thk/2) * dr_hole,base_thk],    // up to the top of the base
        [base_rad-true_x, base_thk],                    // out to the inside edge of the wall
        [base_rad-true_x + in_dx, pot_ht],              // up to the inner topedge
        [base_rad-true_x + in_dx + true_x, pot_ht],     // out to the outer topedge
// the next two points chop a 45-degree chunk off the pointed edge
//  -- the next-best thing to an actual round-over, and indistinguishable from an
//  actual rounded edge when you only have two or three printed layers to define it.
        [base_rad - (in_dx2 - in_dx) + bchamf/tan(90-pot_ang),bchamf],  // down to start of chamfer
        [base_rad - (in_dx2 - in_dx) + bchamf/tan(90-pot_ang) - bchamf, 0], // in and down to y==0

        [base_rad - (in_dx2 - in_dx), 0],      // 
        [(drain_r + base_thk/2) * dr_hole,0]
       ]);

// put a half-circle at the edge of the drain hole to give a rounded inner edge when rotated
translate([drain_r + base_thk/2,base_thk/2]) 
difference()
{
circle(d=base_thk);
translate([0,-(base_thk+1)/2])
 square([base_thk+1, base_thk+1]);  // remove unseen portion: at low diameters it could protrude
}  // end difference

// The rounded top of the rim has to be re-positioned a bit to account for
//  the angle of the sides of the pot.  The center of the circle forming the top of
//  the rim must remain perpendicular to the side of the pot so there won't be a visible
//  hump on the inside edge.  Wouldn't be a problem if it was placed before angling the sides.
//  Hindsight.

// the exact (x) of the top-inner edge of the pot
pot_top_inner_x = base_rad-true_x + in_dx;
// the exact (x) of the top-center edge of the pot
pot_top_center_x = pot_top_inner_x + true_x/2;

// Calculate x and y offset used to lower the top circle (that creates the top rim's round-over)
// so that its rim is flush with the inside edge of the pot

py = (tot_rim_thk)/2 * cos(90-pot_ang);  // how far down to move the center point of the circle
px = tan(pot_ang) * py;                  // how far in to move the center point

// Need to find the diameter of a circle such that the chord after it has been lowered will be exactly 'true_x' long, thus covering exactly the top of the pot edge

// Since the required new radius is the hypotenuse of a right angle formed by the constrained radius (true_x/2) and the vertical amount that the circle was dropped into the leg (py), pythagorus gives us the length of the hypotenuse: hyp**2 = sqrt ( sum of squares of other two sides )  -- about now, I'm questioning my decision to spin a 2D shape...

needed_radius = sqrt(pow((user_rim_thk + true_x)/2,2) + pow(py,2));

// create the rim by placing two circles at the rim angle and hulling them

hull()
{
// top circle - set on top edge then pulled down and back a little based on angle of the wall
//  This lines up circle's perimeter with top inner edge of pot wall
tmp_x_off = pot_top_inner_x + needed_radius;
translate([pot_top_center_x + user_rim_thk/2 , pot_ht-py]) 
  circle(r=needed_radius);
  
// bottom circle x offset - to put perimeter on the inside edge of the pot
offset_x = tan(pot_ang) * rim_ht;

// bottom circle
translate([pot_top_center_x 
           + user_rim_thk/2
           + needed_radius - tot_rim_thk/2 
          - out_dx,
        pot_ht-py-rim_ht])

   circle(d=tot_rim_thk);

}  // end hull for rim


// Here's the maximum overhang fillet (see 'fill_ang' at the top)
//  [This one was a bear to figure out - ended up having to calculate
//   the (x,y) point where a line tangent to the rim (the fillet) meets
//   another line (the outside of the pot). I can barely remember any
//   high-school geometry as it is.  Please forgive the obvious comments
//   as I document what I calculated so I can remember it next week.]

mo_x = abs(tot_rim_thk/2 * sin(270 - fill_ang)); // intermediate calculations to help find pt on rim
mo_y = abs(tot_rim_thk/2 * cos(270 - fill_ang)); 

// here's the tangent point where the fill_ang slope meets the bottom rim's circle
// x coord of tangent point on circle
tx =  (pot_top_center_x + user_rim_thk/2 + needed_radius - tot_rim_thk/2 - out_dx) + mo_x;
// y coord of tangent point on circle
ty = (pot_ht - py - rim_ht) - mo_y;

// Need to find a point along the outer edge of the pot
//  that will give the polygon a 'fill_ang' angle
//  to the x-axis

// Let's try something - trig and algebra - to find out where the overhang line
//  meets the outside edge of the pot.  

// Need to use y=mx+b for both lines.

// First, the slope of the overhang (the 'm' term)
ov_slope = 1/tan(fill_ang);

// Use the slope to find the y-intercept (the b in y=mx+b)
// To do that, first find the value of x when the line crosses x-axis (y == 0)
base_x = ty / tan(90-fill_ang);
base_x_pt = tx - base_x;

// Now, determine the y-intercept
ov_b = ty - (ov_slope * tx);

// Our overhang equation is now y = (1/tan(fill_ang) * tx + (ty - (ov_slope * tx))
//   or... y-point = (ov_slope * x) + ov_b

// Now do the same for the pot's outer wall
// The bottom pt of the outer edge is  "base_rad - (in_dx2 - in_dx), 0"
// The top pt of the outer edge is "base_rad-true_x + in_dx + true_x, pot_ht"
pot_tox = base_rad-true_x + in_dx + true_x;
pot_box = base_rad - (in_dx2 - in_dx);
pot_slope = (pot_ang == 0) ? 1/tan(.00000000001) : 1/tan(pot_ang);
pot_b = pot_ht - (pot_slope * (base_rad-true_x + in_dx + true_x));

// now have slope and b for both the overhang and the pot side
// lets see where they intersect each other
// (ov_slope * x) + ov_b = (pot_slope * x) + pot_b
// solve for x:
//  (ov_slope * x) - (pot_slope * x) = pot_b - ov_b
//   (ov_slope - pot_slope) * x = pot_b -ov_b
// x = (pot_b - ov_b) / (ov_slope - pot_slope)

// Calculate the point where this actually turns out to be
pot_intrcpt_x = (pot_b - ov_b) / (ov_slope - pot_slope);
pot_intrcpt_y = (pot_slope * pot_intrcpt_x) + pot_b;

// draw the overhang protector triangle in position under the rim
polygon([[tx, ty],[pot_intrcpt_x, pot_intrcpt_y], [pot_tox, pot_ht]]);

}  // end union of all 2-D elements

// the square to lop off protrusions from the no-support fillet
//  (at certain extreme pot side angles, the y-intercept, above,  is < 0)
translate([-150,-300])
 square([300,  300]);
}  // end difference() to lop off rogue protrusions
} // end rotate_extrude()


// add some risers (if this is made without a drain hole)
// -- needs more parameterization - gets screwey at small base diameters
if(!dr_hole)
{

if(add_risers)
 {
 for(i=[0:360/number_of_risers:359])
  {
  //echo(i=i);
  translate([0,0,base_thk])  // how high the risers above 0
  rotate([90,0,i])
   translate([0,0, drain_r+1.5])   // how far out the risers are from the center
    union()
     {  // make the 'cylinder' 3/4 the size of th base thickness
     cylinder(r=base_thk - base_thk/4, h= base_rad - 2*wall_thk - drain_r - 5, $fn=6);
     translate([0,0,0]) sphere(r=base_thk - base_thk/4, $fn=6);
     translate([0,0,base_rad - 2*wall_thk - drain_r - 5]) sphere(r=base_thk - base_thk/4, $fn=6);
     }
  }  // end for loop
 } // end if(add_risers)
} // end if(!dr_hole)
