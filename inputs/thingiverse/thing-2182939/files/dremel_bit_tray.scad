// number of holes x direction
total_x_holes = 15;
// number of holes y direction
total_y_holes = 10;

// overall thickness of organize (default 15)
height = 15;
// spacing between holes (default 12)
spacing = 12;

// Factor to scale holes
hole_padding = 0.20;


/* [Hidden] */
corner_r = 5;
inch=25.4;

difference() {
  //cube([x_total * 10, y_total * 10,10]);
  hull() {
    $fn = 50;
    translate([corner_r, corner_r, 0]) cylinder(r=corner_r,h=height);
    translate([total_x_holes * spacing - corner_r, corner_r, 0]) cylinder(r=corner_r,h=height);
    translate([total_x_holes * spacing - corner_r, total_y_holes * spacing - corner_r, 0]) cylinder(r=corner_r,h=height);
    translate([corner_r, total_y_holes * spacing - corner_r, 0]) cylinder(r=corner_r,h=height);
  }
  
  for(x=[0:total_x_holes-1]){
    for(y=[0:total_y_holes - 1]) {
      translate([spacing/2 + x*spacing, spacing/2 + y*spacing,1.2])
        cylinder(d=1/8*inch*(1 + hole_padding), h=height + 3, $fn=20);
    }
  }
}