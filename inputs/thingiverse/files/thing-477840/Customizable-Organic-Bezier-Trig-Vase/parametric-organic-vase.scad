/*
 * Parametric Organic Vase
 * Designed by Jim DeVona, 2014
 * 
 * Creative Commons Attribution-ShareAlike 4.0 International License.
 * http://creativecommons.org/licenses/by-sa/4.0/
 */

// preview[tilt:side]

/* [Dimensions] */

// (mm)
height = 60; // [10:100]

// (mm)
base_diameter = 42; // [10:100]

// Diameter at 1/3 height. (mm)
waist_diameter = 64; // [10:100]

// Diameter at 2/3 height. (mm)
neck_diameter = 50; // [10:100]

// (mm)
top_diameter = 48; // [10:100]

// Show guides representing reference dimensions given above.
display_diameters = 0; // [0:No, 1:Yes]

/* [Texture] */

// Number of ruffled ridges on surface.
ruffle_count = 6; // [2:12]

// Maximum inset/offset of each ruffle. (mm)
ruffle_depth = 6; // [1:8]

// Number of alternating twists applied to ruffles. 
twist_cycles = 3; // [0:6]

// Extent of each twist. (degrees)
twist_max = 40; // [-90:90]

// Number of transitions from ruffled to smooth surfaces.
smoothing_cycles = 2; // [0:6]

// Adjust vertical position of smoothing transitions. (%)
smoothing_start = 50; // [0:100]

/* [Resolution] */

// Number of layers comprising vase.
vertical_resolution = 60;

// Number of wedges comprising each layer.
radial_resolution = 96;

/* [Hidden] */

base_radius = base_diameter / 2;
waist_radius = waist_diameter / 2;
neck_radius = neck_diameter / 2;
top_radius = top_diameter / 2;

p0 = base_radius;
p1 = ((-5 * base_radius) + (18 * waist_radius) - ( 9 * neck_radius) + (2 * top_radius)) / 6;
p2 = (( 2 * base_radius) - ( 9 * waist_radius) + (18 * neck_radius) - (5 * top_radius)) / 6;
p3 = top_radius;

ba = p3 - (3 * p2) + (3 * p1) -      p0;
bb =      (3 * p2) - (6 * p1) + (3 * p0);
bc =                 (3 * p1) - (3 * p0);
bd =                                 p0;

// Twist: Returns rotation of layer at ratio height v.
function twist(v) = twist_max * sin(twist_cycles * 0.25 * 360 * v);

// Bezier: Returns reference radius of layer at ratio height v.
function bezier(v) = (ba * pow(v, 3)) + (bb * pow(v, 2)) + (bc * v) + bd;

// Ruffle: Returns offset radially applied to reference radius to form star petals.
function ruffle(v, t) = ruffle_depth * sin((t + twist(v)) * ruffle_count);

// Smoothing: Returns offset vertically applied to reference radius to vary petal depth.
// Return value varies between 0 and 1; 0 means petal fully suppressed; 1 means petal full depth.
function smoothing(v) = 0.5 + (0.5 * cos(smoothing_cycles * 0.5 * 360 * (v + smoothing_start/100)));

// Radius r: 
function r(v, t) = bezier(v) + ruffle(v, t) * smoothing(v);

// convert polar rt coordinates to cartesian xy
function x(r, t) = r * cos(t);
function y(r, t) = r * sin(t);

for (v = [0:vertical_resolution - 1]) {
	// height of top and bottom of exterior face, expressed as ratio of full height
	assign(v0 = v / vertical_resolution, v1 = (v + 1) / vertical_resolution) {
		// height of top and bottom exterior face, expressed in output units
		assign(h0 = v0 * height, h1 = v1 * height) {
			for (t = [0:radial_resolution - 1]) {
				// angles to either horizontal side of this exterior face
				assign(t0 = t * 360 / radial_resolution, t1 = (t + 1) * 360 / radial_resolution) {
					// radii from axis to each corner of this exterior face:
					assign(rv0t0 = r(v0, t0), rv0t1 = r(v0, t1), rv1t0 = r(v1, t0), rv1t1 = r(v1, t1)) {
						// OpenSCAD: not quite cool enough to dynamically build a single point array.
						// So, I'ma force feed you like ten thousand separate polyhedron wedges instead.
						polyhedron(
							points = [
								[0, 0, h1],                       // center top
								[0, 0, h0],                       // center bottom
								[x(rv1t0, t0), y(rv1t0, t0), h1], // exterior left top
								[x(rv0t0, t0), y(rv0t0, t0), h0], // exterior left bottom
								[x(rv1t1, t1), y(rv1t1, t1), h1], // exterior right top
								[x(rv0t1, t1), y(rv0t1, t1), h0]  // exterior right bottom
							],
							triangles = [  // clockwise as seen from outside
								[0, 2, 4], // top
								[1, 5, 3], // bottom
								[0, 3, 2], // left top
								[0, 1, 3], // left bottom
								[0, 4, 5], // right top
								[0, 5, 1], // right bottom
								[2, 3, 4], // exterior left
								[5, 4, 3]  // exterior right
							]
						);
					}
				}
			}
		}
	}
}

//# cylinder(d=40, h = height + 2);

module Constraints() {
	translate([0, 0, -0.5]) cylinder(r = base_radius, h = 1);
	translate([0, 0, height / 3 - 0.5]) cylinder(r = waist_radius, h = 1);
	translate([0, 0, 2 * height / 3 - 0.5]) cylinder(r = neck_radius, h = 1);
	translate([0, 0, height - 0.5]) cylinder(r = top_radius, h = 1);
}	

if (display_diameters == 1) {
	% Constraints();
}