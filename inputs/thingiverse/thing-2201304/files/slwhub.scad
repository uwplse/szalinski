width = 1; //[1:0.5:25]

/* [Hidden] */

hex_radius = 6 / sin(60) + 0.15;
hex_depth = 4.5;

height = width + hex_depth;

base_radius = 23 / 2;

mounting_hole_radius = 17.4 / 2;

difference() {
    union() {
        //base
        cylinder(r = base_radius, h = height);

        translate([0, 0, height])
            cylinder(r = 12.3 / 2, h = 2, $fs = 0.1);
    }
    
    //center hole
    translate([0, 0, hex_depth + 0.1])
        cylinder(r = 2, h = 2+width, $fs = 0.1);
    
    //hex
    translate([0, 0, -1])
        cylinder(r = hex_radius, h = hex_depth + 1, $fn = 6);
    
    //rounded hex corners
    for(i = [0 : 5]) {
        rotate([0 ,0, i * 60])
            translate([hex_radius-0.25, 0, 0])
                cylinder(r = 0.5, h = hex_depth, $fs = 0.1);
    }
    
    //m3 holes
    for(i = [0 : 5]) {
        rotate([0 ,0, 30 + i * 60])
            translate([mounting_hole_radius, 0, -1])
                cylinder(r = 1.25, h = height+2, $fs = 0.1);
    }

}