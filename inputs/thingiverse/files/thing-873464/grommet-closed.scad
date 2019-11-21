//CUSTOMIZER VARIABLES

top_height=5; // [0:30]
groove_height=3; // [0:30]
top_width=40; // [0:100]
mid_width=32; // [0:100]

//CUSTOMIZER VARIABLES END

grommet_cap(top_height,mid_width,top_width,groove_height);

module top(h=5,r=10) {
  cylinder(h,r,r);
}

module bottom(h=5,r=10) {
  cylinder(h,r,.7*r);
}

module mid(h=3,r=7) {
  cylinder(h,r,r);
}

module solid(h=5,r1=10,r2=15,g=3) {
  union() {
    top(h,r2);
    translate([0,0,h]) mid(g,r1);
    translate([0,0,h+g]) bottom(h,r2);
  }
}

module grommet_cap(h,r1,r2,g) {
  difference() {
    solid(h,r1,r2,g);
    translate([0,0,1.25*h]) cylinder(2*(h+g),.7*r1,.7*r1);
  }
}

