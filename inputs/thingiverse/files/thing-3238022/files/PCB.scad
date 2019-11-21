$fn=36;

PCB_style=1;    //1=Cutted board  2=with frame border
PCB_size_X=2.54*20;
PCB_size_Y=2.54*19;
PCB_size_Z=1;
PCB_pitch=2.54;
PCB_holes_diameter=1;
PCB_copper_rings_diameter=2.15;
PCB_copper_rings_thickness=0.1;
PCB_color="Green";
PCB_rings_color="DarkGoldenrod";

module PCB(PCB_size_X,PCB_size_Y,PCB_size_Z,PCB_pitch)
translate([-PCB_pitch*round(PCB_size_X/PCB_pitch/2),-PCB_pitch*round(PCB_size_Y/PCB_pitch/2),0])
{
if(PCB_style==1)
  difference()
    {
    union()
      {
      color(PCB_color)
        cube([PCB_size_X,PCB_size_Y,PCB_size_Z]);
      
      color(PCB_rings_color)
        intersection()
          {
          for(a=[0:PCB_pitch:PCB_size_X+PCB_pitch])
            {
            for(b=[0:PCB_pitch:PCB_size_Y+PCB_pitch])
              {
              translate([a,b,-PCB_copper_rings_thickness])
                cylinder(d=PCB_copper_rings_diameter,h=PCB_size_Z+PCB_copper_rings_thickness*2);
              }
            }
          translate([0,0,-PCB_size_Z/2])
          cube([PCB_size_X,PCB_size_Y,PCB_size_Z*2]);
          }
      }
      color(PCB_rings_color)
      for(a=[0:PCB_pitch:PCB_size_X+PCB_pitch])
        {
          for(b=[0:PCB_pitch:PCB_size_Y+PCB_pitch])
            {
            translate([a,b,-PCB_size_Z/2])
              cylinder(d=PCB_holes_diameter,h=PCB_size_Z*2);
            }
        }
    }

if(PCB_style==2)
  difference()
    {
    union()
      {
      color(PCB_color)
        cube([PCB_size_X,PCB_size_Y,PCB_size_Z]);
      
      color(PCB_rings_color)
        for(a=[PCB_pitch:PCB_pitch:PCB_size_X-PCB_pitch/2])
          {
          for(b=[PCB_pitch:PCB_pitch:PCB_size_Y-PCB_pitch/2])
            {
            translate([a,b,-PCB_copper_rings_thickness])
              cylinder(d=PCB_copper_rings_diameter,h=PCB_size_Z+PCB_copper_rings_thickness*2);
            }
          }
      }

      color(PCB_rings_color)
        for(a=[PCB_pitch:PCB_pitch:PCB_size_X-PCB_pitch/2])
          {
          for(b=[PCB_pitch:PCB_pitch:PCB_size_Y-PCB_pitch/2])
            {
            translate([a,b,-PCB_size_Z/2])
              cylinder(d=PCB_holes_diameter,h=PCB_size_Z*2);
            }
          }
    }
}

PCB(PCB_size_X,PCB_size_Y,PCB_size_Z,PCB_pitch);