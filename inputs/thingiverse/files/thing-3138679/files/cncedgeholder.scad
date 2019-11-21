$fn=50;
$holderwidth=20;

translate([0,($holderwidth/2)+5,0]) adjustableedgeholder();
translate([-15,-(($holderwidth/2)+5),0]) edgeholder();

module edgeholder()
{
  difference()
  {
    union()
    {
      translate([0,0,0]) cube([18,12,5],center=true);
      translate([17.5,0,2]) scale([1,$holderwidth/20,1]) cube([20,20,9],center=true);
    }
    translate([30,0,7]) scale([1,$holderwidth/20,1]) rotate([0,0,45]) cylinder(11,24,24-2.5,center=true,$fn=4);
    translate([34.5,0,2.5]) scale([1,$holderwidth/20,1]) rotate([0,0,45]) cylinder(11,24,24-2.5,center=true,$fn=4);
    translate([-3,0,0]) cylinder(10,6/2,6/2,center=true);
    difference()
    {
      translate([-8,0,0]) cube([10,20,10],center=true);
      translate([-3,0,0]) cylinder(10,12/2,12/2,center=true);
    }
  }
}

module adjustableedgeholder()
{
  difference()
  {
    union()
    {
      translate([-10,0,0]) cube([50,12,5],center=true);
      translate([17.5,0,2]) scale([1,$holderwidth/20,1]) cube([20,20,9],center=true);
    }
    translate([30,0,7]) scale([1,$holderwidth/20,1]) rotate([0,0,45]) cylinder(11,24,24-2.5,center=true,$fn=4);
    translate([34.5,0,2.5]) scale([1,$holderwidth/20,1]) rotate([0,0,45]) cylinder(11,24,24-2.5,center=true,$fn=4);
    translate([-27,0,0]) cylinder(10,6/2,6/2,center=true);
    translate([-3,0,0]) cylinder(10,6/2,6/2,center=true);
    translate([-15,0,0]) cube([23.5,6,10],center=true);
    difference()
    {
      translate([-32,0,0]) cube([10,20,10],center=true);
      translate([-27,0,0]) cylinder(10,12/2,12/2,center=true);
    }
  }
}
