width = 6; //[1:0.5:25]
style = "pin"; //[pin:Pin, hex:Hex]

/* [Hidden] */

hex_radius = 6 / sin(60) + 0.13;
hex_depth = 4;

height = style == "hex" ? width + hex_depth : width + 2;

base_radius = 23 / 2;

mounting_hole_radius = 16.3 / 2;

difference() {

    //base
    cylinder(r = base_radius, h = height, $fs = 0.1);
    
    //center hole
    translate([0, 0, -1])
        cylinder(r = 2.1, h = height + 2, $fs = 0.1);
    
    if(style == "hex") {
        //hex
        translate([0, 0, width])
            cylinder(r = hex_radius, h = hex_depth + 1, $fn = 6);
        
        //rounded hex corners
        for(i = [0 : 5]) {
            rotate([0 ,0, i * 60])
                translate([hex_radius-0.25, 0, width])
                    cylinder(r = 0.5, h = hex_depth + 1, $fs = 0.1);
        }
    } else if(style == "pin") {
        translate([0,0,height-1])
            cube([10.4,2.1,2.1],center=true);
    }

    //m2.5 screw holes, 2.1mm for making threads with the screw
    for(i = [0 : 4]) {
        //add 5.6 degrees to get as far from hex corners as possible
        rotate([0 ,0, i * 360 / 5 + 5.6])
            translate([mounting_hole_radius, 0, -1])
                cylinder(d=2.1, h = height+2, $fs = 0.1);
    }


}