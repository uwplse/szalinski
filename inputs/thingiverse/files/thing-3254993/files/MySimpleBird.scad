
// a bird for a native american style flute 
// makes the airway from the air hole to the sound hole
// bringing the air up and over a blockage in the tube 
// (often a joint in bamboo-like reed)
// then to the sound hole 
// passing over the cutting edge and making the sound

// printed bottom side up
// wet sand the side against the flute till nice and flat
// if the airway is too high you can sand more to reduce the air flow
// remove any burs, especially in the airway
// suggest 0.1mm layer height

// Shape of the bird can be important for a good sound
// adjust parameters below in openscad to fit your flute
// or stretch in your slicer
// find what works best for your playing

// there are two shape options below selected by adding and removing commented lines
// choose a flat airway or one that constricts in height as it goes
// and choose ears on the sides of the sound hole or a beard over it

// there are some good discussions of beards and ears in the organ pipe literature
// http://faculty.bsc.edu/jhcook/orghist/works/works03.htm
// you'll find you can blow harder and not move up to the next octave with a beard


$fn=120;   // slow really fine
//$fn=30;   // fast for editing

BL=46;        // Bird Length      measure from front of sound hole to back of air hole than add a WW 
BW=16;       // Bird Width        wide enough to include AW and some distance on each side
AW=6;       // Airway Width       I like it just less than the size of the sound hole
AH=.8;     // Airway Height       bigger allows more air flow, how hard do you blow? how fast is the air?
BH=12;    // Bird Height          try AW*2, has an effect on position of beards and height of ears  

WW=(BW-AW)*.5;      // Wall Width     distance from side of bird to side of airway

difference(){ 

hull(){
translate([+BL*.5      ,0,BH*.5])  Donut((BW-BH)*.5,BH*.7071);     // front end    
translate([-BL*.5+BW*.5,0,BH*.5])  Donut((BW-BH)*.5,BH*.7071);    //  back end    
}

hull(){      // Airway 
  translate([-BL*.5+BW*.5,0,BH   ]) scale([1,1,.5])  sphere(r=(BW-WW*.5)*.5);    // sphere back makes airway with gradually constricting air
//translate([-BL*.5+BW*.5,0,BH-AH]) cylinder(h=BH, r=(BW-WW*.5)*.5);            // cylinder back,  makes a flat airway no slope  
  translate([ BL*.5                ,0,BH-AH+4]) cube([4,AW,8], center=true);    
}

translate([-WW*.5,0,(BW+BH)*.66+BH*.2])  scale([1,.6,1]) rotate([0,90,0])  Donut((BW+BH),(BW+BH)*.2);  // for leather or hair band to tie to flute

//  translate([BL*.5,BL*.5,BH  ]) rotate([90,0,0]) scale([.6,1,1]) cylinder(h=BL, r=BH*.9);          // 1 front option overhanging beard   choose one or neither
  translate([BL*.5,   0 ,-.01])                    scale([.6,1,1]) cylinder(h=BL, r=(BW-WW)*.5);    //  2 front option        side ears    

translate([0        ,0,-111  ]) cube([222,222,222], center=true);       // chop bottom
translate([0        ,0,111+BH]) cube([222,222,222], center=true);       // chop top
translate([111+BL*.5,0,0     ]) cube([222,222,222], center=true);       // chop front
}

//======================================================
module Donut(R1,R2)  // r1 radius from center  r2 thickness of donut
{
rotate_extrude(angle=360,convexity = 8)  
difference(){     
translate([R1, 0, 0])   circle(r = R2);
translate([ -111,0,0]) square([222,222], center=true);  // chop left so compatible with rotate_extrude
}}

