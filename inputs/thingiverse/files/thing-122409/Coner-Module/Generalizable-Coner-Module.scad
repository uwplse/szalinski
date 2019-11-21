/*

    Base Spacer Design Author: Andy Kirby, Email: andy@kirbyand.co.uk, Date: 27/12/2010
    Coner Remix for Thingiverse Customizer: George W Childs for cone module, Date: 14/7/2013.
    Licensing GPL V3 (http://www.gnu.org/licenses/quick-guide-gplv3.html).

    Script to create a customizable plastic cone or spacer, thin spacers can also be used as washers.

*/

//  3 = triangular, 4 = pyramidal

// $fn smoothness, > smoothing, 3 = triangular, 4 = pyramidal
smoother = 30; // [3:160]

// Height of Coner
conerh = 10; // [1:100]

// Hole Diameter - Bottom
holeidb = 5; // [0:100]

// Hole Diameter - Top
holeidt = 3; // [0:100]

// Coner Outer Diameter - Bottom
conerodb = 15; // [1:100]

// Coner Outer Diameter - Top
conerodt = 5; // [1:100]

coner(conerh,holeidb,holeidt,conerodb,conerodt);
//coner(10,5,3,10,5);

/* The generalized coner module */
module coner(conerh,holeidb,holeidt,conerodb,conerodt) {
   // Do not change precalculated factors
   holerb = holeidb / 2;
   holert = holeidt / 2;
   conerorb = conerodb / 2;
   conerort = conerodt / 2;
   difference() {
     // from the spacer solid
        cylinder(h=conerh, r1=conerorb, r2=conerort, center=false, $fn=smoother);
     // subtract the hole 
        translate([0,0,-.05]) cylinder(h=conerh+.1, r1=holerb, r2=holert, center=false, $fn=smoother);
	//  This is an optional hole for a screw to hold the coner in place on a rod
//#		translate([0,0,conerh/2]) rotate([0,90,0]) cylinder(r=1.6,h=conerorb*2,center=true,$fn=8);

   }
}

