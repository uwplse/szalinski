// mathgrrl function bracelet - SUN MODEL

/////////////////////////////////////////////////////////
// resolution parameters

$fn = 24*1;
step = .25*1;  // smaller means finer

// Thickness, in mm (recommend between .2 and .8)
th = .2*1;

/////////////////////////////////////////////////////////
// size parameters

// Diameter of the bracelet, in mm (should exceed the wide diameter of your wrist so that you can get the bracelet over your hand)
diameter = 50; 

radius = diameter/2;

// Height of the bracelet, in mm (along your wrist)
height = 10;

// Amplitude of the wave, in mm (suggest between 4 and 8, with higher numbers being more flash but less practical; higher amplitude can allow smaller diameters)
amplitude = 8; 

// Frequency of the wave (number of spokes) 
frequency = 13;

// Amount of twist (recommend 0-10 for best printability)
degrees = 0;

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