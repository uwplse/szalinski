/**
 * SAWBLADE CONTAINER
 * 
 * by Hendrik Busch is licensed under a 
 * 
 * Creative Commons Attribution-ShareAlike 4.0 International License.
 *
 * The outer dimensions are derived using the desired inner dimensions, the wall thickness
 * and the desired clearance between the two parts.
 */
 
/**
 * Defines the inner width of the container (X).
 */
innerWidth = 25;

/**
 * Defines the inner depth of the container (Y).
 */
innerDepth = 25;

/**
 * Defines the inner height (Z) of each half. You can calculate this value
 * by: (height of the object you want to store) / 2 + overlap (should be
 * at least 20%.
 * In my case, the saw blades are 15cm long. The inner height will therefore
 * be at least (15cm/2) * 1.25 ~= 9.4cm, which I upped to 10cm.
 */
innerHeight = 100;

/**
 * Adjust this to set your wall thickness. Thickness should be in multiples of
 * your extrusion width/nozzle size. You can't expect a proper 0.9mm wall from a
 * 0.4mm nozzle.
 */
wallThickness = 1.2;

/**
 * The clearance that the outer container and the inner container will have
 * *on each side*. 0.1mm means that the outer container is 0.2mm wider on the
 * inside than the inner one on the outside.
 */
clearance = 0.1;

/**
 * Set this to true if you want to print a label for your container. If not,
 * set this to false.
 */
useLabel = true; 

/**
 * The text of the label. This model scales this text down to fit the base of
 * the label, but too small of a base and/or to much of text here may render
 * the label unprintable due to too small details.
 */
label = "Sawblades";

// DO NOT MODIFY ANYTHING BELOW THIS LINE

/* [Hidden] */

$fn=128;

bottomDimensions = [innerWidth + 2 * wallThickness, innerDepth + 2 * wallThickness, innerHeight + wallThickness];
topDimensions = [innerWidth + 4 * wallThickness + 2 * clearance, innerDepth + 4 * wallThickness + 2 * clearance, innerHeight + wallThickness];
labelDimensions = [0.8 * topDimensions[0], 0.401, 0.75 * topDimensions[2]]; 

print();

module print() {
    part_containerBottom();
    translate([bottomDimensions[0] * 1.2, 0, 0]) part_containerTop();
    if (useLabel) {
        translate([0, bottomDimensions[0] * -1.2, 0]) part_label();
    }
}

module part_label() {
    cube([labelDimensions[2] - 0.1, labelDimensions[0] - 0.1, 0.8]);
    translate([labelDimensions[2] * 0.1, 0.9 * ((labelDimensions[0] - 0.1) / 2), 0.8]) color("Red") linear_extrude(height = 0.8) resize([labelDimensions[2] * 0.8, 0, 0]) text(text = label, size = 10, valign = "center", font = "sans-serif");
}

module part_containerBottom() {
    sub_openContainer(outerDimensions = bottomDimensions);
}

module part_containerTop() {
    difference() {
        sub_openContainer(outerDimensions = topDimensions);
        if (useLabel) {            
            translate([(topDimensions[0] - labelDimensions[0]) / 2, -0.01, (topDimensions[2] - labelDimensions[2]) / 2]) cube(labelDimensions);
        }
    }
}

module sub_openContainer(outerDimensions = [10, 10, 50], wallWidth = 0.8) {
    difference() {
        cube(outerDimensions);
        translate([wallWidth, wallWidth, wallWidth]) cube([outerDimensions[0] - 2 * wallWidth, outerDimensions[1] - 2 * wallWidth, outerDimensions[2] - wallWidth + 0.01]);
    }
    
}