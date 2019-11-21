//*************************************************************
//
// Commented values represent close to original Catalac hinge dimensions
//
$fn=76; // hole resolution

hingeType="T";  // "N" =normal hinge, "T" = T style hinge

mink = 2;   //minkowski smoothing value
base = 32 ;
tBase=25;   // 25, T width
tLength = 110;   // 110, T  length

height = 80;    // 80, normal style height of single section
thickness = 3-mink;  // 3.2, hinge thickness, make sure pin clears the body
hingeCylDiameter = 9.8; // 9.85, OD of hinge cylinder
screwDiameter = 5.4;  // 5.4, screw hole diameter

//x plane is the axial direction, y plane is the radial direction
xClearance = 1;     //0.05 clearance in axial plane
yClearance = 2;    //(no real Catalac equivilent) clearance in radial plane
slots = 1;    // number of slots on larger hinge.(t style = 0, normal style no real equivilent)
slotSize = (base - mink)/(slots)/2;

// Normal style holes are referenced from center of pin
// x plane is centered for all holes
triy1 = 20.5;
triy2 = 48;
triy3 = 75;

//T sytle hinge holes are referenced from center of pin
squy = 17; //distance from pin on y axis of all holes
//first hole aligns with center of pin in axial direction
squx= 89/2; // center to center outside holes/2

pinDiameter = 4.6; //metal pin diameter
pinClearance = .1;  // inside hinge clearance. Outside hinge is exact fit to holf pin in place

// non Catalac specific hinge settings
hingeCylOffset = 3;   //for Tstyle, make sure the pin is able to be installed

cubeSize = tLength*2;   // used to clean up bottom of hinge from the minkowski function
webbingHeight = hingeCylDiameter;
//***********************************************************



//***********************************************************

MakeHinge(style=hingeType);

//***********************************************************


//################################### Modules start here ###############################
module ScrewHole(x,y)
{
 translate([x,y,0])
 cylinder( r=screwDiameter/2, h=thickness*10, center=true); //hole
 
 //countersink
 translate([x,y,(thickness+mink)/4+(thickness+mink)/2])
 cylinder( r2=screwDiameter, r1=screwDiameter/2, h=(thickness+mink)/2, center = true);
    
  //countersink extension in case webbing is over hole
 translate([x,y,(thickness+mink)-.01])
 cylinder(  r=screwDiameter, h=20, center = false); 
}


module triangle()
{
  translate([-(base - mink)/2,0,0])
    
  linear_extrude(thickness)
  polygon(points=[[0,0],
         [(base - mink)*.15,height],
         [(base - mink)*.8,height],
         [(base - mink),0]],
         paths=[[0,1,2,3]]);
 
}


module Webbing()
{
    
  translate([(base - mink)/2-.001,-hingeCylOffset,0])
  rotate([0,-90,0])
  linear_extrude((base - mink)-.01)
  polygon(points=[[0,0],
         [webbingHeight,0],
         [thickness+mink,hingeCylOffset*2+squy-hingeCylOffset-screwDiameter],
         [0,hingeCylOffset*2+squy-hingeCylOffset-screwDiameter] ],
         paths=[[0,1,2,3]]);
}


module RoundedTriangle()
{
    translate([0,0,0])
    {
      difference()
      {
          union()
          {
           minkowski(){
                      triangle();
                      sphere(r=mink);
                      }
           Webbing();
          }
           translate([0,0,-(thickness+mink)/2])
           cube([cubeSize,cubeSize,thickness+mink],center=true);

        ScrewHole(0,triy1-hingeCylOffset);
        ScrewHole(0,triy2-hingeCylOffset);
        ScrewHole(0,triy3-hingeCylOffset);

       }
    }
}


module RoundedRectangle()
{
     difference()
      {
        translate([0,0,0])
          union()
          {
           minkowski(){
                      translate([0,(base - mink)/2,(thickness)/2])
                      cube([tLength,tBase,thickness], center=true);
                      sphere(r=mink);
                      }
            Webbing();
          }      
        translate([0,0,-(thickness + mink)/2])
         cube([cubeSize,cubeSize,thickness+mink],center=true);
                      
        ScrewHole(0,      squy-hingeCylOffset);
        ScrewHole( - squx, squy-hingeCylOffset);
        ScrewHole(squx,  squy-hingeCylOffset);
       }
}







module Slots(style="A",yclearance=0, xclearance=0)
{
    cy=yclearance/2;
    cx=xclearance/2;
    translate([-(slotSize*(slots)),0,0])
    translate([slotSize/4,-hingeCylOffset,0])

    for(a=[1:slots])  //slots
    {
     for(n=[0:2])
       {
        translate([(a-1)*(slotSize+slotSize),0,hingeCylDiameter/2])
          {
             if(n==0 && style=="A") translate([0,0,0]) rotate([0,90,0])
                  cylinder(r=hingeCylDiameter/2+cy, h= slotSize/2-cx+.01, center=true);
             
             if(n==1 && style=="B") translate([slotSize/2+slotSize/4,0,0]) rotate([0,90,0])
                 cylinder(r=hingeCylDiameter/2+cy, h= slotSize-cx, center=true);
             
             if(n==2 && style=="A") translate([slotSize+slotSize/2,0,0]) rotate([0,90,0])
                 cylinder(r=hingeCylDiameter/2+cy, h= slotSize/2-cx, center=true);
          }  
       }
    }
}
 
module pinhole(diameter=pinDiameter)
{
    d=diameter;
    translate([-mink,-hingeCylOffset,hingeCylDiameter/2])
    rotate([0,90,0])
    cylinder(r=d/2, h=base + mink*5, center=true);
}




module HingeTop()
{
  
  translate([0,(hingeCylOffset),0])
  {
      difference()
      {
        union()
        {
            difference()
            {
                RoundedTriangle();
                union()
                {
                    Slots(style="A",yclearance = yClearance, xclearance = -xClearance);
                }
            }
         Slots(style="B", yclearance = 0, xclearance=xClearance);
        }
        pinhole(diameter=pinDiameter+pinClearance*2);
      }
  }
}





module MakeHinge(style="T")
{
 HingeTop();
  
 translate([0,-hingeCylOffset-hingeCylDiameter-1,0]) rotate([0,0,180])
 {

  difference()
  {
   union()
    {
     if(style=="N")
     difference(){
         RoundedTriangle();
         Slots(style="B",yclearance = yClearance, xclearance=0);
         }
     else
         difference(){
         RoundedRectangle();
         Slots(style="B",yclearance = yClearance, xclearance=0);
         }
 
    
      Slots(style="A",yclearance = 0, xclearance=0);
    }
      pinhole(diameter=pinDiameter);
  }
 }
}
    
//#################################### END OF MODLES ####################################



