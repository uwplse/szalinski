// The thickness of the mount plate (in mm)
mountplate_thickness = 2 ; // [0:10]
// The thickness of the motor mount plate (in mm)
motormountplate_thickness = 2 ; // [2:7]

/* [Hidden] */
layer_height=.25; extrusion_width=.5;
epsilon=.01;

module smoothen(r) {
 offset(r=+r,$fn=r*PI*6) offset(delta=-r) children();
}

module the_bracket(
 mountplate_size=[62,40],
 mountplate_r = 3,
 mounthole_d = 3.5,
 mountholes_span=[54,30],
 motor_side=42.3,
 motor_protrusion_hole_d = 23.5,
 motormountholes_span = 31,
 thickness = 2,
 motormountplate_thickness = 2.5,
 mountplate_thickness = 2,
 motormounthole_d = 3,
 motorconnector_width = 16.5,
 motorconnector_hole_r = 2.5,
 motorconnector_distance = 16.5,
 mountscrew_l = 10, mountscrewhead_d = 6, mountscrewhead_h = 3,
 mounthole_depth = 5,
 motormounthole_depth = 4,
 extra_spacer = 0
) {
 titan_h = 25; titan_bowdenmount_h = 4;
 echo("max longscrew",titan_h+motormountplate_thickness+extra_spacer+motormounthole_depth);
 echo("max shortscrew",titan_bowdenmount_h+motormountplate_thickness+extra_spacer+motormounthole_depth);
 difference() {
  union() {
   // mount plate
   linear_extrude(height=mountplate_thickness)
   smoothen(r=mountplate_r)
   translate([-mountplate_size.x/2,0])
   square(size=mountplate_size);
   // motor mount plate
   hull() for(sx=[-1,1])
   translate([sx*(motor_side/2+thickness-motormountplate_thickness/2),motormountplate_thickness/2,0])
   cylinder(d=motormountplate_thickness,h=motor_side+mountplate_thickness,$fn=motormountplate_thickness*PI*2);
   // sides
   for(sx=[-1,1]) translate([sx*(motor_side+thickness)/2,0,0])
   hull() {
    translate([-thickness/2,motormountplate_thickness/2,0])
    cube(size=[thickness,mountplate_size.y-motormountplate_thickness/2,mountplate_thickness]);
    translate([-thickness/2,motormountplate_thickness/2,0])
    cube(size=[thickness,motormountplate_thickness/2,mountplate_thickness+motor_side]);
   }
  }
  // mount holes
  for(sx=[-1,1]) for(sy=[-1,0,1])
   translate([sx*mountholes_span.x/2,sy*mountholes_span.y/2,0])
   translate([0,mountplate_size.y/2,0]) {
    translate([0,0,-1])
    cylinder(d=mounthole_d,h=mountplate_thickness+2,$fn=mounthole_d*PI*2);
    translate([0,0,mountscrew_l-mounthole_depth])
    cylinder(d=mountscrewhead_d,h=mountplate_thickness+1,$fn=mountscrewhead_d*PI*2);
   }
  // motor protrusion cutout
  translate([0,0,mountplate_thickness+motor_side/2])
  rotate([-90,0,0]) translate([0,0,-1])
  cylinder(d=motor_protrusion_hole_d,h=motormountplate_thickness+2,$fn=motor_protrusion_hole_d*PI*2);
  // motor mount holes
  for(sx=[-1,1]) for(sz=[-1,1])
   translate([sx*motormountholes_span/2,0,sz*motormountholes_span/2])
   translate([0,0,mountplate_thickness+motor_side/2])
   rotate([-90,0,0]) translate([0,0,-1])
   cylinder(d=motormounthole_d,h=motormountplate_thickness+2,$fn=motormounthole_d*PI*2);
  // motor connector cutout
  translate([mountplate_size.x/2,
             motormountplate_thickness+extra_spacer+motorconnector_distance-motorconnector_hole_r,
             mountplate_thickness+motor_side/2-motorconnector_width/2])
  rotate([0,-90,0])
  linear_extrude(height=mountplate_size.x)
  smoothen(r=motorconnector_hole_r)
  square([motor_side+mountplate_thickness+1,mountplate_size.y]);
 }//difference
}//the_bracket module

// mountplate_thickness = 5.1
the_bracket(mountplate_thickness=mountplate_thickness,motormountplate_thickness=motormountplate_thickness);
