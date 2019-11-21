// Filename: window_stopper.scad
// Author: Steffen Pfiffner
// Date: 06/10/2014
// Email: s.pfiffner@gmail.com
// Web: http://www.thingiverse.com/FiveF

// Project: Parametric Window Stopper

use <build_plate.scad>

/* [Basic] */
//This is the height from your ledge to the bottom most part of your window. The total height will be the radius of the top cylinder higher than the given value to actually stop the window. If the spring isn't rendered in your stl try playing around with this value a bit.
height = 30.0;
width = 15.0;
length = 28.0;

//Thickness of the spring.
spring_strength = 2;


//Thickness of the baseplate
base_height = 5;

/* [Quality] */
//$fa is the minimum angle for a fragment. Even a huge circle does not have more fragments than 360 divided by this number. The default value is 12 (i.e. 30 fragments for a full circle). The minimum allowed value is 0.01. Any attempt to set a lower value will cause a warning.
$fa = 12;

//$fs is the minimum size of a fragment. Because of this variable very small circles have a smaller number of fragments than specified using $fa. The default value is 2. The minimum allowed value is 0.01. Any attempt to set a lower value will cause a warning.
$fs = 2;

//More steps make the curve surface smoother. Be careful, if this value is heigh compared to the height of the object the spring might not be rendered any more!!!
steps = height;

/* [Advanced] */
//If the bottom end of the spring is below or above the base it can be fixed here. (- down + up)
base_spring_offset = 0.0;

//Set the frequency of the spring. f(x) = sin(spring_frequency*x)
spring_frequency = 0.5;

cylinder_radius = 6.0;
base_width = width;
base_lenght = length;

/* [Hidden] */

//Add the cylinder radius to the given height to actually be able to hold the window.
total_height = height + cylinder_radius;

echo( "spring_strength" , spring_strength );
echo( "base_spring_offset" , base_spring_offset );
echo( "base_height" , base_height ); 
echo( "height" , height ); 
echo( "length" , length ); 

//Build plate:

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

//Build plate END



// To render an example, remove the comments
pi = 3.1415926536;
e = 2.718281828;
// function to convert degrees to radians
function d2r(theta) = theta*360/(2*pi);


/* Cartesian equations */
/* Sine wave */
pi = 3.14159;
function _f(x) = (length/2-2)*sin((spring_frequency)*x);
function f(x) = _f(d2r(x));

//STOPPER START
translate([-height/2,0,width/2]){
	union(){
		rotate(a=90, v=[0,1,0]){

			//sinus spring
			translate([-width/2,0,height]){
			rotate(a=90, v=[0,1,0]){
				linear_extrude(height=width)
					2dgraph([0, height-spring_strength/2-base_spring_offset], spring_strength, steps=steps);
			}

			}

			//bottom cube
			translate([0,0,spring_strength/2]){
				cube([base_width,base_lenght,base_height], center = true);
			}

			//top cylinder
			translate([-width/2,0,height]){
				rotate(a=90, v=[0,1,0]){
					cylinder(h = width, r=cylinder_radius);
				}
			}

		}
	}
}
//STOPPER END


//2D library start

// These functions are here to help get the slope of each segment, and use that to find points for a correctly oriented polygon
function diffx(x1, y1, x2, y2, th) = cos(atan((y2-y1)/(x2-x1)) + 90)*(th/2);
function diffy(x1, y1, x2, y2, th) = sin(atan((y2-y1)/(x2-x1)) + 90)*(th/2);
function point1(x1, y1, x2, y2, th) = [x1-diffx(x1, y1, x2, y2, th), y1-diffy(x1, y1, x2, y2, th)];
function point2(x1, y1, x2, y2, th) = [x2-diffx(x1, y1, x2, y2, th), y2-diffy(x1, y1, x2, y2, th)];
function point3(x1, y1, x2, y2, th) = [x2+diffx(x1, y1, x2, y2, th), y2+diffy(x1, y1, x2, y2, th)];
function point4(x1, y1, x2, y2, th) = [x1+diffx(x1, y1, x2, y2, th), y1+diffy(x1, y1, x2, y2, th)];
function polarX(theta) = cos(theta)*r(theta);
function polarY(theta) = sin(theta)*r(theta);

module nextPolygon(x1, y1, x2, y2, x3, y3, th) {
	if((x2 > x1 && x2-diffx(x2, y2, x3, y3, th) < x2-diffx(x1, y1, x2, y2, th) || (x2 <= x1 && x2-diffx(x2, y2, x3, y3, th) > x2-diffx(x1, y1, x2, y2, th)))) {
		polygon(
			points = [
				point1(x1, y1, x2, y2, th),
				point2(x1, y1, x2, y2, th),
				// This point connects this segment to the next
				point4(x2, y2, x3, y3, th),
				point3(x1, y1, x2, y2, th),
				point4(x1, y1, x2, y2, th)
			],
			paths = [[0,1,2,3,4]]
		);
	}
	else if((x2 > x1 && x2-diffx(x2, y2, x3, y3, th) > x2-diffx(x1, y1, x2, y2, th) || (x2 <= x1 && x2-diffx(x2, y2, x3, y3, th) < x2-diffx(x1, y1, x2, y2, th)))) {
		polygon(
			points = [
				point1(x1, y1, x2, y2, th),
				point2(x1, y1, x2, y2, th),
				// This point connects this segment to the next
				point1(x2, y2, x3, y3, th),
				point3(x1, y1, x2, y2, th),
				point4(x1, y1, x2, y2, th)
			],
			paths = [[0,1,2,3,4]]
		);
	}
	else {
		polygon(
			points = [
				point1(x1, y1, x2, y2, th),
				point2(x1, y1, x2, y2, th),
				point3(x1, y1, x2, y2, th),
				point4(x1, y1, x2, y2, th)
			],
			paths = [[0,1,2,3]]
		);
	}
}

module 2dgraph(bounds=[-10,10], th=2, steps=10, polar=false, parametric=false) {
	step = (bounds[1]-bounds[0])/steps;
	union() {
		for(i = [bounds[0]:step:bounds[1]-step]) {
			if(polar) {
				nextPolygon(polarX(i), polarY(i), polarX(i+step), polarY(i+step), polarX(i+2*step), polarY(i+2*step), th);
			}
			else if(parametric) {
				nextPolygon(x(i), y(i), x(i+step), y(i+step), x(i+2*step), y(i+2*step), th);
			}
			else {
				nextPolygon(i, f(i), i+step, f(i+step), i+2*step, f(i+2*step), th);
			}
		}
	}
}

