length=80;
//opening size, a C14 appliance inlet is 19.5x27.3
open_x=27.4;
open_y=19.6;
screw_dist=40;

screw_m=3.1;

$fn=60;

difference(){
    union(){
        //plate
        intersection() {
            cube([length,60,4]);
            //round edges
            translate([0,4,0])union(){
                //corners
                translate([4,0,4])sphere(4);
                translate([4,52,4])sphere(4);
                translate([length-4,52,4])sphere(4);
                translate([length-4,0,4])sphere(4);
                //sides
                translate([4,0,0])cube([length-8,52,4]);
                translate([4,0,4])rotate(a=-90, v=[1,0,0])cylinder(r=4, h=52);
                translate([length-4,0,4])rotate(a=-90, v=[1,0,0])cylinder(r=4, h=52);
                translate([4,0,4])rotate(a=90, v=[0,1,0])cylinder(r=4, h=length-8);
                translate([4,52,4])rotate(a=90, v=[0,1,0])cylinder(r=4, h=length-8);
            }
        }
        //vertical extrusion support
        translate([length-13,0,4])cube([5,60,1]);
        //horizontal extrusion supports
        translate([0,7.5,4])cube([length-20,5,1]);
        translate([0,47.5,4])cube([length-20,5,1]);
    }
    //mounting holes
    translate([length-10.5,10,-0.1])cylinder(r=screw_m/2, h=5.2);
    translate([length-10.5,50,-0.1])cylinder(r=screw_m/2, h=5.2);
    translate([10,10,-0.1])cylinder(r=screw_m/2, h=5.2);
    translate([10,50,-0.1])cylinder(r=screw_m/2, h=5.2);
    //(c14) plug opening
    translate([10+screw_dist,30,-0.1])cylinder(r=1.55, h=4.2);
    translate([10,30,-0.1])cylinder(r=1.55, h=4.2);
    translate([(10+screw_dist/2)-(open_x/2),30-open_y/2,-0.1])cube([open_x,open_y,4.2]);
}