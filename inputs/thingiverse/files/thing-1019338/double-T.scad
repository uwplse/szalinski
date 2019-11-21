//spacing between T centers
spacing = 30;
//15mm for misumi and Openbeam
ext_size = 15; 
//thickness of piece
thickness = 2;

m3_hole = 3.5;
corner_radius = 4;

difference() {
  union() {
    difference() {
      union() {
        T();
        translate([spacing,0,0]) T();
        translate([corner_radius,ext_size*2])
        cube([ext_size*3+spacing-corner_radius*2,ext_size,thickness]);
      }
      T_holes();
      translate([spacing,0,0]) T_holes();
    }
    translate([spacing/2+ext_size*1.5,ext_size*2.5,thickness/2])
    if(spacing<37) {
      cylinder(d=ext_size-m3_hole,h=thickness,center=true);
    }
  }
  translate([spacing/2+ext_size*1.5,ext_size*2.5,thickness/2])
  cylinder(d=m3_hole,h=3*thickness,center=true,$fn=30);
}

module T_holes(){
  for (ii = [ext_size/2:ext_size:3*ext_size]) {
    translate([ii,2.5*ext_size ,0 ])
    cylinder(d=m3_hole,h=thickness*3,center=true,$fn=30);
  }
  for (ii = [ext_size/2:ext_size:3*ext_size]) {
    translate([1.5*ext_size,ii ,0 ])
    cylinder(d=m3_hole,h=thickness*3,center=true,$fn=30);
  }
}
module T() {
  difference() {
    union() {
      translate([0,2*ext_size] )
      v_rounded_cube([3*ext_size,ext_size,thickness],corner_radius);
      translate([(ext_size - corner_radius),corner_radius,0])
      v_rounded_cube([ext_size+corner_radius*2,ext_size*3-corner_radius,thickness],corner_radius);
      translate([(ext_size ),0,0])
      v_rounded_cube([ext_size,ext_size*3,thickness],corner_radius);
    }

    translate([-corner_radius,-corner_radius ])
    v_rounded_cube([ext_size+corner_radius,ext_size*2+corner_radius,thickness],corner_radius);
    translate([2*ext_size,-corner_radius ])
    v_rounded_cube([ext_size+corner_radius,ext_size*2+corner_radius,thickness],corner_radius);
  }
}


module v_rounded_cube(xyz,r,$fn=30) {
  z = xyz[2];
  y = xyz[1];
  x = xyz[0];
  translate([r,r])
  hull() {
    cylinder(h=z,r=r);
    translate([0,y-2*r])
    cylinder(h=z,r=r);
    translate([x-2*r,0])
    cylinder(h=z,r=r);
    translate([x-2*r,y-2*r])
    cylinder(h=z,r=r);
  }
}