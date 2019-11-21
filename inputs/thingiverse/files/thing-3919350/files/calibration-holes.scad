


/*
 * Calibration: Holes
 * by ASP3D - https://www.thingiverse.com/asp3d/about
 * created 2019-10-16
 * version v1.0
 * 
 * This work is licensed under the Creative Commons - Attribution - Non-Commercial ShareAlike license.
 * https://creativecommons.org/licenses/by-nc-sa/3.0/
 */
 

/* [Parameters] */

// Diameter of first hole
start_diameter = 4;

// Increment next diameter by this value
diameter_step = 0.1;

// How many holes to generate
holes_count = 5;

// Width of plate
width = 5;


/* [Hidden] */

$fn = 100;

holes_step = start_diameter + diameter_step*holes_count + start_diameter/2;


linear_extrude(width)
    difference() {
        offset(r=5)
            hull()
                holes();
        holes();
    }



module holes() {
    for (i=[0:holes_count-1]) {
        translate([i*holes_step, 0, 0])
            circle((start_diameter + i*diameter_step)/2);
    }
}
