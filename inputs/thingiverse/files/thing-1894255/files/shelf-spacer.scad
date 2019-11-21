//Created by Dave Borghuis aka zeno4ever
//Inspired by blender object by Govert Gombe

//Size
size = 27; // [1:100]
//Height
height = 20; // [1:100]
//Cut Size
cutsize = 3; // [1:100]
//Cut Depth
cutdepth = 7; // [1:100]

translate([0,0,height/2]) 
difference() {
    //make main cube
    intersection() {
        rotate([0,0,45]) cube([size,size,height],center=true);
        cube([size,size,height],center=true);
    };
    //make cuts
    for(side = [0 : 90 : 360]) {
        rotate([0,0,side]) translate([0,size-cutdepth,0]) cube([cutsize,size,height],center=true);
    };
};