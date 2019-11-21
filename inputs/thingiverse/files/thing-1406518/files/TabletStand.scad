left=1; //Show left leg (1 or 0)
right=1; //Show right Leg (1 or 0)
angle=15; //Tilt angle from upright
depth=10.45; //tablet thickness
height=45; //Support height, 1/3 of tablet height
width=8; //bracket width, bezzel size
wall=2; //Wall thickness
ChargerHeight=0; //support lift for bottom charge port

LiftHeight=sin(angle)*(depth+wall*2); //Do not adjust
AngleLength=cos(angle)*(depth+wall*2); //Do not adjust

if (right==1)rotate([90,0,0])translate([0,0,LiftHeight+wall])RightSide();
if (left==1)mirror([0,1,0])rotate([90,0,0])translate([0,0,LiftHeight+wall])RightSide();

module RightSide(){
    translate([0,0,0]){
        rotate([0,angle,0]){
            difference(){
                cube([depth+wall*2,width+wall,height+wall+ChargerHeight]);
                union(){
                    translate([wall,wall,wall+ChargerHeight])cube([depth,width+wall,height+wall+ChargerHeight]);
                    translate([width/2,.9,height/4])rotate([90,0,0])Signature();
                }
            }
        }
    }
    translate([0,0,-LiftHeight])cube([depth*2,wall,LiftHeight]);
    translate([AngleLength,0,-LiftHeight])cube([height*1.75-AngleLength,wall,depth]);
    translate([0,0,-LiftHeight])cube([height*1.75,depth*2,wall]);
}

module Signature(){
    cube([1,4,1]);
    translate([0,4,0]){
        rotate([0,0,45])translate([0,-3,0]){
            difference(){
                cube([3,3,1]);
                translate([1,1,-1])cube([3,3,3]);
            }
        }
    }
    translate([4.95,3.29,0]){
        rotate([0,0,-45])translate([0,-3,0]){
            difference(){
                cube([3,3,1]);
                translate([1,1,-1])cube([3,3,3]);
            }
        }
    }
    translate([2.83,-0.95,0])cube([1,2.12,1]);
}
