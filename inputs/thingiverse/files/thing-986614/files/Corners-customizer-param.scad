use <utils/build_plate.scad>;

// Height of the strop belt
strop_h = 40; // [20:100]

// Render Quality
rendering = 1; // [3:Full, 2:Medium, 1:Draft]

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

translate ([0,0,-(strop_h*1.2)/2]) build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

/* hidden */
re = 32;
$fn = re * rendering;

intersection () {
    difference () {
        cube ([strop_h*2.1, strop_h*2.1, strop_h*1.2], center=true);
        cube ([strop_h, strop_h, strop_h*1.21], center=true);
        difference () {
            cylinder (h=strop_h*0.95, r=(strop_h*2)/2, center=true);
            cylinder (h=strop_h*0.96, r=(strop_h*1.7)/2, center=true);
        }
        cube ([strop_h*(1/10), strop_h*4, strop_h*4], center=true);
        cube ([strop_h*4, strop_h*(1/10), strop_h*4], center=true);
        rotate (a=45, v=[0,0,1]) cube ([strop_h*1.45, strop_h*(1/10), strop_h*3], center=true);
        rotate (a=135, v=[0,0,1]) cube([strop_h*1.45, strop_h*(1/10), strop_h*3], center=true);
    }
    cylinder (h=strop_h*1.2, r=(strop_h*2.21)/2, center=true);
}