/*
 * Highly Configurable Wheel (One Wheel To Rule Them All)
 *
 * by Alex Franke (CodeCreations), Apr-Jun 2012
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
 * 
 * INSTRUCTIONS: Choose some values in the "User-defined values" section, render, print, smile
 *     broadly, share with friends, and send the author a few bottles of your favorite beer. 
 * 
 * CREDITS: Center-trapped nut/bolt design inspired by Wade's Geared Extruder 
 *     (http://www.thingiverse.com/thing:1794). The spiral spoke design was apparently designed in 
 *     parallel with tjhowse's Parametric airless tire (http://www.thingiverse.com/thing:17514), and 
 *     although it can be configured to act in a very similar way, it was originally designed to be 
 *     a rigid spoke design. Vane code by JoeyC (JEC).
 *       Some features were inspired or suggested by commenters. I'll try to add credits in the code
 *     for those features. 
 * 
 * v1.33, Oct 16, 2012: Added code to generate vanes for use with slot detectors.  JEC
 * v1.32, Jun 9, 2012: Fixed a bug that cause outer nut trap to not render properly. 
 * v1.31, Jun 9, 2012: Fixed a bug that didn't include shaft flats when rendered without a hub.
 * v1.30, Jun 9, 2012: Features requested by JuliaDee: Added option for v-grooves instead of just 
 *     o-rings; Added flatted shaft option. 
 * v1.23, Apr 23, 2012: Fixed a bug that places the trapped nuts incorrectly, without considering 
 *     shaft size. Added a parameter to offset the placement of these nuts. (Thanks, AUGuru, for both 
 *     of these!) 
 * v1.22, Apr 21, 2012: Added credits section to instructions. Fixed some argument/reference issues. 
 *     Better knob foundation calculation/rendering. Fixed a number of bugs in knob sizing, including 
 *     the bug indetified by TakeItAndRun, where the knobs sometimes extend into the interior of the 
 *     wheel. 
 * v1.21, Apr 18, 2012: Fixed bug that prevented timing holes from rendering properly with spoke
 *     inset. Edited comments a bit and cleaned up some code. Combined a few parameters.
 * v1.20, Apr 17, 2012: Line style uses spokeWidth. Supports an inner circle using innerCircleDiameter. 
 *     Cleaned up some unnecessary code. Added spokeInset to allow seperate sized of rim and rest of
 *     wheel. Added captive nut option in hub. Added convexity of spoke area (inner and outer).
 * v1.10, Apr 16, 2012: Hub now supports standard hobby servo mounting arms/horns. Renders flat.
 * v1.00, Apr 15, 2012: Initial release. This is a combination of several other several other 
 *     wheel designs that all used the same framework, including http://www.thingiverse.com/thing:21277
 *     http://www.thingiverse.com/thing:21065, http://www.thingiverse.com/thing:21064, and 
 *     http://www.thingiverse.com/thing:21010, as well as some parts of my encoder wheel design at 
 *     http://www.thingiverse.com/thing:20491. I should be finishing my taxes right now. 
 *
 * TODO: 
 *   * Call wheel() with arguments (so it's more library-like)
 *   * Triangle spoke style
 *   * Gear tooth "tread" pattern
 *   * Bearing retainer (AUGuru)
 *   * perhaps move content of rim() to where the rim is actually built so inner hole can be punched out
 *   * outer hub styles (TakeItAndRun)
 */

/////////////////////////////////////////////////////////////////////////////
// User-defined values... 
/////////////////////////////////////////////////////////////////////////////

// Tire Parameters:
//      Often wheels are built around the tires. In this section, specify the properties of the 
//   tires you're using, and this will define the diameter of the wheel. If you're using o-rings, 
//   the tireCSDiameter should be the cross-section diameter of the o-ring, or if you're using some
//   other flat tire material (such as rubber bands), jsut specify the its thickness. If you're not
//   using any tire at all, set the tireCSDiameter to zero. 

wheelWidth     = 15;     // The width (or thickness) of the wheel at the rim.
tireCSDiameter = 4;     // Cross-sectional diameter (CS) -- How thick is the tire rubber?
tireID         = 93;    // Internal diameter (ID) -- How wide is the inside opening? 
tireStretch    = 1.01;  // Circumferential stretch percentage (usually 1 + 0-5%, e.g. 1.02) -- How 
                        //   much do you want to stretch it to get it on? 

// Rim properties 
//      The rim sits at at the outside of the spokes and supports the tires or added treads. 
//   Installed tires (such as o-rings, rubber bands, etc) are set into grooves carved out of the
//   rim, while trads are added onto it. Keep this in mind when you're using tires -- as an 
//   example, the rim height should not be smaller than the radius of o-ring tires. 
//      The rim also supports rotary encoder timing holes for wheel feedback. Use the padding 
//   parameters to adjust the location of those holes. See the compiler output for helpful 
//   information about the distance indicated by each timing hole. Directional timing holes 
//   will produce a second set of holes that are 90 degrees out of phase with the first. This 
//   allows you to stack sensors at the same location over the wheel instead of trying to 
//   position them along the circumference. Directional timing holes essentially double the 
//   resolution. You can also double resolution by looking for both rising and falling edges. 

rimHeight      = 5;        // The height of the rim portion of the wheel. 
timingHoles    = 0;        // The number of timing holes to carve into the rim
timingHolePad  = [1,0.5,3]; // The [inside,middle,outside] padding for the timing holes
directional    = true;      // A directional encoder renders two sets of slots, 90 deg out of phase

// Added 10/16/2012 JEC
// Slot detector vane properties
// These settings generate small vanes on the inside of the rim for use with
// IR slot detectors that are too narrow to be put over the wheel.
vaneCount		= 30;			// Number of slot detector vanes to put inside rim
vaneHeight		= 7;			// The height of the vanes
vaneWidth		= 1;			// Width of vanes
vaneLength		= 4;			// Length of vanes
vaneOffset		= 1;			// Offset into wheel of vanes

// Tread Parameters:
//      In this section, specify the properties of the tire tread you want to render. If you're 
//   using a wheel (e.g. o-ring, rubber bands, etc), then use either the "o-rings" or "slots" 
//   settings, which will cut a groove (or grooves) in the wheel rim to fit the tires. The other
//   treat styles will render a tread pattern protruding out from the tire surface by the amount 
//   you specify in third part of "knobSize".
// 		Imagine the tire is mounted on a robot and facing straight at you. The "knobSize" parameter
// 	 defines the size and shape of knobs in an [x,y,z] format, where x goes across the rim, y 
//   goes up and down along the perimeter of the wheel, and z protrudes out from the wheel toward
//   you. 
// 		The "staggerOffset" parameter allows you to stagger knobs across the tire by an amount you
//   specify. Set this to zero if you want all the knobs lined up along the perimeter and aligned 
//   with the edges of the rim. 
// 		"numberOfKnobs" specifies how many knobs there are across the tire, and "lineThickness" 
// 	 specifies how thick the lines are from "drawn" tire styles, such as "x", "cross", and "zigX". 
// 	 You can use these pameters together in creative ways -- for example to extend a single tread 
//   profile across the width of the tire, or to create a contiguous zig-zag. 
//  		Finally, "radialTreadSets" defines how many sets of treads are rendered around the wheel. 
// 	 Each set contains two rows in order to create the staggered effect. 
// 	    Tread styles are: 
// 		 * none - No tread is rendered 
// 		 * cross - Each knob is the shape of a plus sign with the specified lineThickness
// 		 * o-rings - Grooves are cut into the rim to accept o-ring tires
// 		 * v-grooves - V-grooves are cut into the rim to accept v-grooved tires. The knobSize
//               property defines the shape of the groove as [angle,depth,ignored], so knobSize
//               of [90,2,0] would be a 90-degree v-groove carved at a depth of 2mm. Use 
//               tireCSDiameter to define the width of the actual tire (not the groove), and 
//               spaceBetweenTires and maxTires to define how many and what distance apart. 
// 		 * squares - Each knob is a rectangle, whose size is specified by knobSize
// 		 * spheres - Each knob is a smoot0h bump, whose size is specified by knobSize
// 		 * cylindersX - Each knob is a cylindrical shape running across the wheel, whose size 
// 				is specified by knobSize
// 		 * cylindersY - Each knob is a cylindrical shape running along the perimiter of the wheel, 
// 				whose size is specified by knobSize
// 		 * cylindersZ - Each knob is a cylindrical shape protruding from the surface of the wheel, 
// 				whose size is specified by knobSize
// 		 * spikes - Each knob is a cone or spike protruding from the surface of the wheel, whose
// 				size is specified by knobSize
// 		 * slots - Grooves are cut into the rim to accept flat tires, defined by numberOfKnobs
//              (number of grooves), the first and third numbers in knobSize to define the 
//              width of the slots and the depth, and spaceBetweenTires for the distance between
//              the tires and also from the outside edges to the first slots. 
// 		 * x - Each knob is in the shape of an "x" protruding from the surface of the wheel, whose
// 				size is specified by knobSize
// 		 * zigX - Each knob is in the shape of a zig-zag protruding from the surface of the wheel, 
// 				whose size is specified by knobSize
// 		 * v - Each knob is in the shape of a "v" protruding from the surface of the wheel, whose 
// 				size is specified by knobSize

treadStyle        = "v-grooves";  // none, cross, o-rings, v-grooves, squares, spheres, cylindersX, 
                                  // 	  cylindersY, cylindersZ, spikes, slots, x, zigX, v
knobSize          = [90,1.5,1];   // The size of each knob [across wheel, along the perimeter, prodruding]
                                  //   or for v-grooves, [angle, depth, ignored]
radialTreadSets   = 15;           // How many sets of treads to render around the wheel (2 rows per set).
numberOfKnobs     = 4;            // The number of knobs to render per row. 
staggerOffset     = 2;            // A distance to offset the staggered rows. 
lineThickness     = 1;            // The line thickness for "drawn" styles, such as "x" and "zigX"
maxTires          = 3;            // For o-rings/v-grooves, the maximum number of tires per wheel
spaceBetweenTires = 2;            // For o-rings/v-grooves, the space between each tire, if more than one 

// Spoke-related Parameters:
//      This section is used to define the spoke style of the wheel. Some of the properties are only 
//   applicable to certain wheel types, and these properties can be used together in creative ways 
//   to create a wide range of tire designs. 
//      The "proportion" property affects how some spokes are rendered. The first number is the 
//   proportion of the design from the center of the wheel to the inside of the rim, and the second 
//   number is the proportion of the width inside of the wheel. For example, to create spokes that are 
//   roughly in the shape of a "U", you can use a "circle" style, and set the proportion to [1.5, 1.0], 
//   for cirle spokes that are 150% as long as the distance from the center to the inside of the rim, 
//   100% as wide. 
//      The spoke styles are: 
//       * biohazard - A biohazard logo-inspired design. Set numberOfSpokes to 3 to mimic the logo.
//       * circle - Spokes in a circlar or oval form, defined by spokeWidth and proportion. 
//       * circlefit - The maximum number of circles that will fit between the center and the rim, 
//                with a set of smaller outer circles specified by outerHoleDiameter. 
//       * diamond - Spokes in the shape of a diamond (rhombus), defined by spokeWidth and proportion. 
//       * fill - Fills in the spoke area with a solid cylinder. 
//       * line - Straight line spokes, like you would see on a typical wagon wheel. 
//       * none - Leaves the spoke area empty and does not make for a very useful wheel.  
//       * rectangle - Spokes in the shape of a rectangle, defined by spokeWidth and proportion. 
//       * spiral - Spokes in the shape of a semicircle, defined by curvature, reverse, spokeWidth. 
//      Use spokeInset to specify the inner and outer inset of the spoke area from the inner and outer 
//    faces of the wheel. You can use a negative number to make the spoke area stick out further than 
//    than the rim. The hub position will be based on the inner surface resulting from this inset. 

spokeStyle        = "circle";   // none, biohazard, circle, circlefit, diamond, line, rectangle, spiral, fill
spokeInset        = [8,0];      // The [inner,outer] inset of the spoke area from the surface
numberOfSpokes    = 5;          // Number of "spokes." Set this to three if you're doing the biohazard design
spokeWidth        = 3;          // This is how wide each spoke is.
proportion        = [1.4,1.4];  // proportion to rim, proportion of width
curvature         = 0.66;       // For "spiral", this is how curvey the spokes are. >0, but <=1, where 
                                //     1 is a half circle
reverse           = false;      // For "spiral", setting this to "true" reverses the direction of the spirals
outerHoleDiameter = 13;         // For "circlefit", the diameter of the outer holes, or zero for none
concavity         = [0,0];      // Concavity distance of spoke area for [inside, outside] of wheel

// Hub Parameters: 
//      These properties define the hub.
//      The hubZOffset can be used to "sink" the hub into the wheel, and it defaults to half the wheel 
//   thickness. For example, when the hubHeight is 10 and the hubZOffset is -2, then the hub will 
//   protrude 8mm from the wheel, but the shaft hole will be 10mm deep. The set screw will still be
//   positioned in the middle of the exposed vertical height, and the fillet/chamfer will also be rendered 
//   in the correct position. This property is also useful if you want to poke a hole entirely through the
//   wheel. (e.g. If the wheel is 6mm thick, set the hub height to 16 and the hubZOffset to -6, and 
//   you'll get a hub that protrudes 10mm from the wheel surface with a hole that extends all the way 
//   through the wheel.)
//      Use innerCircleDiameter to specify a solid inner circle to use as a base for the hub. This can 
//   be useful if you need a a solid surface for servo mounting hardware or for the base hub fillet/chamfer.

includeHub           = true; // Set to false to remove the hub and only include the shaft diameter hole. 
hubDiameter          = 15;    // The diameter of the hub portion of the wheel
hubHeight            = 12;    // The total height of the hub
hubZOffset           = 0;     // The Z position of the hub, negative numbers from the surface of the wheel 
innerCircleDiameter  = 30;    // The diameter of the solid inner circle under the hub, or zero for none. 

baseFilletRadius     = 2;     // The radius of the fillet (rounded part) between the hub and wheel. 
topFilletRadius      = 2;     // The radius of the fillet (rounded part) at the top of the hub. 
chamferOnly          = false; // Set to true to use chamfers (straight 45-degree angles) instead of fillets. 

// Hardware Parameters: 
//      These properties define how the wheel is mounted, including the primary hole in the center as 
//   well as any set screws, servo mounting holes, and nut traps. The default values for the captive
//   nut are precise for a M3 nut and will make the nut a very tight (if not impossible) fit. I
//   prefer this because it allows you to "melt" the nut into place with a soldering iron. However, 
//   if you don't have a solder iron or prefer a looser fit, then just adjust the nut diameter and 
//   thickness. (M3 hardware is, by default, set to 3mm screw diameter, 5.4mm nut diameter, and 2.3mm 
//   nut thickness.) Similarly, the holes for the motor shaft and grub screw are also precise. This 
//   allows the holes to be drilled out for a more precise fit. Again, you can adjust these to suit 
// 	 your needs. 
//      When measuring nuts, measure the "in diameter", or the distance from flat to flat (not point 
//   to point).
//      To mount a servo motor, set includeHub to false, set shaftDiameter so that the hole will 
//   accommodate the servo horn screw and any bit that protrudes from the top of the servo horn. Then 
//   set the servoHoleDiameter to the size of your mounting hardware, and set servoHoleDistance1 and 
//   servoHoleDistance2 to the total distance between mounting holes on your servo (not the distance from 
//   the center). These sets of mounting holes will be rendered at 90 degree angles from one another. If
//   you only want one set of holes, set one of the values to zero. Adjust the angle of all the holes 
//   to avoid openings in your wheel design if necessary using servoArmRotation. 
//      Use outerNutTrap to create a nut or bolt head trap on the outside (bottom) of the hub area. 
//   Used in conjunction with shaftDiameter and false for includeHub, this will create a wheel that 
//   can drive a bolt much like the large gear on Wade's Extruder. (This feature is inspired by that 
//   design.)
//      Use servoNutTrap to create nut traps for bolts used to mount the wheel onto servo arms. This 
//   feature was suggested by AUGuru. 

shaftDiameter        = 8;          // The diameter of the motor shaft
shaftFlatDiameter    = 6;          // The diameter of the motor shaft at the flat, or shaftDiameter for no flat.

setScrewCount        = 1;          // The number of set screws/nuts to render, spaced evenly around the shaft 
setScrewDiameter     = 3;          // The diameter of the set screw. 3 is the default for an M3 screw. 
setScrewTrap         = [5.4, 2.3]; // Size [indiameter, thickness] of set screw nut. The depth is set automatically.
setScrewNutDiameter  = 5.4;        // The "diameter" of the captive nut, from flat to flat (the "in-diameter")
setScrewNutThickness = 2.3;        // The thickness of the captive nut
setScrewNutOffset    = 0;          // The distance to offset the nut from the center of the material. -/+ = in/out

servoHoleDiameter    = 0;          // The diameter of servo arm hounting holes, or zero if no holes
servoHoleDistance1   = 25;         // Distance across servo horn from hole to hole (0 to ignore)
servoHoleDistance2   = 21;         // Distance across servo horn from hole to hole, rotated 90 degrees (0 to ignore)
servoArmRotation     = 45;         // The total rotation of all servo holes
servoNutTrap         = [4,1.6];    // Size [indiameter, depth] of servo arm captive nut, or 0 (any) for none.

outerNutTrap         = [12.5,0];   // Size [indiameter, depth] of a captive nut, or 0 (any) for none.


// Quality Parameters: 

$fn = 50;  // Default quality for most circle parts. 


/////////////////////////////////////////////////////////////////////////////
// Calculated values... 
/////////////////////////////////////////////////////////////////////////////

// Let's get some basic math out of the way first.
// Not all of these are necessary, but many are helpful to know and will be echoed to the user. 

// Some basic tire geometry
innerDiameter = tireID; 
centerDiameter = tireID + tireCSDiameter;
outerDiameter = tireID + ( tireCSDiameter *2 );
innerCircumference = innerDiameter*PI;
centerCircumference = centerDiameter*PI;
outerCircumference = outerDiameter*PI;

// Stretched tire geometry
centerCircumferenceStretched = centerCircumference * tireStretch;
centerDiameterStretched = centerCircumferenceStretched/PI; 
innerDiameterStretched = centerDiameterStretched - tireCSDiameter;
outerDiameterStretched = centerDiameterStretched + tireCSDiameter;
innerCircumferenceStretched = innerDiameterStretched * PI;
outerCircumferenceStretched = outerDiameterStretched * PI;

// Wheel geometry.
wheelDiameter =  centerDiameterStretched;
wheelRadius = wheelDiameter / 2;
tireRadius = tireCSDiameter / 2;
hubRadius = hubDiameter / 2;

// Knobbed wheel geometry
outerDiameterKnobbed = wheelDiameter+(2*knobSize[2]);
outerCircumferenceKnobbed = outerDiameterKnobbed * PI;


/////////////////////////////////////////////////////////////////////////////
// Report some basic information to the user...  
/////////////////////////////////////////////////////////////////////////////

// Some tire data, stretched and unstretched 
echo( str("Tire cross-sectional diameter is ", tireCSDiameter ) ); 
echo( str("Tire circumferential stretch is ", tireStretch ) ); 

echo( str("Tire (unstretched): [inner, center, outer]" ) ); 
echo( str("  * Diameter: ", innerDiameter, ", ", centerDiameter, ", ", outerDiameter ) ); 
echo( str("  * Circumference: ", round2(innerCircumference), ", ", round2(centerCircumference), 
	", ", round2(outerCircumference) ) ); 

echo( str("Tire Stretched: [inner, center, outer]" ) ); 
echo( str("  * Diameter: ", round2(innerDiameterStretched), ", ", round2(centerDiameterStretched), 
	", ", round2(outerDiameterStretched) ) ); 
echo( str("  * Circumference: ", round2(innerCircumferenceStretched), ", ", 
	round2(centerCircumferenceStretched), ", ", round2(outerCircumferenceStretched) ) ); 

echo( str("Tire Knobbed: [outer]" ) ); 
echo( str("  * Diameter: ", round2(outerDiameterKnobbed) ) ); 
echo( str("  * Circumference: ", round2(outerCircumferenceKnobbed) ) ); 

echo( str("Wheel diameter will be ", wheelDiameter ) ); 

// Here's a helper function that will round a value to two decimal places. 
function round2( value ) = round(value * 100) / 100;
function concaveRadius( wheelDiameter, depth ) = (wheelDiameter/2) / sin( 2*atan(depth/(wheelDiameter/2)) );

/////////////////////////////////////////////////////////////////////////////
// Render the wheel...  
/////////////////////////////////////////////////////////////////////////////

wheel();

module wheel() {

	// Number of tires - If the width is more than 1.5 times with tire CS, then 
	// we can have multiple tires on the wheel, if defined. 
	tireDistance = tireCSDiameter+spaceBetweenTires; 
	numTires = min( maxTires, max( 1, floor( (wheelWidth + (tireDistance)/2) / tireDistance ) ) );
	echo( str("Number of tires will be ", numTires ) ); 

	// Wheel width defined above is actually the width at the rim. We'll redefine wheelWidth here
	// and take the spoke surface offsets into account. We'll add a new variable for the rim width. 
	rimWidth = wheelWidth; 
	wheelWidth = rimWidth - spokeInset[0] - spokeInset[1]; 

	spokeDiameter = wheelDiameter - 2*rimHeight; 

	union() {
		// The slot detector vanes, added 10/16/2012 JEC
		// Height is increased by.2mm to insure full contact with rim
		if (vaneCount > 0) {
			for (vaneAngle = [0 : 360/vaneCount : 360-(360/vaneCount)])
				rotate([0,0,vaneAngle])
					translate([-(wheelDiameter/2)+rimHeight-.2,-vaneLength/2,(rimWidth/2)-vaneOffset-vaneWidth])
						cube([vaneHeight+.2,vaneLength,vaneWidth]);
			assign( len1 = outerCircumferenceStretched/vaneCount, 
				len2 = outerCircumferenceKnobbed/vaneCount) {
				echo ( str("For o-rings, each vane (same edge) is ", round2(len1), "mm (", 
					round2(len1/25.4), "in).") );
				echo ( str("For knobbed treads, each vane (same edge) is roughly ", round2(len2), 
					"mm (", round2(len2/25.4), "in).") );
			}
		}

		// The rim 
		difference() {
			rim(rimWidth, rimHeight, wheelDiameter);
	
			// Punch out timing holes	
			if ( timingHoles > 0 ) {
				if ( directional ) {
					assign( holeHeight=(rimHeight-timingHolePad[0]-timingHolePad[2]-timingHolePad[1])/2 ) {
						// outer holes 
						placeTimingHoles(timingHoles, holeHeight, rimWidth, (wheelDiameter/2)-timingHolePad[2]);

						// inner holes 
						rotate([0,0,90/timingHoles]) 
						placeTimingHoles(timingHoles, holeHeight, rimWidth, 
							(wheelDiameter/2)-timingHolePad[2]-holeHeight-timingHolePad[1]);
					}	
					assign( len1 = outerCircumferenceStretched/(timingHoles*2), 
		  					len2 = outerCircumferenceKnobbed/(timingHoles*2) ) {
						echo ( str("For o-rings, each timing mark (same edge) is ", round2(len1), "mm (", 
							round2(len1/25.4), "in).") );
						echo ( str("For knobbed treads, each timing mark (same edge) is roughly ", round2(len2), 
							"mm (", round2(len2/25.4), "in).") );
					}
				} else {
					placeTimingHoles(timingHoles, rimHeight-timingHolePad[0]-timingHolePad[2], 
						rimWidth, (wheelDiameter/2)-timingHolePad[2]);
					assign( len1 = outerCircumferenceStretched/(timingHoles), 
		  					len2 = outerCircumferenceKnobbed/(timingHoles) ) {
						echo ( str("For o-rings, each timing mark (same edge) is ", round2(len1), "mm (", 
							round2(len1/25.4), "in).") );
						echo ( str("For knobbed treads, each timing mark (same edge) is roughly ", round2(len2), 
							"mm (", round2(len2/25.4), "in).") );
					}
				}
			}

			// punch out tires
			if ( ( treadStyle == "o-rings" ) || ( treadStyle == "v-grooves" ) ) {
				assign( extent=(numTires-1)*(tireDistance/2) ) {
					for( x=[-extent:tireDistance:extent] ) {
						translate([0,0,x]) {
							if ( treadStyle == "o-rings" )
								tire( wheelDiameter, tireCSDiameter ); 
							else if ( treadStyle == "v-grooves" )
								vGroove( wheelDiameter, knobSize[0], knobSize[1] ); 
						}
					}
				}
			} else if ( treadStyle == "slots" ) {	// punch out slots if necessary 
				assign( separation = (rimWidth-(numberOfKnobs*knobSize[0])) / (numberOfKnobs+1) ) 
				assign( dist = knobSize[0] + separation ) {
					translate([0,0,-rimWidth/2] ) 
					for ( i=[0:numberOfKnobs-1] ) {
						translate([0,0,separation+(dist*i)] ) 
						difference() {
							cylinder(r=(wheelDiameter/2), h=knobSize[0]); 
							cylinder(r=(wheelDiameter/2)-knobSize[2], h=knobSize[0]); 
						}
					}
				}
			}
		}

		// Translate spokes and hub to accommodate insets 
		translate([0,0,rimWidth/2 - wheelWidth/2 - spokeInset[0]]) {
			// The spokes
			difference() {
				union() {
					assign( d = wheelDiameter - (rimHeight*2) ) {
						if ( spokeStyle == "fill" ) { 
							cylinder( h=wheelWidth, r=d/2, center=true );
						} else if ( spokeStyle == "biohazard" ) { 
							biohazardSpokes( d, wheelWidth, numberOfSpokes );
						} else if ( spokeStyle == "circlefit" ) {
							circlefitSpokes( d, hubDiameter, wheelWidth, outerHoleDiameter );
						} else if ( spokeStyle == "line" ) {
							lineSpokes( d, wheelWidth, numberOfSpokes, spokeWidth );
						} else if ( spokeStyle == "rectangle" ) {
							rectangleSpokes( d, wheelWidth, spokeWidth, proportion, numberOfSpokes );
						} else if ( spokeStyle == "diamond" ) {
							diamondSpokes( d, wheelWidth, spokeWidth, proportion, numberOfSpokes );
						} else if ( spokeStyle == "circle" ) {
							circleSpokes( d, wheelWidth, spokeWidth, proportion, numberOfSpokes );
						} else if ( spokeStyle == "spiral" ) {
							spiralSpokes( d, wheelWidth, numberOfSpokes,
								spokeWidth, curvature, reverse, spiralSpoke);
						}
					}
	
					// If there's an inner solid circle, add it here. 
					if ( innerCircleDiameter > 0 ) {
						cylinder( h=wheelWidth, r=innerCircleDiameter/2, center=true ); 
					}
				}

				// Carve out concavity
				if ( concavity[0] > 0 ) {  // inside
					translate([0,0,concaveRadius(spokeDiameter, concavity[0])+ wheelWidth/2 -concavity[0]])
						sphere( r=concaveRadius(spokeDiameter, concavity[0]) ); 
				}
				if ( concavity[1] > 0 ) {  // outside 
					translate([0,0,-concaveRadius(spokeDiameter, concavity[1])- wheelWidth/2 +concavity[1]])
						sphere( r=concaveRadius(spokeDiameter, concavity[1]) ); 
				}
				
				// Carve a spot for an inset hub if necessary 
				if ( includeHub ) {
					translate( [0,0,hubHeight/2 + wheelWidth/2 + hubZOffset - concavity[0]] )
						cylinder( h=hubHeight, r=hubDiameter/2, center=true );
				} else { 
					mountingHoles( shaftDiameter, shaftFlatDiameter, wheelWidth, concavity, servoHoleDiameter, 
						servoHoleDistance1, servoHoleDistance2, servoArmRotation, servoNutTrap ); 
				}

				// Carve out lower nut trap if necessary -- does not carve the hole
				if ( outerNutTrap[0]*outerNutTrap[1] != 0 ) {
					translate([0,0,-wheelWidth/2 + outerNutTrap[1]/2 -1 ])
						nut( [outerNutTrap[0], outerNutTrap[1] +1]); 
				}         
			}	
	
			// The hub	
			if ( includeHub ) {
				translate([0,0, hubHeight/2 + wheelWidth/2 + hubZOffset - concavity[0]]) 
					hub(hubHeight, hubDiameter, shaftDiameter, shaftFlatDiameter,
						setScrewCount, setScrewTrap, setScrewDiameter, setScrewNutOffset,
						hubZOffset, baseFilletRadius, topFilletRadius, chamferOnly);
			}
		}

		// The tread
		if ( treadStyle == "o-rings" ) {
			for( x=[-(numTires-1)*(tireDistance/2):tireDistance:(numTires-1)*(tireDistance/2)] )
				translate([0,0,x])
					%color("black", 0.5) tire( wheelDiameter, tireCSDiameter ); 
		} else if ( treadStyle == "slots" ) {
			// no need to render anything here... 
		} else {		// The rest are all knob designs 
			placeKnobs( wheelWidth, wheelDiameter, treadStyle, knobSize, radialTreadSets, numberOfKnobs, 
				staggerOffset, lineThickness ); 
		}
	}
}

// builds in extra space for better rendering
module mountingHoles( shaftDiameter, shaftFlatDiameter, wheelWidth, concavity, servoHoleDiameter, 
	servoHoleDistance1, servoHoleDistance2, servoArmRotation, servoNutTrap ) {

	newWidth = wheelWidth-concavity[0]-concavity[1];
	
	difference() {
		cylinder( h=newWidth+1, r=shaftDiameter/2, center=true ); 
		translate([(shaftDiameter-shaftFlatDiameter+1)/2 + (shaftDiameter/2) 
				- (shaftDiameter - shaftFlatDiameter),0,0]) 
			cube( [shaftDiameter-shaftFlatDiameter+1,shaftDiameter,newWidth+2], center=true ); 
	}

	// if we're mounting a servo... 
	if ( servoHoleDiameter > 0 ) {
		translate([0,0,-wheelWidth/2-1]) {
			rotate([0,0,servoArmRotation]) 
				holeSet( servoHoleDistance1, servoHoleDiameter, wheelWidth+2, servoNutTrap+[0,1+concavity[1]] );
		
			rotate([0,0,servoArmRotation+90]) 
				holeSet( servoHoleDistance2, servoHoleDiameter, wheelWidth+2, servoNutTrap+[0,1+concavity[1]] );
		}
	}
}

module holeSet( distance, diameter, length, nutTrap ) {
	if ( distance > 0 ) {
		for ( i=[-distance/2:distance:distance/2] ) {
			translate([i,0,nutTrap[1]/2]) {
				captiveNut( nutTrap, diameter, 0, length-nutTrap[1], 0 );
			}
		}
	}
}

module placeTimingHoles( holeCount, holeHeight, wheelWidth, radius ) {
	translate([0,0,-(wheelWidth+1)/2]) {
		for ( i = [0 : holeCount-1] ) {
		   	rotate( i*(360/holeCount), [0, 0, 1])
		   	arc( holeHeight, wheelWidth+1, radius, degrees=180/holeCount );
		}
	}
}

module placeKnobs( wheelWidth, wheelDiameter, treadStyle, knobSize, radialTreadSets, numberOfKnobs, 
	staggerOffset, lineThickness ) {
	
	assign( knobDistance = knobSize[0] + (( wheelWidth - knobSize[0]*numberOfKnobs - staggerOffset ) / 
			(numberOfKnobs-1)) ) {
		
		doTreadSet( wheelWidth, wheelDiameter, treadStyle, knobSize, radialTreadSets, numberOfKnobs, 
			knobDistance, lineThickness ); 
		rotate([180, 0, 180/radialTreadSets])
			doTreadSet( wheelWidth, wheelDiameter, treadStyle, knobSize, radialTreadSets, numberOfKnobs, 
				knobDistance, lineThickness ); 
	}
}

// Renders half of the tread. The other half is rendered rotated 180% to produce the stagger offset 
module doTreadSet( wheelWidth, wheelDiameter, treadStyle, knobSize, radialTreadSets, numberOfKnobs, 
	knobDistance, lineThickness ) {

	radius = wheelDiameter/2;
	halfy = knobSize[1]/2; 
	theta = atan( halfy / radius ); 
	x = sqrt( (radius*radius) + (halfy*halfy) );
	y = x - radius; 
	foundationHeight = ( y / cos(theta) );

	translate([0,0,knobSize[0]/2 - wheelWidth/2]) {
		for ( 	i=[0:radialTreadSets-1], 
				j=[0:numberOfKnobs-1] ) {
		    rotate( i * 360 / radialTreadSets, [0, 0, 1])
		    		translate([wheelDiameter/2, 0, j*knobDistance ])
					doKnob( treadStyle, knobSize, lineThickness, foundationHeight ); 
		}
	}
}


// squares, spheres, cylindersX, cylindersY, cylindersZ, spikes, cross, x, zigX, v
// nyi: zigY, vReverse
//debugKnob( "v" );
module debugKnob( style ) {
	
	knobSize = [5,5,5];
	lineThickness = 1;
	
	radius = 25;
	halfy = knobSize[1]/2; 
	theta = atan( halfy / radius ); 
	x = sqrt( (radius * radius) + (halfy*halfy) );
	y = x - radius; 
	foundationHeight = ( y / cos(theta) );
	
	// Wheel 
	translate([-25,0,0])
		%cylinder(r=25, h=10, center=true); 
	// Extents
	translate([knobSize[2]/2,0,0])
		rotate([90,90,90]) 
			%cube(knobSize, center=true); 
	// foundation 
	translate([-foundationHeight/2,0,0])
		rotate([90,90,90]) 
			color("red", 0.15)
				*cube([knobSize[0], knobSize[1], foundationHeight], center=true); 
	
	doKnob( style, knobSize, lineThickness, foundationHeight );
}

module doKnob( treadStyle, knobSize, lineThickness, foundationHeight ) {

	// slots and o-rings are not knob designs

	// retrograde know elements once so we don't have to keep repeating it
	newSize = [knobSize[2]+foundationHeight,knobSize[1],knobSize[0]];
	newSizeTall = [2*(knobSize[2]+foundationHeight),knobSize[1],knobSize[0]];
	
	render()
	if ( treadStyle == "squares" ) {
		translate([newSize[0]/2 - foundationHeight,0,0])
		    cube(newSize, center=true);
	} else if ( treadStyle == "spheres" ) {
		translate([-foundationHeight,0,0])
		difference() {
			scale(newSizeTall)
		    		sphere(r=.5, center=true);
			translate([-newSize[0]/2,0,0])
			    cube(newSize+[0,1,1], center=true);
		}
	} else if ( treadStyle == "cylindersX" ) {
		translate([-foundationHeight,0,0])
		difference() {
			scale(newSizeTall)
				rotate([0,0,90])
			    		cylinder(r=0.5, h=1, center=true);
			translate([-newSize[0]/2,0,0])
			    cube(newSize+[0,1,1], center=true);
		}
	} else if ( treadStyle == "cylindersY" ) {
		translate([-foundationHeight,0,0])
		difference() {
			scale(newSizeTall)
				rotate([90,0,0])
			    		cylinder(r=0.5, h=1, center=true);
			translate([-newSize[0]/2,0,0])
			    cube(newSize+[0,1,1], center=true);
		}
	} else if ( treadStyle == "cylindersZ" ) {
		translate([newSize[0]/2 -foundationHeight,0,0])
		scale(newSize)
		rotate([0,90,0])
	    		cylinder(r=0.5, h=1, center=true);
	} else if ( treadStyle == "spikes" ) {
		translate([(newSize[0]-foundationHeight)/2,0,0])
		scale(newSize)
		rotate([0,90,0])
		union() {
	    		cylinder(r1=.5, r2=0, h=1, center=true);
		}
	} else if ( treadStyle == "cross" ) {
		translate([newSize[0]/2-foundationHeight,0,0])
		union() {
		    	cube([newSize[0],lineThickness,newSize[2]], center=true);
		    	cube([newSize[0],newSize[1],lineThickness], center=true);
		}
	} else if ( treadStyle == "x" ) {
		assign( len = sqrt( pow(newSize[2], 2) + pow(newSize[1], 2)), 
			    theta = atan( newSize[1]/newSize[2] ) )
		translate([newSize[0]/2-foundationHeight,0,0])
		intersection() {	
			union() {
				rotate([theta,0,0]) 
				    	cube([newSize[0],lineThickness,len], center=true);
				rotate([-theta,0,0]) 
			    		cube([newSize[0],lineThickness,len], center=true);
			}

			// Trim to box size 
		    cube(newSize, center=true);
		}
	} else if ( treadStyle == "zigX" ) {
		assign( seglen = sqrt( pow(newSize[2]/4, 2) + pow(newSize[1]/2, 2)), 
			    theta = atan( (newSize[1]/2)/(newSize[2]/4) ) )
		translate([newSize[0]/2-foundationHeight,0,0])
		intersection() {	
			union() {	// extend seglen so patterns match neighboring patterns
				translate([0,-newSize[1]/4,-newSize[2]/2 + newSize[2]/8])
					rotate([theta,0,0]) 
					    	cube([newSize[0],lineThickness,seglen*2], center=true);
				rotate([-theta,0,0]) 
				    	cube([newSize[0],lineThickness,seglen*2], center=true);
				translate([0,newSize[1]/4, newSize[2]/2 - newSize[2]/8])
					rotate([theta,0,0]) 
					    	cube([newSize[0],lineThickness,seglen*2], center=true);
			}

			// Trim to box size 
		    cube(newSize, center=true);
		}
	} else if ( treadStyle == "v" ) {
		assign( seglen = sqrt( pow(newSize[2]/2, 2) + pow(newSize[1], 2)), 
			    theta = atan( (newSize[1])/(newSize[2]/2) ) )
		translate([newSize[0]/2-foundationHeight,0,0])
		intersection() {	
			union() {
				translate([0,0, newSize[2]/4])
					rotate([-theta,0,0]) 
					    	cube([newSize[0],lineThickness,seglen], center=true);
				translate([0,0, -newSize[2]/4])
					rotate([theta,0,0]) 
					    	cube([newSize[0],lineThickness,seglen], center=true);
			}

			// Trim to box size 
		    cube([newSize[0],newSize[1],newSize[2]], center=true);
		}
	} else if ( treadStyle == "zigY" ) {
		// not yet implemented
	} else if ( treadStyle == "vReverse" ) {
		// not yet implemented
	}
}


/////////////////////////////////////////////////////////////////////////////
// Spoke Styles...  
/////////////////////////////////////////////////////////////////////////////

//Diamonds pattern spokes
module diamondSpokes( wheelDiameter, wheelWidth, lineWidth, proportion, numberofSpokes ) {
	echo( "Diamonds Style..." ); 
	intersection() {
		cylinder( h=wheelWidth, r= wheelDiameter/2, center = true ); 

		for (step = [0:numberofSpokes-1]) {
		    rotate( a=step*(360/numberofSpokes), v=[0, 0, 1])
			diamondSpoke( wheelDiameter, wheelWidth, lineWidth, proportion );
		}
	}
}
module diamondSpoke( wheelDiameter, wheelWidth, lineWidth, proportion ) {

	// Let's make the lines the correct thickness even after the transformations 
	// are made... Maybe there's a better way? 
	render()
	assign( leg=sqrt( 2*pow(wheelDiameter/4,2 ) ) ) // Euclid rocks. 
	assign( p=(wheelDiameter/2)*proportion[0], q=(wheelDiameter/2)*proportion[1] )
	assign( a=sqrt((p*p)/4 + (q*q)/4) ) 
	assign( h=(p*q)/(2*a) )
	assign( theta=2*asin(q/(2*a)) ) 
	assign( prop=( 2*cos(theta/2)*(h-(2*lineWidth)) ) / ( sin(theta)*p ) ) {
		translate ( [-p/2, 0, 0] ) {
			difference() {
				scale([proportion[0],proportion[1],1]) {
					rotate([0,0,45])
						cube( [leg, leg, wheelWidth], center=true); 
				}

				scale([prop,prop,1]) {
					scale([proportion[0],proportion[1],1]) {
						rotate([0,0,45])  // My wife is the epitome of awesomeness. 
							cube( [leg, leg, wheelWidth+1], center=true); 
					}
				}
			}
		}
	}
}

// Circles pattern spokes
module circleSpokes( wheelDiameter, wheelWidth, lineWidth, proportion, numberofSpokes ) {
	echo( "Circles Style..." ); 
	intersection() {
		cylinder( h=wheelWidth, r=wheelDiameter/2, center = true ); 

		for (step = [0:numberofSpokes-1]) {
		    rotate( [0, 0, step*(360/numberofSpokes)] )
				circleSpoke(  wheelDiameter, wheelWidth, lineWidth, proportion );
		}
	}

}
module circleSpoke( wheelDiameter, wheelWidth, lineWidth, proportion ) {
	render()
	assign( ox=(wheelDiameter/2)*proportion[0], oy=(wheelDiameter/2)*proportion[1] )
	assign( ix=ox-(lineWidth*2), iy=oy-(lineWidth*2) ) {
		translate ( [-ox/2, 0, 0] ) {
			difference() {
				scale([proportion[0],proportion[1],1])
					cylinder( r=wheelDiameter/4, h=wheelWidth, center=true); 
				scale([(ix/ox)*proportion[0],(iy/oy)*proportion[1],1])
					cylinder( r=wheelDiameter/4, h=wheelWidth +1, center=true); 
			}
		}
 	}
}

//Rectangle pattern spokes
module rectangleSpokes( wheelDiameter, wheelWidth, lineWidth, proportion, numberofSpokes ) {
	echo( "Rectangles Style..." ); 
	intersection() {
		cylinder( h=wheelWidth, r= wheelDiameter/2, center = true ); 

		for (step = [0:numberofSpokes-1]) {
		    rotate( a = step*(360/numberofSpokes), v=[0, 0, 1])
			rectangleSpoke(  wheelDiameter, wheelWidth, lineWidth, proportion );
		}
	}
}
module rectangleSpoke( wheelDiameter, wheelWidth, lineWidth, proportion ) {
	render()
	assign( ox=(wheelDiameter/2)*proportion[0], oy=(wheelDiameter/2)*proportion[1] )
	assign( ix=ox-(lineWidth*2), iy=oy-(lineWidth*2) ) {
		translate ( [-ox/2, 0, 0] ) {
			difference() {
				cube( [ox, oy, wheelWidth], center=true); 
				cube( [ix, iy, wheelWidth+1], center=true); 
			}
		}
 	}
}

// Spiral pattern spokes 
module spiralSpokes( diameter, wheelWidth, number, spokeWidth, curvature, reverse ) {
	echo( "Spiral Style..." ); 
	intersection() {
		cylinder( h=wheelWidth, r=diameter/2, center = true ); 

		for (step = [0:number-1]) {
		    rotate( a = step*(360/number), v=[0, 0, 1])
			spiralSpoke( wheelWidth, spokeWidth, (diameter/4) * 1/curvature, reverse );
		}
	}
}
module spiralSpoke( wheelWidth, spokeWidth, spokeRadius, reverse=false ) {
	render() 
	intersection() {	
		translate ( [-spokeRadius, 0, 0] ) {
			difference() {
				cylinder( r=spokeRadius, h=wheelWidth, center=true ); 
				cylinder( r=spokeRadius-(spokeWidth/2), h=wheelWidth+1, center=true ); 
			}
		}
		if ( reverse ) 
			translate ( [-spokeRadius, -spokeRadius/2, 0] ) 
				cube( [spokeRadius*2,spokeRadius,wheelWidth+1], center=true ); 
		else 
			translate ( [-spokeRadius, spokeRadius/2, 0] ) 
				cube( [spokeRadius*2,spokeRadius,wheelWidth+1], center=true ); 
	}
}

// Biohazard pattern spokes
module biohazardSpokes( diameter, width, number ) {
	echo( "Biohazard Style..." ); 

	scale = (diameter/2) / 88;
	intersection() {
		cylinder( h=width, r= diameter/2, center = true ); 
		scale( [scale, scale, 1] ) {
			for (step = [0:number-1]) {
			    rotate( a = step*(360/number), v=[0, 0, 1])
				biohazardSpoke( width );
			}
		}
	}

}
module biohazardSpoke( width ) {
	render() 
	translate ( [-60, 0, 0] )
	difference() {
		translate ( [10, 0, 0] ) 
			cylinder( h = width, r= 50, center=true ); 
		translate ( [-1, 0, 0] ) // offset a bit so it's manifold
			cylinder( h = width+2, r= 40, center=true ); 
	}
}

// Circlefit pattern spokes 
// Still need the math for placing/sizing the outer holes... let me know if you figure it out and I'll add it. 
module circlefitSpokes( diameter, hubDiameter, width, outerHoleDiameter ) {
	echo( "Circlefit Style..." ); 

	padding = 2; 
	paddedHoleRadius = (diameter-hubDiameter)/4;
	holeRadius = paddedHoleRadius - padding/2;
	hubRadius = hubDiameter/2; 

	// Figure out how many circles will fit. 
	circles = floor(360/(2*(asin(paddedHoleRadius/(paddedHoleRadius+hubRadius)))));
	difference() {
		cylinder( h=width, r= diameter/2, center = true ); 

		for ( i = [0 : circles-1] ) {
		   	 rotate( i * (360/circles), [0, 0, 1])
		   	 translate([hubRadius + paddedHoleRadius, 0, 0])
		   	 cylinder(h=width+1, r=holeRadius, center=true);
		}

		// Smaller holes to conserve filament
	   	rotate( 360/circles/2, [0, 0, 1])
		for ( i = [0 : circles-1] ) {
		   	 rotate( i * (360/circles), [0, 0, 1])
		   	 translate([diameter/2-outerHoleDiameter/2, 0, 0])
		   	 cylinder(h=width+1, r=outerHoleDiameter/2, center=true);
		}
	}
}

// Line pattern spokes
module lineSpokes( diameter, wheelWidth, number, spokeWidth ) {
	echo( "Lines Style..." );
	intersection() {
		cylinder( h=wheelWidth, r= diameter/2, center = true ); 

		for (step = [0:number-1]) {
		    rotate( a = step*(360/number), v=[0, 0, 1])
			lineSpoke( wheelWidth, spokeWidth );
		}
	}
}
module lineSpoke( wheelWidth, spokeWidth ) {
	translate ( [-60/2, 0, 0] )
	cube( [60, spokeWidth, wheelWidth], center=true); 
}


/////////////////////////////////////////////////////////////////////////////
// Modules...  
/////////////////////////////////////////////////////////////////////////////

// The hub (the part that holds the wheel onto the motor
module hub( height, diameter, boreDiameter, shaftFlatDiameter, nuts, nutSize, setScrewDiameter, 
	setScrewNutOffset=0,	hubZOffset=0, baseFilletRadius=0, topFilletRadius=0, chamferOnly=false) {

	hubWidth=(diameter-boreDiameter)/2;

	union() {	
		difference() {

			// Main hub shape
			union() {
				difference() {
					union() {
						cylinder( h=height, r=diameter/2, center=true );
			
						// First chamfer the base...
						rotate_extrude() 
							translate([diameter/2,-(height/2)-hubZOffset,0])
								polygon(points=[[0,0],[0,baseFilletRadius],[baseFilletRadius,0]]);
					}
			
					// Chamfer the top...
					rotate_extrude() 
						translate([diameter/2,height/2,0])				
							polygon(points=[[0.5,0.5],[-topFilletRadius-0.5,0.5],[0.5, -topFilletRadius-0.5]]);
			
					// Carve the bottom fillet from the chamfer
					if ( !chamferOnly ) { 
						rotate_extrude() {
							translate([(diameter/2)+baseFilletRadius,
								-(height-(2*baseFilletRadius))/2-hubZOffset,0]) {
								circle(r=baseFilletRadius);
							}
						}
					}
				}

				// Add the fillet back on top of the top chamfer 
				if (!chamferOnly) {
					rotate_extrude() {
						translate([
							(diameter/2)-topFilletRadius,
							(height-(2*topFilletRadius))/2,
							0])				
							circle(r=topFilletRadius);
					}
				}
			}
	
			// Remove the bore
			difference() {
				cylinder( h=height+1, r=boreDiameter/2, center=true ); 
				translate([(boreDiameter-shaftFlatDiameter+1)/2 + (boreDiameter/2) 
						- (boreDiameter - shaftFlatDiameter),0,0]) 
					cube( [boreDiameter-shaftFlatDiameter+1,boreDiameter,height+2], center=true ); 
			}
	
			// Remove the captive nut
			for( i=[0:nuts-1] ) {
				rotate([ 0,0, (360/nuts)*i ])
				translate([boreDiameter/2+(diameter-boreDiameter)/4 +setScrewNutOffset,
						0, height/2 - (height+hubZOffset)/2]) {
					rotate([0,-90,0]) { 
						captiveNut( nutSize, setScrewDiameter, 
							depth=height/2+1, holeLengthTop=hubWidth/2+setScrewNutOffset
								+(boreDiameter-shaftFlatDiameter), 
							holeLengthBottom=hubWidth+baseFilletRadius-setScrewNutOffset);
					}
				}
			}
		}
	}
}

// The rim (the solid area between the spokes and tire)
module rim( width, height, diameter ) {
	difference() { 
		// rim 
		cylinder( h=width, r=diameter/2, center=true );
	
		// punch out center
		cylinder(h=width+1, r=diameter/2 - height, center=true );
	}
}

// The tire, where "diameter" is the center-to-center diameter (not ID or OD)
module tire( diameter, csDiameter ) {
	render() {
		rotate_extrude(convexity = 10)
			translate([diameter/2, 0, 0])
				circle(r = csDiameter/2, $fn=20);
	}
}

// The v-grooves -- Pads the depth by 1mm so it renders well when used to difference
module vGroove( diameter, angle, depth ) {
	dist = tan(angle/2)*(depth+1);
	render() {
		rotate_extrude(convexity = 10)
			translate([diameter/2, 0, 0])
				polygon([[1,dist], [-depth,0], [1,-dist]]);
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

// nutSize = [inDiameter,thickness]
module nut( nutSize ) { 
	side = nutSize[0] * tan( 180/6 );
	if ( nutSize[0] * nutSize[1] != 0 ) {
		for ( i = [0 : 2] ) {
			rotate( i*120, [0, 0, 1]) 
				cube( [side, nutSize[0], nutSize[1]], center=true );
		}
	}
}

// Why is this not easy in openSCAD? :/ This is the same code I use in the encoder wheel
module arc( height, depth, radius, degrees ) {
	// This dies a horible death if it's not rendered here 
	// -- sucks up all memory and spins out of control 
	render() {
		difference() {
			// Outer ring
			rotate_extrude($fn = 100)
				translate([radius - height, 0, 0])
					square([height,depth]);
		
			// Cut half off
			translate([0,-(radius+1),-.5]) 
				cube ([radius+1,(radius+1)*2,depth+1]);
		
			// Cover the other half as necessary
			rotate([0,0,180-degrees])
			translate([0,-(radius+1),-.5]) 
				cube ([radius+1,(radius+1)*2,depth+1]);
		}
	}
}