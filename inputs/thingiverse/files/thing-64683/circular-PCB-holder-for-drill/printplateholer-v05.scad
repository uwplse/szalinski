// Licence: Creative Commons, Attribution, Non-commercial
// Created: 15-02-2013 by bmcage http://www.thingiverse.com/bmcage

// radius of the printplate
radpp = 15;
// radius of the holes in printplate                
radholepp = 1;
// thickness of the shell, take eg 2x your nozzle diam. This is thickness of the lip, sphere will have twice this thickness!        
thickshell = 0.8;
radius = radpp + thickshell;
// holes in PCB are on an equilateral triangle. Give side in mm
sidetria = 17;            
radtriacircum = sidetria/sqrt(3);

//there are two possible parts
part = "base";           // [base, top_1] 

//height of the lip that is used to click both parts together
lipheight = 2;

//add a drillholder pin on the base or not/
drill_holder = "yes";    // [yes, no]
//height of the drillholder
drill_height = 20;
//diameter of the drill bit
drill_size = 6; 

use <MCAD/regular_shapes.scad> 

module lip()
{
intersection()
  {
   translate([-1.5*radius, -1.5 *radius, 0])
           cube(size=[radius * 3, radius * 3, lipheight]);
   difference(){sphere(radius-thickshell); sphere(radius-2*thickshell);}
   }
}

module pin()
{union(){
  translate([radtriacircum,0,lipheight-0.4])cylinder(r1=4, r2=4, h=0.4);
  translate([radtriacircum, 0 , -sqrt(radius*radius-radtriacircum*radtriacircum)])
    cylinder(r1=3*radholepp, r2=3*radholepp, h=sqrt(radius*radius-radtriacircum*radtriacircum)+lipheight-2-4, $fn=10);
  translate([radtriacircum, 0 , -5])
    cylinder(r1=3*radholepp, r2=radholepp, h=5, $fn=10);
  translate([radtriacircum, 0 , -1])
    cylinder(r1=radholepp, r2=radholepp, h=lipheight+1, $fn=10);
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
	 difference(){sphere(radius); sphere(radius-2*thickshell);}
    }
  pin();
  rotate([0,0,120]) pin();
  rotate([0,0,-120]) pin();
  if (drill_holder == "yes") {
    translate([0,0,-radius+2*thickshell]) mirror([0,0,-1]) cylinder(r=drill_size/2, h=drill_height, $fn=10);
    }
  }
}

module holderheadbase()
{
    intersection() 
    {
    translate([-1.5*radius, -1.5 *radius, 0])
      cube(size=[radius * 3, radius * 3, 2*radius]);
	 difference(){sphere(radius); sphere(radius-thickshell);}
    }
}

module holderhead()
{
  difference()
  {holderheadbase();
   linear_extrude(height=2*radius) hexagon(2);
   rotate([45,0,0])cylinder(r=2, h=2*radius, $fn=10);
   rotate([45,0,60])cylinder(r=2, h=2*radius, $fn=10);
   rotate([45,0,120])cylinder(r=2, h=2*radius, $fn=10);
   rotate([45,0,180])cylinder(r=2, h=2*radius, $fn=10);
   rotate([45,0,240])cylinder(r=2, h=2*radius, $fn=10);
   rotate([45,0,300])cylinder(r=2, h=2*radius, $fn=10);
  }
}

if (part=="base")
{
  mirror([0,0,1])holder();
} 
if (part == "top_1")
{
  holderhead();
}
