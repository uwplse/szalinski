/*
 *
 *     Handmade weaving machine
 *
 */

pin = 5;            // number of spikes
pin_height = 10;    // height of thorns
width = 30;         // product diameter
height = 15;         // diameter of the hole
hole = 16;          // the height of the opening
$fn = 30;           // extermination


difference()
{
   cylinder(d=width,h=height);
   cylinder(d=hole,h=height);
}
for(i=[0:360/pin:360])
{
   rotate([0,0,i]) translate([((width/2)-((width-hole)/4)),0,height])
   {
      difference()
      {
         union()
         {
            cylinder(d=((width-hole)/2)*0.66, h=pin_height);
            translate([0,0,pin_height]) sphere(d=((width-hole)/2));
         }
         union()
         {
            translate([((width-hole)/8),0,0]) cylinder(d=((width-hole)/2)*0.66, h=(pin_height + (width-hole)));
         }
      }
   }
}