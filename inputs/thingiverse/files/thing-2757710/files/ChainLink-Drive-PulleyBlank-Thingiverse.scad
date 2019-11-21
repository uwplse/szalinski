//ChainLink_Drive_PulleyBlank-Thingiverse.scad
//This is a parametric model of a chain drive pulley.
//The chain type is any link style chain rather than
//proper chain-drive chain.
//The size of the links and the number of link pairs
// around the drum determine its size.

//By Hamish Trolove - www.techmonkeybusiness.com
//Written in 2018
//Licensed under a Creative Commons license - attribution
// share alike. CC-BY-SA

//This version is only the pulley drum to allow you to
//easily modify it with other vertex modelling tools
//to fit whatever you wish.
//There is another version available which includes the
//pulley attachment to the shaft.

//No extra libraries are required and it works under 
//      OpenSCAD 2014 and OpenSCAD 2015.


//Basic Dimensions

//Link length - outside dimension
LLength = 4; 

//Link width - outside dimension
LWidth = 2.9; 

//Link wire thickness
Lthickness = 0.65; 

//Printing Tolerance
PTol = 0.15; 

//Printing Allowance for the "radially" orientated link thickness
PTolThk = 0.2; 

//A factor for creating a clear bar on either side of the link
WClr = 2;  
            
//Chain cylinder resolution (fast but rough = 8)       
Rez = 8; 

//Resolution of the axle hole
AxleRez = 16; 

//The number of chain link pairs around the pulley.  Please note this is pairs of links not the number of single links.
N = 12; 

//Width of the Pulley Main Drum
PWidth = 4.5; 

//axle diameter
AxleD = 3; 


//Derived Dimensions
LStraight = LLength - LWidth; //length of straight
                //section between link's rounded ends.
LAngle = 180/N; //Angle between links

A = LWidth/2 - Lthickness;
B = A * cos(LAngle);

Leff = LStraight + 2*B; //The effective length to
                //account for overlap of the links 
PCD = 2 * N * Leff/PI;
//echo("Factor A = ",A, "factor B = ",B);
//echo("Angle between links = ",LAngle,"Pitch Circle Diameter = ",PCD,"Effective length = ", Leff);
//echo("Length of Chain straight section = ",LStraight);

//Pulley body
difference()
{
    cylinder(h=PWidth,r=PCD/2+Lthickness, center = true);

 
    //The Axle
    cylinder(h=PWidth*10,r=AxleD/2, center = true,$fn=AxleRez);
    
    //Chain link Recess Calculations
    for (ang = [0:LAngle*2:360-LAngle*2])
    {
        rotate([0,0,ang])
        {
    
    //Creating the Tangential Link Outline
            translate([0,PCD/2,0])
            {
                rotate([-90,0,0])
                {
                    translate([-LStraight/2,0,0])cylinder(h=Lthickness,r=LWidth/2+PTol,center=true,$fn=Rez);
                    translate([-LStraight/2,0,Lthickness-PTol/2])cylinder(h=Lthickness,r1=LWidth/2+PTol,r2= 1.4*LWidth/2 ,center=true,$fn=Rez); 
                    cube(size=[LStraight,LWidth+PTol*2+WClr*2,Lthickness],center = true);
                    translate([0,0,Lthickness-PTol/2])cube(size = [LStraight,LWidth+PTol*2+WClr*2,Lthickness],center = true);
                    translate([LStraight/2,0,Lthickness-PTol/2])cylinder(h=Lthickness,r1=LWidth/2+PTol,r2= 1.4*LWidth/2 ,center=true,$fn=Rez);
                    translate([LStraight/2,0,0])cylinder(h=Lthickness,r= LWidth/2+PTol,center=true,$fn=Rez);
                 
                }
            }
        }
    }
    
    
    //Radial Link orientation
    for (ang = [LAngle:LAngle*2:360-LAngle])
    {
        rotate([0,0,ang])
        {
    
            translate([0,PCD/2,0])
            {
            
                translate([-LStraight/2,0,0])cylinder(h=Lthickness+PTolThk,r=LWidth/2+PTol,center=true,$fn=Rez);
                cube(size=[LStraight,LWidth+PTol*2,Lthickness+PTolThk],center = true);
                translate([LStraight/2,0,0])cylinder(h=Lthickness+PTolThk,r=LWidth/2+PTol,center=true,$fn=Rez);

            }
        }
    }

}