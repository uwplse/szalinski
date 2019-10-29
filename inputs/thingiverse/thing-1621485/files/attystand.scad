// preview[view:south west, tilt:top diagonal]

/* [Base] */
// Diameter of the 510 pin
pinDiameter = 7.5;
// Depth for the 510 hole
pinDepth = 6;
// Diameter of the Atomizer
outerDiameter = 25;
// Spacing between Atomizers
spacing = 2;
// Rows
rows = 3;
// Columns
columns = 5;

/* [Hidden] */
$fn = 50;
bottomHeight = 2;

/* Calculated */
height = pinDepth + bottomHeight;
length = columns * (outerDiameter + spacing);
width = rows * (outerDiameter + spacing);

difference() {
    cube([length, width, height]);
    
    rotate([0, 90, 0]) {
        translate([-height, 0, -1])
            cylinder(r=5, h = length + 2);
        translate([-height, width, -1])
            cylinder(r=5, h = length + 2);
    }
    
    rotate([-90, 90, 0]) {
        translate([-height, 0, -1])
            cylinder(r=5, h = width + 2);
        translate([-height, -length, -1])
            cylinder(r=5, h = width + 2);
    }
    
    xOffset = ((spacing + outerDiameter) / 2);
    yOffset = ((spacing + outerDiameter) / 2);
    zOffset = height - pinDepth;
    
    for(n =[0:rows - 1]) {
        for(k =[0:columns - 1]) {
            translate([xOffset + (spacing + outerDiameter) * k, yOffset + (spacing + outerDiameter) * n, zOffset])
                cylinder(r  = pinDiameter / 2, h = pinDepth +1);
        }
    }
}
