// ring puzzle

// Tolerance (vertical gap)
tol=.4;
// Median-ish diameter
L=60;
// Width of of hexagonal cross-section
W=5;
// Angle
phi=60;
// Fraction to cut off points
f=0.43; //0.43;
// Height of brim to keep 1st layer joined, 0 to disable
brim_height=0.2;
// Tiny gap between brim and model so that slicer keeps walls
brim_gap=0.05;

translate([0,0,W/2]) rings();
difference() {
    intersection() {
      translate([0,0,W/2]) {
        ring();
        rotate([0,0,40])ring();
        rotate([0,0,80])ring();
      }
      cylinder(brim_height, L, L);
    }
    translate([0,0,W/2]){
      // Remove a bit of material to leave a gap. Do this
      // by removing the part we'd hit if we push down the
      // rings a bit.
      difference() {
        // Translate down to make the cut. Walls are at 60 deg angle,
        // so we need to move 1/cos(60 deg) = 2 times as far to get
        // the desired gap size.
        translate([0,0,-brim_gap * 2]) rings();
        rings();
      }
    }
}

module rings(w=W) union() {
    ring1(w);
    rotate([0,0,40])ring2(w);
    rotate([0,0,80])ring3(w);
}

module wedge(offset=0)
render()
translate([-L,0,0])intersection(){
    rotate([0,0,-45-phi/2])rotate([0,30,0])translate([offset,0,-L/2])cube(L);
    rotate([0,0,-45+phi/2])rotate([-30,0,0])translate([0,offset,-L/2])cube(L);
    translate([L*f,0,0])rotate([0,30,0])translate([offset,-L/2,-L/2])cube(L);
}

module ring(w=W)
render(convexity=4)
difference(){
    for(i=[0:2])rotate([0,0,120*i])intersection(){
        wedge(-w/2);
        mirror([0,0,1])wedge(-w/2);
        cube([2*L,2*L,w],center=true);
    }
    for(i=[0:2])rotate([0,0,120*i]){
        wedge(w/2);
        mirror([0,0,1])wedge(w/2);
    }
}

module cut(w,i,j,up=1)
intersection(){
    rotate([0,0,40*i])translate([0,0,(w-tol/2)*up])ring(2*w);
    rotate([0,0,60*j+75-40*i])translate([w,w,-L/2])cube(L);
}

module ring1(w=W)
render()
difference(){
    ring(w);
    cut(w,1,0,-1);
    cut(w,1,1);
    cut(w,1,2);
    cut(w,1,3);
    cut(w,1,4,-1);
    cut(w,1,5,-1);
    cut(w,2,0,-1);
    cut(w,2,1);
    cut(w,2,2);
    cut(w,2,3);
    cut(w,2,4,-1);
    cut(w,2,5,-1);
}

module ring2(w=W)
render()
difference(){
    ring(w);
    cut(w,1,0);
    cut(w,1,1);
    cut(w,1,2,-1);
    cut(w,1,3,-1);
    cut(w,1,4,-1);
    cut(w,1,5,-1);
    cut(w,2,0);
    cut(w,2,1,-1);
    cut(w,2,2,-1);
    cut(w,2,3,-1);
    cut(w,2,4);
    cut(w,2,5);
}

module ring3(w=W)
render()
difference(){
    ring(w);
    cut(w,1,0,-1);
    cut(w,1,1,-1);
    cut(w,1,2);
    cut(w,1,3);
    cut(w,1,4);
    cut(w,1,5,-1);
    cut(w,2,0,-1);
    cut(w,2,1,-1);
    cut(w,2,2);
    cut(w,2,3);
    cut(w,2,4);
    cut(w,2,5);
}