// Pipe or Rod Mounting Flange
// (c) 2013, Christopher "ScribbleJ" Jansen


// Minimum Thickness of Object
min_thick = 5;
// Diameter of Pipe/Rod
pipe_d    = 25;
// Diameter of Flange
flange_d  = 60;
// Height of Object
height    = 25;

// Number of Setscrew Holes
num_setscrews = 3;
// Number of Flange Bolts
num_bolts = 3;

// Diameter of Flange Bolt
bolt_d    = 5;
// Diameter of Flange Bolthead
bolthead_d = 10;

// Diameter of "Setscrew" Bolt
setscrew_d = 5;
// Diameter of "Setscrew" Bolthead
setscrewhead_d = 10;

/* [Hidden] */

s = flange_d - pipe_d - min_thick*2;

difference()
{
  union()
  {
    cylinder(r=pipe_d/2 + min_thick, h=height);
    cylinder(r=flange_d/2, h=s/2 + min_thick);
  }

  // Pipehole
  translate([0,0,-1]) cylinder(r=pipe_d/2, h=height+2);

  // Bolts
  if(num_bolts > 0)
  {
    for(x=[0:360/num_bolts:num_bolts*(360/num_bolts)])
    {
      rotate([0,0,x]) 
      {
        translate([pipe_d/2 + min_thick + s/4,0,-1]) 
        {
          cylinder(r=bolt_d/2, h=height);
          translate([0,0,min_thick + 1]) cylinder(r=bolthead_d/2, h=height);
        }
      }
    }
  }

  // Chamfer
  translate([0,0,min_thick+s/2]) rotate_extrude() translate([pipe_d/2+min_thick+s/2,0,0]) circle(r=s/2);

  // Setscrews
  if(num_setscrews > 0)
  {
    for(x=[0:360/num_setscrews:num_setscrews*(360/num_setscrews)])
    {
      translate([0,0,min_thick+s/2]) rotate([0,0,(360/(num_setscrews*2))+x]) rotate([0,90,0])
      {
        cylinder(r=setscrew_d/2, h=flange_d/2);
        translate([0,0,pipe_d/2 + min_thick]) cylinder(r=setscrewhead_d/2, h=flange_d/2);
      }
    }
  }


}
