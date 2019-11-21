renderQuality = 50; //[30:90]
$fn = renderQuality;
size = 1; // [1:Small 45mm tall,2.3:Medium 100mm tall,3.5:Large 150 mm tall]
wingSize = 1; // [1: Large Wings, 2: Small Wings]
hollow = "true"; // ["true":Hollow, "false": Solid]

scale([size,size,size])
union()
{
  
  //the skirt of the angel
  difference()
  {
  hull()
  {
    cylinder(r1 = 15, r2 = 3, h = 25, center = true);
    translate([11.5,0,-12])cube([10,10,1], center = true);
    translate([0,-14.5,-7])sphere(radius = 2, center = true);
    translate([0,14.5,-7])sphere(radius = 2, center = true);
  }
  if(hollow == "true")
  {
  cylinder(r1 = 13.5, r2 = 1.5, h = 25.2, center = true);
  }
  }

  //main body and head
  translate([0,0,14])cylinder(r1 = 3, r2 = 3.5, h = 9, center = true);
  translate([0,0,19])cylinder(r1 = 3.5, r2 = 2, h = 2, center = true);
  translate([0,0,23])sphere(r = 4, center = true);
  //arms
  difference()
  {
    translate([0,4,13])rotate([10,0,0])cylinder(r1=2,r2=.5,h=10,center = true);
    translate([0,6,8])rotate([45,0,0])cube([4,4,4], center = true); 
  }
  mirror([0,90,0])
  {
    difference()
    {
      translate([0,4,13])rotate([10,0,0])cylinder(r1=2,r2=.5,h=10,    center = true);
      translate([0,6,8])rotate([45,0,0])cube([4,4,4], center = true);
    }
  }
  //wings
  if(wingSize == 1)
  {
    scale([2,.9,1.4])
    {
    translate([3,7,13])rotate([15,0,-30])rotate([0,-90,0])cylinder(r1=7, r2=7, h = 1, center = true, $fn = 3);
    mirror([0,90,0])
    {
    translate([3,7,13])rotate([15,0,-30])rotate([0,-90,0])cylinder(r1=7, r2=7, h = 1, center = true, $fn = 3);
    }
    }
  }
  if(wingSize == 2)
  { 
    translate([3,7,18])rotate([15,0,-30])rotate([0,-90,0])cylinder(r1=7, r2=7, h = 1, center = true, $fn = 3);
    mirror([0,90,0])
    {
    translate([3,7,18])rotate([15,0,-30])rotate([0,-90,0])cylinder(r1=7, r2=7, h = 1, center = true, $fn = 3);
    }  
  }   
  //hook hole
  difference()
  {
    translate([0,0,27])sphere(r = 1.5, center = true);
    translate([0,0,27])rotate([0,90,0])cylinder(r1=.9, r2 = .9, h = 20, center = true);
  }
  
}