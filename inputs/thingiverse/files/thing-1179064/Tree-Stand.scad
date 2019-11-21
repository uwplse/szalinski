/* Global */

INNER_DIAMETER = 5;

stand();
module stand()
{
   union()
   {
       wings();
       core();
   }     
}
module core()
{
 difference()
 {   
  difference()
  {
   union()
   {   
   translate([0,0,15])   
    cylinder(d=25.4, h=30, center=true, $fn=50);
   translate([0,0,16])   
    cylinder(d=20, h=32, center=true, $fn=50);
   }
   translate([0,0,18])
      cylinder(d=INNER_DIAMETER, h=32, center=true, $fn=50);
  }    
   translate([0,0,31])
   sphere(d=INNER_DIAMETER+1, center=true, $fn=50);  
}
}

module wing()
{
  difference()
  {
   translate([12, -2.5,0])
    cube([50,5,28]); 
   translate([60,0,55])   
   rotate([90,0,0])  
      cylinder(r=50, h=100, center=true, $fn=100);
     
  } 
}

module wings()
{
    union()
    {
        wing();
        rotate([0,0,90]) wing();
        rotate([0,0,-90]) wing();
        rotate([0,0,180]) wing();
    }
}