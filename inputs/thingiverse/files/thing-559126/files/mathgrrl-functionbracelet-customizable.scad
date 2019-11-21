// mathgrrl trigonometric bracelet

$fn = 12*1;	// larger means finer (and slower!)

/* [Size] */

// (make it large enough so that you can get the bracelet over your hand)
diameter = 65; 

radius = diameter/2;

// (the length of the band along your wrist)
height = 8;

// (recommend between .2 and 1 for most designs)
thickness = .4;

/* [Design] */

// (to twist while extruding; 0 = straight, more = twisted)
degrees = 0;

// (muliplier to make ovals instead of circles; 1 = circle, less = inside oval, more = outside oval)
oval = 1; 	

// (to change from a bangle to a wrap; 0 = closed circle, more = open gap)
cut = 0;	

// (multiplier for flaring in/out during the extrude; 1 = straight up, less = closes up, more = opens up) 
flare = 1;	

/* [Math] */

// (low = shorter bumps, high = taller bumps)
amplitude = 4;	

// (low = fewer bumps, high = more bumps)
frequency = 24;		

// (step size for sampling the curve; smaller means finer, larger can be cool low-poly)
step = .5; 	// 

// Sine/Cosine frequency modifiers (for a simple sine curve choose s=1 and c=0)
s = 1;	//[0,1,2,3,4,5]
c = 0;	//[0,1,2,3,4,5]

///////////////////////////////////////////////////////////////////////
// define the wave function

function f(t) = 1+sin(s*frequency*t)*cos(c*frequency*t);

///////////////////////////////////////////////////////////////////////
// define the wrapped wave function

function g(t) =  
   [ oval*(radius+amplitude*f(t))*cos(t),
     (radius+amplitude*f(t))*sin(t),
     0
   ];

///////////////////////////////////////////////////////////////////////
// renders

// the bracelet
rotate(-90/frequency,[0,0,1])
linear_extrude(height=height, twist=degrees, slices=height/.4, scale=flare)
	function_trace(rad=thickness, start=0+90/frequency+cut, step=step, end=360+90/frequency-cut);


///////////////////////////////////////////////////////////////////////
// module for tracing out a function

module function_trace(rad, start, step, end) {
 for (t=[start: step: end-step]) {
  hull() {
   translate(g(t)) circle(rad);
   translate(g(t+step)) circle(rad);
       }
   }
};