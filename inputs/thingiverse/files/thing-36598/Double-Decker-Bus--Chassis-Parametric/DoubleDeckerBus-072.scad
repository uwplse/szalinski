/*
 * Double Decker Bus
 *
 * by Alex Franke (CodeCreations), Dec 2012
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
 * 
 * INSTRUCTIONS: Choose some values in the "User-defined values" section, render, and print. 
 * 
 * v0.72, Dec 4, 2012: Fixed some bugs, separated axle diameter and axle through-hole diameter
 * v0.69, Dec 3, 2012: New parameters control wheel well gap and axle clip thickness. Fixed a 
 *     couple of bugs. 
 * v0.42, Dec 2, 2012: Initial Release.
 *
 * TODO: 
 *   * Clean up code. 
 */

/////////////////////////////////////////////////////////////////////////////
// User-defined values... 
/////////////////////////////////////////////////////////////////////////////

// Size-related properties  
length              = 60;   // Length of the bus shell 
width               = 20;   // Width of the bus shell 
height              = 30;   // Height of the bus shell (does not include wheels)
thickness           = 2.0;  // Thickness of the bus shell 

// Shell-related properties 
roundRadius         = 4;    // Rounding radius of bus shell 
trimRadius          = 0.5;  // Radius of trim lines around shell 
windowHeight        = 3.5;  // Height of windows
stileWidth          = 3;    // Width of stiles between windows 

// Wheel-related properties 
wheelDiameter       = 7;    // Diameter of the wheels
wheelWidth          = 4;    // Width of the wheels
wheelWellGap        = 1;    // Size of gap between wheel and shell 
frontWheelOffset    = 4;    // Distance of front wheels from front of bus
backWheelOffset     = 11;   // Distance of back wheels from back of bus

// Chassis-related properties 
baseClipPlay        = 0.5;  // Amount of vertical play in the chassis clips
baseClipCatchHeight = 0.75; // Distance the clip catch will extend over the chassis on the bottom
baseClipStopHeight  = 2;    // Distance the clip will extend over the chassis on the inside
baseClipWidth       = 5;    // width of the chassis clips 
shellGap            = 1;    // Size of the gap between the chassis and the shell

// Axle assembly-related properties (e.g. axle and pillow blocks) 
axleDiameter        = 2.0;  // Diameter of axle
axleOpening         = 2.5;  // Inner diameter of axle housing pillow block 
axleClipWidth       = 3;    // Width of the pillow block that holds the axle 
axleClipThickness   = 1.25; // Thickness of material surrounding the axle 
axleHeight          = 0.5;  // Height of axle from bottom on chassis 

$fn                 = 15;   // Overall curve quality


/////////////////////////////////////////////////////////////////////////////
// Calculated values... 
/////////////////////////////////////////////////////////////////////////////

wellRadius = wheelDiameter/2+wheelWellGap; 


/////////////////////////////////////////////////////////////////////////////
// The code... 
/////////////////////////////////////////////////////////////////////////////

busPlate();            // Render all parts, plated and ready for printing
//body();              // Render just the body or shell
//base();              // Render just the chassis
//chassisAndTires();   // Render both the chassis and the wheels
//assembledBus();      // Render the "assembled" bus (useful for debugging) 


/////////////////////////////////////////////////////////////////////////////
// Modules... (Don't change this stuff unless you know what you're doing.)
/////////////////////////////////////////////////////////////////////////////

// Render the chassis and wheels only
module chassisAndTires() {

	// Wheels
	translate([-(wheelDiameter*3+6)/2,-(width+wheelDiameter)/2-2,0]) 
		for( x=[0:3])
			translate([x*(wheelDiameter+2),0,0]) 
					wheel();
	
	base(); 
}

// Render all parts, plated and ready for printing
module busPlate() {

	body(); 
	
	// Wheels
	translate([-(wheelDiameter*3+6)/2,-(width+wheelDiameter)/2-2,0]) 
		for( x=[0:3])
			translate([x*(wheelDiameter+2),0,0]) 
					wheel();
	
	translate([0,width+2,0]) 
		base(); 
}

// Render the assembled bus (useful for debugging) 
module assembledBus() {

	color("FireBrick")
	body(); 
	
	translate(0,0,20);
	
	// Wheels
	color("Black") 
	for( x=[length/2-wellRadius-frontWheelOffset,-length/2+wellRadius+backWheelOffset],
		 y=[-1,1])
		translate([x,y*width/2,height]) 
			rotate([90*y,0,0]) 
				wheel();
	
	color("gray")
	translate([0,0,height-thickness-axleDiameter/2-axleHeight]) 
	base(); 

}

// The clip that holds the chassis into the shell 
module baseClip() {
	translate([0,-baseClipCatchHeight-thickness/2-baseClipPlay/2,-baseClipWidth/2]) 
	linear_extrude(height=baseClipWidth)
		polygon(points=[
			[0,0],
			[shellGap,0],
			[shellGap+baseClipCatchHeight,baseClipCatchHeight],
			[shellGap,baseClipCatchHeight],
			[shellGap,baseClipCatchHeight+thickness+baseClipPlay],
			[shellGap+baseClipStopHeight,baseClipCatchHeight+thickness+baseClipPlay],
			[0,baseClipCatchHeight+thickness+baseClipPlay+shellGap+baseClipStopHeight]
			]);
}

// A single wheel 
module wheel() {
	difference() {
		cylinder(r=wheelDiameter/2, h=wheelWidth);
		translate([0,0,1]) 
			cylinder(r=axleDiameter/2, h=wheelWidth);
	}
} 

// The chassis
module base() {

	l = length-thickness*2-shellGap*2; 
	w = width-thickness*2-shellGap*2;

	difference() {
		hull()
			for(i=[-1,1],j=[-1,1]) 
				translate([((l/2)-roundRadius)*i,((w/2)-roundRadius)*j]) 
					cylinder(h=thickness, r=roundRadius);

		// wheel cutouts 
		for( x=[length/2-wellRadius-frontWheelOffset,-length/2+wellRadius+backWheelOffset],
			 y=[-1,1])
			translate([x,y*(width/2-(wheelWidth)/2),thickness/2]) 
				cube([wellRadius*2,wheelWidth+shellGap*2,thickness*2], center=true);
	}

	// axle clips 
	for( x=[length/2-wellRadius-frontWheelOffset,-length/2+wellRadius+backWheelOffset],
		 y=[-1,1])
		translate([x,y*((width-axleClipWidth)/2 - wheelWidth-shellGap),thickness]) 
			rotate([90,90,0]) 
				axleClip();
}

// A pillow block for the axle
module axleClip() {
	translate([-axleOpening/2-axleHeight,0,0]) 
	difference() {
		union() {
			difference() {
				cylinder(h=axleClipWidth, r=axleOpening/2 + axleClipThickness, center=true);
				translate([ (axleOpening/2 + thickness +1)/2+axleOpening/2,0,0]) 
					cube([axleOpening/2+thickness+1,axleOpening+thickness*2+1,axleClipWidth+1], 
						center=true);
			}

			translate([(axleOpening/2+axleHeight)/2,0,0]) 
				cube([axleOpening/2+axleHeight, axleOpening*2+thickness*3, axleClipWidth], center=true);
		}

		cylinder(h=axleClipWidth+1, r=axleOpening/2, center=true);
	}
}

// The body (shell) of the bus
module body() {

	windowSize = [(length-stileWidth*3)/6-stileWidth,width+1,windowHeight];
	doorSize = [windowSize[0]*0.70, width+trimRadius*2+1, height/2-wellRadius-trimRadius*3]; 
	driverSideWindowSize = [windowSize[0]*0.3,doorSize[1],doorSize[2]/2];
	frontWindowSize = [thickness+trimRadius+roundRadius+1,width-roundRadius,doorSize[2]*.75];
	grillHeight = height/2-trimRadius*4-frontWindowSize[2]; 
	baseClipHeight = height-thickness-axleDiameter/2-axleHeight+thickness/2; 

	union() {
		difference() {
			union() {
				shell(length, width, height, roundRadius); 
	
				// Trim 
				for (z=[roundRadius, roundRadius+windowSize[2]+trimRadius*2, 
					height/2, height/2+windowSize[2]+trimRadius*2, height-trimRadius])
					translate([0,0,z]) 
						trimH();
	
				// grill 
				translate([length/2,0,height-grillHeight/2-trimRadius*2]) 
				grill(grillHeight ); 
			}
			translate([0,0,thickness]) 
				shell(length-thickness*2, width-thickness*2, height, roundRadius); 
	
			// wheel wells
			translate([length/2-wellRadius-frontWheelOffset,0,height]) 
				rotate([90,0,0]) 
					cylinder(h=width+trimRadius*2+1, r=wellRadius, center=true);
			translate([-length/2+wellRadius+backWheelOffset,0,height]) 
				rotate([90,0,0]) 
					cylinder(h=width+trimRadius*2+1, r=wellRadius, center=true);
	
			// Top windows 
			translate([-length/2+windowSize[0]/2+ stileWidth*2,0,0]) 
				for(x=[0:5]) 
					translate([x*(windowSize[0]+stileWidth),0,roundRadius+trimRadius+windowSize[2]/2]) 
						cube(windowSize, center=true);
	
			// Bottom windows 
			translate([-length/2+windowSize[0]/2+stileWidth*2+windowSize[0]+stileWidth,0,0]) 
				for(x=[0:3]) 
					translate([x*(windowSize[0]+stileWidth),0,height/2+windowSize[2]/2+trimRadius]) 
						cube(windowSize, center=true);
	
			// Door
			translate([(length-doorSize[0])/2-roundRadius-stileWidth,0,(doorSize[2]+height)/2+trimRadius]) 
				cube(doorSize, center=true);
	
			// Driver Side Window
			translate([(length+driverSideWindowSize[0])/2-roundRadius-trimRadius,
				0,(driverSideWindowSize[2]+height)/2+trimRadius]) 
				cube(driverSideWindowSize, center=true);
	
			// Front Window
			translate([length/2,0,(height+frontWindowSize[2])/2+trimRadius]) 
				cube(frontWindowSize, center=true);
	
		}

		// Side clips
		for ( x=[length/2-wellRadius-frontWheelOffset-wellRadius-baseClipWidth/2,
					-length/2+wellRadius+backWheelOffset+wellRadius+baseClipWidth/2], y=[-1,1] )
			translate([x,y*(width/2-thickness), baseClipHeight]) 
				rotate([-90,0,-90*y]) 
					baseClip(); 

		// Front/back clips
		for ( x=[-1,1] )
			translate([(length/2-thickness)*x,0,baseClipHeight]) 
				rotate([-90,0,90+(90*x)]) 
					baseClip(); 
	}
}

// The grill 
module grill(height) {
	num = floor( (width-(2*roundRadius))/(2*trimRadius) ); 

	translate([0,-(2*trimRadius*num)/2,-height/2]) 
	for( y=[0:num] ) {
		translate([0,trimRadius*2*y,0]) 
		cylinder(r=trimRadius,h=height);
	}
}

// A horizontal piece of trim lines 
module trimH() {
	hull() {
		for(i=[-1,1],j=[-1,1]) {
			translate([(length/2-roundRadius)*i,(width/2-roundRadius)*j]) 
			rotate_extrude() 
			translate([roundRadius,0,0]) 
			circle(r=trimRadius);
		}
	}
}

// The rounded shell shape 
module shell(length, width, height, radius) {
	translate([0,0,radius]) 
	hull() {
		for(i=[-1,1],j=[-1,1]) {
			translate([((length/2)-radius)*i,((width/2)-radius)*j]) {
				sphere(r=radius);
				if ( height>radius*2 ) {
					cylinder(h=height-radius, r=radius);
				}
			}
		}
	}
}