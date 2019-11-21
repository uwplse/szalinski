// Units are in mm.
// Distance from end of connector unit to vertex is equal to the Length plus the Fillet value. this may be useful in the future when chords of different lengths are used on alternative polyhedra and exact lengths of chords from vertex to vertex is needed
// Future: include gap tolerance in calculations? right now there is a variable that can be adjusted, but it is not used in the calculations
// Add antiprism module
// Add adjustment for angled prisms and antiprisms
// Add add regular pyramid
// Future: add limiter for Fillet adjustment
// Completed 1/31/18: add ability to adjust cutouts 
// Completed 2/1/18: add option for rhombic Triacontahedron: vertex angle for the vertex with 5 elements = 2*atan(1/phi)~63.43 degrees. vertex angle for vertex with 3 elements = asin((2*phi*sqrt(3))/(3*sqrt(1+phi^2)) ~ 79.19 degrees. calculations confirmed
// completed 2/2/18 added Regular Prism PolyType. adjust ngonbase number to choose shape of base

//Type of Polyhedron
PolyType="Regular Prism";//[Tetrahedron,Cube,Octahedron,Dodecahedron,Icosahedron,Rhombic Triacontahedron, Regular Prism, Uniform Antiprism]

//Number of members at vertex
VertNumb=3;//[3:6]

//Shape of base - 3=triangle, 4=square, 5 = pentagon, ... (only used for Pyramids,Prisms and Antiprisms_
ngonBase=6;

//Height of polyhedron (only needed/used for Pyramids and non-uniform prisms and Antiprisms) - Height must be > (2*Length) of connector, >3*Length recommended
Height=100;


//connector length
Length=25;

//connector internal diameter (7mm good diameter for 1/4" dowel)
InternalDiameter=8.3;

//connector external diameter
ExternalDiameter=11;

//Hole Depth (must be less than Length - 0.8 * Length a good starting point)
HoleDepth=16;

//fillet on connector unit (fillet must be less than 0.5*ExternalDiameter. Start with 2 and adjust from there)
fillet=2;

//Length of expansion slot - this is a spacing in the connector to allow flex when connector is inserted (This should be less than the HoleDepth
SlotLength=12;

//Width of expansion slot - enter a value of 0 if no expansion slot desired (this should be less than the InternalDiameter)
SlotWidth=2;

//Outer Shape of connector modules (3 = 3 sided, 4 = 4 sided, ... 100 =~ circle)
ConnectorShape=12;

//Inner Shape of connector modules (3 = 3 sided, 4 = 4 sided, ... 100 =~ circle)
InnerConnectorShape=6;

//Radius of the connector base
BaseRadius=8;

//Connector base height adjustment for flat prints (start at 0, if pivot angle is high, adjust lower using negative numbers)
BaseElevation=0;

//tolerance - not incorporated into calculations yet
GapTolerance=.25;//assumes exporting STL in mm. (if exporting in inches, start with 0.01)
/////////CONSTANTS/Calculated Values////////////////////////////////////
phi=(1+sqrt(5))/2;
Circumradius=1/(2*sin(180/ngonBase));//assumes edge length = 1
Inradius = Circumradius*cos(180/ngonBase);//assumes edge length = 1
echo(phi);
echo(Circumradius);
echo(Inradius);

/////////REGULAR POLYHEDRA//////////////////////////////////////////////
//color([1,0,0,])rotate(a=-90,v=[0,0,1])rotate(a=54.74,v=[0,1,0])cylinder(r=.5, h=Length+fillet, $fn=ConnectorShape);
if (SlotLength>HoleDepth){error2();}else{
if (SlotWidth>InternalDiameter){error3();}else{ 
if (fillet>0.5*ExternalDiameter){error4();}else{

if(PolyType=="Tetrahedron"){
    if(VertNumb!=3){error1();}else{
    pivotAngle = asin(1/(2*cos(30)));//angle individual connectors pivot off central axis(unique to polyhedron type and vertex number (~35.26 degrees for tetrahedron)
    Connector(vNum=3,p=pivotAngle);}
}

if(PolyType=="Cube"){
    if(VertNumb!=3){error1();}else{
    pivotAngle = asin(1/(sqrt(2)*cos(30)));//angle individual connectors pivot off central axis(unique to polyhedron type and vertex number (~54.74 degrees for cube)
    Connector(vNum=3,p=pivotAngle);}
}
    
if(PolyType=="Octahedron"){
    if(VertNumb!=4){error1();}else{
    pivotAngle = asin(sqrt(2)/2);//angle individual connectors pivot off central axis(unique to polyhedron type and vertex number (45 degrees for Octahedron)
    Connector(vNum=4,p=pivotAngle);}
}

if(PolyType=="Dodecahedron"){
    if(VertNumb!=3){error1();}else{
    pivotAngle = asin(((2*sqrt(3))/3)*cos(36));//angle individual connectors pivot off central axis(unique to polyhedron type and vertex number (69.09 degrees for Dodecahedron)
    Connector(vNum=3,p=pivotAngle);}
}

if(PolyType=="Icosahedron"){
    if(VertNumb!=5){error1();}else{
    pivotAngle = asin(1/(2*cos(54)));//angle individual connectors pivot off central axis(unique to polyhedron type and vertex number (58.28 degrees for Icosahedron)
    Connector(vNum=5,p=pivotAngle);}
}

//////////REGULAR PRISMS/////////////////////////////////////////

if(PolyType=="Regular Prism"){
    if(VertNumb<3){error1();}else{
        baseAngle=180-360/ngonBase;
        PrismConnector(b=baseAngle);}
    }

if(PolyType=="Regular Antiprism"){
    if(VertNumb<4){error1();}else{
    if(Height<2*Length||Height>20*Length){error5();}else{
        baseAngle=180-360/ngonBase;
        AntiprismConnector(h=height, b=baseAngle);}
    }
}

//////////OTHER POLYHEDRA/////////////////////////////////////////
if(PolyType=="Rhombic Triacontahedron"){
    if(VertNumb!=5&&VertNumb!=3){error1();}else{
        if(VertNumb==5){pivotAngle = 2*atan(2/(1+sqrt(5)));//angle individual connectors pivot off central axis(unique to polyhedron type and vertex number (63.43 degrees for 5-point vertex of Rhombic Triacontahedron)
            Connector(vNum=5,p=pivotAngle);}
        if(VertNumb==3){pivotAngle=asin((2*phi*sqrt(3))/(3*sqrt(2+phi))); //angle individual connectors pivot off central axis(unique to polyhedron type and vertex number (79.19 degrees for 3-point vertex of Rhombic Triacontahedron)
             Connector(vNum=3,p=pivotAngle);
        }
    }   
}}}}
///////////MODULES////////////////////////////////////////////////////////////////////////
module Connector(vNum,p){
    difference(){
      union(){  
          for(i=[0:vNum-1]){
              rotateAngle= (360/vNum)*i;
              j=sign(cos(rotateAngle));                  //makes j negative between 90-270 degrees
              k=sign(sin(rotateAngle));                  //makes k +1.0 @ 90deg & -1.0 @ 270deg
              if (rotateAngle==90||rotateAngle==270)
                  {rotate(a=p,v=[0,k,0]){rotate(v=[0,0,1],a=rotateAngle){ConnectorUnit();}}}
                  else 
                      {rotate(a=p,v=[j,j*tan((360/vNum)*i),0]){rotate(v=[0,0,1],a=rotateAngle){ConnectorUnit();}}}
          }
          translate(0,0,BaseElevation){sphere(r=BaseRadius, $fn=100);}
      }
      translate([0,0,-BaseRadius/2+BaseElevation]){cylinder(center=true, r=BaseRadius+1,h=BaseRadius, $fn= ConnectorShape);}//This cuts off the base so it is flat for better printing
      }
}

module PrismConnector(b){
    difference(){
      union(){  
              ConnectorUnit();
              rotate(a=b,v=[0,1,0]){ConnectorUnit();}
              rotate(a=180+b/2,v=[0,1,0]){rotate(a=-90,v=[1,0,0]){ConnectorUnit();}}
              translate(0,0,BaseElevation){sphere(r=BaseRadius, $fn=100);}//this is the central sphere, meant to help hold entire connector together
      }
     rotate(a=-90,v=[1,0,0]){translate([0,0,-BaseRadius/2-ExternalDiameter/2]){cylinder(center=true, r=BaseRadius+1,h=BaseRadius, $fn= ConnectorShape);}}
      //this cuts off the base of middle sphere so it is flat for better printing
      }
}

module AntiprismConnector(h,b){
    difference(){
      union(){  
              ConnectorUnit();
              rotate(a=b,v=[0,1,0]){ConnectorUnit();}
              rotate(a=45,v=[1,0,-tan(90-180/ngonBase)])//this points a vector exactly between the 2 needed. Height not factored in yet.
              {rotate(a=180+b/2,v=[0,1,0]){rotate(a=-90,v=[1,0,0]){ConnectorUnit();}}}
              translate(0,0,BaseElevation){sphere(r=BaseRadius, $fn=100);}//this is the central sphere, meant to help hold entire connector together
      }
     rotate(a=-90,v=[1,0,0]){translate([0,0,-BaseRadius/2-ExternalDiameter/2]){cylinder(center=true, r=BaseRadius+1,h=BaseRadius, $fn= ConnectorShape);}}
      //this cuts off the base of middle sphere so it is flat for better printing
      }
}

module ConnectorUnit(){
    $fn=50;
    
difference(){
    minkowski(){
        cylinder(r=ExternalDiameter/2-fillet, h=Length, $fn=ConnectorShape);
        sphere(r=fillet);
    }
       translate([0,0,Length-HoleDepth]){cylinder(r=InternalDiameter/2, h = HoleDepth+20, $fn=InnerConnectorShape);}
       translate([SlotWidth/2,0,Length-SlotLength]){rotate(v=[0,0,1], a=90){cube([ExternalDiameter,SlotWidth,HoleDepth+10]);   } }
    }
}

module Base(){
    translate([-ExternalDiameter/2,-ExternalDiameter/2,-ExternalDiameter/2]){cube(ExternalDiameter,ExternalDiameter,ExternalDiameter);}
 }
 
module error1(){
     text("Error, Vertex number not", size=2);
     translate([0,-5,0]){text("correct for this polyhedron", size=2);}
     }  
 
module error2(){
     text("Error, SlotLength needs to be", size=2);
     translate([0,-5,0]){text("less than HoleDepth", size=2);}
     } 
     
module error3(){
     text("Error, SlotWidth needs to be", size=2);
     translate([0,-5,0]){text("less than InternalDiameter", size=2);}
     } 
 
module error4(){
     text("Error, Fillet needs to be", size=2);
     translate([0,-5,0]){text("less than 0.5*ExteriorDiameter", size=2);}
     }     
     
module error5(){
     text("Error, Height needs to be", size=2);
     translate([0,-5,0]){text("larger or smaller to work", size=2);}
     }     