// Adjustable Tool Holder
// Units are mm

// Variables
w = 59;     //width of backplate
h = w*2;    //height of backplate
t = 5;      //thickness of backplate
d = 3;      //hole size

$fn = 50;

difference(){
    union(){
        //Backplate
        translate([0,t/2,0])
            cube([w,t,h],center=true);
            
        //Outter wall
        translate([0,-w/2,-w/2])
            cube([w,w,h/2],center=true);
    };    
        //Inner wall
        translate([0,-w/2,-w/2+t/2])
            cube([w-t/2,w-t/2,h/2],center=true);
    
        //mounting holes
        translate([w/4,0,h/6])rotate([90,0,0])
            cylinder([t*2,d/2,d/2],center=true);
        translate([-w/4,0,h/3])rotate([90,0,0])
            cylinder([t*2,d/2,d/2],center=true);
}