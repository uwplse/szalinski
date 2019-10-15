//open source chissel

//Length of chissel handle
L=100; //[0:200]

// Length of tip
t= 30; //[0:100]

//Width of chissel handle
w=20; //[0:50]

//Height of chissel handle
h=20; //[0:20]

// Width of blade
b=20;// [0:50]

// Minimum printing step height
a=0.1; //

translate([0,0,w/2])

union(){
cube([L,h,w], center=true);
hull(){
translate([L/2,0,0])cube([1,h,w], center=true);
rotate([0,0,90])translate([0,-t-L/2,-w/2])cube([b,a,a], center=true);
}
}