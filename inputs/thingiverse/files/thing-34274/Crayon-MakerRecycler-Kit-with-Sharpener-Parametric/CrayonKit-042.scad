/*
 * Crayon Recycling Kit
 *
 * by Alex Franke (CodeCreations), Jul 2012
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
 * 
 * WARNING: This is still a work in progress! The code and geometrystill needs to be cleaned up. 
 * 
 * INSTRUCTIONS: This kit includes a mold and sharpener. Many aspects of the kit are parametric
 *   (such as number of crayons, size, length, sharpening angle, etc), but they will all form a 
 *   triangular crayon, which is easier to cast, easy to hold, and easier to stack. This shape 
 *   also won't roll off the drawing surface, and promotes a proper pencil grip.  
 *     You may need to tweak the settings a bit for better results. 
 * 
 *   CRAYONS: 
 *   1) Choose some values in the "User-defined values" section, render, and print. Make note of  
 *      the volume of plaster that will be required for the mold. (It will be echoed out below  
 *      the rendering in OpenSCAD.)
 *   2) Place the mold onto a flat, nonporous surface (like glass) and coat the exposed surfaces 
 *      with a thin layer of Vaseline, dish soap, or liquid bees wax to act as a release agent. 
 *   3) Mix some Plaster of Paris, and pour over the printed postive mold to the top. Carefully 
 *      vibrate the surface to help settle the plaster and release any bubbles. You can often do 
 *      this by simply "drumming" around it with your hands. Level the top, and allow the plaster 
 *      to dry completely. 
 *   4) Once dry, cut the sprues at the bottom against at the wall. This will leave the wall on 
 *      outside of the negative mold, which can protect it a bit. Then remove the printed positive 
 *      mold from the plaster, and coat the inside with dish soap to act as a release agent. 
 *   5) Use a metal cup and a pair of vice grips to carefully and slowly melt broken pieces of 
 *      crayon with a torch or stove burner, and pour the melted wax into the crayon molds. You 
 *      can also put various sizes and shapes of crayon pieces into the mold and pour over them 
 *      to join them together with some melted crayons. 
 * 
 *   SHARPENER:
 *   6) Print the Sharpener Guide (sharpenerGuide()) and Cutter (cutter()) parts, which are 
 *      sized to fit the crayons you made. Be sure you use at least a couple of perimeters on 
 *      the cutter, because you're going to sand it down in the next step to sharpen it.
 *   7) Using a file or sandpaper, clean up the sharpening edge and file or sand down the angled 
 *      flat surface until the cutting surface is sharp. 
 *   8) Snap the guide into position, insert crayon, and carefully turn to sharpen. If it's too 
 *      tight with the dedents, just flip it around and try it the other way. You can add a little 
 *      bit of crayon wax as a lubricant if necessary to make it easier to turn. 
 * 
 * THING: http://www.thingiverse.com/thing:34274
 * 
 * v0.42, Nov 11, 2012: Initial release. 
 *
 * TODO: 
 *   * Auto layout
 *   * Left-handed verision (meantime, just mirror the cutter) 
 */

/////////////////////////////////////////////////////////////////////////////
// User-defined values... 
/////////////////////////////////////////////////////////////////////////////

// Crayon properties 
height             = 12;   // The height of the crayons
length             = 75;   // The length of the crayons 
topRadius          = 1.5;  // The radius of the rounded corner at the top 

// Crayon mold properties 
numberOfMolds      = 3;    // The number of crayons in the mold 
spaceBetweenMolds  = 5;    // The distance between each crayon in the mold 
perimeterDistance  = 7;    // The distance between the crayons and the mold wall  
foundationHeight   = 7;    // The final height of the mold wall (thickness of mold)  
wallThickness      = 0.9;  // The thickness of the mold wall  
sprueHeight        = 0.4;  // Height of the sprues that join the crayons
sprueWidth         = 1.5;  // Width of the sprues that join the crayons  
numberOfSprues     = 4;    // Number of sprues joining crayons 

// Cutter properties 
sharpAngle         = 30;   // The sharpening angle (how sharp the point is)   
housingThickness   = 3;    // The thickness of the outer housing wall of the cutter
dedentRadius       = 1;    // Radius of detent that locks the guide into the cutter
insertionDepth     = 6;    // Distance guide is inserted into cutter body 
innerShaftHeight   = 10;   // Distance from bottom of guide to start of taper 
bladeAngle         = 30;   // The angle at which the blade cuts into the crayon (opening size) 
bladeTranslation   = 1;    // The distance the blade overlaps the material 
bladeLength        = 5;    // The width of the blade extending into the housing 
clearance          = 1;  // The amount of clearance between the guide and the cutter housing

// Guide properties 
minimumThickness   = 2;    // Minimum radial thickness of the guide


/////////////////////////////////////////////////////////////////////////////
// Calculate some useful values, and echo out useful information to user
/////////////////////////////////////////////////////////////////////////////

width = height*tan(30)*2;
//bladeAngle = 90+atan((39-20)/(0-8));

moldsWidth = numberOfMolds*width + (numberOfMolds-1)*spaceBetweenMolds; 
shellWidth = moldsWidth + 2*perimeterDistance + 2*wallThickness;
shellLength = length + 2*perimeterDistance + 2*wallThickness; 
shellHeight = height + foundationHeight;

// Get the volume of the plaster that needs to be mixed up
vol = ( ( shellWidth - 2*wallThickness ) * ( shellLength - 2*wallThickness ) * shellHeight ) 
	- ( numberOfMolds * ( (width*height)/2 ) * length ); 
echo( "Required volume of plaster (estimated)" );
echo( str("   mL: ", vol/1000 ) );
echo( str("   oz: ", (vol*0.033814)/1000 ) );
echo( str("  cup: ", (vol*0.033814)/(1000*8) ) );


/////////////////////////////////////////////////////////////////////////////
// The Code... 
/////////////////////////////////////////////////////////////////////////////

// The mold 
translate([-60,0,0]) 
mold();

// The cutter
cutter( height, clearance, housingThickness, dedentRadius, minimumThickness, sharpAngle,
	insertionDepth, innerShaftHeight, bladeAngle, bladeTranslation, bladeLength ); 

// The guide
translate([-11,17,0]) 
sharpenerGuide( height, topRadius, sharpAngle, clearance, dedentRadius, minimumThickness );


// Experimental support for hobby knife blade, though this isn't really necessary. 
// bladeHousing( height, clearance, housingThickness, dedentRadius, minimumThickness ); 


/////////////////////////////////////////////////////////////////////////////
// Modules... (Don't change this stuff unless you know what you're doing.) 
/////////////////////////////////////////////////////////////////////////////

//echo( "height", height ); 
//echo( "side", sideLength(height) ); 
//echo( "radius", guideRadius(height) ); 

module cutter(height, clearance, housingThickness, dedentRadius, minimumThickness, sharpAngle, 
	insertionDepth, innerShaftHeight, bladeAngle, bladeTranslation, bladeLength ) {

	//tipFlat = 30; 

	shaftRadius = guideRadius( height+clearance );
	barrelRadius = shaftRadius + minimumThickness; 
	outerRadius = barrelRadius + housingThickness; 
	crayonRadius = guideRadius( height ); 
	coneHeight = shaftRadius/tan(sharpAngle); 

	totalHeight = insertionDepth+innerShaftHeight+coneHeight - bladeTranslation; 

	hypotenuse = coneHeight / cos(sharpAngle); 

	cutoffHeight = (shaftRadius)/tan(sharpAngle); 

	// echo( crayonRadius, shaftRadius, barrelRadius, outerRadius );

	translate([0,0,totalHeight])
	rotate([180,0,0]) 

	union() {

		difference() {
			cylinder(h=totalHeight,r=outerRadius);
	
			// outer barrel 
			translate([0,0,-1]) 
				cylinder(h=insertionDepth+1,r=barrelRadius);
	
			// groove 
			translate([0,0,insertionDepth-dedentRadius]) 
				rotate_extrude() {
					translate([barrelRadius,0,0]) 
						circle(r=dedentRadius, $fn=10);
				}
	
			// inner shaft
			translate([0,0,insertionDepth-.25]) 
				cylinder(h=innerShaftHeight+.5,r=shaftRadius);
	
			// cone
			translate([0,0,insertionDepth+innerShaftHeight])
				cylinder(h=coneHeight,r1=shaftRadius, r2=0);
	
			// tip
	 		translate([0,0,insertionDepth+innerShaftHeight+cutoffHeight]) 
				cylinder(h=coneHeight-cutoffHeight,r=shaftRadius+clearance-minimumThickness);
	
			// gap
			intersection() {
				translate([0,0,insertionDepth+innerShaftHeight+coneHeight-bladeTranslation]) 
					rotate([180-sharpAngle,0,0]) 
						rotate([0,0,bladeAngle]) 
							translate([-outerRadius*2,0,-outerRadius*2])
								cube([outerRadius*4,outerRadius*4,hypotenuse*4]);
	
				translate([0,0,-.5])
					cylinder(h=totalHeight+1,r=outerRadius+1);
	
			}
		}

		// blade
		intersection() {
			translate([0,0,insertionDepth+innerShaftHeight+coneHeight-bladeTranslation]) 
				rotate([180-sharpAngle,0,0]) 

					linear_extrude(height=hypotenuse) 
						polygon(points=[	[0,0],
										[bladeLength,tan(bladeAngle)*bladeLength],
								        	[bladeLength,0]]);

			translate([0,0,-1])
				cylinder(h=insertionDepth+innerShaftHeight+coneHeight,r=outerRadius+1);
		}
	}
}


// This is the captive nut module I use in several of my designs. 
module captiveNut( nutSize, setScrewHoleDiameter=3, 
	depth=10, holeLengthTop=5, holeLengthBottom=5 )
{
	render()
	union() {
		nut( nutSize ); 
	
		if ( depth > 0 ) 
			translate([depth/2,0,0]) 
				cube( [depth, nutSize[0], nutSize[1]], center=true );
	
		translate([0,0,-(nutSize[1]/2)-holeLengthBottom]) 
			cylinder(r=setScrewHoleDiameter/2, h=nutSize[1]+holeLengthTop+holeLengthBottom, $fn=15);
	}
}

module bladeHousing( triangleHeight, clearance, housingThickness, 
	dedentRadius, minimumGuideThickness ) {

	length = 40; 
	
	radius = guideRadius( triangleHeight+clearance ) + minimumThickness; 

	echo( "radius", radius );
	insertionDepth = 4; 

	difference() {
		cylinder(h=length,r=radius+clearance+housingThickness);

		translate([0,0,length-insertionDepth]) 
			cylinder(h=insertionDepth+1,r=radius+clearance);

		translate([0,0,length-insertionDepth+dedentRadius]) 
			rotate_extrude() {
				translate([radius+clearance,0,0]) 
					circle(r=dedentRadius, $fn=10);
			}

		translate([0,0,length-insertionDepth-5]) 
			cylinder(h=6,r=radius+clearance-minimumThickness);

		translate([0,0,-.5+18]) 
			cylinder(h=length-insertionDepth-4-18,r2=radius+clearance-minimumThickness, r1=2);


		translate([0,0,18]) 
		rotate([90+sharpAngle,0,0]) 
			translate([-1.5,19/2 - 10,26/2 -.25]) 
			cube([14,39,26], center=true);

		color("red")
		translate([0,0,18]) 
		rotate([90+sharpAngle,0,0]) 
		blade(); 
	}
}


module testBladeAngle2() {
	rotate([sharpAngle,0,0]) 
	rotate([0,0,sharpAngle-bladeAngle]) 
	blade(); 
		color("green")
		rotate([-90,0,0]) 
		cylinder(h=50, r=5);
}


module testBladeAngle() {
	rotate([0,00,0]) 
	rotate([0,80,sharpAngle-bladeAngle]) 
	blade(); 

	color("green")
	rotate([-90,0,0]) 
	cylinder(h=50, r=5);
}


function sideLength(height) = height*tan(30)*2;
function guideRadius(height) = sideLength(height)*(sqrt(3)/3);

module sharpenerGuide( height, topRadius, sharpAngle, clearance, dedentRadius, minimumThickness ) {

	guideLength = 15; 

	sideLength = sideLength(height+clearance);
	radius = guideRadius(height);

	union() {

		// Holder 
		difference() {
			cylinder(h=guideLength, r=radius+minimumThickness);
			
			translate([-sideLength/2, radius/2, -0.5]) 
				crayon(height+clearance, guideLength+1, topRadius);
		}

		// Dedents 
		for( x=[0:2] ) {
			rotate([0,0,x*120]) 
				translate([radius+minimumThickness, 0, dedentRadius]) 
					sphere(r=dedentRadius, $fn=15);

		}
	} 
}

module blade() {

	thickness = 0.5; 

	translate([-8,-20,-thickness/2])
	difference() {
		linear_extrude(height=thickness)
			polygon(points=[[1,0],[1,10],[0,15],[0,39],[8,20],[8,15],[7,10],[7,0]]);
	
		hull() {
			translate([1+3,4.25+1.25,-0.5]) 
				cylinder(h=thickness+1, r=1.25, $fn=15);
			translate([1+3,9-1.25,-0.5]) 
				cylinder(h=thickness+1, r=1.25, $fn=15);
		}
	}
}

module mold() {
	union() {
		// Crayon forms
		translate([-moldsWidth/2,-length/2,0]) 
		for ( x=[0:numberOfMolds-1] ) {
			translate([x*(width+spaceBetweenMolds),0,0])
			rotate([-90,0,0]) 
			crayon(height, length, topRadius);
		}
	
		// Shell
		translate([0,0,shellHeight/2]) 
		difference() {
			cube([shellWidth, shellLength, shellHeight], center=true);
			cube([shellWidth-(2*wallThickness), shellLength-(2*wallThickness), shellHeight+1], 
				center=true);
		}
	
		// Sprues
		translate([0,-length/2,sprueHeight/2]) 
		for( x=[0:numberOfSprues-1] ) {
			translate([0,x*(length/(numberOfSprues-1)),0]) 
			cube( [shellWidth, sprueWidth, sprueHeight], center=true );
	
		}
	}
}

module crayon( height, length, topRadius ) {

	offset = topRadius/sin(30);
	w = height*tan(30);
	s = topRadius/tan(30); 
	x = s*sin(30); 
	y = s*cos(30); 

	translate([w,-height,0]) 
	linear_extrude(height=length)
	union() {
		translate([0,offset]) 
			circle(r=topRadius, $fn=20);
		polygon( points=[[-x,y],[x,y],[w,height],[-w,height]] ); 
	}
}

