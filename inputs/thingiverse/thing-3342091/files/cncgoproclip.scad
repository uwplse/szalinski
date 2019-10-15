union()
{
  translate([0,0,11.25]) rotate([90,0,0]) clip();
  translate([16,0,24]) gopromount();
}

module gopromount()
{
  cube([3,35,48],center=true);
}

module clip()
{
  cliplen=25;
  union()
  {
    difference()
    {
      translate([1,0,0]) cube([26+2,22.5,cliplen],center=true);
      translate([0,3.75,0]) cube([21,25,cliplen+5],center=true);
    }
    translate([0,-8.5,0]) cube([6,2,cliplen],center=true);
    translate([-10.5,1.25,0]) rotate([0,0,90]) cube([6,2,cliplen],center=true);
    translate([10.5,1.25,0]) rotate([0,0,90]) cube([6,2,cliplen],center=true);
  }
}

