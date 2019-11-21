// Customizable Lattice Box
// Author: Alexander Smith
// License: CC BY <https://creativecommons.org/licenses/by/4.0/>
//

// This OpenSCAD file is formatted for use by the Makerbot Customizer.

// preview[view:south, tilt:top diagonal]

use <utils/build_plate.scad>;

/* [Basic] */
parts = "both";			// [box, lid, both]

box_inside_length = 50;	// [0:0.5:300]
box_inside_width = 50;		// [0:0.5:300]
box_inside_height = 50;	// [0:0.5:300]

// The width and length are determined by the box size and "Box To Lid Gap" (under Advanced settings).
lid_outside_height = 15;	// [0:0.5:300]

// Thickness of the walls of the box and lid.
wall_thickness = 2;			// [0.1:0.1:20]

// Density of the walls, from 0 (no lattice at all) to 1 (solid walls instead of a lattice).
density = 0.3;				// [0:0.1:1.0]

// Print the bottom of the box solid, instead of a lattice?
solid_bottom = 0;			// [0:no, 1:yes]

// Print the top of the lid solid, instead of a lattice?
solid_top = 0;				// [0:no, 1:yes]


/* [Advanced] */

// Width of the solid frame on all edges of the box and lid.
frame_width = 5;			// [0:0.1:20]

// Distance between lines of the lattice.
lattice_spacing = 5;		// [1:0.5:30]

// Rotation angle of the lattice. If you use anything other than 45 degrees, you should keep "lattice spacing" to 5mm or smaller to avoid needing support.
lattice_angle = 45;			// [0:5:90]

// The lid width and length will be expanded to leave this much gap on all sides between the inside of the lid and the outside of the box.
box_to_lid_gap = 1;			// [0:0.1:5]

build_plate_preview = -1; // [-1: None, 0:Makerbot Replicator 2, 1: Makerbot Replicator, 2:Makerbot Thingomatic]



// Creates a 2D lattice inside 'square(size, center)'.
// S: Distance between the lines of the lattice.
// density: How thick the lines are. 'density=1' is the same as square(size, center); 'density=0' creates nothing.
// alpha: The angle of the lattice lines will be alpha and alpha+90.
module lattice_square(size, S = 5, density = 0.1, alpha = 45, center = false)
{
    // scalar projection of vector a onto vector b
    function sproj(a, b) = a*b/sqrt(b*b /* dot product */);
    
    if (density >= 1) {
        square(size, center);
        
    } else if ((density <= 0)) {
        // nothing
        
    } else if (len(size) == undef) {
        // only a single number was given
        lattice_square([size, size], S, density, alpha, center);
        
    } else {
        W = (size[0] == undef ? 1 : size[0]);
        H = (size[1] == undef ? W : size[1]);

        // d = width of lines.
        // ('density' is the desired material density. 'd' is the calculated line width, accounting for the fact that the lines overlap.)
        density_fixed = max(0, min(1, density));
        d = S * (1 - sqrt(1 - density_fixed));
		//echo(str("Lattice line width = ", d, " for S=", S, ", density ", density_fixed));
        
        // center of the square
        C = [W, H]/2;
        // unit vectors along and normal to angle alpha, used below
        tmp1 = [cos(alpha), sin(alpha)];
        tmp2 = [-tmp1[1], tmp1[0]];

        // To keep things simple, we generate a lattice that is too big (guaranteed to be big enough in each direction), and clip it to the square.
        translate(center ? -C : [0,0])
        intersection() {
            // the clipping square:
            square([W, H]);
            
            // the lattice to clip:
            union() {
                for (k = [0:1]) {
                    // if k=0, v along alpha
                    // else, v perpendicular to alpha
                    v = (k == 0) ? tmp1 : tmp2;
                    n = (k == 0) ? tmp2 : tmp1;

                    // Figure out how much lattice to draw:
                    Vcorners = [[-W/2, H/2], [W/2, H/2], [W/2, -H/2], [-W/2, -H/2]];
                    // ... vertically ...
                    h_corner_projs = [for (i = [0:len(Vcorners)-1]) sproj(Vcorners[i], n)];
                    r_min = min(h_corner_projs);
                    r_max = max(h_corner_projs);
                    // ... and horizontally.
                    v_corner_projs = [for (i = [0:len(Vcorners)-1]) sproj(Vcorners[i], v)];
                    q_min = min(v_corner_projs);
                    q_max = max(v_corner_projs);
                    
                    for (i = [floor(r_min/S) : ceil(r_max/S)]) {
                        P0 = q_min*v + i*S*n + C;
                        P1 = q_max*v + i*S*n + C;
                        // Draw a "line" from P0 to P1 with width d.
                        polygon([P0 - 0.5*d*n, P1 - 0.5*d*n, P1 + 0.5*d*n, P0 + 0.5*d*n]);
                    }
                }
            }
        }
    }
}


// Creates a 3D lattice inside 'cube(size, center)' by drawing a lattice in the face normal to 'face' and extruding it along the 'face' axis.
// For the meanings of the other parameters, see lattice_square.
module lattice_cube(size, face = "z", S = 5, density = 0.1, alpha = 45, center = false)
{
    X = (size[0] == undef ? 1 : size[0]);
    Y = (size[1] == undef ? W : size[1]);
    Z = (size[1] == undef ? 1 : size[2]);
    
    C = [X, Y, Z]/2;
    
    translate(center ? -C : [0,0,0])
    if (face == "x") {
        rotate([90, 0, 90]) linear_extrude(X) lattice_square([Y, Z], S, density, alpha);
    } else if (face == "y") {
        rotate([0, -90, -90]) linear_extrude(Y) lattice_square([Z, X], S, density, alpha);
    } else {
        linear_extrude(Z) lattice_square([X, Y], S, density, alpha);
    }
}


module _makeLatticeBox(O_dim, I_dim,  frame_width, S, density, alpha, solid_bottom)
{
    echo(str("outside = ", O_dim));
    echo(str("inside = ", I_dim));
    
    D = 0.5*(O_dim - I_dim);
    fw = frame_width;   // alias
    
    if (solid_bottom) {
        cube([O_dim[0], O_dim[1], D[2]]);
    } else {
        // lattice bottom
        lattice_cube([O_dim[0], O_dim[1], D[2]], face="z", S=S, density=density, alpha=alpha);
        
        // frame bottom
        if (fw > 0) {
            difference() {
                cube([O_dim[0], O_dim[1], D[2]]);
                translate([fw, fw, -1])
                    cube([O_dim[0] - 2*fw, O_dim[1] - 2*fw, D[2] + 2]);
            }
        }
    }
    
    for (i = [0:1]) {
        sgn = 2*(i - 0.5);  // map i to -1, 1
        
        translate(i*[0, I_dim[1] + D[1], 0]) {
            // lattice front, back
            lattice_cube([O_dim[0], D[1], O_dim[2]], face="y", S=S, density=density, alpha=sgn*alpha);
        
            // frame front, back
            if (fw > 0) {
                difference() {
                    cube([O_dim[0], D[1], O_dim[2]]);
                    translate([fw, -1, fw])
                        cube([O_dim[0] - 2*fw, D[1] + 2, O_dim[2] - 2*fw]);
                }
            }
        }
        
        translate(i*[I_dim[0] + D[0], 0, 0]) {
            // lattice sides
            lattice_cube([D[0], O_dim[1], O_dim[2]], face="x", S=S, density=density, alpha=sgn*alpha);
            
            // frame sides
            if (fw > 0) {
                difference() {
                    cube([D[0], O_dim[1], O_dim[2]]);
                    translate([-1, fw, fw])
                        cube([D[0] + 2, O_dim[1] - 2*fw, O_dim[2] - 2*fw]);
                }
            }
        }
    }
}

// Define exactly two of the parameters. The third will be inferred.
// The top will always be open.
module lattice_box(outside_dim, inside_dim, wall_thickness, frame_width = 5,  S = 5, density = 0.1, alpha = 45, solid_bottom = false)
{
    if (outside_dim == undef) {
        //echo("No outside");
        _makeLatticeBox(inside_dim + 2*wall_thickness*[1,1,1], inside_dim, frame_width, S, density, alpha, solid_bottom);
    } else if (inside_dim == undef) {
        //echo("No inside");
        _makeLatticeBox(outside_dim, outside_dim - 2*wall_thickness*[1,1,1], frame_width, S, density, alpha, solid_bottom);
    } else {
        //echo("No wall");
        _makeLatticeBox(outside_dim, inside_dim, frame_width, S, density, alpha, solid_bottom);
    }
}


build_plate(build_plate_preview);

B = [box_inside_length, box_inside_width, box_inside_height];
if ((parts == "both") || (parts == "box")) {
    echo("Box dimensions:");
	lattice_box(inside_dim = B,
				wall_thickness = wall_thickness, S = lattice_spacing, density = density,
				alpha = lattice_angle, frame_width = frame_width, solid_bottom = solid_bottom);
}
if ((parts == "both") || (parts == "lid")) {
    echo("Lid dimensions:");
	translate( (box_inside_length + 2*wall_thickness + 5) * (parts == "both" ? [1, 0, 0] : [0, 0, 0]) )
	lattice_box(inside_dim = [B[0], B[1], lid_outside_height - 2*wall_thickness] + (wall_thickness + box_to_lid_gap) * [2, 2, 0],
				wall_thickness = wall_thickness, S = lattice_spacing, density = density,
				alpha = lattice_angle, frame_width = frame_width, solid_bottom = solid_top);
}
