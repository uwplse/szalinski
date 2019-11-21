// Type of object: outline or inner template
mode = "outline"; // [outline, inside]
// Z-height of the generated part (mm)
thickness = 0.5;
// Width of reinforcement band (mm, outline mode)
width = 6;

/* [Hidden] */
if (mode == "inside")
  goblin_wing_template(thickness);
else
  goblin_wing_reinforce(thickness, width);

module goblin_wing_reinforce(thick, wide) {
  linear_extrude(thick) difference() {
    // cut the top and botton to fit in existing space
    intersection() {
      offset(delta=wide) wingshape();
      translate([-500/2, -14, 0]) square([500, 41.5]);
    }
    wingshape();
  }
}

module goblin_wing_template(thick) {
  linear_extrude(thick) wingshape();
}

module wingshape() {
  /* From FT official free plans, imported into Inkscape and path values copied 
     https://www.flitetest.com/articles/ft-goblin-release 
  */
  p=[
[222.899,115.137],
[267.350,120.495],
[267.350,126.845],
[143.521,135.775],
[105.420,135.775],
[80.019,132.352],
[62.239,123.866],
[59.742,118.711],
[64.218,115.137]
  ];
  translate(-p[0]) {
  polygon(p);
  translate([p[6][0]+1.0,(p[6][1]+p[8][1])/2,0])
    circle((p[6][1]-p[8][1])/2+0.1, $fn=14);
  }
}
