/*
 * Parametric Switch Panel
 *
 * by Alex Franke (CodeCreations), Aug-Sep 2012
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
 * 
 * DESCRIPTION: This creates a bank of printable switches with one or more throw position 
 *     that can be wired up as SPST, SPDT, SPTT, DPST, DPDT, DPTT, etc. 
 * 
 * VIDEO: http://www.youtube.com/watch?v=QbMod_f7g1A
 * 
 * INSTRUCTIONS: Choose some values in the "User-defined values" section, render, and print. 
 *     Experiment to get a smooth-acting switch -- several factors affect the action, including 
 *     the thickness of the panel, the fulcrum supports, the dedent height, and others. Insert
 *     the levers through the front of the panel using the extra width provided at the center 
 *     of the holes. Insert a piece of filament or a screw to allow the lever to pivot. 
 *       The wire channels are experimental. They're intended to provide space to route wires 
 *     for the switch The "Plate Contact" seems to work okay, though. To use it, fasten a piece
 *     of metal to the end of the lever using super-glue (CA glue) or a screw. (I use a piece 
 *     cut from a common brass fastener, like the ones shown here: http://amzn.com/B004LWSFAK.)
 *     Feed bare wires through the holes in the fulcrum structure, bend the wires around, and 
 *     twist it back onto itself so that the metal contact bridges the gap when the switch is 
 *     activated. 
 *       You can also attach one of the wires to the center tab. 
 * 
 * RELEASE HISTORY: 
 *   * v0.69, Sep 15, 2012: Renders mounting holes with specified diameter and [x,y] insets. 
 *     Outputs mounting hole distances, panel size, and hole size. Added Prusa snap-on mounting 
 *     brackets. 
 *   * v0.42, Sep 12, 2012: Initial release. 
 *
 * TODO: 
 *   * Automatically arrange the panel and switches for printing 
 *   * Option for different switch settings (angle, positions, etc) per switch
 *   * Rename user-defined variables so they make a bit more sense
 *   * Allow each side to be wired independently 
 *   * Clean up the code
 *   * Prevent/warn if paddles are too big or switches are too close together
 *   * Rounded corners for panel 
 *   * Levers will collide warning
 */

/////////////////////////////////////////////////////////////////////////////
// User-defined values... 
/////////////////////////////////////////////////////////////////////////////

// General Switch Parameters:
//   These parameters define the general properties of the switches on the panel. A number 
// of factors go into making a smooth-acting switch, including dedent height, fulcrumWidth, 
// and even panel thickness. It can take a little experimentation. 
positions              = 2;      // The number of positions for each switch  
throwAngle             = 30;     // The angle the switch will move up and down from the position 
                                 //   perpendicular to the panel.  
$fn                    = 25;     // General curve quality


// Panel Parameters:
//   These parameters define the properties of the switch panel. The sizes of the holes are 
// defined by the leverProfile and the throwAngle. 
switches               = [3,1];  // The number of switches for each axis, e.g. 3,2 will create a 
                                 //    panel that is 3 switches wide and 2 high (6 switches total)
distanceApart          = [12,12]; // The amount of padding between each switch in X and Y directions
margin                 = [17,9]; // Extra material to add to the outside of the panel in X and Y
holeClearance          = 0.85;   // The total hole clearance (horizontal or vertical) 
panelThickness         = 2.00;   // How thick the panel material is. 
mountingHoleDiameter   = 3.5;    // Diameter of holes at corners for mounting, or zero for none 
mountingHoleInset      = [3,3];  // Distance from edge of mounting hole to edge of panel in X and Y


// Paddle Parameters:
//   The paddle is the part you handle when flipping the switch on and off.
paddleThickness        = 1.5;    // The thickness of the paddle
paddleWidth            = 15;     // The width of the paddle
paddleLength           = 19;     // The length of just the paddle portion of lever 
paddleRoundRadius      = 2;      // The rounding radius at the corners of the paddle


// Lever Parameters:
//   The lever extends through the hole in the panel. Its length is defined primarily by 
// the fulcrum settings (below), but can be extended a bit to prevent the paddle from hitting
// the panel. 
leverProfile           = [5,5];  // The [X,Y] profile if looking straight at a vertical switch
leverExtention         = 2.5;    // Extra length so the paddle doesn't hit the panel 
dedentHeight           = 1.0;    // The height of the bump that holds the switch's position


// Fulcrum Parameters:
//   The "fulcrum" is the two rounded extensions that hold the lever in place and 
// allow it to rotate. 
fulcrumDiameter        = 3;      // The diameter of the HOLE in the fulcrum.   
fulcrumThickness       = 5;      // The radial thickness of the material (affects diameter) 
fulcrumWidth           = 3.5;    // The linear width of the material on either side of the lever 


// Wire Parameters: 
//   Use these settings to define the wire you'll be using to to wire up the switch. 
bareWireDiameter       = 0.5;    // The diameter of the bare (stripped) wire 
wireInsulationDiameter = 0.9;    // The diameter of the insulated wire
bareWireProtrusion     = 0.25;   // Percent of bare wire diameter that protrudes above channel


// Plate Contact Parameters: 
//   The "fulcrum" is the two rounded extensions that hold the lever in place and 
// allow it to rotate. The plate lip helps to hold the metal plate in place if screwed. 
includePlateContact    = true;   // Set to true to render the plate contact option
plateLipExtension      = 1;      // The distance the lip extends 
plateLipThickness      = 1;      // The thickness of the lip 
plateScrewHoleDiameter = 1;      // The diameter of the hole used to fasten the plate to the lever
plateScrewHoleDepth    = 5;      // The depth of the hole used to fasten the plate to the lever


// Wire channels:
//   This is experimental -- I don't think I have the print quality to pull this off yet 
// for the size switches I want, but I'll try to re-address it later. It's basically a 
// different option for wiring the switches. 
includeWireChannels    = false; 


// Rod Clip-related parameters 
//      These parameters define the rod clip side of the connector -- the part that snaps onto
//   the smooth or threaded rod. By default, it's set up to snap nicely and hold tightly on my 
//   setup with 8mm rods. 

rodDiameter        = 8.25;   // The diameter of the rod you're snapping it onto 
clipThickness          = 2.5;    // The thickness of the material that snaps onto the rod1
clipLength             = 8;     // The length of the connector (length of rod that will be covered) 
clipOpening            = 6.75;   // The size of the opening where it snaps onto the rod
rodPlaneSeparation = 11.75; // the distance apart of two parallel planes constrained by the two rods going through one half of a single frame vertex. 
clipExtenderThickness = 2; // The thickness of the material that extends out from the clip
clipExtenderOffset = 20; // The distance from the center vertical bar to the center of the mounting holes



/////////////////////////////////////////////////////////////////////////////
// Calculated values... 
/////////////////////////////////////////////////////////////////////////////

// constants 
X=0; 
Y=1; 
Z=2; 

fulcrumPosition = panelThickness + fulcrumDiameter/2; 
holeSize = [
	leverProfile[X] + holeClearance,
	( fulcrumPosition*tan(throwAngle) + (leverProfile[Y]/2)/cos(throwAngle) + holeClearance ) * 2
	];
leverLength = leverExtention + (fulcrumPosition)/cos(throwAngle) + fulcrumDiameter/2 + fulcrumThickness;
panelSize = [ 
	switches[X]*(holeSize[X]) + (switches[X]-1)*(distanceApart[X]) + 2*margin[X],
	switches[Y]*(holeSize[Y]) + (switches[Y]-1)*(distanceApart[Y]) + 2*margin[Y],
	panelThickness
	];

function roundTo( value, places ) = round(value * pow(10,places)) / pow(10,places);

// Trace out sizes of panel and holes, and other useful information  
echo( str( "Final panel size: X=", roundTo(panelSize[X],2), ", Y=", roundTo(panelSize[Y],2), 
	", Z=", roundTo(panelSize[Z],2) ) ); 
echo( str( "Total hole size: X=", roundTo(holeSize[X],2), ", Y=", roundTo(holeSize[Y],2) ) ); 
echo( str( "Lever base length (no lip): ", roundTo(leverLength,2) ) ); 
echo( str( "Lever total length (with paddle, but no lip): ", roundTo(leverLength+paddleLength,2) ) ); 
//echo( str( "Lever swing length (with paddle, from fulcrum): ", roundTo(leverLength+paddleLength,2) ) ); 

// Warn user when things don't make sense e.g. levers will collide 



/////////////////////////////////////////////////////////////////////////////
// The code... (Use this to position the switches for printing.) 
/////////////////////////////////////////////////////////////////////////////

translate([0,0,panelThickness/2]) 
	panel();

translate([-15,-33,0]) 
for( i=[0:switches[X]-1], j=[0:switches[Y]-1] ) {
	translate([(paddleWidth+2)*i,(leverLength+paddleLength+2)*j,0]) 
		lever();
}

//debugMountingClipsInPlace();
//debugLeversInPlace();

// Renders two top clips (long and short), plus one side clip
translate([20,25,clipLength/2]) {
	topMountingClip(true);
	translate([-12,10,0]) 
		topMountingClip(false);
	translate([-37,8,0]) 
		rotate([0,0,-90]) 
		sideMountingClip(clipExtenderOffset, rodPlaneSeparation);
}

// Renders one top clip (long) and two side clips. 
*translate([23,30,clipLength/2]) {
	topMountingClip(true);
	translate([-12,10,0]) 
		sideMountingClip(clipExtenderOffset, rodPlaneSeparation);
	translate([-31,10,0]) 
		sideMountingClip(clipExtenderOffset, rodPlaneSeparation);
}



/////////////////////////////////////////////////////////////////////////////
// The modules... (Don't change this stuff unless you know what you're doing.)
/////////////////////////////////////////////////////////////////////////////

module debugLeversInPlace() {

	centerOnHole = [leverExtention + (fulcrumPosition)/cos(throwAngle),leverProfile[Y]/2]; 
	centerOnRow = [(distanceApart[Y]+holeSize[Y])/2, panelThickness+fulcrumDiameter/2];
	centerOnColumn = (distanceApart[X]+holeSize[X])/2;

	color("green")
	for( i=[-1,1], j=[-1,1], k=[-1,1] ) {
		translate([centerOnColumn*j,centerOnRow[X]*i,centerOnRow[Y]]) 
			rotate([90 - throwAngle*i,0,0]) 
				translate([0,-centerOnHole[X],-centerOnHole[Y]]) 
					lever();
	}
}

module debugMountingClipsInPlace() {
	translate([	-panelSize[X]/2+mountingHoleInset[X]+mountingHoleDiameter/2,
				rodDiameter/2+clipThickness+panelSize[Y]/2,
				clipExtenderThickness/2+panelThickness]) 
		rotate([-90,0,90])
			color("green")
				topMountingClip( true );

	for( i=[-1,1] )
	translate([	clipExtenderOffset+panelSize[X]/2-mountingHoleInset[X]-mountingHoleDiameter/2,
				i*(panelSize[Y]/2-mountingHoleInset[Y]-mountingHoleDiameter/2),
				rodPlaneSeparation+clipExtenderThickness/2+panelThickness]) 
		rotate([0,-90,90])
			color("green")
				sideMountingClip(clipExtenderOffset, rodPlaneSeparation); 
}

module sideMountingClip( offsetX, offsetZ ) {
	difference() {
		union() {
			rodClamp(rodDiameter, clipThickness, clipLength, clipOpening);
	
			translate([	-((rodPlaneSeparation-rodDiameter/2+clipExtenderThickness/2)/2 
							+ rodDiameter/2),
						0,0]) 
				cube([	rodPlaneSeparation-rodDiameter/2+clipExtenderThickness/2,
						clipExtenderThickness,
						clipLength], center=true);
			translate([	-rodPlaneSeparation,
						(offsetX+clipExtenderThickness/2+mountingHoleDiameter)/2
							- clipExtenderThickness/2
						,0]) 
				cube([	clipExtenderThickness,
						offsetX+clipExtenderThickness/2+mountingHoleDiameter,
						clipLength], center=true);
		}
	
		translate([-rodPlaneSeparation,clipExtenderOffset,0])
			rotate([0,90,0]) 
				cylinder(h=offsetX+1, r=mountingHoleDiameter/2, center=true);

	}
}

module topMountingClip( long ) {

	length = long 
		? panelSize[Y]+clipThickness
		: clipThickness + mountingHoleInset[Y] + mountingHoleDiameter*1.5; 

	difference() {
		union() {
			rodClamp(rodDiameter, clipThickness, clipLength, clipOpening);
			
			translate([-(length/2 + rodDiameter/2),0,0]) 
				cube([length,clipExtenderThickness,clipLength], center=true);
		}

		translate([	-( rodDiameter/2+clipThickness+mountingHoleDiameter/2+mountingHoleInset[Y] ),
					0,0])
			rotate([90,0,0]) 
				cylinder(h=clipExtenderThickness+1, r=mountingHoleDiameter/2, center=true);

		if ( long ) {
			translate([	-( rodDiameter/2+clipThickness-mountingHoleDiameter/2
							+panelSize[Y]-mountingHoleInset[Y] ), 0,0])
				rotate([90,0,0]) 
					cylinder(h=clipExtenderThickness+1, r=mountingHoleDiameter/2, center=true);
		}
	}
}

module lever() {

	union() {

		// Paddle
		translate([0,-paddleLength/2,paddleThickness/2]) 
		hull() {
			for(i=[-1,1], j=[-1,1]) 
				translate([(paddleWidth/2-paddleRoundRadius)*i,(paddleLength/2-paddleRoundRadius)*j,0]) 
					cylinder(h=paddleThickness, r=paddleRoundRadius, center=true);
		}
	
		// lever
		difference() {
			leverBase(leverLength);
	
			translate([0,leverExtention + (fulcrumPosition)/cos(throwAngle),leverProfile[Y]/2]) 
			rotate([0,90,0]) 
			cylinder(h=leverProfile[X]+dedentHeight*2+1, r=fulcrumDiameter/2, center=true);
			
		}
	}
}

module leverBase() {
	difference() {
		union() {
			translate([0,leverLength/2,leverProfile[Y]/2]) 
				cube([leverProfile[X], leverLength, leverProfile[Y]], center=true);
	
			for(i=[-1,1]) {
				translate([
					i*leverProfile[X]/2,
					leverLength - (fulcrumDiameter/2 + fulcrumThickness)/2,
					leverProfile[Y]/2]) 
				rotate([90,0,0]) 
				cylinder(h=fulcrumDiameter/2 + fulcrumThickness, r=dedentHeight, center=true);
			}
	
			translate([0,0.05,paddleThickness-0.05]) // avoid self-intersecting error
			rotate([180,-90,0]) 
			quarterCylinder(h=leverProfile[X], r=leverProfile[Y]-paddleThickness);

			// If we're using a contact plate, this will help hold it in place 
			if ( includePlateContact ) {
				translate([0,leverLength + plateLipExtension/2,plateLipThickness/2]) 				
					cube([leverProfile[X], plateLipExtension, plateLipThickness], center=true);
			}
		}

		// contact plate screw holes
		if ( includePlateContact ) {
			translate([	0,
						leverLength-(plateScrewHoleDepth+1)/2+1,
						plateLipThickness + (leverProfile[Y]-plateLipThickness)/2]) 				
				rotate([90,0,0]) 
					cylinder(h=plateScrewHoleDepth+1, r=plateScrewHoleDiameter/2, center=true);

			// Also trim off dedents to make room for the wires 
			for(i=[-1,1]) {
				translate([	i*(leverProfile[X]+dedentHeight)/2,
							leverLength-fulcrumThickness/4+0.5,
							leverProfile[Y]/2 ])
				cube([dedentHeight,fulcrumThickness/2 +1,dedentHeight*2], center=true);
			}
		}


		// Holes for wire channels
		if ( includeWireChannels ) {
			translate([0,leverLength*0.75,leverProfile[Y]/2]) 
			rotate([0,90,0]) 
			cylinder(h=leverProfile[Y] + dedentHeight*2 + 1, r=wireInsulationDiameter/2, center=true); 

			for(i=[-1,1]) {
				translate([
					i* (leverProfile[X]/2 + dedentHeight - bareWireDiameter/2 
						+ bareWireDiameter*bareWireProtrusion ),
					leverLength - (leverLength*0.25 + 1)/2 + 1,
					leverProfile[Y]/2]) 
				cube([bareWireDiameter,leverLength*0.25 + 1,bareWireDiameter], center=true);
			}
		}
	}
}

module quarterCylinder(h, r) {
	difference() {
		cylinder(h=h, r=r, center=true);
		translate([0,-(r+1)/2,0]) 
			cube([r*2+1,r+1,h+1], center=true);
		translate([-(r+1)/2,(r+1)/2-0.25,0]) 
			cube([r+1,r+1,h+1], center=true);
	}
}

module panel() {
	// Panel and holes 
	difference() {
		union() {
			cube(panelSize, center=true);

			// Fulcrum supports
			translate([
				-(panelSize[X]-2*margin[X]-holeSize[X])/2,
				-(panelSize[Y]-2*margin[Y]-holeSize[Y])/2,
				0
				]) {
				for( i=[0:switches[X]-1], j=[0:switches[Y]-1] ) {
					translate([i*(holeSize[X]+distanceApart[X]),j*(holeSize[Y]+distanceApart[Y]),0]) 		
						for(k=[-1,1]) 
							translate([k*(fulcrumWidth+holeSize[X])/2,0,0]) 
							rotate([0,0,-90*k]) 
							translate([0,0,panelThickness/2]) 
							rotate([90,0,0]) 
							translate([0,fulcrumDiameter/2,0]) 
							fulcrum();
				}
			}
		}

		translate([-(panelSize[X]-2*margin[X])/2,-(panelSize[Y]-2*margin[Y])/2,0]) 
		translate([holeSize[X]/2,holeSize[Y]/2,0]) 
		for( i=[0:switches[X]-1], j=[0:switches[Y]-1] ) {
			translate([i*(holeSize[X]+distanceApart[X]),j*(holeSize[Y]+distanceApart[Y]),0]) {
				cube([holeSize[X],holeSize[Y],panelThickness+1], center=true);

				// Poke a hole so we can fit the lever in
				cube([leverProfile[X], leverProfile[Y], panelThickness+1], center=true);

				for(i=[-1,1]) {
					translate([i*leverProfile[X]/2,0,fulcrumDiameter/4-0.5]) 
					cylinder(h=panelThickness+fulcrumDiameter/2+1, r=dedentHeight, center=true);
				}
			}
		}

		// Render mounting holes if required
		if( mountingHoleDiameter>0 ) {
			for( x=[-1,1], y=[-1,1] ) {
				translate([	x*(panelSize[X]/2-mountingHoleInset[X]-mountingHoleDiameter/2), 
							y*(panelSize[Y]/2-mountingHoleInset[Y]-mountingHoleDiameter/2),
							0 ]) 
					cylinder(r=mountingHoleDiameter/2, h=panelThickness+1, center=true);
			}

			// echo distances
			echo( str("Mounting hole distances (on centers): ", 
				roundTo(panelSize[X]-mountingHoleInset[X]*2-mountingHoleDiameter, 2),
				"mm horizontal, and ", 
				roundTo(panelSize[Y]-mountingHoleInset[Y]*2-mountingHoleDiameter, 2),
				 "mm vertical.") ); 
		} 
	}
}




module fulcrum() {

	// Rename some stuff to make the variables more meaningful in scope. 
	lateralThickness = fulcrumWidth; 
	radialThickness = fulcrumThickness; 
	holeDiameter = fulcrumDiameter; 
	radiusTotal = radialThickness+holeDiameter/2;
	radiusCenterMaterial = (radialThickness + holeDiameter)/2;

	difference() {
		union() {
			cylinder(h=lateralThickness, r=radiusTotal, center=true);	
			translate([0,-radiusTotal/2, 0]) 
				cube([
					radiusTotal*2,
					radiusTotal,
					lateralThickness], center=true);	
		}
	
		// remove center hole 
		cylinder(h=lateralThickness+1, r=holeDiameter/2, center=true);	

		// Trim it to the center hole (hold should be flush with the panel
		translate([0,-(radialThickness+1)/2 - holeDiameter/2,0]) 
			cube([radiusTotal*2+1, radialThickness+1, lateralThickness+1], center=true);

		// Cut out dedents
		rotate([0,0,-throwAngle]) 
		for(i=[0:positions-1]) {
			rotate([0,0,(throwAngle*2)/(positions-1) * i])
			translate([0,radiusTotal/2,(lateralThickness+holeClearance)/2]) {
				rotate([90,0,0]) 
					cylinder( h=radiusTotal+1, r=dedentHeight, center=true);

				// Wire channels
				if ( includeWireChannels ) {
					// through-hole for wire
					translate([0,0,-(lateralThickness+1)/2]) 
						cylinder(r=wireInsulationDiameter/2, h=lateralThickness+1, center=true);

					// wire channel
					translate([
							0,
							radiusTotal/4+0.5,
							-dedentHeight + bareWireDiameter*bareWireProtrusion]) 
						cube([bareWireDiameter,radiusTotal/2 + 1,bareWireDiameter*2], center=true);
				}

				// Wire channels for plate contacts
				if ( includePlateContact ) {
					translate([0,radiusTotal/2-radialThickness/4,-(lateralThickness+1)/2] )
						cylinder(h=lateralThickness+1, r=wireInsulationDiameter/2, center=true);
				}
			}
		}
	}
}

// taken from my SnapConnector.scad
module rodClamp(rodDiameter=8, thickness=2, length=8, opening=6) {
	dist = sqrt( pow(rodDiameter/2,2) - pow(opening/2,2) );
	difference() {
		cylinder(h=length, r=rodDiameter/2 + thickness, center=true);
		cylinder(h=length+1, r=rodDiameter/2, center=true);
		translate([dist + (rodDiameter/2 + thickness +1)/2,0,0]) 
			cube([rodDiameter/2 + thickness +1,rodDiameter + thickness*2 +1,length+1], center=true);
	}
}
