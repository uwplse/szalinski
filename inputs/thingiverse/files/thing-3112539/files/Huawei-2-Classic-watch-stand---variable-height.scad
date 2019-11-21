/* [Parameters] */

roundness = 5; // [0:6]
fullHeight = 100; // [53:150]

/* [Hidden] */
$fn=100;
// Account for all the adjustments in the file so that
// the specified height is the actual height of the whole piece.
height=fullHeight - 11.7;

difference() {
    // Join the top part with the rest of the stand
    // Then cut the wire race out of the side
    union() {
        translate([-5, -2.5, height/2 - 11])
            rotate([45,0,0])
                difference() {
                    watchHolder();
                    translate([-4,0,0])
                        watchHolderCutout();
                };                
        watchStand();
    }
    
    // Wire race
    translate([25, -2.5, - (height/2 - 8.5)])
        cube([4, 4, height-20]);
    
    // Opening for USB plug
    translate([25, 0, -(height/2 - 12.5)])
        minkowski() {
            cube([8,6,13], center=true);            
            sphere(r=1);
        };
}

module watchStand() {
    translate([25,0,0])
        // Side pillar with a wire race cutout
        difference() {
            minkowski() {
                cube([7 - roundness, 20 - roundness, height - roundness], center = true);
                sphere(r=roundness/2);        
            }
            
            translate([-5, -10, height/2 + 12.3])
                rotate([45,0,0])
                    cube([20, 50, 50], center=true);
        };
        
        // Base of the stand
       translate([-6.5,-1,-height/2])
       minkowski() {
            cube([70 - roundness, 35 - roundness, 10 - roundness], center = true);
                sphere(r=roundness/2);        
            }
}

module watchHolder() {
    // This is the main shape for the top part
    minkowski() {
        cube([67 - roundness,41 - roundness,12 - roundness], center = true);
        sphere(r=roundness/2);
    }
}

module watchHolderCutout() {
    union() {
        // this is the main part of the watch charger base designed around Huawei 2 Classic, but can be easily swapped out with other designs
        translate([-2,0,2])
            union() {
                cylinder(h = 10.01, d = 37, center = true);
                intersection() {
                    cube([50, 20, 10.01], center = true);
                    cylinder(h = 10.01, d = 50, center = true);            }
            };

        // These cut out the wire race from the top
        translate([7,0,4])
            cube([67,5,10], center = true);

        translate([39,0,0])
            cube([10,5,20], center = true);
    }    
}