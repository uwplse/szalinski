// CC-BY - Design by dusjagr, 2016
// Demo prototyping CubeSat for laser-cutting
// As part of the DIY space education program K_Space
// Kathmandu, Nepal - Karkhana & Hackteria
// more info: http://www.karkhana.asia/k_space/

//Output_Type = "STL";
Output_Type = "STL"; //[DXF,STL,single]
//Output_Type = "single";

Ornament = "NO"; //[YES,NO]
Logo = "YES"; //[YES,NO]


CubeSize = 100;//[30:200]
BeamWidth = 10; //[4:14]
LogoSize = 45;
OrnamentSize = 5;
RoundEdge = 8;

/*[Material]*/

BaseThickness = 4;	//[3:8]
LevelThickness = 2;//[1:6]
ScrewDiam = 4;

/*[Hidden]*/
$fs=0.1;
ScrewPort = (2*BeamWidth+ScrewDiam)/BeamWidth;

// Assembly the Model

if (Output_Type == "single"){
   
   translate ([0,0,0]) InnerLevel();
}

if (Output_Type == "DXF"){
   projection(cut=true) 
    translate ([0,CubeSize+2*ScrewDiam+8,0]) InnerLevel();
   projection(cut=true) 
    translate ([CubeSize,CubeSize+2*ScrewDiam+8,0]) InnerLevel();
    
    projection(cut=true)
    translate ([CubeSize+5,CubeSize+4,0]) InnerShaft();
    projection(cut=true)
    translate ([CubeSize+5,CubeSize+ScrewDiam+8,0]) InnerShaft();
    projection(cut=true)
    translate ([0,CubeSize+4,0]) InnerShaft();
    projection(cut=true)
    translate ([0,CubeSize+ScrewDiam+8,0]) InnerShaft();
    
   projection(cut=true) 
    BasePlateC();
   projection(cut=true) 
    translate ([0,-CubeSize-5,0]) BasePlateC();
    
   projection(cut=true) 
    translate ([CubeSize+5,0,0]) SidePlate();
   projection(cut=true) 
    translate ([CubeSize+5,-CubeSize-5,0]) SidePlateEmblem();
   
}
if (Output_Type == "STL"){
color("deeppink") BasePlateC();
color("deeppink") translate ([0,0,CubeSize-BaseThickness]) BasePlateC();
color("pink") translate ([0,BaseThickness,0]) rotate ([90,0,0]) SidePlateEmblem();
color("pink") translate ([0,CubeSize,0]) rotate ([90,0,0]) SidePlate();

color("yellow") translate ([0,0,CubeSize*0.1]) InnerLevel();
translate ([0,0,CubeSize*0.3]) InnerLevel();
translate ([0,0,CubeSize*0.8]) InnerLevel();

}

// MODULES ///////////////////////////////
module InnerShaft()

cube([CubeSize,ScrewDiam,BaseThickness],false);

module Ornament1()
union(){
rotate([0,0,45]) cube([OrnamentSize,OrnamentSize,33],true);
rotate([0,0,0]) cube([OrnamentSize,OrnamentSize,33],true);
}
module BasePlateC()
difference(){
  translate([CubeSize/2,CubeSize/2,0]) BasePlate2();
    translate([0,0,-2]) cube([BeamWidth,BaseThickness,33],false);
    translate([CubeSize-BeamWidth,0,-2]) cube([BeamWidth,BaseThickness,33],false);
    translate([0,CubeSize-BaseThickness,-2]) cube([BeamWidth,BaseThickness,33],false);
    translate([CubeSize-BeamWidth,CubeSize-BaseThickness,-2]) cube([BeamWidth,BaseThickness,33],false);
}

module InnerLevel()
translate([CubeSize/2,CubeSize/2,0]) 
difference(){
translate ([0,0,0]) roundedRect([CubeSize-BeamWidth-BaseThickness,CubeSize-BeamWidth-BaseThickness,LevelThickness],RoundEdge);
   for(i = [0 : 1]) 
   rotate([0,0,i*180]) translate([CubeSize/2-1.3*BeamWidth-BaseThickness,0,-3]) scale([0.6,1]) cylinder(33,d=15,center=false);

   for(i = [0 : 3]){
     rotate([0,0,i*90]) translate([CubeSize/2-BeamWidth*ScrewPort+1*ScrewDiam,CubeSize/2-BeamWidth*ScrewPort+1*ScrewDiam,-2])  cylinder(33,d=ScrewDiam*1.4,center=false);
}
}
module SidePlate()
{
difference(){
     cube([CubeSize,CubeSize,BaseThickness],false);
     translate([BeamWidth,0,-15]) cube([CubeSize-2*BeamWidth,BaseThickness,33],false);
     translate([BeamWidth,CubeSize-BaseThickness,-15]) cube([CubeSize-2*BeamWidth,BaseThickness,33],false);
    
     if (Ornament == "NO"){
     translate([CubeSize/2,CubeSize/2,0]) cube([CubeSize-2*BeamWidth,CubeSize-2*BeamWidth,33],true);
     }
     if (Ornament == "YES"){
      for(i = [0 : 7])
       for(y = [0 : 7])   
       translate([BeamWidth+11.2*i,BeamWidth+11.2*y,0]) Ornament1();
       }
     } 
 }
 
 module SidePlateEmblem()
{
difference(){
     cube([CubeSize,CubeSize,BaseThickness],false);
     translate([BeamWidth,0,-15]) cube([CubeSize-2*BeamWidth,BaseThickness,33],false);
     translate([BeamWidth,CubeSize-BaseThickness,-15]) cube([CubeSize-2*BeamWidth,BaseThickness,33],false);
    
     if (Ornament == "NO"){
         if (Logo == "YES"){
            for(i = [0 : 3])
                translate([CubeSize/2,CubeSize/2,0]) rotate([0,0,i*90          ]) linear_extrude (height = BaseThickness*3, center          = true) polygon(points=[[0,0],[-CubeSize/2+          BeamWidth*2,-CubeSize/2+BeamWidth],[CubeSize/2-          BeamWidth*2,-CubeSize/2+BeamWidth],[0,0]]);
        }
        if (Logo == "NO"){
            translate([CubeSize/2,CubeSize/2,0]) cube([CubeSize-2*BeamWidth,CubeSize-2*BeamWidth,33],true);
        }
     }  
     if (Ornament == "YES"){
      for(i = [0 : 7])
       for(y = [0 : 7])   
       translate([BeamWidth+11.2*i,BeamWidth+11.2*y,0]) Ornament1();
       }
}
 
     if (Logo == "YES"){  
     color("green") translate([CubeSize/2,CubeSize/2,BaseThickness/2]) cylinder(BaseThickness,d=LogoSize,center=true);
     }
        
    
 }
 module BasePlate2()
{

  difference(){
     translate([0,0,BaseThickness/2])cube([CubeSize,CubeSize,BaseThickness],true);
     translate([0,0,0]) cube([CubeSize-2*BeamWidth,CubeSize-2*BeamWidth,33],true);    
     } 
  difference(){
  for(i = [0 : 3]){
    rotate([0,0,i*90]) translate([CubeSize/2-BeamWidth-3,CubeSize/2-BeamWidth-3,0]) roundedRect([BeamWidth*ScrewPort,BeamWidth*ScrewPort,BaseThickness],4,center=false);
  
  }
  for(i = [0 : 3]){
     rotate([0,0,i*90]) translate([CubeSize/2-BeamWidth*ScrewPort+1*ScrewDiam,CubeSize/2-BeamWidth*ScrewPort+1*ScrewDiam,0])  cylinder(33,d=ScrewDiam,center=false);
  }
 }
 }
 
// radius - radius of corners
module roundedRect(size, radius)
{
	x = size[0];
	y = size[1];
	z = size[2];

	translate([0,0,0])
	linear_extrude(height=z)
	hull()
	{
		// place 4 circles in the corners, with the given radius
		translate([(-x/2)+(radius), (-y/2)+(radius), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius), (-y/2)+(radius), 0])
		circle(r=radius);
	
		translate([(-x/2)+(radius), (y/2)-(radius), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius), (y/2)-(radius), 0])
		circle(r=radius);
	}
  }
