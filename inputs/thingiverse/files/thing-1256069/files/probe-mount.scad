$fn = 50;

length = 30;
diameter = 12.5;
thickness = 12;

height_of_plate=8;
height= 5;
depth = 8;
difference(){
    difference(){
        translate([0, (diameter/2)+(thickness/2)+depth/2, length/2]){
            cube([11, depth, length], center=true);
        }
        translate([0,(diameter/2)+(thickness/2)+(36/2)+depth-2,0]){
            cylinder(r = 36/2, h=length);
        }
    }
    translate([0, (diameter/2)+(thickness/2)+depth, length-(height_of_plate/2)]){
        rotate([90, 0, 0]){
            cylinder(r=1.5, h=depth);
        }
    }
}
difference() {
    hull(){
        translate([0, (diameter/2)+(thickness/2), height / 2]){
            cube([11, 8, height], center=true);
        }

        difference() {
            cylinder(r = (diameter/2)+(thickness / 2), h = height);
            cylinder(r = diameter/2, h = height);
        }
    }
    cylinder(r = diameter/2, h = height);
}
