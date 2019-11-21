cliplen=25;

makefeet();
makesideinsert();

module makefeet()
{
  union()
  {
    difference()
    {
      cube([26,22.5,cliplen],center=true);
      translate([0,3.75,0]) cube([21,25,cliplen+5],center=true);
    }
    translate([0,-8.5,0]) cube([6,2,cliplen],center=true);
    translate([-10.5,1.25,0]) rotate([0,0,90]) cube([6,2,cliplen],center=true);
    translate([10.5,1.25,0]) rotate([0,0,90]) cube([6,2,cliplen],center=true);
  }
}

