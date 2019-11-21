//  A wrench for aeropress
//  Lincoln Probst Feb 21, 2018
//  copyright Feb 21, 2018 GPL license
//
//  Some credit to https://www.thingiverse.com/thing:598964
//  wstein on thingiverse and his version uploaded Dec 14, 2014.
//  
//  Description:
//  This is to make it easy to remove the aeropress filter holder.
//  I decided to design one in SCAD because the one I found on 
//  Thingiverse didn't have an SCAD design, only the STL, and I wanted to 
//  test my SCAD abilities and work with some of the parameters
//
// Updates:
// 1.01) Make center ring a bit bigger so it fits.
// 1.02) Make the notch Depth bigger (amount extra from making center ring bigger)
// 1.02) Slant notch so it is easy to lock into the ring. (the slant is from
// notchDepth to notchDepth/1.5).
// 1.03) Made fragmentSize adjustable.
// 1.03) Made customizable settings separate from other parts.
// 1.03) Fix settings so notches take into account wrench width a little.

// ----------------  Customizable settings ---------------------
// fingerGripNum:
// Number of cylinder cutouts for finger grips
// I like 8 as it is symetrical with number of 
// notches so looks nice.

// Number of cutouts for finger grips.
fingerGripNum=8;//[4,5,6,7,8,9,10,11,12,13,14,15,16]

// wrenchWidth:
// How wide the wrench is.
// as in the width around the the widest point.
// this may not be entirely accurate after going with torus
// and the extra cutouts.  Larger is wider though.

// Width of the wrench, approximately.
wrenchWidth = 5;//[4,5,6,7,8,9,10]

// fragmentSize:
// size of the fragments for smoothness of object.
// This determines quality of the curves.  
// I had it up to 200, but really, 50 is good enough and 
// may be prefered.

//Size of fragments for the $fn on some of the curved objects. Larger is smoother but can take FOREVER to render.
fragmentSize = 50;//[15,25,40,50,75,100,200]

//end of customizable bits and bobs.-----------------------------

cylinderDia = 69.00; // The actual measured amout is : 68.34 Diameter of the aeropress filter holder
                     // so this is .66mm larger than it needs to be

notchHeight = 5.00; // Height of notches in filter

notchWidth = 3.65;  // Actual: 3.75 Width of notches, slightly narrow for easy fit
                    // 3.65 worked for me.

notchDepth = 3.4;  // Depth of the notch.  Makes the radius smaller.
                    // made this deeper to account for enlarging the cylinderDia
                    // by the extra 0.66.  I can't remember the actual measured
                    // depth-- something like 2.8 or 2.75.

notchNum = 16; // number of notches in the full circle.
               //  This is actual number and shouldn't change for aeropress


smallAmt = 0.01; // so that there is not an invisible wall
                 // When subtracting two objects you don't want the 
                 // wall in the exact same spot.



// Make the Object!!

// make it so flat part is flat on Z plane so when using the STL 
// it is already nicely flat on the Z and centered, ready to slice and print.
translate ([0,0,notchHeight/2]) rotate(a=[180,0,0])
// create object
union() {
    //myRing();  // old version.  I like torus better.
    mySpokes();  // spokes
    myTorusRing();  // ring
}

// Modules for creating the different parts!
module myTorusRing(){
    difference() {
        // create torus
        rotate_extrude(convexity = 10, $fn=fragmentSize) {
            translate([cylinderDia/2+notchDepth,0,0])
            circle(r=wrenchWidth, $fn=fragmentSize);
        }
        // make finger grip things
        for(i=[0:fingerGripNum]){
            rotate(a=[0,0,i*(360/fingerGripNum)])
            translate([cylinderDia/2+notchDepth+3*wrenchWidth,0,0]) cylinder(cylinderDia, 3*wrenchWidth,3*wrenchWidth, center=true, $fn=fragmentSize);
        }
        // subtract out the center
        cylinder(cylinderDia, cylinderDia/2, cylinderDia/2, center=true, $fn=fragmentSize);
        // subtract out the top so will lay flat and give a better print.
            translate([0,0,notchHeight+((cylinderDia*4)/2)]) cube([cylinderDia*4, cylinderDia*4,cylinderDia*4+notchHeight], center=true);
    }
}


// this was where I started, simple cylinders.  I like the torus better.
module myRing(){
    difference() {
        union () {
        cylinder(notchHeight*2,cylinderDia/2+wrenchWidth,cylinderDia/2+wrenchWidth, center=true);
        }
    cylinder(notchHeight*2+smallAmt, cylinderDia/2, cylinderDia/2, center=true);
    }
}

// these end up being used to create the notches.
module mySpokes(){
    difference () {
        for(i=[0:notchNum]){
        rotate(a=[0,0,i*(360/notchNum)]) 
            cube(size =[cylinderDia+wrenchWidth/2,notchWidth, notchHeight], center=true);
        }
    cylinder(notchHeight+smallAmt, (cylinderDia/2)-notchDepth/1.5, (cylinderDia/2)-notchDepth, center=true);
    }
}