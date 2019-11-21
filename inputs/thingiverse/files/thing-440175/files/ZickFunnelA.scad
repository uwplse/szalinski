//copyright 2014 Richard Swika (a.k.a. Zick)
//All Rights Reserved
//Rev. Orig - August 19, 2014 - Good for bottom filling resin molds
//Rev. A - August 24, 2014 - Added an option to add an outer air escape shell		
//	Revised Terminology
//										- We now call the very top of the funnel the Mouth
// 							    	    - The taperd part in the center is the Funnel
//										- The third secion we call the Nose
//Rev.B - March 25, 2016 - Updated to work with changes to customizer
/* [Dimensions] */

//Diameter of funnel mouth? (mm)
MouthD = 20; //[10:200]

//Length of funnel mouth? (mm)
MouthL = 2; //[0:200]

//Diameter at bottom of funnel taper? (mm)
FunnelD = 7; //[5:200]

//Length of funnel taper? (mm)
FunnelL = 10; //[10:200]

//Diameter of nose? (mm)
NoseD= 4; //[5:200]

//Length of nose? (mm)
NoseL = 20; //[0:200]

//Thickness of walls? (micron)
WallT = 400; //[300:5000] 

//Thickness of air escape (0 for none)? (micron)
AirEscapeT=1000; //[0:5000]

/* [Private] */
tiny=0.05;
$fn=50;
module funnel(MouthL,MouthD,FunnelL,FunnelD,NoseL,NoseD,WallT)
{
	translate([0,0,0]) 
		difference(){
			if (WallT)
			{
				union(){
					translate([0,0,(MouthL)/2]) 
					cylinder(d=MouthD,h=MouthL+tiny,center=true);
					translate([0,0,tiny+MouthL+FunnelL/2]) 
					cylinder(d1=MouthD,d2=FunnelD,h=FunnelL+tiny,center=true);
					translate([0,0,MouthL+FunnelL+NoseL/2]) 
					cylinder(d1=FunnelD,d2=NoseD,h=NoseL+tiny,center=true);
				}
			}
		translate([0,0,-tiny])
		union(){
			translate([0,0,(MouthL)/2]) 
			cylinder(d=MouthD-WallT*0.002,h=MouthL+2*tiny,center=true);
			translate([0,0,tiny+MouthL+FunnelL/2]) 
			cylinder(d1=MouthD-WallT*0.002,d2=FunnelD-WallT*0.002,h=FunnelL+2*tiny,center=true);
			translate([0,0,MouthL+FunnelL+NoseL/2]) 
			cylinder(d1=FunnelD-WallT*0.002,d2=NoseD-WallT*0.002,h=NoseL+4*tiny,center=true);
		}
	}
}



if (AirEscapeT)
{
	union(){
		//inside funnel
		funnel(MouthL,MouthD,FunnelL,FunnelD,NoseL,NoseD,WallT);
		//outside funnel
		difference(){
			funnel(MouthL,MouthD+AirEscapeT*0.002+WallT*0.002,
				FunnelL,FunnelD+AirEscapeT*0.002+WallT*0.002,NoseL,
				NoseD+AirEscapeT*0.002+WallT*0.002,WallT);
			//cut outside funnel short by 20% of nose length to proide a path for air to escape
			translate([0,0,MouthL+FunnelL+NoseL-NoseL/10]) 
			cylinder(d1=FunnelD*2,d2=NoseD*2,h=2*tiny+NoseL/5,center=true);
		}
		//supports
		intersection(){
			//outside funnel space (zero wall thickness makes it solid)
			funnel(MouthL,MouthD+AirEscapeT*0.002+WallT*0.002,
				FunnelL,FunnelD+AirEscapeT*0.002+WallT*0.002,NoseL,
				NoseD+AirEscapeT*0.002+WallT*0.002,0);
			difference(){
				translate([0,0,-NoseL/10+(MouthL+FunnelL+NoseL)/2]) 
				union(){
					cube([WallT/1000,MouthD*2,MouthL+FunnelL+NoseL-NoseL/5-2*tiny],center=true);
					cube([MouthD*2,WallT/1000,MouthL+FunnelL+NoseL-NoseL/5-2*tiny],center=true);
				}
				//subtract inside funnel space (less tiny)
				funnel(MouthL,MouthD-tiny,
					FunnelL,FunnelD-2*tiny,NoseL,
					NoseD-tiny,0);
			}
		}
	}
}
else
{
	funnel(MouthL,MouthD,FunnelL,FunnelD,NoseL,NoseD,WallT);
}

