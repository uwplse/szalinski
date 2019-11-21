//Toon Light Switch Plate by thistof 2017
//made customizable by cpwallen
//this version is for a rectangular switch cover (original was trapezoidal)


//----variable definitions----

//height of switch cover (long axis)
height= 134;

//width of cover
width= 90;

//thickness of cover 
thickness= 5; //[3,0.5,7]

//smoothness of curves
$fn=32;

//height of switch 
Hswitch= 24.5; //[20,0.5,30]

//width of switch
Wswitch= 10; //[8,0.2,12]

//screw distance from center of switch hole
screwDist=25; //[25,1,35]

//screw head diameter
DscrewHead=8;

//diameter of threaded part of screw
Dscrew=3.5;

//length of threaded part of screw
Lscrew=4;

//screw head height
headHeight=3.6; //[3,0.2,5]

//wiggle room (tolerance for switch hole)
w=0.25; 

// ----calculations----

//radius of curvature of corners
rcorner=thickness;

//----assembly of design----

difference(){
hull(){
        translate([width/2-rcorner,height/2-rcorner]) sphere(rcorner,center=true);
        translate([width/2-rcorner,-(height/2-rcorner)]) sphere(rcorner,center=true);
        translate([-(width/2-rcorner),height/2-rcorner]) sphere(rcorner,center=true);
        translate([-(width/2-rcorner),-(height/2-rcorner)]) sphere(rcorner,center=true);
    }
    
translate([0,0,-thickness]) cube([width,height,2*thickness],center=true);
    cube([(Wswitch)+2*w,(Hswitch)+2*w,(thickness*2)+2*w],center=true);
    translate([0,screwDist,0]) screw();
    translate([0,-screwDist,0]) screw();
}
module screw(){
    translate([0,0,0]) cylinder(d=Dscrew,h=Lscrew,center=true);
    translate([0,0,headHeight/2]) cylinder(d1=Dscrew,d2=DscrewHead,h=Lscrew);
}    
