//L bracket for DJI S1000
// The wedge is the bottom part of the L that fills the gap.
// The upper part of the L parallels the base plate.

// Thickness of wedge
t_w=2.5;

// Width of upper and width of wedge
w=19;

// Length of upper piece not including wedge (height of the upper part of L not including the bottom part)
l_u=20;

// Thickness of upper part.
t_u=5;

// Length of wedge
l_w=10;

union() {
  cube([l_u,w,t_u]);
  translate ([l_u,0,0]){
    cube([t_w,w,l_w]);
  }
}