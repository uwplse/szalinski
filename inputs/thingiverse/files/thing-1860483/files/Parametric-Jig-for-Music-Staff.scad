/*
 * Parallel Line Jig
 *
 * by Alex Franke (CodeCreations), Oct 2012
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
 * 
 * INSTRUCTIONS: Choose some values in the "User-defined values" section, render, and print.
 *   It works well to hold the jig between your thumb and index finger as you pull it across 
 *   the drawing surface.  
 * 
 * THING: http://www.thingiverse.com/thing:31061
 * 
 * v1.00, Oct 3, 2012: Initial release. 
 *
 * TODO: 
 *   * Include keyholes for hanging 
 */

/////////////////////////////////////////////////////////////////////////////
// User-defined values... 
/////////////////////////////////////////////////////////////////////////////
numberOfLines   = 5;    // Total number of pen holders
distanceApart   = 30;   // The distance between parallel lines

penDiameter     = 17;   // The diameter of the writing implement
clampHeight     = 50;    // The height of the writing implement grips  
clampThickness  = 2;    // The thickness of the material that grips the writing implement
gripLength      = 2.5;  // The distance the grips wrap around the writing implements

frameThickness  = 8;    // The thickness of the bars that attach the grips to the handle
frameLength     = 15;   // The distance the grips extend from the handle

handleHeight    = 20;   // The height of the handle
handleThickness = 7;    // The thickness of the handle
handleLength    = 40;   // The length of the handle
handleRadius    = 10;   // The radius of the curve on the upper corners of the handle

rotation        = 0;    // The amount the entire piece will be rotated on the print bed. 



endBarThickness = 7;
hookLength = 22;
hookWidth = 8;
hookPosition = distanceApart/2;
hookVerticalPartThickness = 10;

/////////////////////////////////////////////////////////////////////////////
// The code... 
/////////////////////////////////////////////////////////////////////////////

rotate([0,0,-90+rotation]) 
union() {

	clamps(); 
	
	translate([-penDiameter/2-clampThickness-frameLength,0,0]) 
		rotate([90,0,-90]) 
			handle();
    
    endBar();
    
    coupleOfHangingHooks();
}

module handle() {
	union() {
		translate([-handleLength/2,0,0]) 
			linear_extrude(height=handleThickness)
				polygon(points=[
					[0,0],
					[0,handleHeight-handleRadius],
					[handleRadius,handleHeight],
					[handleLength-handleRadius,handleHeight],
					[handleLength,handleHeight-handleRadius],
					[handleLength,0]
					]);

		for( i=[-1,1] ) {
			translate([(handleLength/2 - handleRadius)*i,handleHeight-handleRadius,0]) 
				difference() {
					cylinder(h=handleThickness, r=handleRadius);
					translate([0,-handleRadius/2,handleThickness/2]) 
						cube([handleRadius*2,handleRadius,handleThickness+1], center=true);
				}
		}

		translate([0,frameThickness/2,handleThickness/2]) 
		cube([distanceApart*(numberOfLines-1)+frameThickness,frameThickness,handleThickness], center=true);
	}
}

module clamps() {
	translate([-0.01, -((numberOfLines-1)*distanceApart)/2,0]) 
	for( i=[0:numberOfLines-1] ) {
		translate([0,distanceApart*i,0]) {
			union() {
				translate([0,0,0]) 
					rodClamp(penDiameter, clampThickness, clampHeight, penDiameter-gripLength);
				translate([-(frameLength+clampThickness+penDiameter)/2,0,frameThickness/2]) 
					cube([frameLength+clampThickness, frameThickness, frameThickness], center=true);
			}
		}
	}
}

// Taken from my SnapConnectors project
module rodClamp(rodDiameter=8, thickness=2, length=8, opening=6) {
	dist = sqrt( pow(rodDiameter/2,2) - pow(opening/2,2) );
	difference() {
		cylinder(h=length, r=rodDiameter/2 + thickness, center=true);
		cylinder(h=length+1, r=rodDiameter/2, center=true);
		translate([dist + (rodDiameter/2 + thickness +1)/2,0,0]) 
			cube([rodDiameter/2 + thickness +1,rodDiameter + thickness*2 +1,length+1], center=true);
	}
}



module endBar()
{
    rotate (90,0,0)
        translate ([0,penDiameter/5,clampHeight/2])
            cube([penDiameter*numberOfLines+(distanceApart-penDiameter)*(numberOfLines-1)+2*(clampThickness), penDiameter, endBarThickness], center=true);
}


module hangingHook(multiplier)
{
    translate ([penDiameter-2,hookPosition*multiplier,penDiameter/2+hookWidth*2+0.5])
		rotate ([0,0,90])
			cube([hookWidth,hookLength,7], center=true);
	
	translate ([hookLength+1,hookPosition*multiplier,penDiameter/2+hookWidth])
		rotate ([0,0,90])
			cube ([hookWidth,6,24], center=true);
}

module coupleOfHangingHooks()
{
	hangingHook(1);
	
	hangingHook(-1);
}


























