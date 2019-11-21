/* [Funnel] */

fine = 60; // [20:100]
show_Hanger = "yes"; // [yes,no]
show_Gab = "yes"; // [yes,no]
WallThickness = 1; // [1:3]

// Which one would you like to see?




HighFunnel =50; // [30:150]
DiameterTop = 100; // [40:150]



DiameterPipe = 10; // [6:20]
HighPipe =50; // [30:80]
BeveledTip = "yes"; // [yes,no]

// ignore variable values

/* [Hidden] */
Spitze = 45;

$fn = fine;
Hoehe = (HighPipe + HighFunnel) / 2;
Ghoehe = (HighPipe + HighFunnel);
ra2 = DiameterPipe/2;

schr=ra2*5;

ra1 = DiameterTop;
Wand = WallThickness;

Hy = (ra2*2)/cos(Spitze);
LuftW = 110 - atan((ra1/2)/HighFunnel);
echo (LuftW);

difference()
{
union() {
//Trichter    
    translate([0,0,HighFunnel/2])
    cylinder(r1=ra1/2,r2=ra2,h=HighFunnel, center = true);

//Lasche
if (show_Hanger=="yes"){    
    translate([0,ra1/2,Wand/2])
    cube(size = [ra1/10,ra1/5,Wand], center = true);    
    translate([0,ra1/2+ra1/10,Wand/2])
    cylinder(r=ra1/20,h=Wand, center = true); 
} 

//Rohr 

    translate([0,0,Ghoehe-(HighPipe/2)])
    cylinder(r=ra2,h=HighPipe, center = true);  
  
//Gab
if (show_Gab=="yes"){ 
    translate([ra2,0,HighFunnel])
    rotate(a=[0,LuftW,0])
    cube(size = [Hoehe/(1/ra2/.1),Wand,ra2], center = true);

    translate([0,ra2,HighFunnel])
    rotate(a=[0,LuftW,90])
    cube(size = [Hoehe/(1/ra2/.1),Wand,ra2], center = true);
  
    translate([-ra2,0,HighFunnel])
    rotate(a=[0,LuftW,180])
    cube(size = [Hoehe/(1/ra2/.1),Wand,ra2], center = true);
  
    translate([0,-ra2,HighFunnel])
    rotate(a=[0,LuftW,270])
    cube(size = [Hoehe/(1/ra2/.1),Wand,ra2], center = true);  
} 
}

//Loch Trichter
    translate([0,0,HighFunnel/2])
    cylinder(r1=ra1/2-Wand,r2=ra2-Wand,h=HighFunnel, center = true);
// Loch Rohr
    translate([0,0,Ghoehe-(HighPipe/2)])
    cylinder(r=ra2-Wand,h=Hoehe, center = true);

// Loch in der Lasche
if (show_Hanger=="yes"){
    translate([0,ra1/2+ra1/10,Wand/2])
    cylinder(r=ra1/40,h=Wand, center = true);
}

//Spitze
if (BeveledTip=="yes"){
    
    translate([ra2*1,0,(HighPipe + HighFunnel)])
    rotate(a=[0,Spitze,0])
    cube(size = [Hy*1.0,ra2*2,Hy*1.0], center = true);
}
}
