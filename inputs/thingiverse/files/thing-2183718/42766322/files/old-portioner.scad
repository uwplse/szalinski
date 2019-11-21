// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Tea portioner
//
// Copyright 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0
// Using material (or inspirations) by
// Soren_Furbo (https://www.thingiverse.com/thing:43899/)
//

// How many cubic centimetres (ml) for one portion
volume = 55;  // [3:0.1:250]

// Don't
use_american_customary_units = 0;  // [1:Yes please. What's a meter?, 0:Of course not! Use SI units.]

module end_customizer()
{
   // This is a dummy module so stop users messing with the values below.
}

// TODO: labels
// TODO 2: Braile labels
// label_style = 1; [0:No label, 1:Raised Text, 2:Colored Text, 3:Braile];


min_funnel_top_width = 66.66667;

// Define values for $fa and $fs (or $fn) to get smoother corners.
// N.B.: Rendering of the funnel gets quite slow for small $fs and $fa values.
// $fa = 5;
// $fs = 0.5;


// This avoids odd edges caused by rounding errors. Use a smaller value
// here when you switched to smoother above.
odd_offset = 0.1;


// Should be a multiple of your nozzle diameter
wall_thickness = 1.6; // [1.2, 1.5, 1.6, 1.8]



// pi is still wrong. Even if we use the area of a circle below. Use tau.
tau = 2 * PI;

// Curvature of sides (Sphere radius)
roundness = 5;
inner_radius = roundness-wall_thickness;

chute_angle = 55;  // Degrees
funnel_angle = 60;

v_cmm = volume * 1000;

// Crazy math to get the volume with the rounding right Basically we
// have V = l^3 - lost_volume, with lost volume = the fillets in the
// edges and corners, 1/2 (cube - sphere), and a bit, depending on l,
// (square rod - cylinder), with no l^2 term.  Transformed to 0 = l^3 +
// al + b, plugged into Wolfram Alpha, put in here.
a = -8*(4-tau/2)*inner_radius*inner_radius;
b = -v_cmm +
      ((4-tau/3) -12 * (4 - tau/2)) * inner_radius*inner_radius*inner_radius;
// echo(a);
// echo(b);
// The solution of x^3+ax+b=0, accordinrg to Wolfram alpha
cube_root_bit = pow(sqrt(3) * sqrt(4*a*a*a + 27*b*b) - 9*b, 1/3);
inner_box_dimension = cube_root_bit / (pow(2, 1/3) * pow(3, 2/3)) -
   pow(2/3, 1/3) * a / cube_root_bit;
// echo(inner_box_dimension);
// echo(pow(v_cmm,1/3));
// Quick tests showed reasonable values, so i'll keep this version
// until somebody spots an error.

// End crazy math.

some_distance = 1.95 * inner_box_dimension + 10 * wall_thickness;


if (use_american_customary_units)
{
   how_rude();
}
else
{
   measure();
   chute();

   translate([0,some_distance,0])
   {
      rotate(180)
      {
         funnel();
      }
   }
}

if (false)
{
   // Demo. Check that the funnel fits
   translate(
      [wall_thickness, wall_thickness, inner_box_dimension + wall_thickness])
   {
      rotate(180)
      {
         funnel();
      }
   }

}

module how_rude()
{
   linear_extrude(height = 0.5) {
      text(text="Please visit", size=5);
      translate([0,-5,0])
      {
         text(text="metric4us.com", size=5);
      }
   }
}

// Length of the inner cube
icl_xy = inner_box_dimension - 2 * inner_radius;
// Measure shell dimension
icl_z = inner_box_dimension - inner_radius;
msd = inner_box_dimension + 2*wall_thickness;


module measure()
{
   // The precisely shaped box

   icl_z_plus =  icl_z + 2*wall_thickness;
   difference()
   {
      union()
      {
         translate([0,0,icl_z_plus/2+roundness])
         {
            difference()
            {
               union()
               {
                  minkowski()
                  {
                     // This is the outer shell
                     cube([icl_xy, icl_xy, icl_z_plus], center=true);
                     sphere(roundness);
                  }
                  // The thicker walls at the top
                  delta_x = (inner_box_dimension +4*wall_thickness)/
                     (inner_box_dimension + 2*wall_thickness);
                  translate([0,0,icl_z/2-4*wall_thickness])
                  {
                     linear_extrude(height=2*wall_thickness,scale=delta_x)
                     {
                        offset(r=roundness)
                        {
                           square([icl_xy,icl_xy],center=true);
                        }
                     }
                  }
                  translate([0,0,icl_z/2-2*wall_thickness])
                  {
                     linear_extrude(height=3*wall_thickness)
                     {
                        offset(r=roundness)
                        {
                           square([icl_xy+2*wall_thickness,icl_xy+2*wall_thickness],center=true);
                        }
                     }
                  }
               }
               minkowski()
               {
                  // This is the main hollow shell
                  cube([icl_xy, icl_xy, icl_z_plus], center=true);
                  sphere(inner_radius);
               }
               // Cut off the top. A big enough cube. important is the
               // lower face height.
               translate([-msd/2,-msd/2,icl_z_plus/2])
               {
                  cube([msd,msd,2*roundness]);
               }
            }
         }
      } // The measuring cup, with thick walls
      // Cutting out space where to put on the funnel. (No rails, just
      // lay it on top.)
      xyl_extra = 5*wall_thickness;
      xyl = inner_box_dimension+2*wall_thickness-2*roundness;
      translate([xyl_extra/2, xyl_extra/2, wall_thickness+inner_box_dimension])
      {
         linear_extrude(2.5*wall_thickness)
         {
            offset(roundness)
            {
               square([xyl + xyl_extra, xyl + xyl_extra],center=true);
            }
         }
      }
   }


}

module chute()
{
   // The length were done by hand, rather than
   // calculated. looks good, is good enough.
   w = inner_box_dimension + 2*wall_thickness - odd_offset;
   h = inner_box_dimension + wall_thickness;
   l = h / sin(chute_angle);
   p = l * cos(chute_angle);
   o = w/2 + p/2 + wall_thickness;
   difference()
   {
      union()
      {
         rotate([0,0,180])
         {
            translate([0,-o, h/2])
            {
               rotate(a=[chute_angle, 0, 0])
               {
                  cube([w, l, wall_thickness], center=true);
                  translate([w/2-wall_thickness/2,0,2.5*wall_thickness])
                  {
                     cube([wall_thickness, 2*l, 5*wall_thickness], center=true);
                  }
                  translate([-w/2+wall_thickness/2,0,2.5*wall_thickness])
                  {
                     cube([wall_thickness, 2*l, 5*wall_thickness], center=true);
                  }
               }
            }
            // Better connection between chute and measure
            difference()
            {
               translate([0,-w/2,
                          inner_box_dimension - inner_radius + roundness])
               {
                  rotate(a=[-chute_angle, 0, 0])
                  {
                     translate([-w/2, -wall_thickness, -2 * roundness + 1 * wall_thickness])
                     {
                        cube([w, 0.85*h, 2 * roundness]);
                     }
                  }
               }
               translate([0,-o, h/2])
               {
                  rotate(a=[chute_angle, 0, 0])
                  {
                     translate([0, 3*wall_thickness, 5*wall_thickness])
                     {
                        cube([w-odd_offset, l, 10*wall_thickness], center=true);
                     }
                  }
               }
               // I wanted to round the connection off. Too much work
               // to position the cylinder to do it.
               // translate([0,0,0])
               // {
               //    rotate(a=[0,90,0])
               //    {
               //       translate([0,0,-w/2])
               //       {
               //          cylinder(r=inner_radius, h=w);
               //       }
               //    }
               // }
            }
         }
      }
      // Honking big boxes to cut off too large stuff
      translate([0,0,-10*inner_box_dimension])
      {
         cube(20*inner_box_dimension,center=true);
      }
      translate(
         [0,0,10*inner_box_dimension + inner_box_dimension -
          inner_radius +roundness])
      {
         cube(20*inner_box_dimension,center=true);
      }
      cube([inner_box_dimension+wall_thickness/2,inner_box_dimension+wall_thickness/2,3*inner_box_dimension],center=true);
   }
}

module funnel()
{
   // First the base
//   xo = inner_box_dimension+2*wall_thickness-2*roundness-2*slider_tolerance;
   xyo = inner_box_dimension+3*wall_thickness-2*roundness;

//   xm = inner_box_dimension                 -2*roundness-2*slider_tolerance;
   xym = inner_box_dimension+2*wall_thickness-2*roundness;

//   xi = inner_box_dimension-2*wall_thickness-2*roundness-2*slider_tolerance;
   xyi = inner_box_dimension+0*  wall_thickness-2*roundness;
   difference()
    {
       translate([0.5*wall_thickness, 0.5*wall_thickness, 0])
       {
          union()
          {
             linear_extrude(wall_thickness)
             {
                offset(roundness)
                {
                   square([xyo,xyo],center=true);
                }
             }
             // Half of this is hidden in the bit below. This covers some edges
             translate([0,0, wall_thickness])
             {

                linear_extrude(height=1.5*wall_thickness, scale=xym/xyo)
                {
                   offset(roundness)
                   {
                      square([xyo,xyo],center=true);
                   }
                }
             }
          }
       }
       translate([wall_thickness, wall_thickness, -0.5*wall_thickness])
       {
          linear_extrude(4*wall_thickness)
          {
             offset(roundness)
             {
                square([xyi, xyi],center=true);
             }
          }
       }

    }

   difference()
    {
       translate([wall_thickness, wall_thickness, wall_thickness])
       {
          linear_extrude(1.5*wall_thickness)
          {
             offset(roundness)
             {
                square([xym, xym],center=true);
             }
          }
       }
       translate([wall_thickness, wall_thickness, -0.5*wall_thickness])
       {
          linear_extrude(4*wall_thickness)
          {
             offset(roundness)
             {
                square([xyi, xyi],center=true);
             }
          }
       }
    }
   // funnel_angle is typically 60 degrees, tan(60degrees) == sqrt(3)
   funnel_offset = wall_thickness / sin(funnel_angle);
   funnel_z_offset = roundness * sin(funnel_angle);
//   xf = xm + roundness * cos(funnel_angle);
   xyfb = xym + roundness * cos(funnel_angle);
   xyft = max(xyfb, min_funnel_top_width/2);
   funnel_height = (xyft - xyfb/2) * tan(funnel_angle);
   translate([wall_thickness, wall_thickness,
              2*wall_thickness + funnel_z_offset])
   {
       difference()
       {
           hull()
           {
               translate([xyfb/2, xyfb/2, 0])
               {
                   sphere(roundness);
               }
               translate([-xyfb/2, xyfb/2, 0])
               {
                   sphere(roundness);
               }
               translate([xyfb/2, -xyfb/2, 0])
               {
                   sphere(roundness);
               }
               translate([-xyfb/2, -xyfb/2, 0])
               {
                   sphere(roundness);
               }
               translate([0,0,funnel_height])
               {
                   translate([xyft, xyft, 0])
                   {
                       sphere(roundness);
                   }
                   translate([-xyft, xyft, 0])
                   {
                       sphere(roundness);
                   }
                   translate([xyft, -xyft, 0])
                   {
                       sphere(roundness);
                   }
                   translate([-xyft, -xyft, 0])
                   {
                       sphere(roundness);
                   }
               }
           }
           translate([0,0,funnel_offset])
           {
               hull()
               {
                   translate([xyfb/2, xyfb/2, 0])
                   {
                       sphere(roundness);
                   }
                   translate([-xyfb/2, xyfb/2, 0])
                   {
                       sphere(roundness);
                   }
                   translate([xyfb/2, -xyfb/2, 0])
                   {
                       sphere(roundness);
                   }
                   translate([-xyfb/2, -xyfb/2, 0])
                   {
                       sphere(roundness);
                   }
                   translate([0,0,funnel_height])
                   {
                       translate([xyft, xyft, 0])
                       {
                           sphere(roundness);
                       }
                       translate([-xyft, xyft, 0])
                       {
                           sphere(roundness);
                       }
                       translate([xyft, -xyft, 0])
                       {
                           sphere(roundness);
                       }
                       translate([-xyft, -xyft, 0])
                       {
                           sphere(roundness);
                       }
                   }
               }
           }
           translate([0,0,-2*roundness])
           {
               linear_extrude(4*roundness)
               {
                   offset(roundness)
                   {
                       square([xyi, xyi],center=true);
                   }
               }
           }
           translate([0,0,funnel_height-roundness])
           {
               linear_extrude(2*roundness)
               {
                   offset(roundness)
                   {
                       square([3*xyfb, 3*xyfb],center=true);
                   }
               }
           }

       }
   }
}
