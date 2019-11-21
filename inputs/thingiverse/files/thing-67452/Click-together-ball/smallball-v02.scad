// Licence: Creative Commons, Attribution, Non-commercial
// Created: 15-02-2013 by bmcage http://www.thingiverse.com/bmcage

//radius of ball in mm
rad = 9;              // [5:200]
// scale factor to make ball egg-shaped
vertical_scale = 1;
//thickness of the mould
thickshell = 0.4;
//vent size
vent = 0; 
// lip to click halves together
lipheight = 1.5;

radius = rad + thickshell;
zradius = vertical_scale * radius; 


//what to print of the ball?
part = "both";           // ["both", "base", "top"]


use <MCAD/regular_shapes.scad> 

module lip()
{
intersection()
  {
   translate([-1.5*radius, -1.5 *radius, 0])
           cube(size=[radius * 3, radius * 3, lipheight]);
   scale([1,1,vertical_scale])
     difference(){sphere(radius-thickshell, $fn=50); sphere(radius-2*thickshell, $fn=50);}
   }
}

module holder()
{
union()
  {
  lip();
  intersection()
    {
    translate([-1.5*radius, -1.5 *radius, -2*radius])
              cube(size=[radius * 3, radius * 3, 2*radius]);
	 difference(){
   	scale([1,1,vertical_scale])sphere(radius, $fn=50); 
      scale([1,1,vertical_scale])sphere(radius-2*thickshell, $fn=50);
      intersection(){
      	scale([1,1,vertical_scale])sphere(radius-thickshell, $fn=50);
         translate([0,0,-vertical_scale*(radius+radius/2)])cube(size=[radius * 3, radius * 3, 2*vertical_scale*radius],center=true);
        }
      }
    }
  }
}

module holderheadbase()
{
    intersection() 
    {
    translate([-1.5*radius, -1.5 *radius, 0])
      cube(size=[radius * 3, radius * 3, 2*zradius]);
	 difference(){
   	scale([1,1,vertical_scale])sphere(radius, $fn=50); 
      scale([1,1,vertical_scale])sphere(radius-thickshell, $fn=50);
      }
    }
}

module holderhead()
{
  difference()
  {holderheadbase();
   cylinder(r=vent, h=2*zradius, $fn=10);
  }
}

if (part=="base")
{
  mirror([0,0,1])holder();
} 
if (part == "top")
{
  holderhead();
}
if (part == "both")
{
  translate([0,0,lipheight]) mirror([0,0,1])holder();
  translate([2*radius+ 5, 0, 0]) holderhead();
}
