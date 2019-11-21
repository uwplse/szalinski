/*

Alternative Pocket Dungeons counters with models instead of embossed pictograms.

*/

draft = false;
$fs = draft ? 1 : 0.1;
$fa = 2;

q = 0.02;

// The counters are 15mm across and 2mm high

disc_outer_radius = 15 / 2;
rim_width = 1;
disc_inner_radius = disc_outer_radius - rim_width;
chamfer_radius = 0.5;
recess_depth = 2.5; // space in which to place objects
total_thickness = chamfer_radius + recess_depth;


module slice( r, a)
{
  ar = r * sqrt(2);

  intersection()
  {
    circle( r= r);

    if ( a < 360)
      polygon([
        [ 0,              0 ],
        [ 0,              ar ],
        [ sin(a*1/4)*ar,  cos(a*1/4)*ar ],
        [ sin(a*2/4)*ar,  cos(a*2/4)*ar ],
        [ sin(a*3/4)*ar,  cos(a*3/4)*ar ],
        [ sin(a*4/4)*ar,  cos(a*4/4)*ar ],
      ]);
  }
}


module counter()
{
  // Base
  translate([0,0, chamfer_radius ])
  rotate_extrude()
    hull()
    {
      // Chamfer the bottom in an effort to avoid "Elephant's foot"
      translate([ disc_outer_radius - chamfer_radius, 0])
      difference()
      {
        circle( r= chamfer_radius );
        translate([ -99, 0 ])
          square([ 199, 99 ]);
      }
      mirror([ 0, 1 ])
        square( [ q, chamfer_radius ] );
    }

  // Walls
  translate([0,0, chamfer_radius ])
  {
    linear_extrude( height= total_thickness - chamfer_radius )
    difference()
    {
      circle( r= disc_outer_radius );
      circle( r= disc_inner_radius );
    }
  }
  // Move to the upper surface of the base
  translate([0,0, chamfer_radius ])
    children();
}


module chest()
{
  width = recess_depth * 1.5;
  height = 1;
  band_width = 0.4;

  module xt( total_height, width, offset )
  {
    radius = total_height - height;
    depth = radius * 2;
    translate([ 0, 0, offset ])
    linear_extrude( height= width ) mirror([0,1])
    {
      translate([ -depth/2, 0])
        square([ depth, height ]);
      translate([0, height ])
        circle( r= radius );
    }
  }

  rotate([ -90, 0,0])
  {
    xt( recess_depth - 0.2, width, -width/2 );
    xt( recess_depth, band_width, -width/2+0.3*0 );
    xt( recess_depth, band_width, -band_width/2 );
    xt( recess_depth, band_width, width/2-band_width-0.3*0 );
  }
}


module stairs()
{
  steps = 8;
  step_height = recess_depth / steps;
  step_angle = ( 360 - 90) / ( steps);
  radius = disc_inner_radius * 1 / 2;

  cylinder( r= radius / 4, h= recess_depth);

  for( s= [ 1 : steps ])
  rotate( -( 90 + step_angle * ( s - 1) ) )
  linear_extrude( height= step_height*s)
    slice( radius, step_angle );
}


module hazard()
{
  intersection()
  {
    translate([ 0, -1, 0 ])
    scale( 0.05)
    translate([ 0, 0, -30 ])
    rotate([ -90, 0, 0 ])
      import("wfu_cbi_skull-hollow_jawless.stl", convexity=3);
    linear_extrude( height= 999, convexity=3)
      square( [ 999, 999 ], center=true);
  }
}


for (x= [-20, -40])
translate ([x, 0, 0])
//translate([ -20, 0, 0 ])
counter()
  chest();

for (x= [0, 20])
translate ([x, 0, 0])
//translate([ +20, 0, 0 ])
counter()
  hazard();

*counter()
  stairs();

