//design by Sean Murphy

//This code generates a simple collimating slit of customisable size.

/* [Global] */


//width of plate
width=20;

//height of plate
height=10;

//thickness of plate
depth=0.1;

//slit height
slit_height=0.025;

//set openSCAD resolution
$fa=1;
$fs=1;

difference() {
cube([width,height,depth], 0);
translate([1,height/2, 0])
cube([width-2,slit_height,depth], 0);
}