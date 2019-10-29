/* End stop striker for optical end stop
   -- Williams

http://www.amazon.com/OpenSCAD-3D-Printing-Al-Williams-ebook/dp/B00I6K19OM

The idea is to put an endstop bolt in through a
locknut (nylock) and then CA glue 
the nut to the body. This provides a narrow
striker for an optical end stop */


$fn=50+0;

// Main body diameter (mm)
main_diameter=15;
// Main body length (mm)
body_length=15;
// Nut diameter (mm; 8.5mm=#6)
nut_diameter=9.4;
// Nut height (mm; 5mm=#6)
nut_height=5;
// Depth to cut out nut (mm)
nut_depth=1;

// Striker length (mm)
striker_length=10;
// Striker width (mm)
striker_x=2;
// Striker height (mm)
striker_y=6;

// Bolt hole diameter (mm; 3.8=#6)
bolt_diameter=3.8;


module nutHole(size,height)
  {
  cylinder(r=size,h=height,$fn=6,center=[0,0]);
  }

union() {
translate([0,0,body_length/2+striker_length/2]) cube([striker_x,striker_y,striker_length],center=true);
difference() {
  cylinder(r=main_diameter/2,h=body_length,center=true);
  translate([0,0,-2]) cylinder(r=bolt_diameter/2,h=body_length,center=true);
translate([0,0,-(body_length/2+.1)]) nutHole(size=nut_diameter/2,height=nut_height);
}
}
