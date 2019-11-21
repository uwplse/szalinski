// screw hole offset for finetuning the height + / - 1mm
screw_hole_offset = 0.1;

module triangle(o_len, a_len, depth)
{
    linear_extrude(height=depth)
    {
        polygon(points=[[0,0],[a_len,0],[0,o_len]], paths=[[0,1,2]]);
    }
}


// 3Dtje fan shroud
module fan_shroud() {
    translate([0, 60, 0]) {
        difference() {

            // create the main shape, which is only 2 cubes //

            union() {
                translate([0, 0, - 5]) {
                    difference() {
                        translate([0, -10, 0]) cube([40, 60, 10], true); // main body cube
                        // cut out a cylinder in the middle for the fan center
                        cylinder(20, 7, 7, true, $fn = 180);
                        // cut off the top to make a half cylinder
                        translate([0, 32, 0]) cube([40 + 4, 60, 10 + 4], true); 
                    }
                }    
                // add the extension part cube
                translate([0, -40 + 15 / 2, 20 / 2 - 0.5]) cube([40, 15, 20], true);
            }

            // shape the extension bottom with a slope
            rotate([3, 0, 0]) translate([0, -41.8, 10]) cube([40, 5, 35], true);  

            // make it sexy //
            
            // shape the body sides (optional)
            translate([+20.5, -40.5, +26]) rotate([0, 180, 0]) triangle(24, 14, 40);
            translate([-20.5, -40.5, -14]) rotate([0, 0, 0]) triangle(24, 14, 40);

            // shape the extension sides (optional)
            translate([+21, -22, 24]) rotate([90, 180, 0]) triangle(27.5, 15, 20);
            translate([-21, -42, 24]) rotate([90, 180, 180]) triangle(27.5, 15, 20);

            // shape the extension top (optional)
            rotate([42, 0, 0]) translate([0, -13 + 15 / 2, 30]) cube([40, 15, 23], true);  

        }
    }    
}

difference() {
    union() {
        // create 2 fan shrouds, subtract the smaller, inner one to make the construct hollow
        difference() {
            fan_shroud();
            // cut off the sides of the rescaled version, so it won't create open walls
            difference() {
                translate([0, 2.4, -1]) scale([1.1, 0.92, 0.8]) fan_shroud();

                translate([+21, 40, 0]) cube([4, 50, 40], true); 
                translate([-21, 40, 0]) cube([4, 50, 40], true); 

                translate([+19, 60 -40.5, +26]) rotate([0, 180, 0]) triangle(24, 14, 40);
                translate([-19, 60 -40.5, -14]) rotate([0, 0, 0]) triangle(24, 14, 40);
            }
            
            // add holes for the vent outtake
            translate([0, 23, 26]) cube([10, 5, 30], true);
            translate([0, 20, 28]) cube([12, 7, 20], true); 
        }
        
        // add stronger walls to the screw holes
        translate([-16, 60 -16 + screw_hole_offset, -5]) cylinder(10, 3.3, 3.1, true, $fn = 180);
        translate([+16, 60 -16 + screw_hole_offset, -5]) cylinder(10, 3.3, 3.1, true, $fn = 180);

        // add 3 bridge pillars for easier printing and to guide the airflow
        translate([0, 52 -14.2, -5]) scale([1, 4.5, 1]) cylinder(10, 0.6, 0.6, true, $fn = 180);
        translate([+7, 52 -13, -5]) rotate([0, 0, -15]) scale([1, 5, 1]) cylinder(10, 0.6, 0.6, true, $fn = 180);
        translate([-7, 52 -13, -5]) rotate([0, 0, +15]) scale([1, 5, 1]) cylinder(10, 0.6, 0.6, true, $fn = 180);
        
        // side pillars to guide airflow
        translate([-17.6, 65 -13.5, -5]) rotate([0, 0, 16]) scale([1, 10, 1]) cylinder(10, 0.8, 0.8, true, $fn = 180);
        translate([17.6, 65 -13.5, -5]) rotate([0, 0, -16]) scale([1, 10, 1]) cylinder(10, 0.8, 0.8, true, $fn = 180);

        // add internal air guides / slopes
        translate([5, 25.5, 19.5]) rotate([270, 90, 90]) triangle(2, 5.3, 10);
        translate([6.5, 21.1, -9]) rotate([270, 270, 90]) triangle(4, 4, 13);
    }
    
    // cut screw holes
    translate([-16, 60 -16 + screw_hole_offset, -5]) cylinder(20, 1.85, 1.85, true, $fn = 180);
    translate([+16, 60 -16 + screw_hole_offset, -5]) cylinder(20, 1.85, 1.85, true, $fn = 180);

    // cut screw head guides
    translate([-16, 60 -16 + screw_hole_offset, -10]) cylinder(2.5, 4.75, 1.5, true, $fn = 180);
    translate([+16, 60 -16 + screw_hole_offset, -10]) cylinder(2.5, 4.75, 1.5, true, $fn = 180);

    // cut off the top half circle for the vent intake, create a "cookie cutter" shape first, then apply it
    translate([0, 60, 0]) {
        difference() {
            cylinder(14, 18.5, 18.5, true, $fn = 180);
            cylinder(25, 9, 9, true, $fn = 180);
            translate([0, 11, 0]) cube([40, 20, 30], true); // remove half of it
        }
    } 

    // cut slopes in case the shroud catches on the print
    translate([0, 19, -10]) rotate([35, 0, 0]) cube([20, 5, 10], true);  
    translate([0, 19, 21]) rotate([-35, 0, 0]) cube([20, 5, 10], true);  
}



        
    


