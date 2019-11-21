//Shredder Blade v1.1 (v1.0 had 69 downloads on Thingiverse)
//Ari M Diacou - July 2014
//Published at: http://www.thingiverse.com/thing:383635
//Shared under Creative Commons License: Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) 
//see http://creativecommons.org/licenses/by-sa/3.0/

///////////////////// Parameters ///////////////////////////////////
//Diameter of the gear that the tooth extends from
diameter=10; 
//Perpendicular distance from the gear surface to the tooth tip
tooth_height=1.5; 
//Measure corner to corner of your axel/nut
bore_diameter=2; 
//Thickness of the gear. Set to 0 if you want to make a CNC drawing.
thickness=1;
//Sets the angular width of the tooth, A cicular saw blade would have N*TeethPerN teeth.
TeethPerN=2.5; 
//The pitch of the teeth in degrees
pitch=10;
circle_resolution=100;
Number_of_teeth=3;
//The number of sides in the borehole
bore_shape=12;//[4,6,12] 

                      /*[Hidden]*/
////////////////// Derived Constants ///////////////////////////
R=diameter/2;
$fs=0+0.01;
number_of_teeth=Number_of_teeth+0.001; //There was a bug for 3 and 5, which caused a "No top level geometry error" during F6, this is a catchall hack around it.
//////////////////////// MAIN() ////////////////////////////////
if(thickness<=$fs){ 
//Used if you want a drawing for CNC
	difference(){ 
		circle(r=diameter/2,$fn=100);
		bore(bore_shape);
		}
	teeth(number_of_teeth,TeethPerN);
	}

if(thickness>$fs){ 
//Used if you want an STL
	linear_extrude(thickness){
		difference(){
			circle(r=diameter/2,$fn=circle_resolution);
			bore(bore_shape);
			}
		teeth(number_of_teeth,TeethPerN);
		}
	}
/////////////////////// Functions ////////////////////////////
module bore(n=6){
	//creates a bore hole to attach the gear to, default is a hexagon
	if(n!=12)
		circle(r=bore_diameter/2,$fn=n);
	if(n==12)
		union(){
			circle(r=bore_diameter/2,$fn=6);
			rotate([0,0,360/12]) 
				circle(r=bore_diameter/2,$fn=6);
		}
	}	
	
module tooth1(N){
	//A tooth without pitch, N is the number of teeth around the gear
	theta=360/N/TeethPerN;
	A=[0,R];
	B=[-R*sin(theta), R*cos(theta)];
	C=[0,R+tooth_height];
	polygon([A,B,C]);
	}

module teeth(N){
	for(i=[1:N]){
		rotate(i*360/N) tooth3(N,pitch);
		}
	}

module tooth2(N, pitch=10){
	//A tooth with settable pitch
	theta=360/N/TeethPerN;
	B=[-R*sin(theta), R*cos(theta)];
	C=[0,R+tooth_height];
	A=C-tooth_height*[sin(pitch),cos(pitch)];
	polygon([A,B,C]);
	}

module tooth3(N, pitch=10){
	//A 4-point tooth with settable pitch
	theta=360/N/TeethPerN;
	theta2=theta/3;
	B=[-R*sin(theta), R*cos(theta)];
	C=[0,R+tooth_height];
	A=C-tooth_height*[sin(pitch),cos(pitch)];
	D=(R+tooth_height)*[-sin(theta2), cos(theta2+pitch)];
	polygon([A,B,D,C]);
	}
