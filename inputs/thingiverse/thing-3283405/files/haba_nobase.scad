// haba block unit size 
unit=40;
// how much play your blocks should have.
tolerance=0.2;

// wall thickness
w=2;
// wall height
wh=8;
// wall height below track exits
wh_low=6;
// base plate offset, if > 0 the blocks will be lifted
// should be << wall size
// if == 0 you need left and right walls
offset=0;
// plate for the next brick to lay on
terrace=3;

// left wall (1 or 0, yes or no)
left = 1;
// right wall
right = 1;
// right wall support (1 or 0)
rws = 0;
// support distance
sd = 0.15;

// set the correct values from customizer settings
h=unit+tolerance;
lw=left*w;
rw=right*w;

difference() {
//clip
union() {
  translate([-w,-rw,-wh+offset/2])
  cube([h+2*w+terrace, h+lw+rw, wh+wh_low]);
  translate([-w,0,-wh+offset/2])
  cube([h+2*w+terrace, h+lw, 2*wh]);
}
//}
//track setup to be saved
union() {
translate([0,0,offset])
  cube([h,h,h]);
translate([0,-h,-h])
  cube([h,2*h,h]);
translate([h,0,0+offset])
  cube([2*h,h,h]);
}
}

//support under the right wall
translate([1,-rw,-wh])
cube([rws*(h-2),rws*rw,rws*(wh-sd)]);