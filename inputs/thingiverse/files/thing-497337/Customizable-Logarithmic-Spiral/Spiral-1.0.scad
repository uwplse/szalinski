//Customizable Column v1.1
//v1.0 had 10 downloads
//Created by Ari M. Diacou, October 2014
//Shared under Creative Commons License: Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) 
//see http://creativecommons.org/licenses/by-sa/3.0/

loops=3;
steps_per_loop=20;
//A logarthmic Spiral has the form r=a*exp(b*theta);
a=0.4;
b=0.2;
//How much detail on the curves
$fn=30;
//If segments dont line up with spheres, use this to move segments in and out. Vary between [-0.5,0.5].
rad_fudge=0.30;
//If segments dont line up with spheres, use this to rotate segments. Vary between [-0.5,0.5].
deg_fudge=-0.10;

						/*[Hidden]*/
////////////////// Variables //////////////////////////
pi=3.1415+0;
//////////////////// Main() ///////////////////////////
for(i=[0:loops*steps_per_loop]){
	translate([r(rad(i))*cos(deg(i)),r(rad(i))*sin(deg(i)),0])
		color("pink") sphere(d=d(i));
	translate([
					r(rad(i+rad_fudge))*cos(deg(i+0.5)),
					r(rad(i+rad_fudge))*sin(deg(i+0.5)),
					0])
		rotate([90,0,deg(i+deg_fudge)])
			cylinder(d2=d(i),d1=d(i+1),h=arc_length(i-1),center=true);
	}
////////////////// Functions //////////////////////////
function deg(n)=360*n/steps_per_loop;
function rad(n)=2*pi*n/steps_per_loop;
function arc_length(n)= //The length of a line segment = sqrt( (y2-y1)^2 + (x2-x1)^2 )
		sqrt(
			pow(
				r(rad(n+1))*sin(deg(n+1)) -
				r(rad(n))*sin(deg(n))
				,2) 
			+
			pow(
				r(rad(n+1))*cos(deg(n+1)) -
				r(rad(n))*cos(deg(n))
				,2)
			);
function r(th)=a*exp(b*th);
function d(i) =r(rad(i))/3;	