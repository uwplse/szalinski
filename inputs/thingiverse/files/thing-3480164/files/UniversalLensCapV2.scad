/* [General Parameters] */

//(in mm) the thread size of the lens
FilterThreadSize = 52; //[25 : 1 : 100]

RenderInside = true;
RenderOutside = true;

//render quality
$fn=100;

/* [Advanced Parameters] */

//(in mm)
thickness= 1.5;//[0.5 : 0.1 : 3] 

//(in mm) how much should the cap overlap the thread size
outerLedge = 1.5; //[0.1 : 0.1 : 5]

//(in mm) how much empty space should be between the printed cap and the real filter thread size
diameterOffset = 1.0; //[0.1 : 0.1 : 3]

//(in mm) how much smaller should the holder be
holderOffset = 10; //[1 : 1 : 20]

//(in mm) moves the clip in/outwards
clipOffset= 0;//[-3 : 0.1 : 3] 


co = clipOffset;
id=FilterThreadSize-diameterOffset;
od=FilterThreadSize+outerLedge;
rd=FilterThreadSize-holderOffset;

//Prints:
if(RenderInside) inside();
if(RenderOutside) outside();

module outside(){
    rotate([0,180,0])cap();     
}


module cap(){difference(){
    union(){
    cylinder(2,id/2,id/2);
    translate([0,0,2])cylinder(4,od/2,od/2);
    }
    difference(){
        translate([0,0,-0.01])cylinder(4.42,id/2-1.5,id/2-1.5);
        translate([-od/2,rd/2-2,0])cube([od,od-rd,1.1]);
        rotate([0,0,180])translate([-od/2,rd/2-2,0])cube([od,od-rd,1.3]);
    }
    rotate([0,0,180])translate([-16/2,0,-0.01])cube([16,od/2,4.12]);
    translate([-16/2,0,-0.01])cube([16,od/2,4.12]);
    rotate([0,0,180])translate([-16/2,rd/2,-0.01])cube([16,od-rd,6.02]);
    translate([-16/2,rd/2,-0.01])cube([16,od-rd,6.02]);
}}

module inside(){rotate([0,180,0])difference(){
    union(){
        rotate([0,0,180])translate([0,co,0])holder();
        translate([0,co,0])holder();
        translate([0,0,1.5])cylinder(2.5,rd/2,rd/2);
    }
    translate([0,0,1.5-0.01])cylinder(2.52,rd/2-1.7,rd/2-1.7);
}}

module holder(){union(){
    translate([-15/2,0,1.5])cube([15,od/2-1,2.5]);
    intersection(){
        translate([-20/2,0,1.5])cube([20,od/2,2.5]);
        cylinder(6,id/2-1.75,id/2-1.75);
    }
    translate([0,(od-id)/2,0])intersection(){
            translate([-15/2,0,0])cube([15,od/2,6]);
            difference(){
                union(){
                    cylinder(2,id/2,id/2);
                    translate([0,0,2])cylinder(4,od/2,od/2);
                    cylinder(0.6,id/2,id/2+0.7);
                    translate([0,0,0.9])cylinder(0.6,id/2,id/2+0.7);
                    //#translate([0,0,1.2])cylinder(0.6,id/2,id/2+0.7);
                }
                translate([0,0,-0.01])cylinder(6.02,id/2-1.5,id/2-1.5);
            }
    }
   
}}

