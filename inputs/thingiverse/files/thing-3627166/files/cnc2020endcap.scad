$fn=50;

snugness_factor=0.97;

makefeet();

module makefeet()
{
  union()
  {
    translate([0,0,0]) roundedbox(20,20,2.5,2);
    translate([0,0,(11/2)+1.25-1]) cylinder(11,4.6/2,4.6/2,center=true); // Rod for central 5mm dia hole
    translate([0,-(10-4.15),((11/2)+1.25)-1]) rotate([0,0,0]) makesideinsert(10);
    translate([0,10-4.15,((11/2)+1.25)-1]) rotate([0,0,180]) makesideinsert(10);
  }
}

module makesideinsert(len)
{
  scale([snugness_factor,snugness_factor,1])
  {
    difference()
    {
      cube([10.5,4.3,len+1],center=true);
      translate([(10.5/2)+((4/1.414)/2),(4.3/2)+((4/1.414)/2)-2.3,0]) rotate([0,0,45]) cube([4,10,len+2],center=true);
      translate([-((10.5/2)+((4/1.414)/2)),(4.3/2)+((4/1.414)/2)-2.3,0]) rotate([0,0,-45]) cube([4,10,len+2],center=true);
    }
  }
}

module roundedbox(l,d,h,r)
{
  difference()
  {
    difference()
    {
      difference()
      {
        difference()
        {
          cube([l,d,h],center=true);
          translate([-(l/2)+r,-(d/2)+r,0]){corner(r,h,0);};
        }
        translate([(l/2)-r,-(d/2)+r,0]){corner(r,h,90);};
      }
      translate([(l/2)-r,(d/2)-r,0]){corner(r,h,180);};
    }
    translate([-(l/2)+r,(d/2)-r,0]){corner(r,h,270);};
  }
}

module corner(r,h,ang)
{
  rotate([0,0,ang])
  {
    difference()
    {
      difference()
      {
        difference()
        {
          cylinder(h*2,r*2,r*2,center=true);
          cylinder(h*2,r,r,center=true);
        }
        translate([r*5,0,0]){cube([r*10,r*10,h*2],center=true);}
      }
      translate([0,r*5,0]){cube([r*10,r*10,h*2],center=true);}
    }
  }
}


