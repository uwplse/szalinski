use <utils/build_plate.scad>

/* [Geometry] */
// The size of the shape
cutter_width = 45; 
// The number of sides
sides = 3;
// How uneven to make the sides. 2 gives a rectangle or 30-60-90 triangle.
xyratio = 1;
// Skew the shape, with a side ratio of 2, 45 degrees makes a diamond and an isoceles triangle.
skew_angle = 0; 

/* [Cutter options] */
flange_width = 5;
flange_height = 1;
cutter_thickness = 1;
height = 13;
/* [Build plate] */

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);


/* [Hidden] */
// All done. Customizer doesn't need to see all this

$fn = 80;
rad = cutter_width/2;


xscale = 2/(xyratio+1);
yscale = 2*xyratio/(xyratio+1);

difference(){
    union(){
        minkowski(){
            cutter(height);
            cylinder (r = cutter_thickness, h = 0.1);
        }
        minkowski(){
            cutter(flange_height);
            cylinder (r = flange_width, h = 0.1);
        }
    }
    translate([0,0,-height])cutter(height*3);
}

module cutter(high = height){
    $fn = sides;
    scale([xscale,yscale,1])
    rotate([0,0,180/sides+skew_angle])cylinder (r = rad, h = high);
}