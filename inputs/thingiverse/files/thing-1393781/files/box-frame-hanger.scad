//
// Box-framed picture hanging tool
// version 1.0   05/03/2016
// by Matthew Flint (mkflint @ Thingiverse)
//

/* [Main] */
// thickness of the walls
thickness = 2; // [3:8]
// depth; limited by the distance between the canvas and the wall
depth = 10; // [8:20]
// height of the teeth (from the base to the tip of the tooth)
teeth_height = 3; // [2:20]
// number of teeth. Even number!
number_of_teeth = 4; // [2:10]
// width of each tooth
tooth_width = 3; // [2:10]
// diameter of the screw hole
hole_diameter = 4; // [2:10];

/* [Hidden] */
teeth_width = number_of_teeth * tooth_width;
width = teeth_width + (depth * 2);

main();

module main()
{
  render(convexity = 3)
  rotate([0,0,180])
  translate([-width * 0.5, 0, 0])
    union()
    {
      flat_bit();
      teeth();
    }
}

module flat_bit()
{
  difference()
  {
    linear_extrude(thickness)
      flat_bit_shape();
    centre_notch();
  }
}

module flat_bit_shape()
{
  difference()
  {
    square(size=[width,depth]);
    translate([depth*0.5, depth*0.5])
      circle(d=hole_diameter, $fn = 30);
    translate([width - (depth*0.5), depth*0.5])
      circle(d=hole_diameter, $fn = 30);
  }
}

module centre_notch()
{
  translate([width*0.5, 0, 0])
  rotate([-90,0,0])
  linear_extrude(depth)
  {
    rotate([0,0,30])
    circle(d=1, $fn=3);
  }
}

module teeth()
{
  translate([(width-teeth_width)/2,thickness,thickness])
    rotate([90,0,0])
      linear_extrude(thickness)
        teeth_shape();
}

module teeth_shape()
{
  rectangle_height = teeth_height - (tooth_width * cos(60));
  x_offset = (tooth_width * 0.5) + teeth_width - (tooth_width * number_of_teeth);
  y_offset = teeth_height - (tooth_width * cos(60) * 0.5);

  union()
  {
    square(size=[teeth_width,rectangle_height]);
    for (i=[0:number_of_teeth-1]) {
      translate([x_offset + (tooth_width * i), y_offset])
        rotate([0,0,-30])
          circle(d=tooth_width / sin(60), $fn = 3);
    }

  }
}
