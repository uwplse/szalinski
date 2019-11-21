// mathgrrl function bracelet - POW design

///////////////////////////////////////////////////////////////////////
// resolution parameters

$fn = 24*1;
step = .25*1; 	// smaller means finer

// Thickness, in mm (recommend between .2 and .4)
th = .4;

///////////////////////////////////////////////////////////////////////
// size parameters

// Diameter of the bracelet, in mm (just smaller than the largest part of your hand)
diameter = 60; 
radius = diameter/2;

// Height of the bracelet, in mm (along your wrist)
height = 10;

///////////////////////////////////////////////////////////////////////
// style parameters

// Amplitude of the wave, in mm
amplitude = 6;

// Frequency of the wave (number of spokes)
frequency = 12;

///////////////////////////////////////////////////////////////////////
// function parameters
// for simple sine curve choose s=1, c=0

s = 2*1;
c = 1*1;

///////////////////////////////////////////////////////////////////////
// define the wave function

function f(t) = 1+sin(s*frequency*t)*cos(c*frequency*t);

///////////////////////////////////////////////////////////////////////
// define the wrapped wave function

function g(t) =  
   [ (radius+amplitude*f(t))*cos(t),
     (radius+amplitude*f(t))*sin(t),
     0
   ];

///////////////////////////////////////////////////////////////////////
// renders

// the bracelet
linear_extrude(height=height,slices=height/.4)
	function_trace(rad=th, step=step, end=360);

// add solid center if desired
//cylinder(h=height,r1=radius+1,r2=flare*(radius+1),$fn=48);

// testing cylinders
//wrist_tester();
//hand_tester();

///////////////////////////////////////////////////////////////////////
// module for tracing out a function

module function_trace(rad, step, end) {
 for (t=[0: step: end+step]) {
  hull() {
   translate(g(t)) circle(rad);
   translate(g(t+step)) circle(rad);
       }
   }
};

///////////////////////////////////////////////////////////////////////
// modules for testing wrist and hand fit

module wrist_tester(){
	wrist_radius = wrist_circumference/(2*3.14159);
	translate([0,0,-height]) 
		%cylinder(h=3*height,r=wrist_radius,$fn=48);
}

module hand_tester(){
	hand_radius = hand_circumference/(2*3.14159);
	translate([0,0,-height]) 
		%cylinder(h=3*height,r=hand_radius,$fn=48);
}



