//External diameter
ext_diam= 70;

//Internal diameter
int_diam = 55;

//Internal height
int_height = 20; 

//Hole diameter
hole_diam = 30;

hole_height = int_height + 5;

difference() {
    union() {
        cylinder(d=ext_diam, h=5, $fn=500);
        cylinder(d=int_diam, h=int_height, $fn=50);
    }
    translate ([0,0,0]) cylinder(d=hole_diam, h=hole_height, $fn=1000);
}