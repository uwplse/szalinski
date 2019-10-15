/* [Sizes] */

// Go board size, usual values are 9x9 or 19x19
board_size = 9; // [7,9,11,13,19]
// Height of a single stone [mm]
stone_height = 9; // [5:20]
// Diameter of a single stone [mm]
stone_diameter = 22; // [10:30]
// outer bowl diameter (viewed from top) [cm]
bowl_diameter = 10;

/* [Printing] */

// which part to display?
print_part = "both"; // [both,cap,bowl]
// resolution, use 100 for prints and 40 for preview
$fn = 40; // [40,100]
// free space from bowl top to first stone layer [cm]
free_space = 0.5;
// space between bowl and cap [cm]
print_spacing = 0.06;

/* [Hidden] */

/*******************************
 * Computed parameters, part I */

// number of stones per bowl
num_stones = pow(board_size,2) / 2 + 0.5;
// outer radius
bowl_r = bowl_diameter / 2;
// adaptive wall thickness [cm], maximum 1 cm, minimum 0.5 cm
wall_thickness = max(min(bowl_diameter/10, 1), 0.5);

/***************************
 * Determine target volume */
 
// I tried to measure the volume of each stone vs. the occupied space
// If you want to contribute here, please sent me a line or leave a comment
measurements = [
    // diameter [cm], height [cm], density(number per volume [cm^3])
    [2.2,  0.9, 117, 400],
    [2.15, 0.55,147, 400],
    [2.15, 1.1, 115, 400],
];

// determine factor to generate an average volume for each stone by its dimensions
function sumv(v,i,s=0) = (i==s ? v[i] : v[i] + sumv(v,i-1,s));

// estimated volume [cm^3] of a single stone by given diameter [cm] and height [cm]
function volStone(d_cm, h_cm) = 4/3 * PI * pow(d_cm / 2,3) * h_cm / d_cm;

M = [for (m  = measurements) ((m[3] / m[2]) / volStone(m[0], m[1]))];
vol_factor = sumv(M, len(M)-1) / len(M); // average

// final target volume based on the settings
target_volume = vol_factor * volStone(stone_diameter/10, stone_height/10) * num_stones;

/****************************************************
 * Optimize height scale depending on target volume */

// optimization function: inner volume [cm^3] depending on height scale
function f(h_scale) = let(
    h_t = bowl_r * (1 - 0.65) + free_space / h_scale,
    h_b = bowl_r * (1 - 0.55) + 2*wall_thickness / h_scale, // still don't know why factor 2 is necessary here...
    V_g = 4/3 * PI * pow(bowl_r,3),
    V_h_t = pow(h_t,2) * PI / 3 * (3 * bowl_r - h_t),
    V_h_b = pow(h_b,2) * PI / 3 * (3 * bowl_r - h_b),
    compression = h_scale * pow((bowl_r - wall_thickness) / bowl_r, 2)
    )
    pow(((V_g - V_h_t - V_h_b) * compression) - target_volume, 2);

/*  Recursive optimization of the convex function f.
    [implemented as a binary-like tree search]

    Optimizes the input value x w.r.t. minimization of f(x).

    Parameters
    ----------
    rg_min, rg_max : float
        Maximum and minimum range to search in.
    eps : float
        Target precision.
    iter : int
        Maximumm number of recursive iterations.
        100 is a good choice because of OpenScad limitations.

    Notes
    -----
    Define the target function f(x) beforehand!
    
    References
    ----------
    http://www.thingiverse.com/thing:1123583
*/ 
function optim(rg_min, rg_max, eps, iter=100) = let(
        h = rg_min + (rg_max - rg_min) / 2,
        df = f(h + eps) - f(h - eps)
    )
    ((abs(rg_max - rg_min) < eps) || (iter < 1))
    ? h
    : ((df > 0)
       ? optim(rg_min, h, eps, iter-1)
       : optim(h, rg_max, eps, iter-1));

bowl_h_scale = optim(0, 3, 0.00001); // [scale] height proportional to the radius

/*************************************************************************
 * Compute the remaining parameters from the (determined) settings above */

bowl_h = bowl_r * bowl_h_scale; // [cm] actual bowl height
echo("Determined bowl height [cm]", bowl_h);


/**********************************************************
 * Build the bowl and the cap by modifying the primitives */

// prevent ugly intersections of primitive surfaces
eps = 0.001;

module bowl_block() {
	difference() {
		scale([1,1,bowl_h/bowl_r]) sphere(bowl_r);
		translate([0,0,+5+bowl_h*0.65]) cube([bowl_diameter,bowl_diameter,10], center=true); // top
		translate([0,0,-5-bowl_h*0.55]) cube([bowl_diameter,bowl_diameter,10], center=true); // bottom
	}
}

module cap() {
	scale([1.08,1.08,1])
	intersection() {
		scale([1,1,bowl_h/bowl_r]) sphere(bowl_r);
		translate([0,0,+5+bowl_h*0.65]) cube([bowl_diameter,bowl_diameter,10], center=true);
	}
}

module ring(add_r=0) {
	s = 2 / 3 + 0.1; // wall_thickness scale in z direction
    w = sqrt(1 - pow(0.65,2)) * bowl_r - wall_thickness * 0.8;
	translate([0,0,bowl_h*0.65])
		cylinder(wall_thickness*s, w+add_r, w+add_r, center=true);
}

module bowl_wall() {
	difference () {
		bowl_block();
		scale([1-wall_thickness/bowl_r,1-wall_thickness/bowl_r,1+eps]) {
			bowl_block();
		}
	}
}

module bowl() {
    cs = sqrt(1 - pow(0.55,2)) * bowl_r;
	union() {
		bowl_wall();
		scale([1-eps,1-eps,1]) translate([0,0,-eps]) hull() { // bottom
			intersection() {
				bowl_wall();
				translate([0,0,-5-bowl_h*0.55+wall_thickness])
                    cube([cs*2,cs*2,10], center=true);
			}
		}
	}
}

module final_cap() {
    difference () {
        union() {
            cap();
            ring();
        }
        translate([0,0,-wall_thickness*0.65])
            scale([(bowl_r-2*wall_thickness)/bowl_r,(bowl_r-2*wall_thickness)/bowl_r,1])
            cap();
    }
}

module final_bowl() {
	difference() {
		bowl();
		ring(print_spacing); // add space between cap and bowl
	}
}

/***********************
 * Final visualization */

// Slic3r expects 10x scaling (other slicer utils as well?)
scale([10,10,10]) {
    if (print_part == "both") {
        translate([0,0,5]) final_cap();
        final_bowl();
    } else if (print_part == "cap") {
        final_cap();
    } else if (print_part == "bowl") {
        final_bowl();
    }
}
