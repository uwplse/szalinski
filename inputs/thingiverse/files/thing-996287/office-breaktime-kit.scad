/* OIK - Office Idling Kit
Daniel.schneider@unige.ch
sept. 2015

History:
- Version 1.0: first version

Instructions:
- print a half_sphere, a wheel and a stick. If the stick does not fit, then ajust the STICK_RADIUS parameter.
- print a chosen module by uncommenting (see below)
- VERY LIKELY NEEDS ADJUSTEMENT for slicer, printer, plastic and wheather ....
*/

// ----------------------- parameters ----------------------------------

// Radius for sticks
STICK_RADIUS = 5;

/* You could adopt the folling defaults if you want bigger or smaller objects 
  HOLE_RADIUS should be at least as big a STICK_RADIUS
  because stick has to fit inside holes
  In some settings the slicer/printer could print sticks and holes smaller though...
*/

// Radius for holes, initially same as stick radius
HOLE_RADIUS = 5;
// HOLE_RADIUS = STICK_RADIUS;
// HOLE_RADIUS = STICK_RADIUS+0.5;

// no modification needed for tuning, but you can change sizes...
// The reference size for all objects, except for the hole and stick width, is the width of the half sphere

// Sphere radius (basic unit)
SPHERE_RADIUS = 30; 

// Wheel radius
// WHEEL_RADIUS = SPHERE_RADIUS;
WHEEL_RADIUS = 30;

// Wheel height (or width)
// WHEEL_HEIGHT = SPHERE_RADIUS / 2;
WHEEL_HEIGHT = 15;      

// Inset radius of stick with inset (for spinning wheels)
// STICK_SLIM_RADIUS = HOLE_RADIUS - 0.5;
STICK_SLIM_RADIUS = 4.5; 

// Height of short stick
// STICK_SHORT_HEIGHT = SPHERE_RADIUS;    
STICK_SHORT_HEIGHT = 30;    

// Height of long stick
// STICK_LONG_HEIGHT = SPHERE_RADIUS * 2; 
STICK_LONG_HEIGHT = 60 ; 

// Length of beam
// BEAM_LENGTH = SPHERE_RADIUS*5;     // [3,4,5,6]
BEAM_LENGTH = 150;

// Width and height of beam
// BEAM_WIDTH = SPHERE_RADIUS/2;
BEAM_WIDTH = 15;

// Display defaults

echo ("STICK_RADIUS=", STICK_RADIUS);
echo ("HOLE_RADIUS=", HOLE_RADIUS);
echo ("SPHERE_RADIUS=", SPHERE_RADIUS);
echo ("WHEEL_RADIUS=", WHEEL_RADIUS);
echo ("WHEEL_HEIGHT=", WHEEL_HEIGHT);
echo ("STICK_RADIUS=", STICK_RADIUS);
echo ("STICK_SLIM_RADIUS=", STICK_SLIM_RADIUS);
echo ("STICK_SHORT_HEIGHT=", STICK_SHORT_HEIGHT);
echo ("STICK_LONG_HEIGHT=", STICK_LONG_HEIGHT);
echo ("BEAM_LENGTH=", BEAM_LENGTH);

// default resolution
$fn=50;

// -------------------- Modules ----------------------
// uncomment line by line to generate the STLs

// half_sphere();
// wheel ();
// stick_short ();
// stick_long ();
// stick_with_inset ();
// beam7();

// see all of it - NOT so recommended for printing, since I'd change the slicer settings and plastic for various objects

exhibit () ;

module exhibit () {
     // row 1
     translate ([0,-1.5*WHEEL_RADIUS,0]) {stick_short(); }
     translate ([4*STICK_RADIUS,-1.5*WHEEL_RADIUS,0]) {stick_long(); }
     translate ([8*STICK_RADIUS,-1.5*WHEEL_RADIUS,0]) {stick_with_inset(); }
     // row 2
     translate ([-WHEEL_RADIUS*1.5,0,0])  {half_sphere(); }
     translate ([WHEEL_RADIUS,0,0]) {wheel(); }
     // row 3
     translate ([-WHEEL_RADIUS*2,1.5*WHEEL_RADIUS,0]) {beam7(); }
     }

// --------------------- Module definitions ------------------------


// Half sphere is one of the three major objects

module half_sphere ()
{
     $fn=100;
     
     difference (){
	  // halfsphere
	  difference () {
	       sphere(r=SPHERE_RADIUS);
	        translate ([0,0,-SPHERE_RADIUS])
	       {
		    cylinder (h=SPHERE_RADIUS,r=SPHERE_RADIUS+10);
	       }
	  }
	  
	  // rod for the hole
	   translate ([0,0,-SPHERE_RADIUS]) {
	        cylinder (h=100,r=HOLE_RADIUS);
	  }
	  // shave a little bit off the top of the sphere,
	  // this way it can "sit" upside down
	  translate ([0,0,SPHERE_RADIUS-1])
	  {
	       cylinder (h=10,r=SPHERE_RADIUS+10);
	  }
     }
}

// Module wheel

module wheel ()
{
     $fn=100;
     difference (){
	  
	  // create the wheel form
	  difference (){
	        translate ([0,0,0])
	       {
		    cylinder (h=WHEEL_HEIGHT,r=SPHERE_RADIUS);
	       }
	       
	       translate ([0,0,SPHERE_RADIUS+SPHERE_RADIUS/4])
	       {
		    sphere(r=SPHERE_RADIUS);
	       }
	  }
	  // rod for the hole
	   translate ([0,0,-SPHERE_RADIUS]) {
	        cylinder (h=100,r=HOLE_RADIUS);
	  }
     }
}

// Module short rounded stick

module stick_short ()
{
     union ()
     {
	  cylinder (h=STICK_SHORT_HEIGHT - STICK_RADIUS,r=STICK_RADIUS);
	   translate ([0,0,STICK_SHORT_HEIGHT - STICK_RADIUS]) {
	       sphere(r=STICK_RADIUS);
	  }
     }
}

// Module long rounded stick

module stick_long ()
{
     union ()
     {
	  cylinder (h=STICK_LONG_HEIGHT - STICK_RADIUS,r=STICK_RADIUS);
	   translate ([0,0,STICK_LONG_HEIGHT - STICK_RADIUS]) {
	       sphere(r=STICK_RADIUS);
	  }
     }
}

// Module long stick with inset

module stick_with_inset ()
{
     // low is normal fat
     cylinder (h=STICK_LONG_HEIGHT/4 -1, r=STICK_RADIUS);
     translate ([0,0,STICK_LONG_HEIGHT/4 -1]) {
	  cylinder (h=STICK_LONG_HEIGHT/2 + 2, r=STICK_SLIM_RADIUS);
     }
     translate ([0,0,STICK_LONG_HEIGHT * 3/4 + 1]) {
	  cylinder (h=STICK_LONG_HEIGHT/4 -1, r=STICK_RADIUS);
     }

     // incline for the inset, better for some printers
     translate ([0,0,STICK_LONG_HEIGHT/4 -1]) {
	  cylinder (h=1, r1=STICK_RADIUS, r2=STICK_SLIM_RADIUS);
	  }
     translate ([0,0,STICK_LONG_HEIGHT * 3/4]) {
	  cylinder (h=1, r1=STICK_SLIM_RADIUS, r2=STICK_RADIUS);
     }
}

module beam7 ()
{
     // vertical position of holes
     x_offset = STICK_RADIUS * 2;
     x_step = (BEAM_LENGTH - 2*x_offset)  / 3;
     // horizontal pos
     x_offset2 = BEAM_LENGTH / 4;
     x_step2 = x_offset2;

     difference (){
	  translate ([0,-SPHERE_RADIUS/2/2,0]) {
	       cube (size = [BEAM_LENGTH, BEAM_WIDTH, BEAM_WIDTH], center=false);
	  }
	  // vertical holes
	   for (x = [0:3]) {
	       assign (x_pos = x_offset + x * x_step) {
		    translate ([x_pos,0,-BEAM_WIDTH]) {
			 cylinder (h=100,r=HOLE_RADIUS);
		    }
		    
	       }
	  }
	  // horizontal holes
	   for (x = [0:2]) {
	       assign (x_pos = x_step2 + x * x_step2) {
		    translate ([x_pos,BEAM_WIDTH,BEAM_WIDTH/2]) {
			 rotate (90, [1,0,0]) {
				   cylinder (h=100,r=HOLE_RADIUS);
			      }
			      }
		    
	       }
	  }

     }
}

