//copyright 2014 Richard Swika (a.k.a. Zick)
//All Rights Reserved
//Rev. Orig - Augest 19, 2014 - Good for bottom filling resin molds
//Rev. A - March 25, 2016 - Updated to work with changes to customizer
/* [Dimensions] */

//Diameter of funnel mouth? (mm)
funnelTopD = 40; //[10:200]

//Length of funnel mouth? (mm)
funnelTopL = 2; //[0:200]

//Diameter at bottom of funnel taper? (mm)
funnelBottomD = 10; //[5:200]

//Length of funnel taper? (mm)
funnelL = 20; //[10:200]

//Diameter of egress? (mm)
egressD= 5; //[5:200]

//Length of egress? (mm)
egressL = 10; //[0:200]

//Thickness of walls? (micron)
wallT = 400; //[300:5000] 

/* [Private] */
tiny=0.05;
$fn=50;
module funnel()
{
	translate([0,0,0]) 
		difference(){
		union(){
			translate([0,0,(funnelTopL)/2]) 
			cylinder(d=funnelTopD,h=funnelTopL+tiny,center=true);
			translate([0,0,tiny+funnelTopL+funnelL/2]) 
			cylinder(d1=funnelTopD,d2=funnelBottomD,h=funnelL+tiny,center=true);
			translate([0,0,funnelTopL+funnelL+egressL/2]) 
			cylinder(d1=funnelBottomD,d2=egressD,h=egressL+tiny,center=true);
		}
		translate([0,0,-tiny])
		union(){
			translate([0,0,(funnelTopL)/2]) 
			cylinder(d=funnelTopD-wallT*0.003,h=funnelTopL+2*tiny,center=true);
			translate([0,0,tiny+funnelTopL+funnelL/2]) 
			cylinder(d1=funnelTopD-wallT*0.003,d2=funnelBottomD-wallT*0.003,h=funnelL+2*tiny,center=true);
			translate([0,0,funnelTopL+funnelL+egressL/2]) 
			cylinder(d1=funnelBottomD-wallT*0.003,d2=egressD-wallT*0.003,h=egressL+4*tiny,center=true);
		}

	}
}

rotate([0,0,0]) funnel();