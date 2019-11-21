
/* [Global] */
// Height
h=40;
// Radius
r=12;
// Make a tube around ?
outertube=1; // [0,1]

/* [Hidden] */
$fn=64;

module tube() {
difference() {
  cylinder(h,r+r/12,r+r/12);
  translate(0,0,-0.5) cylinder(h+1,r-0.05,r-0.05);
 }
}

union() {
  difference(){
    union(){
      linear_extrude(height=h, twist=h/r*720)
        translate([0,0,0])
           square([r,r/3]);

      cylinder(h+r/2,r/4,r/4);
    }

    translate (0,0,-0.05) cylinder(6,r/6,0.5);
  }

  if (outertube==1) {
    tube();
  }
}