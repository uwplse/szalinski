$fn = 31+1;

// Customizable spool holder

// preview[view:south, tilt:top]

// thickness of your frame (in mm)
thickness = 7;
depth = thickness + 8;
center = depth/2;

// width of the holder (in mm)
width = 10;

// lenth of the holder clip (in mm)
frame = 21;

// diameter of your spool (in mm)
diameter = 150;
spool = diameter/2;
rectangle = frame*2;

// size of the rod that hold your spool (in mm)
rod = 5;
x = depth-cos(45)*depth;

rotate (0, 0, 0){
    difference () {
        cube ([depth, rectangle, width]);
        translate([center-thickness/2,-1,-0.5]){
            cube ([thickness, frame+1, width+1]);
        }}
    translate ([depth, rectangle, 0]){
        rotate ([0, 0, 135]){
            cube ([spool, depth, width]);
            }
        }
    difference (){
        translate ([-cos(45)*spool+x, rectangle-cos(45)*depth+cos(45)*spool, 0]){
            cube ([cos(45)*depth, cos(45)*depth, width]);
        }
        translate ([-cos(45)*spool+x+cos(45)*depth/2, rectangle-cos(45)*depth+cos(45)*spool+cos(45)*depth, -0.5]){
            cylinder (width+1, d = rod);
        }
        }}