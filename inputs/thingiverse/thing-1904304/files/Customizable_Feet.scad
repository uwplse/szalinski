//Customizable "Rubber Feet"
//(Best in a flexible filament)

include <utils/build_plate.scad>


//Customizable Variables
diameter = 30; // [6:100]
height = 3;

//Cylinder
cylinder (r=0.5*diameter, h=height);

//Build plate for scale
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
