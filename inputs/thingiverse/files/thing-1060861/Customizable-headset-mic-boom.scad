// Customizable headset boom mic
// Designed by Rich Moore, Oct 8th, 2016 dr.romeo.chaire@gmail.com

// Note: default values are set to accept an inexpensive "Neewer"
// brand electret condenser microphone, available on amazon.com
// for under $2/ea in quantities of 5 and up. Dimensions may change

/* [Microphone dimensions (mm)] */
// Enter the largest diameter of your microphone in mm
mic_major_dia=10;

// If the body of the microphone is tapered, enter the smaller diameter.  If it's a straight cylinder, enter the major diameter again.
mic_minor_dia=6.2;

// Enter the length of the body of the microphone cylinder in mm.
mic_len=18;

// Enter the diameter of the microphone cable in mm.
cord_dia=2.2;

/* [Magnet dimensions (mm)] */
// Diameter of cylindrical magnet (mm)
mag_dia=8;

// Height of cylindrical magnet (mm)
mag_h=2;

/* [Design Parameters] */

// Which part would you like to create?
part = "boom"; // [boom: Boom Only, mount: Mount Only]

// Length of the microphone boom from center of pivot mount to mic holderBoom Parameters
boom_len=100;   // [25:150]

// Angle of microphone, relative to the boom. 0 is straight, 90 is max angle
mic_angle=60;   // [0:90]

// mount_side is whether you want to mount to the right or left of your headphones
mount_side= -1;  // [-1: Left side, 1: Right side]

// support_factor controls how long the support between the boom and pivot is. This is just a general control, not in mm.
support_factor=3; // [2,3,4,5]

/* [Hidden] */ 
// other parameters set by default but not in Customizer interface

mic_wall=2.4; // wall thickness of mic holder
boom_wall=1.5; // wall thickness of boom tube
cord_factor=1.2; // opening for cable should have some extra room
boom_dia=cord_dia+2*boom_wall; // outer diameter of boom tube
cord_slot=cord_dia*.9; // opening for cord is slightly smaller to retain cord
mount_dia=20;   // size of the disk that makes up the pivot
boom_facets=25;  // how many sides for the boom tube

bmp_dia=1.8;    // diameter of the detents or bumps on the pivot
bmp_rng_dia=mount_dia*.7; // diameter of the ring of bumps
bump_count=10;  // how many bumps
INF=1000;   // large number used for cutting objects
FF=0.01;    // fudge factor for making sure unions don't have zero width planes
$fn=50;

// preview[view:south, tilt:top]

module half_space(size,axis,dir)
{
// half_space is a utility module used to cut objects with difference function
// axis: x=0, y=1, z=2
// dir: -1 or 1, direction of half-space
    sign = dir==-1 ? -1 : 1;
    if (axis==0) // x axis
        translate([sign*size/2,0,0]) cube(size+FF,center=true);
    else if (axis==1)
        translate([0,sign*size/2,0]) cube(size+FF,center=true);    
    else 
        translate([0,0,sign*size/2]) cube(size+FF,center=true);
}

module boom() {
// create boom by taking a difference of two unions
difference(){
    
// stuff to add
union()    {  
// main pivot -- disk that holds boom to base with magnet
    cylinder(boom_dia,d=mount_dia,center=true);              
 
// add some support to where the pivot meets the boom shaft, looks and strength
    translate([mount_dia/(1+support_factor),0,0])
       difference() {
           scale([support_factor,1,1])
              cylinder(boom_dia,d=mount_dia/2,center=true);
           half_space(100,0,-1);
       }
                            
// boom shaft
    rotate([0,90,0])
        cylinder(boom_len,d=boom_dia,$fn=boom_facets);

// put mic holder at end of boom shaft  
    translate([boom_len,0,boom_dia/3]) {
       sphere(d=mic_minor_dia+mic_wall);
          rotate([0,90-mic_angle,0])
            cylinder(mic_len,d1=mic_minor_dia+mic_wall,d2=mic_major_dia+mic_wall);    
    }
    
// place the bumps used to hold the boom in place    
    for(ang=[0:360/bump_count:360])
       rotate([0,0,ang])
          translate([bmp_rng_dia/2,0,boom_dia/2])
             sphere(0.8*bmp_dia);
    }
         
// stuff to subtract 
    union() {
// cut cavity in the boom for cord
        rotate([0,90,0])
          translate([0,0,mount_dia/2])
            cylinder(boom_len-mic_minor_dia-2*mic_wall,d=cord_dia*cord_factor);
             
// cut opening for mic
   translate([boom_len,0,boom_dia/3])
      rotate([0,90-mic_angle,0])
         cylinder(mic_len+mic_wall+FF,d1=mic_minor_dia,d2=mic_major_dia);             
 
// cut slot in boom shaft for cord entry
   translate([mount_dia/2,-cord_dia/2,cord_dia/2])
        cube([boom_len-mount_dia/2,cord_slot,INF]);
        
// cut slot in mic holder for cord entry
    translate([boom_len,-cord_slot/2,boom_dia/3])
        rotate([0,90-mic_angle,0])
            translate([-mic_len/2,0,0])
                cube([mic_major_dia,cord_slot+FF,2*mic_len]);

// cut groove for cable to exit
    translate([mount_dia/2+cord_slot,mount_side*mount_dia/2,boom_dia/2])
        cube([cord_slot*1.2,mount_dia,boom_dia],center=true);  

// take the sharp corners off cord exit        
    translate([mount_dia/2+cord_slot,0,boom_dia/2])
        cylinder(boom_dia/2,r=cord_slot,center=true);
                 
// cut magnet hole
    translate([0,0,boom_dia-1.75*mag_h])
       cylinder(mag_h*1.25,d=mag_dia,center=true);                
    }            
  }                
}  
 
module mount()
{
     difference()
     {
         union()
         {
             // pivot mount
                cylinder(mag_h+1,d=mount_dia,center=true);       
         }
         
         union()
         {
             // magnet hole
             cylinder(mag_h,d=mag_dia);
             
             for(ang=[0:360/bump_count:360])
                rotate([0,0,ang])
                    translate([0,bmp_rng_dia/2,0])
                        cylinder(mag_h,d=2*bmp_dia);
         }
     }
 }

// create desired part based on selection
if (part == "boom") {
    boom();
} else {    
    mount();
}
