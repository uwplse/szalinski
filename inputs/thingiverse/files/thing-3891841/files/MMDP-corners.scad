//Monoprice Mini Delta Printer corners
//Designed by Nathaniel Stenzel
//August 2019

$fn=30;
pin_thickness=3;
protrusion=0;
face=1;
hinge=1;
piece_1=1;
piece_2=1;
clearance=1;
//there is a screw between 9mm and 14 from the side rail and 4mm to 9mm from the edge of the machine
//top rail is 5.1-5.85 thick
//3.2 wide slot
//2.3 from back of slot to back of rail
module hinge_section(){
    difference(){
    cylinder(d=pin_thickness+3,h=10);
        difference(){
            translate([0,0,-1])cylinder(d=pin_thickness+clearance,h=12);
            cylinder(d=pin_thickness,h=10);
        }
    }
}

//translate([-10,2.7,0])cube([20,3,43]);
/*
difference(){
    translate([-5,5.7,0])cube([10,6.5,45.85]);
    translate([-10,2.7,40])cube([20,5.3,5.85]);
}*/
//translate([-5,0.7,40+5.85])cube([15,11.5,3]);

module door_hinge(){
    difference(){
        intersection(){
            translate([0,-pin_thickness/2,0])cube([45,pin_thickness,40]);
            rotate([0,-45,0])translate([0,-pin_thickness/2,-3])cube([60,pin_thickness,50]);
        }
        cylinder(d=pin_thickness+4,h=10.5);
        translate([0,0,19.5])cylinder(d=pin_thickness+4,h=11);
    }

    cylinder(d=pin_thickness,h=40);
    hinge_section();
    translate([0,0,20])hinge_section();
}

module MMDP_corner_top(hinge=1,protrusion=0,face=1){
    difference(){
        intersection(){
            cube([60,9+protrusion,50]);
            rotate([0,-45,0])cube([90,9+protrusion,50]);
        }
        translate([0,protrusion,0])translate([11.5,6.5,46])cylinder(d=3,h=5);
        if(face) {
            translate([3,4,0])cube([60,9+protrusion,47]);
        } else {
            translate([3,-1,0])cube([60,11+protrusion,47]);
        }            
    }
    if (hinge && face)translate([4,-pin_thickness/2-0.5,10])door_hinge();

    translate([-2,4.5+protrusion,2])cube([3,2.5,48]);

}
if (piece_1){
    translate([0,-5,50])rotate([180,0,0])MMDP_corner_top(hinge=hinge,protrusion=protrusion,face=face);
}
if (piece_2){
    translate([0,8,50])mirror([0,0,1])MMDP_corner_top(hinge=hinge,protrusion=protrusion,face=face);
}