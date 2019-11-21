// Simple magnifying telescope
// Eric Landahl 3/13/19

$fn = 300; // 30 for low res, 300 very high res
f1 = 100;  // focal length of first lens (green)
f2 = -50;  // focal length of second lens (green)
f3 = 50; // focal length of spectrometer entrance lens
f4 = 50; // focal length of spectrometer collimation lens
f5 = 100; // focal length of spectrometer final lens
dIn = 1; // initial beam diameter
pipeLength = 100; // Light pipe length
pipeDiameter = 2; // Light pipe diameter
pipeAngle = 75; //Light pipe acceptance angle (deg)
ramanDistance = 15; // distance away from light pipe to collect Raman
pipeGap = 50; // gap before/after Raman collection optics
ramanReflectorSize = 25; // Reflection mirror radius
a = 1/2.4; // Grating groove spacing (um)
thetaIn = 45; // Incident angle on grating
lambda1 = 0.560; // Raman wavelength 1 (um)
lambda2 = 0.570; // Raman wavelength 2 (um)
lambda3 = 0.580; // Raman wavelength 3 (um)
lambda0 = 0.590; // Incident laser wavelength (um)
theta1 = asin((lambda1/a)-sin(thetaIn)); //Diffracted 1
theta2 = asin((lambda2/a)-sin(thetaIn));
theta3 = asin((lambda3/a)-sin(thetaIn));
theta0 = asin((lambda0/a)-sin(thetaIn)); 


d2= (.65)*pipeDiameter*0.7*(1+2*tan(pipeAngle)); //beam diameter after off axis parabola

color([0,0.5,0,1]) 
translate([0,0,-25])  // Incident beam
    cylinder(25,dIn,dIn);  
    
color([0,0.5,0,1])     
cylinder(50,dIn,abs(dIn*f2/f1),center=false);  // Between lenses
   
color([0,0.5,0,1]) 
translate([0,0,f1+f2])  // Exiting beam
    cylinder(2*ramanDistance+2*pipeGap+pipeLength,abs(dIn*f2/f1),abs(dIn*f2/f1));  
    
translate([0,0,0])  // De-magnifying positive lens
    lens(1.4,f1,12.5,1,1);
    
translate([0,0,f1+f2])  // De-magnifying negative lens
    lens(1.4,f2,12.5,.1,1);

// Raman Reflector on-axis parabola
difference(){
     translate([0,0,(f1+f2+pipeGap+pipeLength+2*ramanDistance)*2+9.5])
mirror([0,0,180])
color("gold")    //Raman reflector
     translate([0,0,f1+f2+pipeGap+pipeLength+2*ramanDistance+9.5])
difference(){
    translate([0,0,-10])
    cylinder(15,15,15);
    paraboloid(25, 10, 0, 1, 100);
}
translate([0,0,(f1+f2+pipeGap+pipeLength+2*ramanDistance)])
cylinder(20,pipeDiameter); // Exit hole
}
  
 // Off Axis Parabola Raman Collector  
difference(){
color("gold")
     translate([0,-12.5,f1+f2+pipeGap])
difference(){
    translate([0,10,-10])
    cylinder(15,15,15);
    paraboloid(25, 10, 0, 1, 100);
}
translate([0,0,f1+f2])
cylinder(100,pipeDiameter); // Exit hole
}

// Lenses and Gratings in Spectrometer
translate([0,0,f1+f2+pipeGap-3]){
    rotate([90,0,0]){
      translate([0,0,f3])
        lens(1.4,f3,25,1,1);  // Entrance lens
      translate([0,0,f3+f3])
        difference(){
        color("black",1)  // Entrance slit
            cube([25,25,3],center=true);   
            cube([10,2,4],center=true);
        }
      translate([0,0,f3+f3+f4])
        lens(1.4,f3,25,1,1);  // collimating Lens
      translate([0,0,2*f3+2*f4]){
        rotate([thetaIn,0,0]){
         color("gray",1) 
            translate([0,0,5])
            cube([25,40,10],center=true); 
        } // End Rotate Grating
        rotate([270-theta3,0,0]){ // Pick theta2 as center
         translate([0,0,f5])
            lens(1.4,f3,35,1,1);
         translate([0,-2,2*f5-1])
            cube([2,25,2],center=true);
        }  
    }}}

     
//Raman
color("red",0.5)  // Inside light pipe
translate([0,0,f1+f2+pipeGap+ramanDistance])
    cylinder(pipeLength,pipeDiameter*0.7,pipeDiameter*0.7);
color("red",0.5)  // Exiting light pipe
translate([0,0,f1+f2+pipeGap+ramanDistance+pipeLength])
    cylinder(ramanDistance+9.5,pipeDiameter*0.7,pipeDiameter*0.7*(1+2*tan(pipeAngle)));
color("red",0.5)  // Entering light pipe
 translate([0,0,f1+f2+pipeGap-9.5])
    cylinder(ramanDistance+9.5,pipeDiameter*0.7*(1+2*tan(pipeAngle)),pipeDiameter*0.7);   
color("red",0.5)
translate([0,0,f1+f2+pipeGap-3]){
    rotate([90,0,0]){
        cylinder(50,d2,d2);
        translate([0,0,f3])
            cylinder(f3,d2,0);
        translate([0,0,f3+f3]) //
          cylinder(f4,0,d2*(f4/f3));
        translate([0,0,f3+f3+f4])
          cylinder(f4,d2*(f4/f3),d2*(f4/f3));  
        translate([0,0,2*f3+2*f4]){ // grating
         rotate([270-theta0,0,0]){
          cylinder(f5,d2*(f4/f3),d2*(f4/f3));
          translate([0,0,f5])
             cylinder(f5,d2*(f4/f3),0);
         }
         rotate([270-theta1,0,0]){
          cylinder(f5,d2*(f4/f3),d2*(f4/f3));
          translate([0,0,f5])
             cylinder(f5,d2*(f4/f3),0);
         }
         rotate([270-theta2,0,0]){ 
          cylinder(f5,d2*(f4/f3),d2*(f4/f3));
          translate([0,0,f5])
             cylinder(f5,d2*(f4/f3),0);
         }
         rotate([270-theta3,0,0]){ 
          cylinder(f5,d2*(f4/f3),d2*(f4/f3));
          translate([0,0,f5])
             cylinder(f5,d2*(f4/f3),0);
         }
        }
    }  // End rotate spectrometer
}

// Light Pipe
color("gold",0.4) 
translate([0,0,f1+f2+pipeGap+ramanDistance])
    cylinder(pipeLength,2*pipeDiameter,2*pipeDiameter);


module lens(reflectiveIndex,focalLength,aperture,thickness,isBicurved){

//Adapted from https://www.thingiverse.com/OsomBlossom/designs
//Reflective index of used material, n. Pick between 1.0 and 1.7.
//Needed focal length. Take negative for diverging lens.
//Lens diameter  //[10.0:100.0]
//Minimal distance between optical surfaces. //[0.0:10.0]
//Pick if biconvex or biconcave lens needed.  //[0:1]
    
/* [Hidden] */
$fn = 100;

curvature = abs((reflectiveIndex-1)*focalLength*(isBicurved+1));
segmentHeight = curvature-sqrt(curvature*curvature - 0.25*aperture*aperture);

thickness2 = thickness/(1+isBicurved);
/*helping variable, which allows to mirror generated part*/

module convex(){
translate([0,0,thickness2]){
union()
{
difference()
{
    translate([0,0,-curvature+segmentHeight]){sphere(curvature);}
    translate([0,0,-2*curvature]) {cylinder(r=curvature,h=2*curvature,center=false);}
}
    translate([0,0,-thickness2]) {cylinder(r=0.5*aperture,h=thickness2,center=false);}
}
}
}
module concave(){
translate([0,0,thickness2]){
difference()
{
    translate([0,0,-thickness2]) {cylinder(r=0.5*aperture,h=curvature+thickness2,center=false);}
    translate([0,0,curvature]){sphere(curvature);}
}
}
}

module 2convex(){
union(){
convex();
mirror ([0,0,1]){convex();}
}
}
module 2concave(){
union(){
concave();
mirror ([0,0,1]){concave();}
}
}
if (focalLength>0 && isBicurved==0) {color([1,1,1,.8]) convex();}
if (focalLength>0 && isBicurved==1) {color([1,1,1,.8]) 2convex();}
if (focalLength<0 && isBicurved==0) {color([1,1,1,.8]) concave();}
if (focalLength<0 && isBicurved==1) {color([1,1,1,.8]) 2concave();}
} // end lens module





//////////////////////////////////////////////////////////////////////////////////////////////
// Paraboloid module for OpenScad
//
// Copyright (C) 2013  Lochner, Juergen
// http://www.thingiverse.com/Ablapo/designs
//
// This program is free software. It is 
// licensed under the Attribution - Creative Commons license.
// http://creativecommons.org/licenses/by/3.0/
//////////////////////////////////////////////////////////////////////////////////////////////

module paraboloid (y, f, rfa, fc, detail){
	// y = height of paraboloid
	// f = focus distance 
	// fc : 1 = center paraboloid in focus point(x=0, y=f); 0 = center paraboloid on top (x=0, y=0)
	// rfa = radius of the focus area : 0 = point focus
	// detail = $fn of cone

	hi = (y+2*f)/sqrt(2);								// height and radius of the cone -> alpha = 45° -> sin(45°)=1/sqrt(2)
	x =2*f*sqrt(y/f);									// x  = half size of parabola
	
   translate([0,0,-f*fc])								// center on focus 
	rotate_extrude(convexity = 10,$fn=detail )		// extrude paraboild
	translate([rfa,0,0])								// translate for fokus area	 
	difference(){
		union(){											// adding square for focal area
			projection(cut = true)																			// reduce from 3D cone to 2D parabola
				translate([0,0,f*2]) rotate([45,0,0])													// rotate cone 45° and translate for cutting
				translate([0,0,-hi/2])cylinder(h= hi, r1=hi, r2=0, center=true, $fn=detail);   	// center cone on tip
			translate([-(rfa+x ),0]) square ([rfa+x , y ]);											// focal area square
		}
		translate([-(2*rfa+x ), -1/2]) square ([rfa+x ,y +1] ); 					// cut of half at rotation center 
	}
}