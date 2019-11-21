use <utils/build_plate.scad>

/* [Customized Logo] */

// logo file, size should be 100x100 pixels, and it should be in B/W PNG format. You can download a couple of examples from the "Files" section of this Thing (LOGO_Samples.zip). By default, black will be the bottom and white the top of the relief in the image.
logo_file = "tennisball.png"; // [image_surface:100x100]

// decide whether to have the logo on one side of the dampner (easier to print) or both sides (cooler, but requires fine support for printing)
logo_on_both_sides = 0; // [0:No, 1:Yes]

/* [Build Plate] */

// display or hide the build plate
show_build_plate = 0; // [0:Hide,1:Show]

//for display only, doesn't contribute to final object
build_plate_selector = 3; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 140; //[100:400]
//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

translate([0,0,3.75 + logo_on_both_sides]) {
    for(b = [0:1]) {
        rotate([180 * b,0,0]) {
            translate([0,0,2.25]) {
                cube(size = [20,20,3], center = true);
            }
            translate([0,0,0.5]) {
                cube(size = [10,10,1], center = true);
            }
            for (s = [0:3]) {
                angle = 90 * s;
                rotate([0,0,angle]) {
                    translate([0,10.5,1.75]) {
                        cube(size = [20,1,2], center = true);
                    }
                    translate([0,10,2.75]) {
                        rotate([0,90,0]) {
                            cylinder(r = 1, h = 20, center = true, $fn=100);
                        }
                    }
                    translate([10,10,1.75]) {
                        cylinder(r = 1, h = 2, center = true, $fn = 100);
                    }
                    translate([10,10,2.75]) {
                        sphere(r = 1, center = true, $fn = 100);
                    }
                }
            }
        }
    }
    if (logo_file != "") {
    for ( p = [0:logo_on_both_sides]) {
        rotate([0,180*p,0])
            translate([0,0,3.75])
                scale([0.2,0.2,1])
                    surface(file = logo_file, center = true, invert=false);
    }
   }
}
if (show_build_plate == 1) {
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
}
