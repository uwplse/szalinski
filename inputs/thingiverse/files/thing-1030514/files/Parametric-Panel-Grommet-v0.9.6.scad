// Clean Parametric Panel Grommet
// Modified by Bill Gertz (billgertz) on 6 September 2015
// Version 0.9.5
// Threaded Library modules by syvwlch from the Threaded Library GitHub repository 
//     see: "https://github.com/syvwlch/Thingiverse-Projects/tree/master/Threaded Library"
// Fillet inspiration by LucidOne and the "Round 2 - Advanced Rounds" tutorial
//     see: "https://http://www.thingiverse.com/thing:6455" and
//          "http://www.iheartrobotics.com/2011/02/openscad-tip-round-2-of-3.html"
//
// Version  Author          Change
// -------  -------------   ----------------------------------------------------------------------------
//   0.6    billgertz       Fixed inside part screw length and removed countersink on outside part
//   0.7    billgertz       Added option to dress up outside part to hide thread ends
//   0.7.1  billgertz       Fixed hole radius on outside part flange for threads_hidden set to 'no'
//   0.7.2  billgertz       Fixed variable name threads_hidden in code so inside part length is correct
//   0.8    billgertz       Added grommet cover part (think big power plugs with narrower gauge cords)
//   0.8.1  billgertz       Added cover plug length and changed thickness to a seperate parameter
//   0.8.2  billgertz       Fixed so that no hole is made when cover hole is set to no
//   0.8.3  billgertz       Corrected spelling and screw pitch variable name
//   0.8.4  billgertz       Added inside fillet on cover plug join to cap for improved strength
//   0.9    billgertz       Revised for new flush cover style - flush style modifies outside part
//   0.9.1  billgertz       Backport of cap length for flanged style plug
//   0.9.2  billgertz       Added plug catch to inside part and plug
//   0.9.3  billgertz       Cleaned up central void on all parts to ensure complete seperation 
//                          by adding nudging
//   0.9.4  billgertz       Renamed Global to General section as work around for Customizer bug
//   0.9.5  billgertz       Fixed cover length for new end blind
//   0.9.6  billgertz       Fixed erronous plug length calculation for both plug styles
//                          Changed dimension stepping 0.1 from 1.0mm
//
// This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

// Local Variables and Calculations //////////////////////////////////////

/* [General] */
// create one of three parts
part = "inside";                    // [inside, outside, cover]
// edge finish type
edge_type = "fillet";              // [chamfer, fillet]
// select flush for flangeless cover
cover_style = "flush";             // [flush, flanged]
// press fit cover catch
cover_catch = "yes";               // [yes, no]

/* [Panel] */
//panel thickness (mm)
panel_thickness = 6;               // [2:0.1:40]
// panel hole outside diameter (mm)
hole_size = 40;                    //

/* [Grommet] */
// overall thickness of gommet wall (mm)
grommet_thickness = 3;             // [3:0:1:8]
// width of grommet flange (mm)
flange_width = 5;                  // [5:0.1:25]
// thichness of flange (mm)
flange_thickness = 2.3;            // [2:0.1:5]

/* [Cover] */
// hole in cover 
cover_hole = "yes";                 // [yes, no]
// hole diameter (mm)
cover_hole_size = 7;                // 
// plug wall thickness (mm)
cover_wall_thickness = 2;           // [1:0.1:4]

/* [Advanced] */
//axial distance from crest to crest (mm)
screw_pitch = 4;                   // [3:0.1:10]
// ratio between the height of the profile and the pitch (percent)
thread_height_to_pitch = 50;       // [20:80]
// line segments per full circle
resolution = 90;                   // [30:Rough,60:Coarse,90:Fine,180:Smooth,360:Insane]
// Chamfer angle (90 is vertical)
flange_chamfer_angle = 45;         // [90:None,75:High,60:Steep,45:Normal,30:Shallow,15:Low]
// Edge fillet area (percent)
fillet_percent = 100;              // [25:Corner,50:Half,75:Most,100:Entire]
// Partial flanged cover plug size (percent)
plug_length_percent = 100;         // [25:Quarter,50:Half,75:Three-Quarters,100:Full]
// Cover sizing for plug fit (mm)
undersize = 0.2;                   // [0.05:0.01:0.50]
// Catch sizing of undersize (percent)
catch_sizing_percent = 100;        // [125:Oversized,100:Normal,75:Three-Quarters,50:Half,25:Quarter] 
// Cover catch offset from flange or void top (mm)
cover_catch_offset = 0.8;          //

/* [Hidden] */
// let user know the inside diameter
echo(str("Inside diameter calculation:"));
echo(str("     Panel Hole OD:        ", hole_size, " mm"));
echo(str("   - 2 X Screw Height:     ", threadHeightToPitch*screw_pitch*2, " mm"));
echo(str("   - 2 X Wall Thickness:  ", grommet_thickness*2, " mm"));
echo(str("                                   ----"));
echo(str("   = Final Grommet ID:  ", insideHoleRadius*2, " mm"));
// outside part height (mm)
partLength = panel_thickness + flange_thickness;
// plug length ratio used in flanged style plug
plugLengthRatio = plug_length_percent/100;
// cover part height (mm)
plugLength = cover_style == "flush" ? panel_thickness + flange_thickness : (panel_thickness + flange_thickness*3) * plugLengthRatio;
//height to pitch (ratio)
threadHeightToPitch = thread_height_to_pitch/100;
// hole radius (mm)
holeRadius = hole_size/2;
// cover hole radius (mm)
coverHoleRadius = cover_hole_size/2;
// thickness of each grommet wall (mm)
grommetWallThickness = grommet_thickness/2;
// pitch height (mm)
halfThreadHeight = threadHeightToPitch*screw_pitch/2;
// nudge for artifact reduction and complete manifolds (mm)
nudge = 0.1;
// pitch nudged a bit to prevent threaded library beat artifacts (mm)
nudgedPitch = screw_pitch + nudge;
// radial distance from center to mid-profile (mm)
pitchRadius = holeRadius - grommetWallThickness - halfThreadHeight;
// inside hole radius after room taken up by grommet wall and screw pitch height (mm)
insideHoleRadius = pitchRadius - grommetWallThickness - halfThreadHeight;
// outside hole radius adjusted depending upon hidden threads selected (mm)
outsideHoleRadius = cover_style == "flush" ? insideHoleRadius - cover_wall_thickness - undersize : insideHoleRadius;
// inside part central void hole radius (mm)
insideVoidRadius = pitchRadius - halfThreadHeight - grommetWallThickness;
// plug radius (mm)
plugRadius = insideHoleRadius - undersize;
// flange cylinder radius (mm)
flangeRadius = holeRadius + flange_width;
// flange champfer pitch (ratio)
flangePitch = 1/(tan(flange_chamfer_angle));
// fillet area on edge (ratio)
filletRatio = fillet_percent/100;
// catch sizing (mm)
catchSize = undersize * catch_sizing_percent/100;

// alter flange bottom radius for chamfer
flangeBottomRadius = edge_type == "chamfer" ? flangeRadius - flangePitch*flange_thickness : flangeRadius;

// set cover radius to flange bottom radius if chamfer otherwise to computed fillet radius
tempCoverRadius = edge_type == "chamfer" ? flangeBottomRadius : flangeRadius - filletRatio*flange_thickness;
// set cover bottom radius like as with flange above
tempCoverBottomRadius = edge_type == "chamfer" ? coverRadius - flangePitch*flange_thickness : tempCoverRadius;
// override radius smaller if flush style
coverRadius = cover_style == "flush" ? insideHoleRadius - undersize : tempCoverRadius;
// override bottom radius to coverRadius if flush style (throw away chamfer)
coverBottomRadius = cover_style == "flush" ? coverRadius : tempCoverBottomRadius;
// set cover catch z offset as flange offset needs to be moved up the flange thickness
coverCatchOffset = cover_style == "flush" ? cover_catch_offset : flange_thickness + cover_catch_offset;

// End Local Variables and Calculations //////////////////////////////////

// Threaded_Library by sywlch ////////////////////////////////////////////
// Embedding normally included library required by Thingiverse Customizer

function norm(vector) = sqrt(vector[0]*vector[0]+vector[1]*vector[1]+vector[2]*vector[2]); 

function unitVector(vector) = vector / norm ( vector );

function barycenter(vector1, vector2, ratio) = (vector1*ratio + vector2*(1-ratio) );

module slice( 
	AShaftBottom,
	AShaftTop,
	BShaftBottom,
	BShaftTop,
	ABottom,
	ATop,
	BBottom,
	BTop,
	AThreadDepth,
	AThreadRatio=0.5,
	AThreadPosition=0.5,
	AThreadAngle=20,
	BThreadDepth,
	BThreadRatio=0.5,
	BThreadPosition=0.5,
	BThreadAngle=20,
	showVertices=false
)
{ 
	polyPoints=[
		AShaftBottom,
		AShaftTop,
		ATop,
		barycenter(ATop,ABottom,AThreadPosition+AThreadRatio/2) + unitVector(ATop-ABottom)*AThreadDepth/2*tan(AThreadAngle),
		barycenter(ATop,ABottom,AThreadPosition+AThreadRatio/2) - unitVector(ATop-ABottom)*AThreadDepth/2*tan(AThreadAngle) + unitVector(ATop-AShaftTop)*AThreadDepth,
		barycenter(ATop,ABottom,AThreadPosition),
		barycenter(ATop,ABottom,AThreadPosition-AThreadRatio/2) + unitVector(ATop-ABottom)*AThreadDepth/2*tan(AThreadAngle) + unitVector(ATop-AShaftTop)*AThreadDepth,
		barycenter(ATop,ABottom,AThreadPosition-AThreadRatio/2) - unitVector(ATop-ABottom)*AThreadDepth/2*tan(AThreadAngle),
		ABottom,
		BTop,
		barycenter(BTop,BBottom,BThreadPosition+BThreadRatio/2) + unitVector(BTop-BBottom)*BThreadDepth/2*tan(BThreadAngle),
		barycenter(BTop,BBottom,BThreadPosition+BThreadRatio/2) - unitVector(BTop-BBottom)*BThreadDepth/2*tan(BThreadAngle) + unitVector(BTop-BShaftTop)*BThreadDepth,
		barycenter(BTop,BBottom,BThreadPosition),
		barycenter(BTop,BBottom,BThreadPosition-BThreadRatio/2) + unitVector(BTop-BBottom)*BThreadDepth/2*tan(BThreadAngle) + unitVector(BTop-BShaftTop)*BThreadDepth,
		barycenter(BTop,BBottom,BThreadPosition-BThreadRatio/2) - unitVector(BTop-BBottom)*BThreadDepth/2*tan(BThreadAngle),
		BBottom,
		BShaftBottom,
		BShaftTop
	];

	polyTriangles=[
		[ 0,1,5], [1,2,3], [1,3,5], [0,5,7], [0,7,8],        // A side of shaft
		[1,0,12], [1,10,9], [1,12,10], [0,14,12], [0,15,14], // B side of shaft
		[0,8,15],                                            // bottom of shaft
		[1,9,2],                                             // top of shaft
		[3,2,10], [2,9,10], [4,3,10], [10,11,4],             // top of thread
		[6,4,11], [11,13,6],                                 // tip of thread
		[7,6,13], [13,14,7], [8,7,14], [14,15,8],            // bottom of thread
		[3,4,5], [5,4,6], [5,6,7],                           // A side of thread
		[11,10,12], [11,12,13], [12,14,13]                   // B side of thread
	];
	
	if (showVertices==true) for (i=[0:15]) translate(polyPoints[i]) color([1,0.5,0.5]) cube(0.25,true);
	
	polyhedron(polyPoints, polyTriangles);
}

module trapezoidThread(
	length=45,				 // axial length of the threaded rod
	pitch=10,				 // axial distance from crest to crest
	pitchRadius=10,			 // radial distance from center to mid-profile
	threadHeightToPitch=0.5, // ratio between the height of the profile and the pitch
						     // std value for Acme or metric lead screw is 0.5
	profileRatio=0.5,	     // ratio between the lengths of the raised part of the profile and the pitch
						     // std value for Acme or metric lead screw is 0.5
	threadAngle=30,			 // angle between the two faces of the thread
						     // std value for Acme is 29 or for metric lead screw is 30
	RH=true,				 // true/false the thread winds clockwise looking along shaft, i.e.follows the Right Hand Rule
	clearance=0.1,			 // radial clearance, normalized to thread height
	backlash=0.1,			 // axial clearance, normalized to pitch
	stepsPerTurn=24,	     // number of slices to create per turn,
	showVertices=false
)
{

	numberTurns=length/pitch-1;
		
	steps=stepsPerTurn*numberTurns;

	startLength=0.25;	// number of turns for profile to reach full height

	function 	profileRatio(i)=profileRatio*(1-backlash);

	function	threadAngle(i)=threadAngle;

	function	threadPosition(i)=(profileRatio(i) + threadHeightToPitch*(1+clearance)*tan(threadAngle(i)))/2;

	function 	threadHeight(i)=pitch*threadHeightToPitch*(1+clearance);

	function	pitchRadius(i)=pitchRadius;
	function	minorRadius(i)=pitchRadius(i)-(0.5+clearance)*pitch*threadHeightToPitch;

	function 	ShaftX(i)=0; 
	function 	ShaftY(i)=0;
	function 	ShaftZ(i)=pitch*numberTurns*i;
	
	function 	X(i)=ShaftX(i)+minorRadius(i)*cos(i*360*numberTurns);
	function 	Y(i)=ShaftY(i)+minorRadius(i)*sin(i*360*numberTurns);
	function 	Z(i)=ShaftZ(i);

	if (RH==true) {
	    for (i=[0:steps-1]) {
	        slice( 
	        	AShaftBottom= [ShaftX(i/steps),                  ShaftY(i/steps),                  ShaftZ(i/steps)                 ],
	        	AShaftTop=    [ShaftX((i+stepsPerTurn)/steps),   ShaftY((i+stepsPerTurn)/steps),   ShaftZ((i+stepsPerTurn)/steps)  ],
	        	BShaftBottom= [ShaftX((i+1)/steps),              ShaftY((i+1)/steps),              ShaftZ((i+1)/steps)             ],
	        	BShaftTop=    [ShaftX((i+1+stepsPerTurn)/steps), ShaftY((i+1+stepsPerTurn)/steps), ShaftZ((i+1+stepsPerTurn)/steps)],
	        	ABottom=      [X(i/steps),                       Y(i/steps),                       Z(i/steps)                      ],
	        	ATop=         [X((i+stepsPerTurn)/steps),        Y((i+stepsPerTurn)/steps),        Z((i+stepsPerTurn)/steps)       ],
	        	BBottom= 	  [X((i+1)/steps),                   Y((i+1)/steps),                   Z((i+1)/steps)                  ],
	        	BTop=         [X((i+1+stepsPerTurn)/steps),      Y((i+1+stepsPerTurn)/steps),      Z((i+1+stepsPerTurn)/steps)     ],
		
	        	AThreadDepth=  min(min(i,steps-i)/stepsPerTurn/startLength,1)*threadHeight(i), 
	        	AThreadRatio=  min(min(i,steps-i)/stepsPerTurn/startLength,1)*profileRatio(i),
	        	AThreadPosition=threadPosition(i),
	        	AThreadAngle=   threadAngle(i),
		
	        	BThreadDepth=   min(min(i+1,steps-i-1)/stepsPerTurn/startLength,1)*threadHeight(i+1),
	        	BThreadRatio=   min(min(i+1,steps-i-1)/stepsPerTurn/startLength,1)*profileRatio(i+1),
	        	BThreadPosition=threadPosition(i),
	        	BThreadAngle=   threadAngle(i+1),
	        	showVertices=showVertices
	      	);
	    }

	} else {
	    mirror([0,1,0])
            for (i=[0:steps-1]) {
	            slice( 
		            AShaftBottom= 	[ShaftX(i/steps),				ShaftY(i/steps),				ShaftZ(i/steps)				],
		            AShaftTop= 	[ShaftX((i+stepsPerTurn)/steps),	ShaftY((i+stepsPerTurn)/steps),	ShaftZ((i+stepsPerTurn)/steps)	],
		            BShaftBottom= 	[ShaftX((i+1)/steps),			ShaftY((i+1)/steps),			ShaftZ((i+1)/steps)			],
	            	BShaftTop= 	[ShaftX((i+1+stepsPerTurn)/steps),	ShaftY((i+1+stepsPerTurn)/steps),	ShaftZ((i+1+stepsPerTurn)/steps)	],
	            	ABottom= 		[X(i/steps),					Y(i/steps),					Z(i/steps)					],
	            	ATop= 		[X((i+stepsPerTurn)/steps),		Y((i+stepsPerTurn)/steps),		Z((i+stepsPerTurn)/steps)		],
    	        	BBottom= 		[X((i+1)/steps),				Y((i+1)/steps),				Z((i+1)/steps)				],
	            	BTop= 		[X((i+1+stepsPerTurn)/steps),		Y((i+1+stepsPerTurn)/steps),		Z((i+1+stepsPerTurn)/steps)		],
		
	            	AThreadDepth= 	min(min(i,steps-i)/stepsPerTurn/startLength,1)*threadHeight(i), 
		            AThreadRatio= 	min(min(i,steps-i)/stepsPerTurn/startLength,1)*profileRatio(i),
	            	AThreadPosition= 	threadPosition(i),
		            AThreadAngle= 	threadAngle(i),
		
	            	BThreadDepth= 	min(min(i+1,steps-i-1)/stepsPerTurn/startLength,1)*threadHeight(i+1),
		            BThreadRatio= 	min(min(i+1,steps-i-1)/stepsPerTurn/startLength,1)*profileRatio(i+1),
	            	BThreadPosition= 	threadPosition(i),
		            BThreadAngle= 	threadAngle(i+1),
	            	showVertices=showVertices
		        );
	        }
            
    }

	rotate([0,0,180/stepsPerTurn])
	    cylinder(
		    h=pitch,
		    r1=0.999*pitchRadius-(0.5+clearance)*pitch*threadHeightToPitch,
		    r2=0.999*pitchRadius-(0.5+clearance)*pitch*threadHeightToPitch,$fn=stepsPerTurn);

	translate([0,0,length-pitch])
	    rotate([0,0,180/stepsPerTurn])
	        cylinder(
	    	h=pitch,
	    	r1=0.999*pitchRadius-(0.5+clearance)*pitch*threadHeightToPitch,
	    	r2=0.999*pitchRadius-(0.5+clearance)*pitch*threadHeightToPitch,$fn=stepsPerTurn);
}

module trapezoidThreadNegativeSpace(
	length=45,               // axial length of the threaded rod
	pitch=10,                // axial distance from crest to crest
	pitchRadius=10,          // radial distance from center to mid-profile
	threadHeightToPitch=0.5, // ratio between the height of the profile and the pitch
                             // std value for Acme or metric lead screw is 0.5
	profileRatio=0.5,        // ratio between the lengths of the raised part of the profile and the pitch
                             // std value for Acme or metric lead screw is 0.5
	threadAngle=30,          // angle between the two faces of the thread
                             // std value for Acme is 29 or for metric lead screw is 30
	RH=true,                 // true/false the thread winds clockwise looking along shaft, i.e.follows the Right Hand Rule
	countersunk=0,           // depth of 45 degree chamfered entries, normalized to pitch
	clearance=0.1,           // radial clearance, normalized to thread height
	backlash=0.1,            // axial clearance, normalized to pitch
	stepsPerTurn=24	         // number of slices to create per turn
)
{

	translate([0,0,-countersunk*pitch])	
	    cylinder(
		    h=2*countersunk*pitch, 
		    r2=pitchRadius+clearance*pitch+0.25*pitch,
		    r1=pitchRadius+clearance*pitch+0.25*pitch+2*countersunk*pitch,
		    $fn=24
	    );

	translate([0,0,countersunk*pitch])	
	    translate([0,0,-pitch])
	        trapezoidThread(
		        length=length+2*pitch, 				        // axial length of the threaded rod 
		        pitch=pitch, 					            // axial distance from crest to crest
		        pitchRadius=pitchRadius+clearance*pitch, 	// radial distance from center to mid-profile
		        threadHeightToPitch=threadHeightToPitch, 	// ratio between the height of the profile and the pitch 
		        							                // std value for Acme or metric lead screw is 0.5
		        profileRatio=profileRatio, 			        // ratio between the lengths of the raised part of the profile and the pitch
		        							                // std value for Acme or metric lead screw is 0.5
		        threadAngle=threadAngle,			        // angle between the two faces of the thread
		                							        // std value for Acme is 29 or for metric lead screw is 30
		        RH=RH, 						                // true/false the thread winds clockwise looking along shaft
		        							                // i.e.follows  Right Hand Rule
		        clearance=-clearance,			        	// radial clearance, normalized to thread height
		        backlash=-backlash, 		        		// axial clearance, normalized to pitch
		        stepsPerTurn=stepsPerTurn 	        		// number of slices to create per turn
	        );	

	translate([0,0,length-countersunk*pitch])
	    cylinder(
		    h=2*countersunk*pitch, 
		    r1=pitchRadius+clearance*pitch+0.25*pitch,
		    r2=pitchRadius+clearance*pitch+0.25*pitch+2*countersunk*pitch,$fn=24,
		    $fn=24
	    );
}

module trapezoidNut(
    length=45,               // axial length of the threaded rod
	radius=25,               // outer radius of the nut
	pitch=10,                // axial distance from crest to crest
	pitchRadius=10,          // radial distance from center to mid-profile
	threadHeightToPitch=0.5, // ratio between the height of the profile and the pitch
                             // std value for Acme or metric lead screw is 0.5
	profileRatio=0.5,        // ratio between the lengths of the raised part of the profile and the pitch
                             // std value for Acme or metric lead screw is 0.5
	threadAngle=30,          // angle between the two faces of the thread
	                         // std value for Acme is 29 or for metric lead screw is 30
	RH=true,                 // true/false the thread winds clockwise looking along shaft, i.e.follows the Right Hand Rule
	countersunk=0,           // depth of 45 degree chamfered entries, normalized to pitch
	clearance=0.1,           // radial clearance, normalized to thread height
	backlash=0.1,            // axial clearance, normalized to pitch
	stepsPerTurn=24          // number of slices to create per turn
)
{
    trapezoidCylinder(
	    length=length,
	    radius=radius,
	    pitch=pitch,
	    pitchRadius=pitchRadius,
	    threadHeightToPitch=threadHeightToPitch,
	    profileRatio=threadHeightToPitch,
		threadAngle=threadAngle,
		RH=RH,
	    countersunk=countersunk,
	    clearance=clearance,
	    backlash=backlash,
	    stepsPerTurn=stepsPerTurn,
        cylinderResolution=6
	);
}

module trapezoidCylinder(
	length=45,               // axial length of the threaded rod
	radius=25,               // outer radius of the nut
	pitch=10,                // axial distance from crest to crest
	pitchRadius=10,          // radial distance from center to mid-profile
	threadHeightToPitch=0.5, // ratio between the height of the profile and the pitch
                             // std value for Acme or metric lead screw is 0.5
	profileRatio=0.5,        // ratio between the lengths of the raised part of the profile and the pitch
                             // std value for Acme or metric lead screw is 0.5
	threadAngle=30,          // angle between the two faces of the thread
                             // std value for Acme is 29 or for metric lead screw is 30
	RH=true,                 // true/false the thread winds clockwise looking along shaft, i.e.follows the Right Hand Rule
	countersunk=0,           // depth of 45 degree chamfered entries, normalized to pitch
	clearance=0.1,           // radial clearance, normalized to thread height
	backlash=0.1,            // axial clearance, normalized to pitch
	stepsPerTurn=24,         // number of slices to create per turn
    cylinderResolution=60    // number of steps in circle extruded to create cylinder
)
{
	difference() 
	{
		cylinder(
			h=length,
			r1=radius, 
			r2=radius,
			$fn=cylinderResolution
		);
		
		trapezoidThreadNegativeSpace(
			length=length,              // axial length of the threaded rod 
			pitch=pitch,                // axial distance from crest to crest
			pitchRadius=pitchRadius,    // radial distance from center to mid-profile
			threadHeightToPitch=threadHeightToPitch, // ratio between the height of the profile and the pitch 
                                        // std value for Acme or metric lead screw is 0.5
			profileRatio=profileRatio,  // ratio between the lengths of the raised part of the profile and the pitch
                                        // std value for Acme or metric lead screw is 0.5
			threadAngle=threadAngle,    // angle between the two faces of the thread
                                        // std value for Acme is 29 or for metric lead screw is 30
			RH=true,                    // true/false the thread winds clockwise looking along shaft
                                        // i.e. follows  Right Hand Rule
			countersunk=countersunk,    // depth of 45 degree countersunk entries, normalized to pitch
			clearance=clearance,        // radial clearance, normalized to thread height
			backlash=backlash,          // axial clearance, normalized to pitch
			stepsPerTurn=stepsPerTurn   // number of slices to create per turn
		);	
	}
}

// End Threaded_Library //////////////////////////////////////////////////
// Thanks to sywlch 

// Local Modules /////////////////////////////////////////////////////////

 module cylinderFillet (
     radius,             // radius of cylinder
     fillet_radius,      // smoothing curve radius
     resolution,         // line segments per unit circle
     pad = 0.1           // padding to ensure manifold object
 )
 {
     difference() {
	    rotate_extrude(convexity=10, $fn=resolution)
		    translate([radius-fillet_radius+pad,-pad,0])
			    square(fillet_radius+pad,fillet_radius+pad);
	    rotate_extrude(convexity=10, $fn=resolution)
		    translate([radius-fillet_radius,fillet_radius,0])
			    circle(r=fillet_radius,$fn=resolution);
    }
}

// End Local Modules /////////////////////////////////////////////////////

// Main Program //////////////////////////////////////////////////////////

// create directed part
if (part == "outside") {
    // join the flange to the threaded cylinder
    union() {
    
        difference() {
            
            // Create outside of flange with finished edge
            difference() {
                cylinder(
                    h = flange_thickness,
                    r1 = flangeBottomRadius, 
                    r2 = flangeRadius,
                    $fn = resolution
                );
                
                if (edge_type == "fillet") {
                    cylinderFillet(
                         radius = flangeRadius,                         // radius of cylinder
                         fillet_radius = flange_thickness*filletRatio,  // smoothing curve radius
                         resolution = resolution,                       // line segments per unit circle
                         pad = nudge                                    // added pad to ensure manifold objects
                     );
                }
                
            }
    
            // Remove center of flange disc for threaded cylinder
            translate(v=[0, 0, -nudge]) cylinder(
                h=plugLength - flange_thickness + nudge*2,
                r1 = outsideHoleRadius, 
                r2 = outsideHoleRadius,
                $fn = resolution
            );
        } 

        // Create threaded cylinder
        trapezoidCylinder(
        	length = partLength + nudge*2,  // axial length of the threaded rod 
        	pitch = nudgedPitch, 		    // axial distance from crest to crest
        	pitchRadius = pitchRadius,      // radial distance from center to mid-profile
	        threadHeightToPitch = threadHeightToPitch, // ratio between the height of the profile and the pitch
		      				                // std value for Acme or metric lead screw is 0.5
            radius = holeRadius,            // outer radius of the nut	
	        countersunk = 0.01, 		    // depth of 45 degree chamfered entries, normalized to pitch
	        stepsPerTurn = resolution,      // number of slices to create per turn
            cylinderResolution = resolution // number of segments to create extruded cirlce for cylinder
        );
    
    }
    
} else { 
    if (part=="inside") {
   
        // subract void model creating the joined flanged threaded inside grommet 
        difference() {
        
            // join the flanged disc to the threaded rod
            union() {
            
                // Create f=lange with finished edge
                difference() {
                    cylinder(
                        h=flange_thickness,
                        r1=flangeBottomRadius, 
                        r2=flangeRadius,
                        $fn=resolution
                    );
                
                    if (edge_type == "fillet") {
                        cylinderFillet(
                             radius = flangeRadius,                         // radius of cylinder
                             fillet_radius = flange_thickness*filletRatio,  // smoothing curve radius
                             resolution = resolution,                       // line segments per unit circle
                             pad = nudge                                  // added pad to ensure manifold objects
                         );
                    }
                
                }
  
                // create the threaded rod
                trapezoidThread( 
	                length = partLength,            // axial length of the threaded rod
	                pitch = nudgedPitch,            // axial distance from crest to crest
	                pitchRadius = pitchRadius,      // radial distance from center to mid-profile
	                threadHeightToPitch = threadHeightToPitch, // ratio between the height of the profile and the pitch
                                                               // std value for Acme or metric lead screw is 0.5
	                stepsPerTurn=resolution       // number of slices to create per turn
	            );
            }
            
            // create central void model
            translate (v=[0, 0, -nudge]) cylinder(
                h=partLength + nudge*2,
                r=insideVoidRadius, 
                $fn=resolution
            );
                
            // create the plug catch void if plug style
            if (cover_catch == "yes") {
                translate([0, 0, coverCatchOffset]) {
                    rotate_extrude(convexity=10, $fn=resolution) {
                        // move semicircle minus a small nudge so the void comes to surface
                        translate([insideVoidRadius - nudge/10, 0, 0]) {
                            resize([catchSize*1.5, flange_thickness/2, 0]) {
                                difference() {
                            
                                    circle (r=catchSize*1.5,$fn=resolution);
                         
                                    translate([-catchSize*1.5, 0, 0]) {
                                        square (
                                            size = catchSize*3,
                                            center = true
                                        );
                                    }
                                
                                }
                            }
                        }
                    }
                }
            }
        
        }
    
    } else {
   
        // subract hole and side cut model creating the cap 
        difference() {
        
            // add plug to create capped plug
            union() {
            
                // Create cover cap cylinder
                difference() {
                    cylinder(
                        h=flange_thickness,
                        r1=coverBottomRadius, 
                        r2=coverRadius,
                        $fn=resolution
                    );
                    
                    // ignore cap flange fillet if flush style requested
                    if (edge_type == "fillet" && cover_style == "flanged") {
                        cylinderFillet(
                             radius = coverRadius,                          // radius of cylinder
                             fillet_radius = flange_thickness*filletRatio,  // smoothing curve radius
                             resolution = resolution,                       // line segments per unit circle
                             pad = nudge                                    // added pad to ensure manifold objects
                         );
                    }
                
                }
  
                // finish the cover plug

                union() {
                    
                    //create just the plug
                    difference() {
                    
                        #cylinder(
                            h=plugLength,
                            r=plugRadius, 
                            $fn=resolution
                        );
                    
                        translate([0, 0, flange_thickness]) {
                            cylinder(
                                h=plugLength - flange_thickness + nudge,
                                r=plugRadius - cover_wall_thickness, 
                                $fn=resolution
                            ); 
                        } 
            
                    }   
 
                    // create fillet to join plug to cover cap
                    rotate_extrude(convexity=10, $fn=resolution) {
                        translate([plugRadius - cover_wall_thickness, flange_thickness, 0]) {
                            polygon(
                                points=[
                                    [nudge, -nudge],
                                    [-cover_wall_thickness - nudge, -nudge],
                                    [nudge, cover_wall_thickness]
                                ]
                            );
                        }       
                   }
                   
                               
                  // create catch to secure plug in inside part
                  if (cover_catch == "yes") {
                      translate([0,0,coverCatchOffset - nudge/10]) {
                          rotate_extrude(convexity=10, $fn=resolution) {
                              translate([plugRadius, 0, 0]) {
                                  resize([catchSize*1.5, flange_thickness/2, 0]) {
                                      difference() {
                            
                                          circle (r = catchSize,$fn = resolution);
                         
                                          translate([-catchSize,0,0]) {
                                              square (
                                                  size = catchSize*2,
                                                  center = true
                                              );
                                          }
                                  
                                      }
                                  
                                  }
                              }
                          }
                      }
                  }
                        
               }
                
            }
        
            if (cover_hole == "yes") {
                
                // create hole and side cut model
                translate([0,insideHoleRadius - (coverHoleRadius + cover_wall_thickness + undersize),0]) {
                
                    union() {
                    
                        translate(v=[0, 0, -nudge]) cylinder(
                            h=plugLength + nudge*2,
                            r=coverHoleRadius, 
                            $fn=resolution
                        );
                    
                        translate([-coverHoleRadius, 0, -nudge]) {
                            cube(
                                size = [cover_hole_size,cover_hole_size + (coverRadius - insideHoleRadius) + cover_wall_thickness, plugLength + flange_thickness + nudge*2]
                            );
                        }
                    
                    }
                    
                }
                
            }
        
        }

    }

}    