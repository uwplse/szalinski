//open source chissel

//Length of chissel handle
L=100; //[0:200]

// Length of tip
t= 40; //[0:100]

//Width of chissel handle
w=20; //[0:50]

//Height of chissel handle
h=20; //[0:20]

// Minimum printing step height
a=0.1; //

translate([0,0,w/2])

union(){
cube([L,h,w], center=true);
hull(){
translate([L/2,0,0])cube([1,h,w], center=true);
rotate([0,90,90])translate([0,-t-L/2,0])cube([w,a,a], center=true);
}
}