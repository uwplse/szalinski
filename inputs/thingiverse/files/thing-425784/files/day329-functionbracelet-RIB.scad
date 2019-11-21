// mathgrrl function bracelet - RIB MODEL

/////////////////////////////////////////////////////////
// resolution parameters

$fn = 24*1;
step = .25*1;  // smaller means finer

// Thickness, in mm (recommend between .2 and .8)
th = .2*1;

/////////////////////////////////////////////////////////
// size parameters

// Diameter of the bracelet, in mm
diameter = 65; 
radius = diameter/2;

// Height of the bracelet, in mm (along your wrist)
height = 20;

// Amplitude of the wave, in mm
amplitude = 2*1; 

// Frequency of the wave (number of spokes) 
frequency = 72*1;

// Amount of slant (to the left or the right)
slant = 0; //[-3,-2,-1,0,1,2,3]
degrees = slant*360/frequency;

/////////////////////////////////////////////////////////
// define the wrapped wave function

function g(t) =  
   [ (radius+amplitude*(1+sin(frequency*t)))*cos(t),
     (radius+amplitude*(1+sin(frequency*t)))*sin(t),
     0
   ];

/////////////////////////////////////////////////////////
// renders

// the bracelet
linear_extrude(height=height,twist=degrees,slices=height/.4)
 function_trace(rad=th, step=step, end=360);

/////////////////////////////////////////////////////////
// module for tracing out a function

module function_trace(rad, step, end) {
 for (t=[0: step: end+step]) {
  hull() {
   translate(g(t)) circle(rad);
   translate(g(t+step)) circle(rad);
       }
   }
};