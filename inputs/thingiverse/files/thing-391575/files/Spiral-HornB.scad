//copyright 2014 Richard Swika
//All Rights Reserved
//Rev. Orig - July 10, 2014 - one way to make a twisted spiral horn like mesh
//Rev. A - July 12, 2014 - improved Thingiverse Customizer support
//Rev. B - March 25, 2016 - updated to work with changes to Customizer
/* [Dimensions] */

//How much resolution?
$fn =50;	// [20,30,40,50,60,70,80,90,100]

// How long? (mm)
length = 100; //[10:200]

// Radius of spiral? (mm)
spiralR=5; //[0:40]

// Radius of horn at bottom (mm)
startR=10; //[5:50]

// Radius of horn at toip (mm)
endR=3.5; //[2:50]

//How many rotations?
rotations=2; //[0:10]

//How many segments? 
segments=40; //[2:200]

//$fs=0.01;
module spiral_horn(
	length=100, //Measurements are in mm
	spiralR=2.5,
	startR=10,
	endR=3.5,
	rotations=3.5,
	segments=40
){
	function spiral(z)=[spiralR*cos(z*360*rotations),spiralR*sin(z*360*rotations),z*length];
	function horn_radius(z)= z*(endR-startR)+startR;
	step=1/segments;
	union(){
		for(p = [0 : step : 1-step])	{
			translate(spiral(p))
			sphere(r=horn_radius(p));
		}
	}
}
function t()= animate ? $t : 1; //control time; become a Time Lord

//to see animation, click View|Animate, then set FPS to 30, and Steps to 120 on the animation toolbar
//and uncomment the next line of code
//animate=1;
if (animate)
{
	translate([-30,0,0]) 
		spiral_horn(rotations=5*t());
	translate([0,0,0]) 
		spiral_horn(length=100*t(), rotations=2);
	translate([40+t()*10,0,0]) 
		spiral_horn(length=100*t(), rotations=2*t(), spiralR=20*t(), startR=15,segments=50*t());
}
else //for customizer
	spiral_horn(length=length,
		spiralR=spiralR,
		startR=startR,
		endR=endR,
		rotations=rotations,
		segments=segments
);
