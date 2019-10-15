/*                                                
 * A Bahtinov mask generator.
 * Units in mm, default values are for
 * the Samyang 135mm F/2.0 lens.
 *
 * 2019, Andreas Dietz
 * License: CC-BY-SA
 *
 */

/* [primary] */


// Total height of the mask
height = 20; // [2:40]

// Inner (mechanical) diameter of the mask
inner_dia = 94; // [40:300]

// free (optical) aperture of the lens
free_aperture = 80; // [30:290]

/* [Advanced] */


// Wall thickness
thickness = 2.0; // [1:0.5:5]

// Width of the grating bars
grating_width = 0.8; // [0.8:0.1:7.0]

// Gap between the grating bars
grating_gap = 0.8; // [0.8:0.1:7.0]

/* [Hidden] */
 
min_wt = 3.0;
$fn=300;

outer_dia = inner_dia + 2*thickness;

module mask()
{
   number = outer_dia/(grating_width+grating_gap);
   number_diag = (outer_dia/cos(45))/(grating_width+grating_gap);
 
   translate([0,0,-thickness/2])
   intersection() // grating
      {
         union()
            {
               union()
                  {
                     for (i = [-ceil(number/2):+ceil(number/2)]) // vertical grating
                        {
                           translate([i*(grating_width+grating_gap),-(outer_dia/2)/2,0]) cube([grating_width,outer_dia/2,thickness], center=true);
                        }
                     union() // stabilisation structure
                        {
                           cube([outer_dia,grating_width,thickness], center=true);
                           rotate([0,0,90]) cube([outer_dia,grating_width,thickness], center=true);
                           cylinder(d=4.0, h=thickness, center=true);
                           difference()
                              {
                                 cylinder(d=outer_dia, h=thickness, center=true);
                                 cylinder(d=free_aperture, h=thickness+0.1, center=true);
                              }
                        }
                  }
               
               translate([(outer_dia/2)/2,(outer_dia/2)/2,0])
               intersection() // left diagonal grating
                  {
                     translate([0,0,0])
                     rotate([0,0,-30.0])
                     for (i = [-ceil(number_diag/4):+ceil(number_diag/4)])
                        {
                           translate([i*(grating_width+grating_gap),0,0]) cube([grating_width,(outer_dia/cos(45)/2),thickness], center=true);
                        }
                     cube([(outer_dia/2),(outer_dia/2),thickness+0.1], center=true);
                  }
               translate([-(outer_dia/2)/2,(outer_dia/2)/2,0])
               intersection() // right diagonal grating
                  {
                     translate([0,0,0])
                     rotate([0,0,+30.0])
                     for (i = [-ceil(number_diag/4):+ceil(number_diag/4)])
                        {
                           translate([i*(grating_width+grating_gap),0,0]) cube([grating_width,(outer_dia/cos(45)/2),thickness], center=true);
                        }
                     cube([(outer_dia/2),(outer_dia/2),thickness+0.1], center=true);
                  }
            }
         cylinder(d=outer_dia, h=thickness+0.1, center=true);
      } // grating
   translate([0,0,-height/2])
   difference()
      {
         cylinder(d=outer_dia, h=height, center=true);
         cylinder(d=inner_dia, h=height+0.1, center=true);
      }
}
 
 
difference()
{
   if (free_aperture > inner_dia)
      {
         echo("ERROR: free_aperture must be smaller or equal to inner_dia!");
      }
   else
      {
         mask();
      }
   *rotate([0,0,270]) translate([-100,0,-110]) cube([200,200,200]);
}
