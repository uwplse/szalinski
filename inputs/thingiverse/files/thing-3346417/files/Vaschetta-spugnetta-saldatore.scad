$fn=72;
Reservoir_X=80;
Reservoir_Y=80;
Reservoir_Z=25;
ReservoirWallThickness=2;
Tray_X=50;
Tray_Y=50;
Tray_Z=10;
Border_cut_offset_Z=5;  //Border round cut
Holes_diameter=2;       //Sponge pad holes
Pads_number=2;        //Screw fixing pads
Part=0;           // 0=body    1=pad with holes     2=both
Section=0;      //Cross section of body

module Fixing_pad()
  {
    difference()
      {
      hull()
        {
        translate([-5,0,0])
          cube([10,10,2]);
        translate([0,0,0])
          cylinder(r=5,h=2);
        }
      translate([0,0,-1])
      cylinder(r=1.5,h=4);
      }
  }

module Reservoir()
  {
  difference()
  {
  union()
    {
    hull()
      {
      translate([Reservoir_X/2,Reservoir_Y/2,1])
        scale([1,1,2])
          sphere(1);
      translate([Reservoir_X/2,-Reservoir_Y/2,1])
        scale([1,1,2])
          sphere(1);
      translate([-Reservoir_X/2,Reservoir_Y/2,1])
        scale([1,1,2])
          sphere(1);
      translate([-Reservoir_X/2,-Reservoir_Y/2,1])
        scale([1,1,2])
          sphere(1);

      translate([Tray_X/2,Tray_Y/2,Reservoir_Z])
        scale([1,1,2])
          sphere(1);
      translate([Tray_X/2,-Tray_Y/2,Reservoir_Z])
        scale([1,1,2])
          sphere(1);
      translate([-Tray_X/2,Tray_Y/2,Reservoir_Z])
        scale([1,1,2])
          sphere(1);
      translate([-Tray_X/2,-Tray_Y/2,Reservoir_Z])
        scale([1,1,2])
          sphere(1);
      }

      if(Pads_number>0)
        translate([0,-Reservoir_Y/2-5,0])
          Fixing_pad();
      if(Pads_number>1)
        translate([0,Reservoir_Y/2+5,0])
          rotate([0,0,180])
            Fixing_pad();
      if(Pads_number>2)
        translate([Reservoir_Y/2+5,0,0])
          rotate([0,0,90])
            Fixing_pad();
      if(Pads_number>3)
        translate([-Reservoir_Y/2-5,0,0])
          rotate([0,0,-90])
            Fixing_pad();

    }


  }
}


if(Part==0 || Part==2)
color("Silver",0.75)
difference()
{
union()
{
difference()
  {
  union()
    {
    hull()
      {
      translate([Tray_X/2,Tray_Y/2,1+Reservoir_Z])
       sphere(2);
      translate([Tray_X/2,-Tray_Y/2,1+Reservoir_Z])
       sphere(2);
      translate([-Tray_X/2,Tray_Y/2,1+Reservoir_Z])
       sphere(2);
      translate([-Tray_X/2,-Tray_Y/2,1+Reservoir_Z])
       sphere(2);

      translate([Tray_X/2,Tray_Y/2,Tray_Z+Reservoir_Z])
       sphere(2);
      translate([Tray_X/2,-Tray_Y/2,Tray_Z+Reservoir_Z])
       sphere(2);
      translate([-Tray_X/2,Tray_Y/2,Tray_Z+Reservoir_Z])
       sphere(2);
      translate([-Tray_X/2,-Tray_Y/2,Tray_Z+Reservoir_Z])
       sphere(2);
      }
    }

    translate([0,0,Tray_X/2+Reservoir_Z+Border_cut_offset_Z])
      rotate([0,90,0])
        cylinder(r=Tray_X*0.5,h=Tray_X*2,center=true);
    translate([0,0,Tray_X/2+Reservoir_Z+Border_cut_offset_Z])
      rotate([90,0,0])
        cylinder(r=Tray_X*0.5,h=Tray_X*2,center=true);

    hull()
      {
      translate([Tray_X/2-1,Tray_Y/2-1,-1+Reservoir_Z])
       sphere(0.1);
      translate([Tray_X/2-1,-Tray_Y/2+1,-1+Reservoir_Z])
       sphere(0.1);
      translate([-Tray_X/2+1,Tray_Y/2-1,-1+Reservoir_Z])
       sphere(0.1);
      translate([-Tray_X/2+1,-Tray_Y/2+1,-1+Reservoir_Z])
       sphere(0.1);

      translate([Tray_X/2-4,Tray_Y/2-4,25+Reservoir_Z])
       sphere(2);
      translate([Tray_X/2-4,-Tray_Y/2+4,25+Reservoir_Z])
       sphere(2);
      translate([-Tray_X/2+4,Tray_Y/2-4,25+Reservoir_Z])
       sphere(2);
      translate([-Tray_X/2+4,-Tray_Y/2+4,25+Reservoir_Z])
       sphere(2);
      }
  }

    translate([0,0,0])
      Reservoir();
}

  hull()
    {
    translate([Reservoir_X/2-ReservoirWallThickness,Reservoir_Y/2-ReservoirWallThickness,3])
      scale([1,1,2])
        sphere(d=1);
    translate([Reservoir_X/2-ReservoirWallThickness,-Reservoir_Y/2+ReservoirWallThickness,3])
      scale([1,1,2])
        sphere(d=1);
    translate([-Reservoir_X/2+ReservoirWallThickness,Reservoir_Y/2-ReservoirWallThickness,3])
      scale([1,1,2])
        sphere(d=1);
    translate([-Reservoir_X/2+ReservoirWallThickness,-Reservoir_Y/2+ReservoirWallThickness,3])
      scale([1,1,2])
        sphere(d=1);

    translate([Tray_X/2-ReservoirWallThickness-3,Tray_Y/2-ReservoirWallThickness-3,Reservoir_Z+2])
      scale([1,1,2])
        sphere(1);
    translate([Tray_X/2-ReservoirWallThickness-3,-Tray_Y/2+ReservoirWallThickness+3,Reservoir_Z+2])
      scale([1,1,2])
        sphere(1);
    translate([-Tray_X/2+ReservoirWallThickness+3,Tray_Y/2-ReservoirWallThickness-3,Reservoir_Z+2])
      scale([1,1,2])
        sphere(1);
    translate([-Tray_X/2+ReservoirWallThickness+3,-Tray_Y/2+ReservoirWallThickness+3,Reservoir_Z+2])
      scale([1,1,2])
        sphere(1);
    }

    translate([0,0,-2.5])
      cube([100,100,5],center=true);

  if(Section==1)
    translate([0,100,0])
      cube([200,200,200],center=true);
}

if(Part==1 || Part==2)
color("White",0.9)
translate([0,0,26])
difference()
  {
  cube([Tray_X-2.5,Tray_Y-2.5,1],center=true);

  for(a=[0:30:359])
    {
    rotate([0,0,a])
      translate([Tray_X*0.4,0,0])
        cylinder(d=Holes_diameter,h=10,center=true);
    rotate([0,0,a])
      translate([Tray_X*0.15,0,0])
        cylinder(d=Holes_diameter,h=10,center=true);
    rotate([0,0,a])
      translate([Tray_X*0.28,0,0])
        cylinder(d=Holes_diameter,h=10,center=true);
    }
  }