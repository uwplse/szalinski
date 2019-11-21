//height of the surface the keyboard half will rest on
height = 88;

// width of the surface the keyboard will rest on
width = 121;

//angle of inclination
angle = 15; // [0:90]

// minkowski radius. increase to increase rounding
mink_r = 0;

// side length of cube at the bottom of the tent to hold in the keyboards
support_board_thickness = 5;

// how big the holes are. higher numbers = smaller holes. 2 = 1/2 the size of the sides
hole_size_factor = 2;

// facet number for cylinders and spheres. decrease to decrease rounded edges and compilation time
$fn=24;

// length is now x, width is y, height is still z
module prism(l, w, h){
  polyhedron(
    points=[[0,0,0], [0,w,0], [l,w,0], [l,0,0], [l,0,h], [l,w,h]],
    faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
  );
}


//calculated variables

// height is the only thing that needs adjustment, since the supoport bar
// at the bottom of the print actually extends, counteracting the extension
// of the length at the other side. that does make the support bar longer
// than advertised, but eh

real_height = height - mink_r * 2;




module tent(angle){
  hypotenuse = width + support_board_thickness;
  opposite = sin(angle) * hypotenuse;
  adjacent = cos(angle) * hypotenuse;

  minkowski(){
    difference(){
      union(){
        prism(adjacent, real_height, opposite);
        rotate([0, -angle, 0]) cube([support_board_thickness, real_height, support_board_thickness]);
      }
      holes(adjacent, real_height);
      // bottom board. if you want more height in your design you can enable this
      /* translate([0, 0, -10]) cube([adjacent, real_height, 10]); */
    }
    minkowski_shape(angle);
  }
}

// special cylinder with a tilted top that exactly matches the angle of the support
module minkowski_shape(angle=15){
  hull() {
    cylinder(r=mink_r, h=.001);
    rotate([0, -angle, 0]) translate([0, 0, mink_r]) cylinder(r= mink_r, h=.001);
  }
}

module holes(length, real_height){
  $fn=24;
  translate ([length / 2, 0, 0]) cylinder(d=length / hole_size_factor, h=100);
  translate([0, real_height / 2, 0]) cylinder(d=length / hole_size_factor, h=100);
  translate([length / 2, real_height, 0]) cylinder(d=length / hole_size_factor, h=100);
  translate([length, real_height / 2, 0]) cylinder(d=length / hole_size_factor, h=100);
}

/* minkowski_shape(); */
tent(angle);
