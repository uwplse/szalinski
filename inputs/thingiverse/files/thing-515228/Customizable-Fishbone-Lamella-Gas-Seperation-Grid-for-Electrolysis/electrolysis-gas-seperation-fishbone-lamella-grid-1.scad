
// date: 2014
// author: Lukas Süss aka mechadense
// license: CC BY
// title: customizable fishbone lamella gas seperation grid for electrolysis

/*

This is a halve grid for gas separation in an electrolysis apparatus.  
When two (mirrored versions) of these are put together back on back the lamellas form herringbone shapes. This disallows the gasses to pass from one side to the other and mix.  
In a concrete application a gas separation wall must be extended upwards and the fluid level must be always kept above the grid.  

Standalone this thing is incomplete. An electrolysis chamber capable of gas separation is needed in conjunction. It might be a good idea to design the gas splitter top as one piece print with mainly diagonal surfaces to archive maximum gas tightness.  

pros & cons:  
+ no separation membranes (filterpaper / 0.1mm mesh fine lye resistant textiles) needed   
+ if separation membranes are used nonetheless they are mechanically stabilized by the grid  
- more distance between the plates (resistive losses) more electrolyte needed  
- less water cross section between plates  

Some data randomly found on the net (no guarantee of correctness):  
* 1.5mm to (2.0mm) for bubble-flow needed  
* keep current below 85mA/cm^2 of plate area  
* try to archive 2V voltage drop per plate  
* => six plates in series are useful:  
connect only the outermost two for 12V operation and  
connect only the second from outermost for for 9V operation 
 
One side can be made to have no slide-in border so that one can look in when a transparent window is glued onto the chamber.

*/



/* [main] */

// grid width without slidein rim
w = 40;
// grid height without slidein rim
h = 40;

angle = 45; // 0° no arrow shape
// halve fishbone lamella thickness

part = "symmetrical"; //[left,right,symmetrical]


/* [halve herringbone] */

// halve herringbone thickness
s2 = 2;
sft = s2/tan(angle);

// rib thickness
trib = 1;
// gap size between ribs
tgap = 0.75;

t1 = trib/sin(angle);
t2 = tgap/sin(angle);

// number of lamellas
n = floor(h/(t1+t2))-1; // -1 ... good working hack
heff = (n-1)*(t1+t2)+sft;



/* [connector spacer bars] */

// thickness of connector bars
tconn = 1;
// distance between connector bars
aconn = 10;
// space for gas bubbles to rise up
tbubble = 1.5;
// offset for the first connector bar
shiftconn = 4.5;
nconn = floor(h/aconn);


/* [slidein rim] */

// thickness of slidein rim - countergrooves must be more than double that wide (herringbonehalve - optional filterpaper - herringbonehavle)
tslidein = 1;
// depth of slidein rim - how far it goes in
sslidein = 1;


eps = 0.05*1;



// ###############

// size estimation cube
//translate([0,0,20])cube([10,10,10]);

part();

module part()
{
  if(part=="left") {translate([-w/2,0,0]) halvegrid("no");}
  if(part=="right") {translate([+w/2,0,0]) scale([-1,1,1]) halvegrid("no");}
  if(part=="symmetrical") {translate([-w/2,0,0]) halvegrid("yes");}

}

//



module halvegrid(slidein="yes")
{

for(i=[0:n-1])
{
  translate([0,i*(t1+t2),0])
  scale([1,1,-1])rotate(+90,[0,1,0])
  linear_extrude(height=w)
  polygon(points=[[0,0],[0,t1],[s2,t1+sft],[s2,sft]], paths=[[0,1,2,3]]);
}

for(i=[0:nconn-1])
{
  translate([aconn*i+shiftconn,0,0])
  cube([tconn,h,s2+tbubble]);
}

//bottom end
cube([w,t1,s2+tbubble]);
// top end
translate([0,heff,-0.1*0])
cube([w,t1,s2]);

difference()
{
  // sicrumdference slidein ring
  if(slidein=="no")
  {
    translate([-sslidein,-sslidein,0])
      color("orange") cube([w+sslidein-eps,h+sslidein*2,tslidein]);
  }
  else
  {
    translate([-sslidein,-sslidein,0])
      color("orange") cube([w+sslidein*2,h+sslidein*2,tslidein]);
  }

  translate([eps,eps,-1])
    cube([w,heff,tslidein+3]);
}
}
