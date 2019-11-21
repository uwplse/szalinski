/*Polygon-möbius-strip generator by Mixomycetes
*Licence: CC non-commercial
*
* Inspired by Twistypuzzle forum and
* mobius_polygon(n,m)
*
* v1: functional mobius_polygon();
* v2: Used pie library to implement Angle_to_keep_in_STL <360;
* v3: added twisty_puzzle pieces();
* v4: rebuild with steps using children(). Much faster.
* v5: implemented my_pieslice instead of pie;
* v6: smooth output available (hull of every 2 adjencent pieces)
* v7: accepts any 2D polygon as input for rotation. 
* v8: some cleanup.
*******************************
*/

//Number of edges of rotated polygon.
NEdges = 4; //[1:20]

//Number of full twists over one ring turn.Make negative to reverse chirality. n/m fractions possible too
Twists  = 2/4;  
// Diameter of polygon (circumscribed)
Width_strip= 19; 
 // Diameter of total ring
Size_ring = 100; //should be larger than width_strip.

// Angle to print. May need to make multiple rotations (>360), when NEdges/Twist is non-integer.
Angle_to_form_shape = 360; // [0:720]

// Typically 360, smaller if you want to keep only a fraction. Note that it slows things down considerably!
Angle_to_keep_in_STL = 360; // [0:360]
// Angle of polygon at X-axis. Mainly important for Twists =0
Start_angle = 0;

Make_empty_centre_ring = 0; // [1:Yes,0:No]

//FULL centre hole diameter. Should be smaller than Width_strip.
Diameter_hollow_centre =5; 

// Angle-section of each segment
Stepsize=20; 

smoothed = 1; // 1: uses a hull between every 2 items. 0 doesn't. 0 is faster, 1 nicer.
// the lower the faster, but higher means nicer
fn = 5;


/** Begin of program **/
    
//Some simple shapes/features:
//mobius_strip(20,4,0.1);
mobius_polygon(NEdges,Twists,Width_strip,Size_ring,fn,Angle_to_form_shape,Start_angle,Stepsize,Angle_to_keep_in_STL,Make_empty_centre_ring,Diameter_hollow_centre,smoothed);

//rotate_step_by_step(Twists,Stepsize,Angle_to_form_shape,0,20,0,1)ngon(20)
//nparts = 4;
//points = [[0,0],[-1,1],[1,-1],[1,1]]*Width_strip/2;
//georgehart_mobius_centre_v1(nparts,points,TiltAngle=20);

/** Modules **/

module georgehart_mobius_centre_v1(nparts,points,TiltAngle=20){
// n_gon: points = 
CentreAngle = 360/nparts;

union(){
    for (i = [0:nparts-1]){
rotate([0,TiltAngle,i*CentreAngle])translate([0,Size_ring/4,0])  rotate_step_by_step(Twists,1,Angle_to_form_shape,0,Size_ring,1) polygon(points);
};
};
};


module mobius_polygon(NEdges=5,Twists=0,Width_strip=1,Size_ring=10,fn=10,Angle_to_form_shape =360,Start_angle=0,Stepsize=5,Angle_to_keep_in_STL=360,Make_empty_centre_ring=0,Diameter_hollow_centre=0,smoothed=0){
steps_obsolete=Angle_to_form_shape/Stepsize; 
  steps=360/Stepsize; // a step per 5°, faster than per 1°
intersection(){ //keep just a pieslice    
    if (Angle_to_keep_in_STL<360) {
        safetymargin=3; // default 3
   translate([0,0,-Width_strip/2*safetymargin]) mypie(Size_ring/2*safetymargin+Width_strip/2*safetymargin, Width_strip*safetymargin, Angle_to_keep_in_STL, spin=0);
    };
    
difference(){ 
//make main shape
if (NEdges==2){
    thickness = 1;
    // available for backward compatibility    
    mobius_strip(Size_ring/2,Width_strip,thickness,Twists/2,Stepsize,Start_angle);
     };   

    
if (NEdges>2){
                
rotate([0,0,Start_angle]) rotate_step_by_step(Twists,Stepsize,Angle_to_form_shape,smoothed,Size_ring) circle(d=Width_strip,$fn=NEdges);
    };
  
    // cut out centre ring.
if (  Make_empty_centre_ring==1 ){
    rotate_extrude($fn=fn)translate([Size_ring/2,0,0])circle(d=Diameter_hollow_centre,$fn=fn);
};

};
};
};


// some helper functions:
module ngon(diam=10, fn=6){
//rotate([90,0,0])    linear_extrude(thickness)
    circle(d=diam,$fn=fn);
    }; // in XZ-plane, needed positive X for rotate-extrude! => translate([diam,0])


module rotate_step_by_step(Twists=0,Stepsize=5,To_angle=360,smoothed =0,Size_ring=50,From_angle=0){// iterative rotate_extrude of 2D child. (Sv7)
    // Much Faster, but creates more coordinates.
    // children shapes should be within a Size_ring/2 circle.
     // OneStepAngle_wrong =Angle_to_form_shape/Stepsize; // a step per 5°, faster 
        if (smoothed==1)
    for (step = [From_angle:Stepsize:To_angle-Stepsize]){
            hull(){rotate([0,0,step]) rotate_extrude(angle = Stepsize, convexity = 2) translate([Size_ring/2,0,0]) rotate([0,0,step *Twists])       children();
    rotate([0,0,step+Stepsize]) rotate_extrude(angle = Stepsize, convexity = 2) translate([Size_ring/2,0,0]) rotate([0,0,(step+Stepsize) *Twists])        children();
            };
};  
            if (smoothed==0){
    for (step = [From_angle:Stepsize:To_angle-Stepsize]){
            rotate([0,0,step]) rotate_extrude(angle = Stepsize, convexity = 2)translate([Size_ring/2,0,0]) rotate([0,0,step *Twists])        children();
            };  
};  
};


module mobius_strip(radius=20,width=5,thickness=1,twist=1,step=1, ,start=90){ // original code by Kitwallace
    
   // Original_code_by_kitwallace
   //source:    http://www.thingiverse.com/thing:239158/#files
    // Mobius strip
   
Halftwist =twist/2;
Delta= 0.01;

  for (i = [0:step:360])
    hull() {
       rotate([0,0,i])
          translate([radius,0,0])
             rotate([0,start+i * Halftwist, 0]) 
               cube([width,Delta,thickness], center=true);
       rotate([0,0,i+step])
          translate([radius,0,0])
             rotate([0,start+(i+step)* Halftwist , 0]) 
               cube([width,Delta,thickness], center=true);
       }
};

    
    


module thorus(Size_ring=10,Diameter_hollow_centre=5,fn=5){ // simple thorus
rotate_extrude(,$fn=fn)translate([Size_ring/2,0,0])circle(d=Diameter_hollow_centre,$fn=fn);
    };

module mypie(radius,height,pieangle,spin){
rotate_extrude(angle=pieangle,$fn=fn)square(size =[radius,height],centre=false);
};
    

