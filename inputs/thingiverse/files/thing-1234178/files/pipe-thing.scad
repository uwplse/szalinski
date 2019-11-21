/* [Base] */
// thickness of the walls
thickness = 3; // [3:8]
// outer diameter of the pipe (ie, inner diameter of the printed splint)
pipe_diameter = 15; // [5:30]
// angle of the bend, in degrees
splint_curve = 135; // [0:5:180]
// the length of the half-cutaway pipe which will sit on the rim of your vessel
length_before_curve = 15; // [10:1:30]
// length of the half-cutaway pipe at the other end
length_after_curve = 10; // [5:1:20]
// length of two overlap sections
overlap = 7; // [5:1:15]
// length of the outer legs
outer_leg_length = 15; // [10:1:30]
// length of the inner leg
inner_leg_length = 25; // [20:1:50]
// render coarseness
coarseness = 100; // [100:Fine, 20:Coarse]

/* [Hidden] */
inner_radius = pipe_diameter / 2;
outer_radius = (pipe_diameter / 2) + thickness;
curve_radius = pipe_diameter * 1.25;

rotate([0,90,0])
  translate([-20,0,-30])
    main();

module main()
{
    splint();
}

module splint()
{
    union() {
        pre_curve_1();
        pre_curve_2();
        curve();
        post_curve_1();
        post_curve_2();
        outside_legs();
        inside_leg();
    }
}

module pre_curve_1()
{
    linear_extrude(height = length_before_curve)
          half_ring();
}

module pre_curve_2()
{
    translate([0,0,length_before_curve])
    linear_extrude(height = overlap)
          ring();
}

module curve()
{
    translate([outer_radius + curve_radius, 0, length_before_curve + overlap])
    rotate([90,0,180])
    rotate_extrude(angle = splint_curve, $fn = coarseness)
      translate([outer_radius + curve_radius, 0, 0])
        half_ring();
}

module post_curve_1()
{
    translate([curve_radius + outer_radius,0,length_before_curve + overlap])
    rotate([0,splint_curve,0])
    translate([-curve_radius - outer_radius,0,0])
    linear_extrude(height = overlap)
          ring();
}

module post_curve_2()
{
    translate([curve_radius + outer_radius,0,length_before_curve + overlap])
    rotate([0,splint_curve,0])
    translate([-curve_radius - outer_radius,0,overlap])
    linear_extrude(height = length_after_curve)
          half_ring();
}

module outside_legs()
{
    union()
    {
      translate([0,-((thickness/2) + inner_radius),thickness/2])
        leg(outer_leg_length);
      translate([0,+((thickness/2) + inner_radius),thickness/2])
        leg(outer_leg_length);
    }
}

module inside_leg()
{
    translate([(thickness/2) + inner_radius, 0, (thickness/2) + length_before_curve])
    rotate([180, 0, 0])
    leg(inner_leg_length);
}

module leg(length)
{
    rotate([0, 90, 0])
      union()
      {
        linear_extrude(length)
          square(size = thickness, center = true);
        translate([-thickness, 0, length])
        rotate([90, 0, 0])
        rotate_extrude(angle = 90)
          translate([thickness, 0, 0])
            square(size = thickness, center = true);
      }
}

module post_curve()
{
    rotate([0,0,0], [0,0,0])
    linear_extrude(height = length_before_curve)
          half_ring();
}

module half_ring()
{
      difference()
      {
          circle(outer_radius, $fn = coarseness);
          circle(inner_radius, $fn = coarseness);
          polygon(points=[[0,outer_radius], [outer_radius,outer_radius], [outer_radius,-outer_radius], [0,-outer_radius], [0,outer_radius]]);
      }
}

module ring()
{
      difference()
      {
          circle(outer_radius, $fn = coarseness);
          circle(inner_radius, $fn = coarseness);
      }
}

///

module cut_out_tube()
{
    difference()
    {
        tube(true);
        tube(false);
    }
}

module tube(outer)
{
    diameter = outer ? (thickness + pipe_diameter) : pipe_diameter;
    rotate([0,0,0]) {
      union() {
        linear_extrude(height = 20)
          circle(r = diameter / 2);
        
          translate([-((thickness + pipe_diameter) / 2) - curve_radius, 0, 20])
        rotate([90,0,0])
        rotate_extrude(angle = 135, convexity = 2)
          translate([((thickness + pipe_diameter) / 2) + curve_radius, 0, 0])
            circle(r = diameter / 2);
      }
    }
}