$fn=36;

Terminal_pitch=2.54*2;
Terminal_positions=2;

module Screw_terminal(Pitch,Positions)
  {
    for(a=[0:1:Positions-1])
      {
      difference()
        {
        union()
          {
            color("Slategrey")
            hull()
              {
              translate([0,Pitch*a,3.5])
              cube([8,Pitch,6],center=true);
              translate([0.5,Pitch*a,5.5])
              cube([5,Pitch,10],center=true);
              }
          color("Silver")
          translate([0,Pitch*a,0])
            cylinder(d=0.75,h=6,center=true);

          color("Silver")
            translate([0,Pitch*a,-2])
               cylinder(r1=0,r2=1,h=1);
          }

          color("silver")
          translate([0.5,Pitch*a,11])
            cylinder(d=3,h=6,center=true);
          color("DarkGrey")
          translate([0.5,Pitch*a,11])
            rotate([0,0,45])
            cube([0.5,3,10],center=true);
          translate([4,Pitch*a,3.5])
            cube([8,3,5],center=true);

        }

      }




  }

translate([2.54*12,2.54*2,1.5])
Screw_terminal(Terminal_pitch,Terminal_positions);
