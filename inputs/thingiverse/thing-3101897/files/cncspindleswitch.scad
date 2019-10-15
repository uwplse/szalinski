$fn=50;
snugness_factor=0.95;

translate([20,0,1.25]) makebase();
translate([-20,0,15]) rotate([0,180,0]) makebox();

module makebox()
{
  difference()
  {
    translate([0,0,-1.5]) rotate([90,0,0]) roundedbox(23,33,23,3); // Main box part
    translate([0,0,-17]) cube([40,40,4],center=true); // Chop of rounded bottom
    translate([0,0,-3]) cube([17,17,30],center=true); // Hollow inside
    translate([0,0,-15]) cube([20,20,5],center=true); // Inset for base
    translate([0,10,0]) cube([13,5,20],center=true); // Switch cutout
    translate([0,-10,2.5]) cube([13,5,13],center=true); // Cables cutout
  }
}

module makebase()
{
  union()
  {
    cube([19,19,2.5],center=true);
    translate([0,0,((16/2)+1.25)-1]) cylinder(16,4.6/2,4.6/2,center=true); // Rod for central 5mm dia hole
    translate([10-4.15,0,((16/2)+1.25)-1]) rotate([0,0,90]) makesideinsert();
    translate([-(10-4.15),0,((16/2)+1.25)-1]) rotate([0,0,-90]) makesideinsert();
    translate([0,-(10-4.15),((16/2)+1.25)-1]) rotate([0,0,0]) makesideinsert();
  }
}

module makesideinsert()
{
  scale([snugness_factor,snugness_factor,1])
  {
    difference()
    {
      cube([10.5,4.3,11+5],center=true);
      translate([(10.5/2)+((4/1.414)/2),(4.3/2)+((4/1.414)/2)-2.3,0]) rotate([0,0,45]) cube([4,10,13+5],center=true);
      translate([-((10.5/2)+((4/1.414)/2)),(4.3/2)+((4/1.414)/2)-2.3,0]) rotate([0,0,-45]) cube([4,10,13+5],center=true);
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


