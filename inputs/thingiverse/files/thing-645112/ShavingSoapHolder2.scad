//Holder for Shaving Soap from http://www.mermaidbay.co.nz/
// Soap block is a frustrum

//A holder is needed to stop the damn family from using it to wash hands etc

/* [Global] */

// Which parts would you like to see?
part = "All"; // [Sleeve:Main Sleeve part only  ,Ring:Base Retention Ring only,All:All Parts]

// Show the parts Mated together?
PartsMated = "Separated"; //[Mated, Separated]

/* [Soap Block] */
//Thickness of Soap
SoapT=27; 
//Diameter of Soap at base (max diameter)
SoapDBase=75;
//Diameter of Soap at top (diameter of a frustrum ignoring the edge bevels)
SoapDTop=69;
//

/* [Other Dimensions] */
//Flare radius of Upper cup more than D2;
FlareR=8;
//Height of lower retaining cone part
T=12;
//Height of upper rim
T2=SoapT+10 -T; 

SoapD2=SoapDBase - ( (SoapDBase-SoapDTop)*(T/SoapT)); //was 72 @ 12
echo(str("BaseD=",SoapDBase, " TopD= ",SoapDTop,"  SoapD2 =",SoapD2 , " at height T=",T));

// Height of the base part
RingH=7;
//gap between ring and sleeve
RingGap=0.3; 

// Top Rim / Lip is a toroidal section. Increase Thickness by XX% of the wall thickness
RimScale=0; 
// Wall thickness at the top lip
wallt=1.5;
//wall thickness at the bottom
wallt2=2.4;

//number of bumps and ribs in the base
NStep=7;

RimX=wallt*RimScale/200;

/* [Hidden] */
IR1=SoapDBase/2; //diameter of cake of soap at base
IR2=SoapD2/2; //diameter of soap at T above base (was 71)
IR3=IR2+FlareR;


OR1=IR1+wallt2;
OR2=IR2+wallt;
OR3=IR3+wallt;

BumpR=4/2;

use <MCAD/regular_shapes.scad>

module Ring(r,h) {
	difference() {
		cylinder(r=r, h=h);
		translate([0,0,-0.1]) cylinder(r1=r-wallt, r2=r-wallt2, h=h+0.2);
	}//diff
}//mod

module Bumps( dR=0) {
    
    translate([0,0,RingH/2])
	for (A=[0:NStep-1]) {
			rotate([0,0,(A+0.5)*(360/NStep)]) translate([IR1,-wallt/2,0]) 	sphere(r=BumpR+dR,$fn=20);
		}//for
}//mod bumps

module Base() { //base to slip inside
    color("red") 
    difference() {
        union() {
  	 translate([0,0,0]) {
		for (dR=[RingGap,10,20]) Ring(r=IR1-dR, h=RingH); //rings
                    

		for (A=[0:NStep-1]) { //radials
			rotate([0,0,(A+0.5)*(360/NStep)]) 
                            translate([-IR1+0.5,-wallt/2,0]) 	
                                cube([20+1,wallt,RingH]);
		}//for
	}//trans
        intersection() {
            Bumps(2);
            cylinder(r=IR1-RingGap, h=RingH);
        }//intersect
        }//union
        
      Bumps(0.4);  
    }//diff
}//mod base
//-------------


if (part=="Sleeve" || part=="All") { 
    //$fn=70;
	difference() {
		union() {
			cylinder(r1=OR1, r2=OR2, h=T); //main retaining cone
			translate([0,0,T]) cylinder(r1=OR2, r2=OR3,h=T2); //upper flare cup
                        color("yellow") translate([0,0,T+T2]) torus(OR3+RimX, innerRadius=IR3-RimX,$fn=50); //round rim/lip on top
                        color("red") translate([0,0,-RingH]) cylinder(r=OR1, h=RingH); //lower ring sleeve
		}//union
		translate([0,0,-0.01]) cylinder(r1=IR1, r2=IR2, h=T+0.2, $fn=30); //
		translate([0,0,T-0.01]) cylinder(r1=IR2, r2=IR3,h=T2+0.2);
                translate([0,0,-RingH-0.01]) cylinder(r1=IR1, r2=IR1,h=RingH+0.2,$fn=30);
	}//diff

        translate([0,0, -RingH]) Bumps(); //positive bumps
    }//if
    
$fn=50;
dXY= (PartsMated=="Mated") ? 0: IR1*2.5;
if (part=="Ring" || part=="All") 
    color("orange") 
        translate([dXY, 0, -RingH])  
            Base();
//soap
if (part=="All") color("white") 
    translate([dXY/2,dXY]) 
        difference() {
            cylinder(r1=SoapDBase/2, r2=SoapDTop/2, h=SoapT);
            rotate([0,0,-60]) 
                translate([0,0,-0.01])cube([SoapDBase,SoapDBase,SoapT+0.02]);
        }//diff