/* [Global] */

// Part to print.  Desiccant cap is only needed if including desiccant pocket.
part = "all"; // [container:Container,cap:Cap for Container,desiccantcap:Cap for Desiccant Pocket,all:All Parts]

/* [Main] */

// Diameter of inner compartment
compartmentDiameter = 25;

// Height of inner compartment
compartmentHeight = 30;

// Number of concentric o-ring seals
numORings = 2; // [1, 2, 3, 4]

// Whether or not to include external cap clips.  These can help prevent the lid from backing off due to vibration, but increase the unused size of the container.
includeClips_str = "yes";

// Whether or not to include a cavity in the cap for desiccant to be added
includeDesiccantPocket_str = "yes"; // [yes, no]
includeDesiccantPocket = includeDesiccantPocket_str == "yes";

// Thickness/height of the top of the cap
capTopHeight = 7;


/* [Screw Thread] */

// Extra clearance to add to the diameter of threaded connections
extraThreadDiameterClearance = 0.6;

// Metric thread pitch for main container thread
containerThreadPitch = 3;

// Minimum number of screw threads engaged
containerThreadNumTurnsMin = 5;


/* [O-Rings] */

// Series number for o-rings to use.  Larger numbers are larger o-rings.
oRingSeries = 1; // [0, 1, 2, 3, 4]

// Whether to include raised protrusions that dig into the o-rings.  This can increase the sealing ability on 3d-printed objects, but may cause additional wear to the o-rings.
useORingBites_str = "yes"; // [yes, no]
useORingBites = useORingBites_str == "yes";

// Whether to include retaining clips for the o-rings.  These help the o-rings not fall out when opened, but may cause additional wear.
useORingRetainers_str = "yes"; // [yes, no]
useORingRetainers = useORingRetainers_str == "yes";

// Amount of space to leave on each side of the o-ring grooves
oRingGrooveMinBufferWidth = 2;

// Clearance gap between lid and container to use for o-ring gland calculations
oRingSurfaceClearance = 0;

// Height of the raised surface to dig into the o-ring
oRingBiteHeight = 0.2;


/* [Labels] */

// Whether or not to include a label for the desiccant cavity
includeDesiccantLabel_str = "yes"; // [yes, no]
includeDesiccantLabel = includeDesiccantLabel_str == "yes";

// Whether or not to include the o-ring numbers on the inner bottom of the container
includeORingLabel_str = "yes"; // [yes, no]
includeORingLabel = includeORingLabel_str == "yes";

// Text on top of cap
topLabel = "GEOCACHE CONTAINER";

// Text on bottom of container
bottomLabel = "GEOCACHE CONTAINER";

// Text on side of container
sideLabel = "GEOCACHE CONTAINER";


/* [Clips] */

// Number of external cap clips
numClips_cfg = 6;
numClips = includeClips_str == "yes" ? numClips_cfg : 0;

// Angle of deflection for the clips when container is opened and closed.  Higher values result in a more positive lock, but can make the clips prone to breaking off.
clipDeflectionAngle = 3.5;

// Thickness of the clip arm
clipArmThick = 3;

// Desired width of the clip arm
maxClipWidth = 10;

// Minimum length of the clip arm, to the start of the clip protrusion.
clipArmMinLength = 15;

// Gap between clips and outer container wall
clipArmContainerClearance = 0.6;

// Minimum number of thread turns that must be engaged before the clips touch the container body.
minThreadEngagementBeforeClips = 1;


/* [Misc] */

// Thickness of the container wall
wallThick = 3;

// Minimum thickness of any part of the container top overhang, measured from the bottom of the deepest o-ring groove
containerTopMinThick = 2;

// Minimum thickness of the wall of the desiccant pocket/main screw
desiccantPocketWallThick = 2;

// Number of thread turns for the desiccant pocket cap
desiccantThreadNumTurns = 2;


/* [Hidden] */

$fa = 3;
$fs = 0.2;

/*
* ISO-standard metric threads, following this specification:
*          http://en.wikipedia.org/wiki/ISO_metric_screw_thread
*
* Copyright 2017 Dan Kirshner - dan_kirshner@yahoo.com
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* See <http://www.gnu.org/licenses/>.
*
* Version 2.3.  2017-08-31  Default for leadin: 0 (best for internal threads).
* Version 2.2.  2017-01-01  Correction for angle; leadfac option.  (Thanks to
*                           Andrew Allen <a2intl@gmail.com>.)
* Version 2.1.  2016-12-04  Chamfer bottom end (low-z); leadin option.
* Version 2.0.  2016-11-05  Backwards compatibility (earlier OpenSCAD) fixes.
* Version 1.9.  2016-07-03  Option: tapered.
* Version 1.8.  2016-01-08  Option: (non-standard) angle.
* Version 1.7.  2015-11-28  Larger x-increment - for small-diameters.
* Version 1.6.  2015-09-01  Options: square threads, rectangular threads.
* Version 1.5.  2015-06-12  Options: thread_size, groove.
* Version 1.4.  2014-10-17  Use "faces" instead of "triangles" for polyhedron
* Version 1.3.  2013-12-01  Correct loop over turns -- don't have early cut-off
* Version 1.2.  2012-09-09  Use discrete polyhedra rather than linear_extrude ()
* Version 1.1.  2012-09-07  Corrected to right-hand threads!
*/

// Examples.
//
// Standard M8 x 1.
// metric_thread (diameter=8, pitch=1, length=4);

// Square thread.
// metric_thread (diameter=8, pitch=1, length=4, square=true);

// Non-standard: long pitch, same thread size.
//metric_thread (diameter=8, pitch=4, length=4, thread_size=1, groove=true);

// Non-standard: 20 mm diameter, long pitch, square "trough" width 3 mm,
// depth 1 mm.
//metric_thread (diameter=20, pitch=8, length=16, square=true, thread_size=6,
//               groove=true, rectangle=0.333);

// English: 1/4 x 20.
//english_thread (diameter=1/4, threads_per_inch=20, length=1);

// Tapered.  Example -- pipe size 3/4" -- per:
// http://www.engineeringtoolbox.com/npt-national-pipe-taper-threads-d_750.html
// english_thread (diameter=1.05, threads_per_inch=14, length=3/4, taper=1/16);

// Thread for mounting on Rohloff hub.
//difference () {
//   cylinder (r=20, h=10, $fn=100);
//
//   metric_thread (diameter=34, pitch=1, length=10, internal=true, n_starts=6);
//}


// ----------------------------------------------------------------------------
function segments (diameter) = min (50, ceil (diameter*6));


// ----------------------------------------------------------------------------
// diameter -    outside diameter of threads in mm. Default: 8.
// pitch    -    thread axial "travel" per turn in mm.  Default: 1.
// length   -    overall axial length of thread in mm.  Default: 1.
// internal -    true = clearances for internal thread (e.g., a nut).
//               false = clearances for external thread (e.g., a bolt).
//               (Internal threads should be "cut out" from a solid using
//               difference ()).
// n_starts -    Number of thread starts (e.g., DNA, a "double helix," has
//               n_starts=2).  See wikipedia Screw_thread.
// thread_size - (non-standard) axial width of a single thread "V" - independent
//               of pitch.  Default: same as pitch.
// groove      - (non-standard) subtract inverted "V" from cylinder (rather than
//               add protruding "V" to cylinder).
// square      - Square threads (per
//               https://en.wikipedia.org/wiki/Square_thread_form).
// rectangle   - (non-standard) "Rectangular" thread - ratio depth/(axial) width
//               Default: 1 (square).
// angle       - (non-standard) angle (deg) of thread side from perpendicular to
//               axis (default = standard = 30 degrees).
// taper       - diameter change per length (National Pipe Thread/ANSI B1.20.1
//               is 1" diameter per 16" length). Taper decreases from 'diameter'
//               as z increases.
// leadin      - 0 (default): no chamfer; 1: chamfer (45 degree) at max-z end;
//               2: chamfer at both ends, 3: chamfer at z=0 end.
// leadfac     - scale of leadin chamfer (default: 1.0 = 1/2 thread).
module metric_thread (diameter=8, pitch=1, length=1, internal=false, n_starts=1,
thread_size=-1, groove=false, square=false, rectangle=0,
angle=30, taper=0, leadin=0, leadfac=1.0)
{
// thread_size: size of thread "V" different than travel per turn (pitch).
// Default: same as pitch.
local_thread_size = thread_size == -1 ? pitch : thread_size;
local_rectangle = rectangle ? rectangle : 1;

n_segments = segments (diameter);
h = (square || rectangle) ? local_thread_size*local_rectangle/2 : local_thread_size / (2 * tan(angle));

h_fac1 = (square || rectangle) ? 0.90 : 0.625;

// External thread includes additional relief.
h_fac2 = (square || rectangle) ? 0.95 : 5.3/8;

tapered_diameter = diameter - length*taper;

difference () {
union () {
if (! groove) {
metric_thread_turns (diameter, pitch, length, internal, n_starts,
local_thread_size, groove, square, rectangle, angle,
taper);
}

difference () {

// Solid center, including Dmin truncation.
if (groove) {
cylinder (r1=diameter/2, r2=tapered_diameter/2,
h=length, $fn=n_segments);
} else if (internal) {
cylinder (r1=diameter/2 - h*h_fac1, r2=tapered_diameter/2 - h*h_fac1,
h=length, $fn=n_segments);
} else {

// External thread.
cylinder (r1=diameter/2 - h*h_fac2, r2=tapered_diameter/2 - h*h_fac2,
h=length, $fn=n_segments);
}

if (groove) {
metric_thread_turns (diameter, pitch, length, internal, n_starts,
local_thread_size, groove, square, rectangle,
angle, taper);
}
}
}

// chamfer z=0 end if leadin is 2 or 3
if (leadin == 2 || leadin == 3) {
difference () {
cylinder (r=diameter/2 + 1, h=h*h_fac1*leadfac, $fn=n_segments);

cylinder (r2=diameter/2, r1=diameter/2 - h*h_fac1*leadfac, h=h*h_fac1*leadfac,
$fn=n_segments);
}
}

// chamfer z-max end if leadin is 1 or 2.
if (leadin == 1 || leadin == 2) {
translate ([0, 0, length + 0.05 - h*h_fac1*leadfac]) {
difference () {
cylinder (r=diameter/2 + 1, h=h*h_fac1*leadfac, $fn=n_segments);
cylinder (r1=tapered_diameter/2, r2=tapered_diameter/2 - h*h_fac1*leadfac, h=h*h_fac1*leadfac,
$fn=n_segments);
}
}
}
}
}


// ----------------------------------------------------------------------------
// Input units in inches.
// Note: units of measure in drawing are mm!
module english_thread (diameter=0.25, threads_per_inch=20, length=1,
internal=false, n_starts=1, thread_size=-1, groove=false,
square=false, rectangle=0, angle=30, taper=0, leadin=0,
leadfac=1.0)
{
// Convert to mm.
mm_diameter = diameter*25.4;
mm_pitch = (1.0/threads_per_inch)*25.4;
mm_length = length*25.4;

echo (str ("mm_diameter: ", mm_diameter));
echo (str ("mm_pitch: ", mm_pitch));
echo (str ("mm_length: ", mm_length));
metric_thread (mm_diameter, mm_pitch, mm_length, internal, n_starts,
thread_size, groove, square, rectangle, angle, taper, leadin,
leadfac);
}

// ----------------------------------------------------------------------------
module metric_thread_turns (diameter, pitch, length, internal, n_starts,
thread_size, groove, square, rectangle, angle,
taper)
{
// Number of turns needed.
n_turns = floor (length/pitch);

intersection () {

// Start one below z = 0.  Gives an extra turn at each end.
for (i=[-1*n_starts : n_turns+1]) {
translate ([0, 0, i*pitch]) {
metric_thread_turn (diameter, pitch, internal, n_starts,
thread_size, groove, square, rectangle, angle,
taper, i*pitch);
}
}

// Cut to length.
translate ([0, 0, length/2]) {
cube ([diameter*3, diameter*3, length], center=true);
}
}
}


// ----------------------------------------------------------------------------
module metric_thread_turn (diameter, pitch, internal, n_starts, thread_size,
groove, square, rectangle, angle, taper, z)
{
n_segments = segments (diameter);
fraction_circle = 1.0/n_segments;
for (i=[0 : n_segments-1]) {
rotate ([0, 0, i*360*fraction_circle]) {
translate ([0, 0, i*n_starts*pitch*fraction_circle]) {
//current_diameter = diameter - taper*(z + i*n_starts*pitch*fraction_circle);
thread_polyhedron ((diameter - taper*(z + i*n_starts*pitch*fraction_circle))/2,
pitch, internal, n_starts, thread_size, groove,
square, rectangle, angle);
}
}
}
}


// ----------------------------------------------------------------------------
module thread_polyhedron (radius, pitch, internal, n_starts, thread_size,
groove, square, rectangle, angle)
{
n_segments = segments (radius*2);
fraction_circle = 1.0/n_segments;

local_rectangle = rectangle ? rectangle : 1;

h = (square || rectangle) ? thread_size*local_rectangle/2 : thread_size / (2 * tan(angle));
outer_r = radius + (internal ? h/20 : 0); // Adds internal relief.
//echo (str ("outer_r: ", outer_r));

// A little extra on square thread -- make sure overlaps cylinder.
h_fac1 = (square || rectangle) ? 1.1 : 0.875;
inner_r = radius - h*h_fac1; // Does NOT do Dmin_truncation - do later with
// cylinder.

translate_y = groove ? outer_r + inner_r : 0;
reflect_x   = groove ? 1 : 0;

// Make these just slightly bigger (keep in proportion) so polyhedra will
// overlap.
x_incr_outer = (! groove ? outer_r : inner_r) * fraction_circle * 2 * PI * 1.02;
x_incr_inner = (! groove ? inner_r : outer_r) * fraction_circle * 2 * PI * 1.02;
z_incr = n_starts * pitch * fraction_circle * 1.005;

/*
(angles x0 and x3 inner are actually 60 deg)

/\  (x2_inner, z2_inner) [2]
/  \
(x3_inner, z3_inner) /    \
[3]   \     \
|\     \ (x2_outer, z2_outer) [6]
| \    /
|  \  /|
z          |[7]\/ / (x1_outer, z1_outer) [5]
|          |   | /
|   x      |   |/
|  /       |   / (x0_outer, z0_outer) [4]
| /        |  /     (behind: (x1_inner, z1_inner) [1]
|/         | /
y________|          |/
(r)                  / (x0_inner, z0_inner) [0]

*/

x1_outer = outer_r * fraction_circle * 2 * PI;

z0_outer = (outer_r - inner_r) * tan(angle);
//echo (str ("z0_outer: ", z0_outer));

//polygon ([[inner_r, 0], [outer_r, z0_outer],
//        [outer_r, 0.5*pitch], [inner_r, 0.5*pitch]]);
z1_outer = z0_outer + z_incr;

// Give internal square threads some clearance in the z direction, too.
bottom = internal ? 0.235 : 0.25;
top    = internal ? 0.765 : 0.75;

translate ([0, translate_y, 0]) {
mirror ([reflect_x, 0, 0]) {

if (square || rectangle) {

// Rule for face ordering: look at polyhedron from outside: points must
// be in clockwise order.
polyhedron (
points = [
[-x_incr_inner/2, -inner_r, bottom*thread_size],         // [0]
[x_incr_inner/2, -inner_r, bottom*thread_size + z_incr], // [1]
[x_incr_inner/2, -inner_r, top*thread_size + z_incr],    // [2]
[-x_incr_inner/2, -inner_r, top*thread_size],            // [3]

[-x_incr_outer/2, -outer_r, bottom*thread_size],         // [4]
[x_incr_outer/2, -outer_r, bottom*thread_size + z_incr], // [5]
[x_incr_outer/2, -outer_r, top*thread_size + z_incr],    // [6]
[-x_incr_outer/2, -outer_r, top*thread_size]             // [7]
],

faces = [
[0, 3, 7, 4],  // This-side trapezoid

[1, 5, 6, 2],  // Back-side trapezoid

[0, 1, 2, 3],  // Inner rectangle

[4, 7, 6, 5],  // Outer rectangle

// These are not planar, so do with separate triangles.
[7, 2, 6],     // Upper rectangle, bottom
[7, 3, 2],     // Upper rectangle, top

[0, 5, 1],     // Lower rectangle, bottom
[0, 4, 5]      // Lower rectangle, top
]
);
} else {

// Rule for face ordering: look at polyhedron from outside: points must
// be in clockwise order.
polyhedron (
points = [
[-x_incr_inner/2, -inner_r, 0],                        // [0]
[x_incr_inner/2, -inner_r, z_incr],                    // [1]
[x_incr_inner/2, -inner_r, thread_size + z_incr],      // [2]
[-x_incr_inner/2, -inner_r, thread_size],              // [3]

[-x_incr_outer/2, -outer_r, z0_outer],                 // [4]
[x_incr_outer/2, -outer_r, z0_outer + z_incr],         // [5]
[x_incr_outer/2, -outer_r, thread_size - z0_outer + z_incr], // [6]
[-x_incr_outer/2, -outer_r, thread_size - z0_outer]    // [7]
],

faces = [
[0, 3, 7, 4],  // This-side trapezoid

[1, 5, 6, 2],  // Back-side trapezoid

[0, 1, 2, 3],  // Inner rectangle

[4, 7, 6, 5],  // Outer rectangle

// These are not planar, so do with separate triangles.
[7, 2, 6],     // Upper rectangle, bottom
[7, 3, 2],     // Upper rectangle, top

[0, 5, 1],     // Lower rectangle, bottom
[0, 4, 5]      // Lower rectangle, top
]
);
}
}
}
}


// From http://forum.openscad.org/rotate-extrude-angle-always-360-td19035.html

module rotate_extrude2(angle=360, convexity=2, size=1000) {

module angle_cut(angle=90,size=1000) {
x = size*cos(angle/2);
y = size*sin(angle/2);
translate([0,0,-size])
linear_extrude(2*size) polygon([[0,0],[x,y],[x,size],[-size,size],[-size,-size],[x,-size],[x,-y]]);
}

// support for angle parameter in rotate_extrude was added after release 2015.03
// Thingiverse customizer is still on 2015.03
angleSupport = (version_num() > 20150399) ? true : false; // Next openscad releases after 2015.03.xx will have support angle parameter
// Using angle parameter when possible provides huge speed boost, avoids a difference operation

if (angleSupport || angle == 360) {
rotate_extrude(angle=angle,convexity=convexity)
children();
} else {
rotate([0,0,angle/2]) difference() {
rotate_extrude(convexity=convexity) children();
angle_cut(angle, size);
}
}
}

// DashNumber,ID_Inch,ID_Tolerance_Inch,CS_Inch,CS_Tolerance_Inch,ID_mm,ID_Tolerance_mm,CS_mm,CS_Tolerance_mm
oRingTable = [
[001,0.029,0.004,0.040,0.003,0.74,0.10,1.02,0.08],
[002,0.042,0.004,0.050,0.003,1.07,0.10,1.27,0.08],
[003,0.056,0.004,0.060,0.003,1.42,0.10,1.52,0.08],
[004,0.070,0.005,0.070,0.003,1.78,0.13,1.78,0.08],
[005,0.101,0.005,0.070,0.003,2.57,0.13,1.78,0.08],
[006,0.114,0.005,0.070,0.003,2.90,0.13,1.78,0.08],
[007,0.145,0.005,0.070,0.003,3.68,0.13,1.78,0.08],
[008,0.176,0.005,0.070,0.003,4.47,0.13,1.78,0.08],
[009,0.208,0.005,0.070,0.003,5.28,0.13,1.78,0.08],
[010,0.239,0.005,0.070,0.003,6.07,0.13,1.78,0.08],
[011,0.301,0.005,0.070,0.003,7.65,0.13,1.78,0.08],
[012,0.364,0.005,0.070,0.003,9.25,0.13,1.78,0.08],
[013,0.426,0.005,0.070,0.003,10.82,0.13,1.78,0.08],
[014,0.489,0.005,0.070,0.003,12.42,0.13,1.78,0.08],
[015,0.551,0.007,0.070,0.003,14.00,0.18,1.78,0.08],
[016,0.614,0.009,0.070,0.003,15.60,0.23,1.78,0.08],
[017,0.676,0.009,0.070,0.003,17.17,0.23,1.78,0.08],
[018,0.739,0.009,0.070,0.003,18.77,0.23,1.78,0.08],
[019,0.801,0.009,0.070,0.003,20.35,0.23,1.78,0.08],
[020,0.864,0.009,0.070,0.003,21.95,0.23,1.78,0.08],
[021,0.926,0.009,0.070,0.003,23.52,0.23,1.78,0.08],
[022,0.989,0.010,0.070,0.003,25.12,0.25,1.78,0.08],
[023,1.051,0.010,0.070,0.003,26.70,0.25,1.78,0.08],
[024,1.114,0.010,0.070,0.003,28.30,0.25,1.78,0.08],
[025,1.176,0.011,0.070,0.003,29.87,0.28,1.78,0.08],
[026,1.239,0.011,0.070,0.003,31.47,0.28,1.78,0.08],
[027,1.301,0.011,0.070,0.003,33.05,0.28,1.78,0.08],
[028,1.364,0.013,0.070,0.003,34.65,0.33,1.78,0.08],
[029,1.489,0.013,0.070,0.003,37.82,0.33,1.78,0.08],
[030,1.614,0.013,0.070,0.003,41.00,0.33,1.78,0.08],
[031,1.739,0.015,0.070,0.003,44.17,0.38,1.78,0.08],
[032,1.864,0.015,0.070,0.003,47.35,0.38,1.78,0.08],
[033,1.989,0.018,0.070,0.003,50.52,0.46,1.78,0.08],
[034,2.114,0.018,0.070,0.003,53.70,0.46,1.78,0.08],
[035,2.239,0.018,0.070,0.003,56.87,0.46,1.78,0.08],
[036,2.364,0.018,0.070,0.003,60.05,0.46,1.78,0.08],
[037,2.489,0.018,0.070,0.003,63.22,0.46,1.78,0.08],
[038,2.614,0.020,0.070,0.003,66.40,0.51,1.78,0.08],
[039,2.739,0.020,0.070,0.003,69.57,0.51,1.78,0.08],
[040,2.864,0.020,0.070,0.003,72.75,0.51,1.78,0.08],
[041,2.989,0.024,0.070,0.003,75.92,0.61,1.78,0.08],
[042,3.239,0.024,0.070,0.003,82.27,0.61,1.78,0.08],
[043,3.489,0.024,0.070,0.003,88.62,0.61,1.78,0.08],
[044,3.739,0.027,0.070,0.003,94.97,0.69,1.78,0.08],
[045,3.989,0.027,0.070,0.003,101.32,0.69,1.78,0.08],
[046,4.239,0.030,0.070,0.003,107.67,0.76,1.78,0.08],
[047,4.489,0.030,0.070,0.003,114.02,0.76,1.78,0.08],
[048,4.739,0.030,0.070,0.003,120.37,0.76,1.78,0.08],
[049,4.989,0.037,0.070,0.003,126.72,0.94,1.78,0.08],
[050,5.239,0.037,0.070,0.003,133.07,0.94,1.78,0.08],
[102,0.049,0.005,0.103,0.003,1.24,0.13,2.62,0.08],
[103,0.081,0.005,0.103,0.003,2.06,0.13,2.62,0.08],
[104,0.112,0.005,0.103,0.003,2.84,0.13,2.62,0.08],
[105,0.143,0.005,0.103,0.003,3.63,0.13,2.62,0.08],
[106,0.174,0.005,0.103,0.003,4.42,0.13,2.62,0.08],
[107,0.206,0.005,0.103,0.003,5.23,0.13,2.62,0.08],
[108,0.237,0.005,0.103,0.003,6.02,0.13,2.62,0.08],
[109,0.299,0.005,0.103,0.003,7.59,0.13,2.62,0.08],
[110,0.362,0.005,0.103,0.003,9.19,0.13,2.62,0.08],
[111,0.424,0.005,0.103,0.003,10.77,0.13,2.62,0.08],
[112,0.487,0.005,0.103,0.003,12.37,0.13,2.62,0.08],
[113,0.549,0.007,0.103,0.003,13.94,0.18,2.62,0.08],
[114,0.612,0.009,0.103,0.003,15.54,0.23,2.62,0.08],
[115,0.674,0.009,0.103,0.003,17.12,0.23,2.62,0.08],
[116,0.737,0.009,0.103,0.003,18.72,0.23,2.62,0.08],
[117,0.799,0.010,0.103,0.003,20.29,0.25,2.62,0.08],
[118,0.862,0.010,0.103,0.003,21.89,0.25,2.62,0.08],
[119,0.924,0.010,0.103,0.003,23.47,0.25,2.62,0.08],
[120,0.987,0.010,0.103,0.003,25.07,0.25,2.62,0.08],
[121,1.049,0.010,0.103,0.003,26.64,0.25,2.62,0.08],
[122,1.112,0.010,0.103,0.003,28.24,0.25,2.62,0.08],
[123,1.174,0.012,0.103,0.003,29.82,0.30,2.62,0.08],
[124,1.237,0.012,0.103,0.003,31.42,0.30,2.62,0.08],
[125,1.299,0.012,0.103,0.003,32.99,0.30,2.62,0.08],
[126,1.362,0.012,0.103,0.003,34.59,0.30,2.62,0.08],
[127,1.424,0.012,0.103,0.003,36.17,0.30,2.62,0.08],
[128,1.487,0.012,0.103,0.003,37.77,0.30,2.62,0.08],
[129,1.549,0.015,0.103,0.003,39.34,0.38,2.62,0.08],
[130,1.612,0.015,0.103,0.003,40.94,0.38,2.62,0.08],
[131,1.674,0.015,0.103,0.003,42.52,0.38,2.62,0.08],
[132,1.737,0.015,0.103,0.003,44.12,0.38,2.62,0.08],
[133,1.799,0.015,0.103,0.003,45.69,0.38,2.62,0.08],
[134,1.862,0.015,0.103,0.003,47.29,0.38,2.62,0.08],
[135,1.925,0.017,0.103,0.003,48.90,0.43,2.62,0.08],
[136,1.987,0.017,0.103,0.003,50.47,0.43,2.62,0.08],
[137,2.050,0.017,0.103,0.003,52.07,0.43,2.62,0.08],
[138,2.112,0.017,0.103,0.003,53.64,0.43,2.62,0.08],
[139,2.175,0.017,0.103,0.003,55.25,0.43,2.62,0.08],
[140,2.237,0.017,0.103,0.003,56.82,0.43,2.62,0.08],
[141,2.300,0.020,0.103,0.003,58.42,0.51,2.62,0.08],
[142,2.362,0.020,0.103,0.003,59.99,0.51,2.62,0.08],
[143,2.425,0.020,0.103,0.003,61.60,0.51,2.62,0.08],
[144,2.487,0.020,0.103,0.003,63.17,0.51,2.62,0.08],
[145,2.550,0.020,0.103,0.003,64.77,0.51,2.62,0.08],
[146,2.612,0.020,0.103,0.003,66.34,0.51,2.62,0.08],
[147,2.675,0.022,0.103,0.003,67.95,0.56,2.62,0.08],
[148,2.737,0.022,0.103,0.003,69.52,0.56,2.62,0.08],
[149,2.800,0.022,0.103,0.003,71.12,0.56,2.62,0.08],
[150,2.862,0.022,0.103,0.003,72.69,0.56,2.62,0.08],
[151,2.987,0.024,0.103,0.003,75.87,0.61,2.62,0.08],
[152,3.237,0.024,0.103,0.003,82.22,0.61,2.62,0.08],
[153,3.487,0.024,0.103,0.003,88.57,0.61,2.62,0.08],
[154,3.737,0.028,0.103,0.003,94.92,0.71,2.62,0.08],
[155,3.987,0.028,0.103,0.003,101.27,0.71,2.62,0.08],
[156,4.237,0.030,0.103,0.003,107.62,0.76,2.62,0.08],
[157,4.487,0.030,0.103,0.003,113.97,0.76,2.62,0.08],
[158,4.737,0.030,0.103,0.003,120.32,0.76,2.62,0.08],
[159,4.987,0.035,0.103,0.003,126.67,0.89,2.62,0.08],
[160,5.237,0.035,0.103,0.003,133.02,0.89,2.62,0.08],
[161,5.487,0.035,0.103,0.003,139.37,0.89,2.62,0.08],
[162,5.737,0.035,0.103,0.003,145.72,0.89,2.62,0.08],
[163,5.987,0.035,0.103,0.003,152.07,0.89,2.62,0.08],
[164,6.237,0.040,0.103,0.003,158.42,1.02,2.62,0.08],
[165,6.487,0.040,0.103,0.003,164.77,1.02,2.62,0.08],
[166,6.737,0.040,0.103,0.003,171.12,1.02,2.62,0.08],
[167,6.987,0.040,0.103,0.003,177.47,1.02,2.62,0.08],
[168,7.237,0.045,0.103,0.003,183.82,1.14,2.62,0.08],
[169,7.487,0.045,0.103,0.003,190.17,1.14,2.62,0.08],
[170,7.737,0.045,0.103,0.003,196.52,1.14,2.62,0.08],
[171,7.987,0.045,0.103,0.003,202.87,1.14,2.62,0.08],
[172,8.237,0.050,0.103,0.003,209.22,1.27,2.62,0.08],
[173,8.487,0.050,0.103,0.003,215.57,1.27,2.62,0.08],
[174,8.737,0.050,0.103,0.003,221.92,1.27,2.62,0.08],
[175,8.987,0.050,0.103,0.003,228.27,1.27,2.62,0.08],
[176,9.237,0.055,0.103,0.003,234.62,1.40,2.62,0.08],
[177,9.487,0.055,0.103,0.003,240.97,1.40,2.62,0.08],
[178,9.737,0.055,0.103,0.003,247.32,1.40,2.62,0.08],
[201,0.171,0.005,0.139,0.004,4.34,0.13,3.53,0.10],
[202,0.234,0.005,0.139,0.004,5.94,0.13,3.53,0.10],
[203,0.296,0.005,0.139,0.004,7.52,0.13,3.53,0.10],
[204,0.359,0.005,0.139,0.004,9.12,0.13,3.53,0.10],
[205,0.421,0.005,0.139,0.004,10.69,0.13,3.53,0.10],
[206,0.484,0.005,0.139,0.004,12.29,0.13,3.53,0.10],
[207,0.546,0.007,0.139,0.004,13.87,0.18,3.53,0.10],
[208,0.609,0.009,0.139,0.004,15.47,0.23,3.53,0.10],
[209,0.671,0.009,0.139,0.004,17.04,0.23,3.53,0.10],
[210,0.734,0.010,0.139,0.004,18.64,0.25,3.53,0.10],
[211,0.796,0.010,0.139,0.004,20.22,0.25,3.53,0.10],
[212,0.859,0.010,0.139,0.004,21.82,0.25,3.53,0.10],
[213,0.921,0.010,0.139,0.004,23.39,0.25,3.53,0.10],
[214,0.984,0.010,0.139,0.004,24.99,0.25,3.53,0.10],
[215,1.046,0.010,0.139,0.004,26.57,0.25,3.53,0.10],
[216,1.109,0.012,0.139,0.004,28.17,0.30,3.53,0.10],
[217,1.171,0.012,0.139,0.004,29.74,0.30,3.53,0.10],
[218,1.234,0.012,0.139,0.004,31.34,0.30,3.53,0.10],
[219,1.296,0.012,0.139,0.004,32.92,0.30,3.53,0.10],
[220,1.359,0.012,0.139,0.004,34.52,0.30,3.53,0.10],
[221,1.421,0.012,0.139,0.004,36.09,0.30,3.53,0.10],
[222,1.484,0.015,0.139,0.004,37.69,0.38,3.53,0.10],
[223,1.609,0.015,0.139,0.004,40.87,0.38,3.53,0.10],
[224,1.734,0.015,0.139,0.004,44.04,0.38,3.53,0.10],
[225,1.859,0.018,0.139,0.004,47.22,0.46,3.53,0.10],
[226,1.984,0.018,0.139,0.004,50.39,0.46,3.53,0.10],
[227,2.109,0.018,0.139,0.004,53.57,0.46,3.53,0.10],
[228,2.234,0.020,0.139,0.004,56.74,0.51,3.53,0.10],
[229,2.359,0.020,0.139,0.004,59.92,0.51,3.53,0.10],
[230,2.484,0.020,0.139,0.004,63.09,0.51,3.53,0.10],
[231,2.609,0.020,0.139,0.004,66.27,0.51,3.53,0.10],
[232,2.734,0.024,0.139,0.004,69.44,0.61,3.53,0.10],
[233,2.859,0.024,0.139,0.004,72.62,0.61,3.53,0.10],
[234,2.984,0.024,0.139,0.004,75.79,0.61,3.53,0.10],
[235,3.109,0.024,0.139,0.004,78.97,0.61,3.53,0.10],
[236,3.234,0.024,0.139,0.004,82.14,0.61,3.53,0.10],
[237,3.359,0.024,0.139,0.004,85.32,0.61,3.53,0.10],
[238,3.484,0.024,0.139,0.004,88.49,0.61,3.53,0.10],
[239,3.609,0.024,0.139,0.004,91.67,0.61,3.53,0.10],
[240,3.734,0.028,0.139,0.004,94.84,0.71,3.53,0.10],
[241,3.859,0.028,0.139,0.004,98.02,0.71,3.53,0.10],
[242,3.984,0.028,0.139,0.004,101.19,0.71,3.53,0.10],
[243,4.109,0.028,0.139,0.004,104.37,0.71,3.53,0.10],
[244,4.234,0.030,0.139,0.004,107.54,0.76,3.53,0.10],
[245,4.359,0.030,0.139,0.004,110.72,0.76,3.53,0.10],
[246,4.484,0.030,0.139,0.004,113.89,0.76,3.53,0.10],
[247,4.609,0.030,0.139,0.004,117.07,0.76,3.53,0.10],
[248,4.734,0.030,0.139,0.004,120.24,0.76,3.53,0.10],
[249,4.859,0.035,0.139,0.004,123.42,0.89,3.53,0.10],
[250,4.984,0.035,0.139,0.004,126.59,0.89,3.53,0.10],
[251,5.109,0.035,0.139,0.004,129.77,0.89,3.53,0.10],
[252,5.234,0.035,0.139,0.004,132.94,0.89,3.53,0.10],
[253,5.359,0.035,0.139,0.004,136.12,0.89,3.53,0.10],
[254,5.484,0.035,0.139,0.004,139.29,0.89,3.53,0.10],
[255,5.609,0.035,0.139,0.004,142.47,0.89,3.53,0.10],
[256,5.734,0.035,0.139,0.004,145.64,0.89,3.53,0.10],
[257,5.859,0.035,0.139,0.004,148.82,0.89,3.53,0.10],
[258,5.984,0.035,0.139,0.004,151.99,0.89,3.53,0.10],
[259,6.234,0.040,0.139,0.004,158.34,1.02,3.53,0.10],
[260,6.484,0.040,0.139,0.004,164.69,1.02,3.53,0.10],
[261,6.734,0.040,0.139,0.004,171.04,1.02,3.53,0.10],
[262,6.984,0.040,0.139,0.004,177.39,1.02,3.53,0.10],
[263,7.234,0.045,0.139,0.004,183.74,1.14,3.53,0.10],
[264,7.484,0.045,0.139,0.004,190.09,1.14,3.53,0.10],
[265,7.734,0.045,0.139,0.004,196.44,1.14,3.53,0.10],
[266,7.984,0.045,0.139,0.004,202.79,1.14,3.53,0.10],
[267,8.234,0.050,0.139,0.004,209.14,1.27,3.53,0.10],
[268,8.484,0.050,0.139,0.004,215.49,1.27,3.53,0.10],
[269,8.734,0.050,0.139,0.004,221.84,1.27,3.53,0.10],
[270,8.984,0.050,0.139,0.004,228.19,1.27,3.53,0.10],
[271,9.234,0.055,0.139,0.004,234.54,1.40,3.53,0.10],
[272,9.484,0.055,0.139,0.004,240.89,1.40,3.53,0.10],
[273,9.734,0.055,0.139,0.004,247.24,1.40,3.53,0.10],
[274,9.984,0.055,0.139,0.004,253.59,1.40,3.53,0.10],
[275,10.484,0.055,0.139,0.004,266.29,1.40,3.53,0.10],
[276,10.984,0.065,0.139,0.004,278.99,1.65,3.53,0.10],
[277,11.484,0.065,0.139,0.004,291.69,1.65,3.53,0.10],
[278,11.984,0.065,0.139,0.004,304.39,1.65,3.53,0.10],
[279,12.984,0.065,0.139,0.004,329.79,1.65,3.53,0.10],
[280,13.984,0.065,0.139,0.004,355.19,1.65,3.53,0.10],
[281,14.984,0.065,0.139,0.004,380.59,1.65,3.53,0.10],
[282,15.955,0.075,0.139,0.004,405.26,1.91,3.53,0.10],
[283,16.955,0.080,0.139,0.004,430.66,2.03,3.53,0.10],
[284,17.955,0.085,0.139,0.004,459.06,2.16,3.53,0.10],
[309,0.412,0.005,0.210,0.005,10.46,0.13,5.33,0.13],
[310,0.475,0.005,0.210,0.005,12.07,0.13,5.33,0.13],
[311,0.537,0.007,0.210,0.005,13.64,0.18,5.33,0.13],
[312,0.600,0.009,0.210,0.005,15.24,0.23,5.33,0.13],
[313,0.662,0.009,0.210,0.005,16.81,0.23,5.33,0.13],
[314,0.725,0.010,0.210,0.005,18.42,0.25,5.33,0.13],
[315,0.787,0.010,0.210,0.005,19.99,0.25,5.33,0.13],
[316,0.850,0.010,0.210,0.005,21.59,0.25,5.33,0.13],
[317,0.912,0.010,0.210,0.005,23.16,0.25,5.33,0.13],
[318,0.975,0.010,0.210,0.005,24.77,0.25,5.33,0.13],
[319,1.034,0.010,0.210,0.005,26.26,0.25,5.33,0.13],
[320,1.100,0.012,0.210,0.005,27.94,0.30,5.33,0.13],
[321,1.162,0.012,0.210,0.005,29.51,0.30,5.33,0.13],
[322,1.225,0.012,0.210,0.005,31.12,0.30,5.33,0.13],
[323,1.287,0.012,0.210,0.005,32.69,0.30,5.33,0.13],
[324,1.350,0.012,0.210,0.005,34.29,0.30,5.33,0.13],
[325,1.475,0.015,0.210,0.005,37.47,0.38,5.33,0.13],
[326,1.600,0.015,0.210,0.005,40.64,0.38,5.33,0.13],
[327,1.725,0.015,0.210,0.005,43.82,0.38,5.33,0.13],
[328,1.850,0.015,0.210,0.005,46.99,0.38,5.33,0.13],
[329,1.975,0.018,0.210,0.005,50.17,0.46,5.33,0.13],
[330,2.100,0.018,0.210,0.005,53.34,0.46,5.33,0.13],
[331,2.225,0.018,0.210,0.005,56.52,0.46,5.33,0.13],
[332,2.350,0.018,0.210,0.005,59.69,0.46,5.33,0.13],
[333,2.475,0.020,0.210,0.005,62.87,0.51,5.33,0.13],
[334,2.600,0.020,0.210,0.005,66.04,0.51,5.33,0.13],
[335,2.725,0.020,0.210,0.005,69.22,0.51,5.33,0.13],
[336,2.850,0.020,0.210,0.005,72.39,0.51,5.33,0.13],
[337,2.975,0.024,0.210,0.005,75.57,0.61,5.33,0.13],
[338,3.100,0.024,0.210,0.005,78.74,0.61,5.33,0.13],
[339,3.225,0.024,0.210,0.005,81.92,0.61,5.33,0.13],
[340,3.350,0.024,0.210,0.005,85.09,0.61,5.33,0.13],
[341,3.475,0.024,0.210,0.005,88.27,0.61,5.33,0.13],
[342,3.600,0.028,0.210,0.005,91.44,0.71,5.33,0.13],
[343,3.725,0.028,0.210,0.005,94.62,0.71,5.33,0.13],
[344,3.850,0.028,0.210,0.005,97.79,0.71,5.33,0.13],
[345,3.975,0.028,0.210,0.005,100.97,0.71,5.33,0.13],
[346,4.100,0.028,0.210,0.005,104.14,0.71,5.33,0.13],
[347,4.225,0.030,0.210,0.005,107.32,0.76,5.33,0.13],
[348,4.350,0.030,0.210,0.005,110.49,0.76,5.33,0.13],
[349,4.475,0.030,0.210,0.005,113.67,0.76,5.33,0.13],
[350,4.600,0.030,0.210,0.005,116.84,0.76,5.33,0.13],
[351,4.725,0.030,0.210,0.005,120.02,0.76,5.33,0.13],
[352,4.850,0.030,0.210,0.005,123.19,0.76,5.33,0.13],
[353,4.975,0.037,0.210,0.005,126.37,0.94,5.33,0.13],
[354,5.100,0.037,0.210,0.005,129.54,0.94,5.33,0.13],
[355,5.225,0.037,0.210,0.005,132.72,0.94,5.33,0.13],
[356,5.350,0.037,0.210,0.005,135.89,0.94,5.33,0.13],
[357,5.475,0.037,0.210,0.005,139.07,0.94,5.33,0.13],
[358,5.600,0.037,0.210,0.005,142.24,0.94,5.33,0.13],
[359,5.725,0.037,0.210,0.005,145.42,0.94,5.33,0.13],
[360,5.850,0.037,0.210,0.005,148.59,0.94,5.33,0.13],
[361,5.975,0.037,0.210,0.005,151.77,0.94,5.33,0.13],
[362,6.225,0.040,0.210,0.005,158.12,1.02,5.33,0.13],
[363,6.475,0.040,0.210,0.005,164.47,1.02,5.33,0.13],
[364,6.725,0.040,0.210,0.005,170.82,1.02,5.33,0.13],
[365,6.975,0.040,0.210,0.005,177.17,1.02,5.33,0.13],
[366,7.225,0.045,0.210,0.005,183.52,1.14,5.33,0.13],
[367,7.475,0.045,0.210,0.005,189.87,1.14,5.33,0.13],
[368,7.725,0.045,0.210,0.005,196.22,1.14,5.33,0.13],
[369,7.975,0.045,0.210,0.005,202.57,1.14,5.33,0.13],
[370,8.225,0.050,0.210,0.005,208.92,1.27,5.33,0.13],
[371,8.475,0.050,0.210,0.005,215.27,1.27,5.33,0.13],
[372,8.725,0.050,0.210,0.005,221.62,1.27,5.33,0.13],
[373,8.975,0.050,0.210,0.005,227.97,1.27,5.33,0.13],
[374,9.225,0.055,0.210,0.005,234.32,1.40,5.33,0.13],
[375,9.475,0.055,0.210,0.005,240.67,1.40,5.33,0.13],
[376,9.725,0.055,0.210,0.005,247.02,1.40,5.33,0.13],
[377,9.925,0.055,0.210,0.005,253.37,1.40,5.33,0.13],
[378,10.475,0.060,0.210,0.005,266.07,1.52,5.33,0.13],
[379,10.975,0.060,0.210,0.005,278.77,1.52,5.33,0.13],
[380,11.475,0.065,0.210,0.005,291.47,1.65,5.33,0.13],
[381,11.975,0.065,0.210,0.005,304.17,1.65,5.33,0.13],
[382,12.975,0.065,0.210,0.005,329.57,1.65,5.33,0.13],
[383,13.975,0.070,0.210,0.005,354.97,1.78,5.33,0.13],
[384,14.975,0.070,0.210,0.005,380.37,1.78,5.33,0.13],
[385,15.955,0.075,0.210,0.005,405.26,1.91,5.33,0.13],
[386,16.955,0.075,0.210,0.005,430.66,1.91,5.33,0.13],
[387,17.955,0.085,0.210,0.005,456.06,2.16,5.33,0.13],
[388,18.955,0.090,0.210,0.005,481.46,2.29,5.33,0.13],
[389,19.955,0.095,0.210,0.005,506.86,2.41,5.33,0.13],
[390,20.955,0.095,0.210,0.005,532.26,2.41,5.33,0.13],
[425,4.475,0.033,0.275,0.006,113.67,0.84,6.99,0.15],
[426,4.600,0.033,0.275,0.006,116.84,0.84,6.99,0.15],
[427,4.725,0.033,0.275,0.006,120.02,0.84,6.99,0.15],
[428,4.850,0.033,0.275,0.006,123.19,0.84,6.99,0.15],
[429,4.975,0.037,0.275,0.006,126.37,0.94,6.99,0.15],
[430,5.100,0.037,0.275,0.006,129.54,0.94,6.99,0.15],
[431,5.225,0.037,0.275,0.006,132.72,0.94,6.99,0.15],
[432,5.350,0.037,0.275,0.006,135.89,0.94,6.99,0.15],
[433,5.475,0.037,0.275,0.006,139.07,0.94,6.99,0.15],
[434,5.600,0.037,0.275,0.006,142.24,0.94,6.99,0.15],
[435,5.725,0.037,0.275,0.006,145.42,0.94,6.99,0.15],
[436,5.850,0.037,0.275,0.006,148.59,0.94,6.99,0.15],
[437,5.975,0.037,0.275,0.006,151.77,0.94,6.99,0.15],
[438,6.225,0.040,0.275,0.006,158.12,1.02,6.99,0.15],
[439,6.475,0.040,0.275,0.006,164.47,1.02,6.99,0.15],
[440,6.725,0.040,0.275,0.006,170.82,1.02,6.99,0.15],
[441,6.975,0.040,0.275,0.006,177.17,1.02,6.99,0.15],
[442,7.225,0.045,0.275,0.006,183.52,1.14,6.99,0.15],
[443,7.475,0.045,0.275,0.006,189.87,1.14,6.99,0.15],
[444,7.725,0.045,0.275,0.006,196.22,1.14,6.99,0.15],
[445,7.975,0.045,0.275,0.006,202.57,1.14,6.99,0.15],
[446,8.475,0.055,0.275,0.006,215.27,1.40,6.99,0.15],
[447,8.975,0.055,0.275,0.006,227.97,1.40,6.99,0.15],
[448,9.475,0.055,0.275,0.006,240.67,1.40,6.99,0.15],
[449,9.975,0.055,0.275,0.006,253.37,1.40,6.99,0.15],
[450,10.475,0.060,0.275,0.006,266.07,1.52,6.99,0.15],
[451,10.975,0.060,0.275,0.006,278.77,1.52,6.99,0.15],
[452,11.475,0.060,0.275,0.006,291.47,1.52,6.99,0.15],
[453,11.975,0.060,0.275,0.006,304.17,1.52,6.99,0.15],
[454,12.475,0.060,0.275,0.006,316.87,1.52,6.99,0.15],
[455,12.975,0.060,0.275,0.006,329.57,1.52,6.99,0.15],
[456,13.475,0.070,0.275,0.006,342.27,1.78,6.99,0.15],
[457,13.975,0.070,0.275,0.006,354.97,1.78,6.99,0.15],
[458,14.475,0.070,0.275,0.006,367.67,1.78,6.99,0.15],
[459,14.975,0.070,0.275,0.006,380.37,1.78,6.99,0.15],
[460,15.475,0.070,0.275,0.006,393.07,1.78,6.99,0.15],
[461,15.955,0.075,0.275,0.006,405.26,1.91,6.99,0.15],
[462,16.455,0.075,0.275,0.006,417.96,1.91,6.99,0.15],
[463,16.955,0.080,0.275,0.006,430.66,2.03,6.99,0.15],
[464,17.455,0.085,0.275,0.006,443.36,2.16,6.99,0.15],
[465,17.955,0.085,0.275,0.006,456.06,2.16,6.99,0.15],
[466,18.455,0.085,0.275,0.006,468.76,2.16,6.99,0.15],
[467,18.955,0.090,0.275,0.006,481.46,2.29,6.99,0.15],
[901,0.185,0.005,0.056,0.003,4.70,0.13,1.42,0.08],
[902,0.239,0.005,0.064,0.003,6.07,0.13,1.63,0.08],
[903,0.301,0.005,0.064,0.003,7.65,0.13,1.63,0.08],
[904,0.351,0.005,0.072,0.003,8.92,0.13,1.83,0.08],
[905,0.414,0.005,0.072,0.003,10.52,0.13,1.83,0.08],
[906,0.468,0.005,0.078,0.003,11.89,0.13,1.98,0.08],
[907,0.530,0.007,0.082,0.003,13.46,0.18,2.08,0.08],
[908,0.644,0.009,0.087,0.003,16.36,0.23,2.21,0.08],
[909,0.706,0.009,0.097,0.003,17.93,0.23,2.46,0.08],
[910,0.755,0.009,0.097,0.003,19.18,0.23,2.46,0.08],
[911,0.863,0.009,0.116,0.004,21.92,0.23,2.95,0.10],
[912,0.924,0.009,0.116,0.004,23.47,0.23,2.95,0.10],
[913,0.986,0.010,0.116,0.004,25.04,0.25,2.95,0.10],
[914,1.047,0.010,0.116,0.004,26.59,0.25,2.95,0.10],
[916,1.171,0.010,0.116,0.004,29.74,0.25,2.95,0.10],
[918,1.355,0.012,0.116,0.004,34.42,0.30,2.95,0.10],
[920,1.475,0.014,0.118,0.004,37.47,0.36,3.00,0.10],
[924,1.720,0.014,0.118,0.004,43.69,0.36,3.00,0.10],
[928,2.090,0.018,0.118,0.004,53.09,0.46,3.00,0.10],
[932,2.337,0.018,0.118,0.004,59.36,0.46,3.00,0.10]
];

function GetAllORings() = oRingTable;

// Returns the vector of o-ring information given its dash number
function GetORingByDashNo(dashno) =
[ for (row = oRingTable) if (row[0] == dashno) row ][0];

// Returns the vector of o-ring information with the next-largest given internal diameter
// Optionally specify desired series or cross section range
function GetNextLargestORingByID(minIDmm, series = -1, minCSmm = 0, maxCSmm = 100) =
let (candidates = [ for (row = oRingTable) if (
row[5] >= minIDmm
&& row[7] >= minCSmm
&& row[7] <= maxCSmm
&& (series == -1 || floor(row[0] / 100) == series)
) row ])
let (minID = min([ for (row = candidates) row[5] ]))
let (candidatesWithMinID = [ for (row = candidates) if (row[5] == minID) row ])
let (minCS = min([ for (row = candidatesWithMinID) row[7] ]))
let (candidatesWithMinCS = [ for (row = candidatesWithMinID) if (row[7] == minCS) row ])
candidatesWithMinCS[0];

// Pretty-prints o-ring vector
function ORingToStr(row) = str(
"ORing #",
row[0] < 10 ? "0" : "",
row[0] < 100 ? "0" : "",
row[0],
" - ID ",
row[1],
"\" (",
row[5],
"mm), CS ",
row[3],
"\" (",
row[7],
"mm)"
);

// Parameters for o-ring retaining clips in gland
// Returns: [ topWidth, spanAngle, numRetainers ]
function GetORingRetainerParameters(oring, numRetainers = 8, overhangFrac = 0.1, spanAngle = 12) =
[
oring[7] * (1 - overhangFrac),
spanAngle,
numRetainers
];

// Parameters for an extra ring inside the gland and on the opposing face to bite into the o-ring
// May help get a better seal on 3d-printed parts
// height = how thick the bite should be; numBites = how many bites there are, 2 if on both gland and mating surface
// Returns: [ biteID, biteOD, biteHeight, numBites ]
function GetORingBiteParameters(oring, height = 0.2, numBites = 2) =
let (biteCenterDiameter = oring[5] + oring[7])
let (biteWidth = min(oring[7] / 3, 1))
[ biteCenterDiameter - biteWidth, biteCenterDiameter + biteWidth, height, numBites ];

// Get parameters for a basic o-ring sealing gland.
// For argument values, see https://www.marcorubber.com/o-ring-groove-design-considerations.htm
// compression = percent compression of o-ring
// stretch = amount o-ring should be stretched
// fill = percent fill of gland by o-ring
// clearance = clearance between mating plates
// centered = whether o-ring should be centered in gland; if false, o-ring hugs the ID, should be false for nonzero stretch
// bite = o-ring bite params
// Returned values are a vector containing:
// [ grooveID, grooveOD, grooveDepth ]
function GetORingGlandParameters(oring, compression = 0.2, stretch = 0, fill = 0.75, clearance = 0, centered = true, bite = [0,0,0,0]) =
let (desiredRingID = oring[5] * (1 + stretch))
let (grooveDepth = oring[7] * (1 - compression) - clearance)
let (biteArea = (bite[1] - bite[0]) / 2 * bite[2] * bite[3])
let (grooveWidth = (PI * pow(oring[7] / 2, 2) / fill + biteArea) / grooveDepth)
centered ?
[
desiredRingID + oring[7] - grooveWidth,
desiredRingID + oring[7] + grooveWidth,
grooveDepth
]
:
[
desiredRingID,
grooveID + grooveWidth * 2,
grooveDepth
];

function GetNextLargestORingByGlandID(
minIDmm, series = -1, minCSmm = 0, maxCSmm = 100,
compression = 0.2, stretch = 0, fill = 0.75, clearance = 0, centered = true,
biteHeight = 0.2, numBites = 0
) =
let (oringsWithGlands = [ for (row = oRingTable) concat(row, [GetORingGlandParameters(
row,
compression, stretch, fill, clearance, centered,
GetORingBiteParameters(row, biteHeight, numBites)
)]) ])
let (candidates = [ for (row = oringsWithGlands) if (
row[9][0] >= minIDmm
&& row[7] >= minCSmm
&& row[7] <= maxCSmm
&& (series == -1 || floor(row[0] / 100) == series)
) row ])
let (minID = min([ for (row = candidates) row[9][0] ]))
let (candidatesWithMinID = [ for (row = candidates) if (row[9][0] == minID) row ])
let (minCS = min([ for (row = candidatesWithMinID) row[7] ]))
let (candidatesWithMinCS = [ for (row = candidatesWithMinID) if (row[7] == minCS) row ])
candidatesWithMinCS[0];

// Produces the shape of a basic o-ring sealing gland.  Should be subtracted from a shape with difference().
module ORingGland(glandparams, chamferFrac = 0.2, bite=undef, retainer=undef) {
grooveID = glandparams[0];
grooveOD = glandparams[1];
grooveWidth = (grooveOD - grooveID) / 2;
grooveDepth = glandparams[2];
chamfer = chamferFrac * grooveDepth;
difference() {
rotate_extrude()
translate([grooveID/2, 0])
polygon([
[-chamfer, 0],
[grooveWidth + chamfer, 0],
[grooveWidth, -chamfer],
[grooveWidth, -grooveDepth],
[0, -grooveDepth],
[0, -chamfer]
]);
if (bite != undef && bite[3] > 0)
translate([0, 0, -grooveDepth])
ORingBite(bite);
if (retainer != undef && retainer[2] > 0)
for (i = [0 : retainer[2] - 1])
rotate([0, 0, i * (360 / retainer[2]) - retainer[1]/2])
rotate_extrude2(angle=retainer[1])
union() {
retainerClipWidth = (grooveWidth - retainer[0]) / 2;
polygon([
[0, 0],
[grooveID/2 + retainerClipWidth, 0],
[0, -grooveID/2 - retainerClipWidth]
]);
polygon([
[grooveOD/2 - retainerClipWidth, 0],
[grooveOD/2 + 10, 0],
[grooveOD/2 + 10, -retainerClipWidth - 10]
]);
};
};
};

// Produces the bite ridge; can be placed inside the gland and/or on the mating surface
module ORingBite(bite) {
difference() {
cylinder(r=bite[1]/2, h=bite[2]);
cylinder(r=bite[0]/2, h=bite[2]+10);
};
};

/*
* knurledFinishLib_v2.scad
*
* Written by aubenc @ Thingiverse
*
* This script is licensed under the Public Domain license.
*
* http://www.thingiverse.com/thing:31122
*
* Derived from knurledFinishLib.scad (also Public Domain license) available at
*
* http://www.thingiverse.com/thing:9095
*
* Usage:
*
*	 Drop this script somewhere where OpenSCAD can find it (your current project's
*	 working directory/folder or your OpenSCAD libraries directory/folder).
*
*	 Add the line:
*
*		use <knurledFinishLib_v2.scad>
*
*	 in your OpenSCAD script and call either...
*
*    knurled_cyl( Knurled cylinder height,
*                 Knurled cylinder outer diameter,
*                 Knurl polyhedron width,
*                 Knurl polyhedron height,
*                 Knurl polyhedron depth,
*                 Cylinder ends smoothed height,
*                 Knurled surface smoothing amount );
*
*  ...or...
*
*    knurl();
*
*	If you use knurled_cyl() module, you need to specify the values for all and
*
*  Call the module ' help(); ' for a little bit more of detail
*  and/or take a look to the PDF available at http://www.thingiverse.com/thing:9095
*  for a in depth descrition of the knurl properties.
*/


module knurl(	k_cyl_hg	= 12,
k_cyl_od	= 25,
knurl_wd =  3,
knurl_hg =  4,
knurl_dp =  1.5,
e_smooth =  2,
s_smooth =  0)
{
knurled_cyl(k_cyl_hg, k_cyl_od,
knurl_wd, knurl_hg, knurl_dp,
e_smooth, s_smooth);
}

module knurled_cyl(chg, cod, cwd, csh, cdp, fsh, smt)
{
cord=(cod+cdp+cdp*smt/100)/2;
cird=cord-cdp;
cfn=round(2*cird*PI/cwd);
clf=360/cfn;
crn=ceil(chg/csh);

//echo("knurled cylinder max diameter: ", 2*cord);
//echo("knurled cylinder min diameter: ", 2*cird);

if( fsh < 0 )
{
union()
{
shape(fsh, cird+cdp*smt/100, cord, cfn*4, chg);

translate([0,0,-(crn*csh-chg)/2])
knurled_finish(cord, cird, clf, csh, cfn, crn);
}
}
else if ( fsh == 0 )
{
intersection()
{
cylinder(h=chg, r=cord-cdp*smt/100, $fn=2*cfn, center=false);

translate([0,0,-(crn*csh-chg)/2])
knurled_finish(cord, cird, clf, csh, cfn, crn);
}
}
else
{
intersection()
{
shape(fsh, cird, cord-cdp*smt/100, cfn*4, chg);

translate([0,0,-(crn*csh-chg)/2])
knurled_finish(cord, cird, clf, csh, cfn, crn);
}
}
}

module shape(hsh, ird, ord, fn4, hg)
{
x0= 0;	x1 = hsh > 0 ? ird : ord;		x2 = hsh > 0 ? ord : ird;
y0=-0.1;	y1=0;	y2=abs(hsh);	y3=hg-abs(hsh);	y4=hg;	y5=hg+0.1;

if ( hsh >= 0 )
{
rotate_extrude(convexity=10, $fn=fn4)
polygon(points=[	[x0,y1],[x1,y1],[x2,y2],[x2,y3],[x1,y4],[x0,y4]	],
paths=[	[0,1,2,3,4,5]	]);
}
else
{
rotate_extrude(convexity=10, $fn=fn4)
polygon(points=[	[x0,y0],[x1,y0],[x1,y1],[x2,y2],
[x2,y3],[x1,y4],[x1,y5],[x0,y5]	],
paths=[	[0,1,2,3,4,5,6,7]	]);
}
}

module knurled_finish(ord, ird, lf, sh, fn, rn)
{
for(j=[0:rn-1])
{
h0=sh*j; h1=sh*(j+1/2); h2=sh*(j+1);
for(i=[0:fn-1])
{
lf0=lf*i; lf1=lf*(i+1/2); lf2=lf*(i+1);
polyhedron(
points=[
[ 0,0,h0],
[ ord*cos(lf0), ord*sin(lf0), h0],
[ ird*cos(lf1), ird*sin(lf1), h0],
[ ord*cos(lf2), ord*sin(lf2), h0],

[ ird*cos(lf0), ird*sin(lf0), h1],
[ ord*cos(lf1), ord*sin(lf1), h1],
[ ird*cos(lf2), ird*sin(lf2), h1],

[ 0,0,h2],
[ ord*cos(lf0), ord*sin(lf0), h2],
[ ird*cos(lf1), ird*sin(lf1), h2],
[ ord*cos(lf2), ord*sin(lf2), h2]
],
faces=[
[0,1,2],[2,3,0],
[1,0,4],[4,0,7],[7,8,4],
[8,7,9],[10,9,7],
[10,7,6],[6,7,0],[3,6,0],
[2,1,4],[3,2,6],[10,6,9],[8,9,4],
[4,5,2],[2,5,6],[6,5,9],[9,5,4]
],
convexity=5);
}
}
}

module knurl_help()
{
echo();
echo("    Knurled Surface Library  v2  ");
echo("");
echo("      Modules:    ");
echo("");
echo("        knurled_cyl(parameters... );    -    Requires a value for each an every expected parameter (see bellow)    ");
echo("");
echo("        knurl();    -    Call to the previous module with a set of default parameters,    ");
echo("                                  values may be changed by adding 'parameter_name=value'        i.e.     knurl(s_smooth=40);    ");
echo("");
echo("      Parameters, all of them in mm but the last one.    ");
echo("");
echo("        k_cyl_hg       -   [ 12   ]  ,,  Height for the knurled cylinder    ");
echo("        k_cyl_od      -   [ 25   ]  ,,  Cylinder's Outer Diameter before applying the knurled surfacefinishing.    ");
echo("        knurl_wd     -   [   3   ]  ,,  Knurl's Width.    ");
echo("        knurl_hg      -   [   4   ]  ,,  Knurl's Height.    ");
echo("        knurl_dp     -   [  1.5 ]  ,,  Knurl's Depth.    ");
echo("        e_smooth   -    [  2   ]  ,,  Bevel's Height at the bottom and the top of the cylinder    ");
echo("        s_smooth   -    [  0   ]  ,,  Knurl's Surface Smoothing :  File donwn the top of the knurl this value, i.e. 40 will snooth it a 40%.    ");
echo("");
}

// From http://forum.openscad.org/rotate-extrude-angle-always-360-td19035.html

module rotate_extrude2(angle=360, convexity=2, size=1000) {

module angle_cut(angle=90,size=1000) {
x = size*cos(angle/2);
y = size*sin(angle/2);
translate([0,0,-size])
linear_extrude(2*size) polygon([[0,0],[x,y],[x,size],[-size,size],[-size,-size],[x,-size],[x,-y]]);
}

// support for angle parameter in rotate_extrude was added after release 2015.03
// Thingiverse customizer is still on 2015.03
angleSupport = (version_num() > 20150399) ? true : false; // Next openscad releases after 2015.03.xx will have support angle parameter
// Using angle parameter when possible provides huge speed boost, avoids a difference operation

if (angleSupport || angle == 360) {
rotate_extrude(angle=angle,convexity=convexity)
children();
} else {
rotate([0,0,angle/2]) difference() {
rotate_extrude(convexity=convexity) children();
angle_cut(angle, size);
}
}
}
use <write/Write.scad>

// Thickness of the container floor
floorThick = wallThick;

compartmentRadius = compartmentDiameter / 2;

containerOuterRadius = compartmentRadius + 2 * wallThick;
containerInnerRadius = compartmentRadius;

containerThreadOuterDiameter = containerInnerRadius * 2 + containerThreadPitch * 0.3125 * 2;

clipWidth = min(maxClipWidth, 2*PI*containerOuterRadius/numClips/2, 2*PI*containerOuterRadius/20);

// Returns O-ring information for the given o-ring number (starting at 0)
// Return format: [ ORingData, GlandData, BiteData, RetainerData ]
function GetContainerORingInfo(oringNum) =
let (desiredID =
(oringNum <= 0)
? (containerInnerRadius + containerThreadPitch/2 + oRingGrooveMinBufferWidth) * 2
: GetContainerORingInfo(oringNum - 1)[1][1] + 2 * oRingGrooveMinBufferWidth
)
let (oring = GetNextLargestORingByGlandID(desiredID, series=oRingSeries, clearance=oRingSurfaceClearance, biteHeight=oRingBiteHeight, numBites=useORingBites?2:0))
let (bite = GetORingBiteParameters(oring, oRingBiteHeight, useORingBites?2:0))
let (gland = GetORingGlandParameters(oring, clearance=oRingSurfaceClearance, bite=bite))
let (retainer = GetORingRetainerParameters(oring))
[ oring, gland, bite, retainer ];

// Calculate the thickness of the top part of the container from the maximum depth of any of the O-ring grooves
containerTopThick_ord = max([ for (i = [0 : numORings - 1]) GetContainerORingInfo(i)[1][2] ]) + containerTopMinThick;
containerTopThick = (numClips > 0) ? max(containerTopThick_ord, clipArmMinLength) : containerTopThick_ord;

capThreadLengthOffset = -1;

clipProtrusion = (containerTopThick * tan(clipDeflectionAngle) + clipArmContainerClearance / cos(clipDeflectionAngle)) / (1 - tan(clipDeflectionAngle));
clipArmLengthOffset = -clipProtrusion * (3/4);

clipPointHeight = 1;
clipArmFullLength = containerTopThick + 2 * clipProtrusion + clipPointHeight - clipArmContainerClearance + clipArmLengthOffset;

// Minimal number of threads on cap screw
containerThreadNumTurns_clips = (clipArmFullLength - capThreadLengthOffset) / containerThreadPitch + 1 + minThreadEngagementBeforeClips;

containerThreadNumTurns = max(containerThreadNumTurnsMin, numClips > 0 ? containerThreadNumTurns_clips : 0);
containerThreadLength = containerThreadNumTurns * containerThreadPitch;
containerOuterHeight = compartmentHeight + floorThick + containerThreadLength;

containerTopChamferSize = numClips > 0 ? clipProtrusion : 0;

// Calculate the radius of the top part of the container from the OD of the largest O-ring groove
containerTopRadius_ord = GetContainerORingInfo(numORings - 1)[1][1] / 2 + oRingGrooveMinBufferWidth + containerTopChamferSize;
containerTopRadius_clip = containerOuterRadius + clipProtrusion;
// Use the larger of the two minimum radii
containerTopRadius = max(containerTopRadius_ord, numClips > 0 ? containerTopRadius_clip : 0);

// Print out o-ring info
for (i = [0 : numORings - 1])
echo(ORingToStr(GetContainerORingInfo(i)[0]));

function getAllORingInfoString(fromIdx = 0) =
(fromIdx < numORings - 1) ?
str(GetContainerORingInfo(fromIdx)[0][0], "-", getAllORingInfoString(fromIdx+1)) :
str(GetContainerORingInfo(fromIdx)[0][0]);

module Container() {
topOverhangSupportZ = containerOuterHeight-containerTopThick-(containerTopRadius-containerOuterRadius);
difference() {
union() {
// Main outer cylinder
cylinder(r=containerOuterRadius, h=containerOuterHeight);
// Container top overhang
translate([0, 0, containerOuterHeight - containerTopThick])
cylinder(h=containerTopThick, r=containerTopRadius);
// Support for overhang
translate([0, 0, topOverhangSupportZ])
cylinder(r1=containerOuterRadius, r2=containerTopRadius, h=containerTopRadius-containerOuterRadius);
};
// Inner cutout
translate([0, 0, floorThick])
cylinder(r=containerInnerRadius, h=10000);
// Top threads
translate([0, 0, containerOuterHeight - containerThreadLength])
metric_thread(
diameter=containerThreadOuterDiameter,
pitch=containerThreadPitch,
length=containerThreadLength+containerThreadPitch,
internal=true,
angle=45
);
// Thread lead-in cone
translate([0, 0, containerOuterHeight-containerThreadPitch])
cylinder(r1=containerInnerRadius, r2=containerInnerRadius+containerThreadPitch, h=containerThreadPitch);
// O-ring glands
translate([0, 0, containerOuterHeight])
for (i = [0 : numORings - 1])
ORingGland(GetContainerORingInfo(i)[1], bite=useORingBites?GetContainerORingInfo(i)[2]:undef, retainer=useORingRetainers?GetContainerORingInfo(i)[3]:undef);
// Outer chamfer
containerTopChamferHeight = containerTopThick * 0.75;
if (containerTopChamferSize > 0)
translate([0, 0, containerOuterHeight])
rotate_extrude()
translate([containerTopRadius, 0])
polygon([
[0, 0],
[-containerTopChamferSize, 0],
[0, -containerTopChamferHeight]
]);
// Bottom label
if (len(bottomLabel) > 0)
writecylinder(
text = bottomLabel,
where = [0, 0, 0],
radius = containerOuterRadius,
height = containerOuterHeight,
face = "bottom",
h = containerOuterRadius / 5,
space = 1.5
);
// Side label
if (len(sideLabel) > 0)
writecylinder(
text = sideLabel,
where = [0, 0, 0],
radius = containerOuterRadius,
height = topOverhangSupportZ,
h = containerOuterRadius / 5,
space = 1.5,
rotate = 15
);
// O-ring dash number label
if (includeORingLabel)
writecylinder(
text = getAllORingInfoString(),
where = [0, 0, 0],
radius = containerInnerRadius,
height = floorThick,
face = "top",
h = containerInnerRadius / 3,
space = 1.5
);
};
};

capThreadLength = containerThreadLength + capThreadLengthOffset;
capThreadDiameter = containerThreadOuterDiameter-extraThreadDiameterClearance;
desiccantPocketHeight = capTopHeight + capThreadLength - floorThick;
desiccantThreadDiameter = capThreadDiameter - 2*containerThreadPitch - 2*desiccantPocketWallThick;
desiccantThreadLength = desiccantThreadNumTurns * containerThreadPitch;
desiccantCapHeight = desiccantThreadLength;
desiccantPocketCapShoulder = 1;
desiccantPocketInternalRadius = desiccantThreadDiameter/2-containerThreadPitch-desiccantPocketCapShoulder;

// Extra cap radius to add when clips are enabled
extraCapRadiusWithClips = 2;

capRadius = (numClips > 0) ? containerTopRadius + clipArmContainerClearance + clipArmThick + extraCapRadiusWithClips : containerTopRadius;

module Cap() {

difference() {
union() {
// Base
cylinder(h=capTopHeight, r=capRadius);
// Knurls
knurl(capTopHeight, capRadius*2);
// Threads
translate([0, 0, capTopHeight])
metric_thread(
diameter=capThreadDiameter,
pitch=containerThreadPitch,
length=capThreadLength,
internal=false,
angle=45,
leadin=1
);
};

// Desiccant pocket
desiccantPocketZ = floorThick;
if (includeDesiccantPocket)
translate([0, 0, desiccantPocketZ])
union() {
cylinder(r=desiccantPocketInternalRadius, h=1000);
translate([0, 0, desiccantPocketHeight - desiccantThreadLength])
metric_thread(
diameter=desiccantThreadDiameter,
pitch=containerThreadPitch,
length=desiccantThreadLength + containerThreadPitch,
internal=true,
angle=45
);
};

// Desiccant label
if (includeDesiccantPocket && includeDesiccantLabel)
writecylinder(
text = "DESICCANT",
where = [0, 0, 0],
radius = capThreadDiameter/2 - containerThreadPitch,
height = capThreadLength + capTopHeight,
face = "top",
h = desiccantPocketWallThick,
middle = -desiccantPocketWallThick,
space = 2
);

// Top label
if (len(topLabel) > 0)
writecylinder(
text = topLabel,
where = [0, 0, 0],
radius = capRadius,
height = capTopHeight,
face = "bottom",
h = capRadius / 5,
space = 1.5
);
};

// O-ring bites
if (useORingBites)
for (i = [0 : numORings-1])
translate([0, 0, capTopHeight])
ORingBite(GetContainerORingInfo(i)[2]);

// Clip shroud and clips
clipShroudGapClearance = 1;
clipArmOffsetX = containerTopRadius + clipArmContainerClearance;
clipSpanAngle = clipWidth / (2 * PI * clipArmOffsetX) * 360;
clipShroudGapSpanAngle = (clipWidth + 2 * clipShroudGapClearance) / (2 * PI * clipArmOffsetX) * 360;
clipAngleSpacing = 360 / numClips;
clipArmTopThick = clipArmThick / 2;
clipBaseBevelHeight = min(extraCapRadiusWithClips, containerTopThick / 10);
if (numClips > 0)
translate([0, 0, capTopHeight])
union() {
difference() {
// Clip shroud, same thickness as clip arms
rotate_extrude()
translate([clipArmOffsetX, 0])
polygon([
[0, 0],
[clipArmThick + extraCapRadiusWithClips, 0],
[clipArmThick, clipBaseBevelHeight],
[clipArmThick, clipArmFullLength],
[0, clipArmFullLength]
]);
// Gaps in the clip shroud
for (i = [0 : numClips - 1])
rotate([0, 0, i * clipAngleSpacing - clipShroudGapSpanAngle/2])
rotate_extrude2(angle=clipShroudGapSpanAngle)
square([capRadius+1, clipArmFullLength+1]);
};

// Clips
for (i = [0 : numClips - 1])
rotate([0, 0, i * clipAngleSpacing - clipSpanAngle/2])
rotate_extrude2(angle=clipSpanAngle)
translate([clipArmOffsetX, 0])
polygon([
[0, 0],
[clipArmThick + extraCapRadiusWithClips, 0],
[clipArmThick, clipBaseBevelHeight],
[clipArmTopThick, clipArmFullLength],
[0, clipArmFullLength],
[-clipProtrusion, clipArmFullLength - clipProtrusion],
[-clipProtrusion, clipArmFullLength - clipProtrusion - clipPointHeight],
[0, clipArmFullLength - 2*clipProtrusion - clipPointHeight]
]);
};
};

module DesiccantCap() {
perforationDiameter = 1.5;
perforationSpacing = perforationDiameter * 3;
difference() {
// Body of cap
metric_thread(
diameter=desiccantThreadDiameter-extraThreadDiameterClearance,
pitch=containerThreadPitch,
length=desiccantCapHeight,
internal=false,
angle=45
);
// Slot for turning
slotWidth = min(3, desiccantThreadDiameter/5);
slotLength = (desiccantThreadDiameter - containerThreadPitch*2) * 0.6;
slotDepth = desiccantCapHeight * 0.7;
translate([-slotWidth/2, -slotLength/2, desiccantCapHeight-slotDepth])
cube([slotWidth, slotLength, 1000]);
// Perforations
for (r = [desiccantPocketInternalRadius-perforationDiameter : -perforationSpacing : perforationSpacing/2]) {
numPerforations = floor(2*PI*r / perforationSpacing);
startAngle = rands(-360, 0, 1)[0];
for (a = [startAngle : 360/numPerforations : startAngle+359])
rotate([0, 0, a])
translate([r, 0, 0])
cylinder(r=perforationDiameter/2, h=1000);
};
};
};

module print_part() {
if (part == "container")
Container();
else if (part == "cap")
Cap();
else if (part == "desiccantcap")
DesiccantCap();
else if (part == "all")
union() {
translate([-containerTopRadius-1, 0, 0])
Container();
translate([capRadius + 2, 0, 0])
Cap();
if (includeDesiccantPocket)
translate([0, max(containerTopRadius + 1, capRadius + 2)+desiccantThreadDiameter/2, 0])
DesiccantCap();
};
};

print_part();

//Container();
//Cap();
//DesiccantCap();
