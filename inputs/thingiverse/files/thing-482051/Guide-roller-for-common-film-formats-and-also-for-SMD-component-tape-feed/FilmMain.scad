// TODO - make EMBEDDED BASE of sprockets non-sloped, so area is smaller & less likely to "poke out" into "free air" over edge of roller surface

//CUSTOMIZER VARIABLES

//Add sprockets
addSprockets = "yes"; // [yes,no]

//Add outer guide edges
addOuterGuideEdges = "yes"; // [yes,no]

// Number of sprockets
numSprockets = 8;

// Distance between sprockets
SprocketPitch = 7.605;

// Embed base of sprockets into roller - so no air gap
sprocketEmbed = 0.08;	// because a flat cone base on a cylinder surface would leave a gap,
                        // need to 'embed' sprocket cone into surface to ensure fully mates - no gaps!
                        // ** ADJUST FOR DIF NUMBER OF SPROCKETS .. ie dif roller radius!

// std 16mm sprocket-perforations
// Width
spkt_W = 1.829;
// Length
spkt_L = 1.27;
//Corner radius
spktCorner_R = 0.25;

spkt_H = 2.2 + sprocketEmbed;		// <<< embedding will reduce actual base size!!!!!
								// hopefully this will give just enough slop for good fit :)

//Film width
filmWidth = 16;		 // from 16mm standards

// Film frame width
frameWidth = 10.26;  // from 16mm standards

// bit of slop - so film does not grab/stick/rub on sides of roller walls
filmSlop = 0.2;		 // a little bit of slop - so film does not grab/stick/rub on sides
					 // reduce or REMOVE if add sloping outer walls

// film **frame** area NOT touching roller ... so less change of damaging actual picture area in the frame!!!
frameGap = 0.1;

// RunnerCyl_H is left at it's full nominal height
// frameGap is NOT subtracted here, relevant drawing methods adjust for filmGap as required.
// This way sprockets are easier to put in the nominal middle of the film roller area!
RunnerCyl_H = (filmWidth - frameWidth - frameGap)/2;		// -frameGap => film **frame** area NOT touching roller ... so less change of damaging actual picture area in the frame!!!
RunnerCyl_R = (numSprockets*SprocketPitch)/(2*PI);          //circumference = 2*pi*radius

// max outer wall thickness, excluding any inner tapering to stop film grabbing on walls
OuterCyl_H = 2;

CoreCyl_H = filmWidth + filmSlop - 2*RunnerCyl_H ;

// Core cylinder radius (includes motor shaft radius!)
CoreCyl_R = 4;

// motor/stepper shaft radius. Must be less than CoreCyl_R!
shaft_R = 6.5/2;        // motor/stepper shaft radius

OuterCyl_R = RunnerCyl_R + 3;

// Slope inner roller wall, avoid film edges grabbing. Only used by 2D_extruded_roller code, not by film_roller.scad
outerWallSlopeGap = 0.5;

// resolution of individual parts in the 3D model
fragResolution = 500;

//CUSTOMIZER VARIABLES END



/* What is this thing?
    Guide roller for common film formats and also for SMD component tape feed.
    Optional outer guide walls and sprocket teeth.
    Adjustable features: guide wall slopes, number of sprockets, sprocket slopes & height....

Ultimate goal:
    Create generic design to suit all the different 8, 16, 35, .... film formats
    AND even SMD tape (16mm seems fit as is, but is likely to need tweaking for more reliable feeding!)

Current status:
    2014-09-14. Untested work in progress for 16mm film.
    Can already simply adjust features. Structure in place to easily switch to other formats.
    Just need data entry & testing for the other formats.

Version 0.61 2014-10-13
    -------------------------------------------------------------------------------------------------
USAGE:
	To add/remove outer guide walls or sprockets, in "2D_extruded_roller.scad" or "film_roller.scad":
        //Select which parts to display
        addSprockets = true;
        addOuterGuideEdges = false;

	To adjust individual features - edit the configuration file matching your chosen film size, eg "16mm.scad".
	Many features are calculated from basic parameters.
	For example the number of sprockets and the frame height combine to set the roller circumference and thus the radius.

	All the openSCAD source files must all be in same directory.
	Open "FilmMain.scad" in openSCAD then compile as usual.
	"FilmMain.scad" shows how to display one of each type of roller/capstan and in/exclude outer guide edges and sprockets.
    -------------------------------------------------------------------------------------------------

Other notes:
    - If sprockets are floating unattached out of position, refer to USAGE notes above on selecting roller drawing type.
    - Also zoom in a LOT to check sprockets are properly embedded in roller and do not have edge gaps, or conversely embedded to deep.
        If they do, adjust sprocketEmbed parameter.
	- film_roller.scad - does not have sloping inner edge on outer guide walls.

TO DO:
    - finish parameters for all formats 8, 16, 35, .... film formats & SMD
    - add option to make one/both outer edges a cog - expect this will help driving stack of multiple SMD rollers
        ... or 'down' on the shaft - ie add extra cylinder that is also cog.  (Less preferred as would make each roller fatter  - takes more space!)
    - Sprockets - Currently 2 per frame, at frame edges. Cater for more/less per frame and different positions.
        ... sprockets on one/both sides.....
    - create the physical objects and test
    - plus more TO DO in code

Credits:
  - http://openSCAD.org
  - http://en.wikipedia.org/wiki/16_mm_film
  - http://www.paulivester.com/films/filmstock/guide.htm
  - http://motion.kodak.com/motion/uploadedFiles/US_plugins_acrobat_en_motion_newsletters_filmEss_11_Film_Specs.pdf

License:
    Film-SMD-Roller-Capstan by Spanner888 at {U}sable{D}evices is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
    Permissions beyond the scope of this license may be available via http://usabledevices.com/2011/11/contact-emails-and-legal-and-copyright-information/.

    Blog of hardware build and other Telecine info can be found at http://usabledevices.com/category/telecine/
    gitHub:	 http://github/spanner888
    thingiverse: http://www.thingiverse.com/user:spanner888


Version 0.71 2014-09-30
*/


// Add one 2D_extrude_roller at offset to the "right"
 if (addSprockets == "yes") {
         color("orange")
    translate([0,28,0])
    TwoDExtrudeRoller(addOuterGuideEdges);
    translate([0,28,0])
    color("green")
    if (addOuterGuideEdges  == "yes") {
        sprocketRing(OuterCyl_H + RunnerCyl_H/2, spkt_H, spkt_W, spktCorner_R, spkt_L);
    }
    else{
        sprocketRing(RunnerCyl_H/2, spkt_H, spkt_W, spktCorner_R, spkt_L);
    }
}
else {
    color("brown")
    translate([0,55,0])
    TwoDExtrudeRoller(addOuterGuideEdges);
}

// Add ONE film_roller - created from cylinders
 if (addSprockets == "yes") {
    if (addOuterGuideEdges  == "yes") {
        sprocketRing(OuterCyl_H + RunnerCyl_H/2, spkt_H, spkt_W, spktCorner_R, spkt_L);
    }
    else{
        sprocketRing(RunnerCyl_H/2, spkt_H, spkt_W, spktCorner_R, spkt_L);
    }
}
color("silver")
film_roller(addOuterGuideEdges);


/* All the helper modules etc are below here! */

// SPROCKET START

// ASSUMPTION: embedding sprockets will reduce actual base size!!!!!
// hopefully this will give just enough slop for good fit :), else have to increase base size!

/*sprockets should be more oval shaped?
	 how to bevel or round edges of a cylinder????
	... actualy do NOT have to be round/oval
	B&H ones are made ffrom FLAT steel and FLAT beveled
	... so always have FLAT surfaces on contact with film!!!!!!

	?? so make as cube, then difference with TWO dif pyramids to set base & top bevels/slopes??
	simpler = just TWO dif pyramids to set base & top bevels/slopes??
.. MORE complete .. back to cube + ROUND the corners as have the sprocket corner radius
...then bevel with two pyramids!!!!

*/

/*sprockets
  *** ACTUALLY AT LEAST THREE DIF SPROCKET HOLE SHAPES: 16mm, Kodak, B&H
  .. need to determine for EACH FILM ... and even each clip on a film!!!!!
  ... see below in standards section

  Need to design sprocket type for each film ... or a generic type!!!!
*/

/**
*****************************************************************************
*** RunnerCyl_R IS CRITICAL - SETS SPROCKET SPACING = FRAME PERF SPACING!!!!
*** ?? CALC FROM DIAMETER = numSprockets*Sprocket-pitch, SO RADIUS = numSprockets*Sprocket-pitch/2&pi
***
******************************************************************************
*/

///////////////////////////////////////////////////////////////////////////////////////////
// now draw the parts
///////////////////////////////////////////////////////////////////////////////////////////
$fn = fragResolution;

// Module to draw ONE sprocket
module sprocket(s_height, s_L, sCorner_R, s_W){
	//need to do 2D shape - THEN extrude!!!!!
	rotate(a=[0,180,0]){			// rotate to get sprocket facing outwards!
		linear_extrude(height = s_height, center = true, convexity = 10, scale=1.5)
		minkowski()
		{
		   square([(s_W - 2*sCorner_R ), (s_L - 2*sCorner_R)], center = true, $fn = fragResolution);
		   circle(r=sCorner_R, center = true);
		}
	}
}


// Now draw Aa ring of ALL the sprockets in final position
//film drive sprockets, by default dir of cyl is "up Z axis" ... 3rd param
module sprocketRing(shaft_H, s_height, s_W, sCorner_R, s_L){
	color("red")
	for ( i = [0 : 1 : numSprockets-1 ] )
	{
	   rotate( [90, 0, i * 360 / numSprockets])
	   translate([0,
                    shaft_H,
                    RunnerCyl_R + spkt_H/2 - sprocketEmbed // set sprockets at this radius. + spkt_H/2 as drawn with "center = true".
                    ])
        sprocket(s_height, s_W, sCorner_R, s_L);
    }
}
// SPROCKET END

// FILM_ROLLER START
//*** ASSUMPTION: SPROCKETS ARE IN CENTER OF RUNNER!!!!!!!!


/* mounting shaft hole
	... Does it have to go ALL the way through??
 	... add a flat spot to mate with shaft?
	?? adjust hole size for tightish fit on shaft?????????
*/

//... should the INSIDE edges of the outer guide edges have slight slope ?
// - ie thinner at top edges to help film slot in easier.
// ... or at LEAST a rounded top edge?
/* see Extruding a Polygon

Extrusion can also be performed on polygons with points chosen by the user.

Here is a simple polygon and its (fine-grained: $fn=200) rotational extrusion (profile and lathe). (Note it has been rotated 90 degrees to show how the rotation will look, the rotate_extrude() needs it flat).

rotate([90,0,0])        polygon( points=[[0,0],[2,1],[1,2],[1,3],[3,4],[0,5]] );
// --------------------------------------------------------------------------- ;
rotate_extrude($fn=200) polygon( points=[[0,0],[2,1],[1,2],[1,3],[3,4],[0,5]] );
*/


// ** b&h - non-sprocket side RunnerCyl film surface slopes INWARDS!!!

/* how to MEASURE/VALIDATE sizes before creating/printing?
Getting input

  Now we have variables, it would be nice to be able to get input into them instead of setting the values from code.
  There are a few functions to read data from DXF files, or you can set a variable with the -D switch on the command line.
  Getting a point from a drawing
  Getting a point is useful for reading an origin point in a 2D view in a technical drawing.
  The function dxf_cross will read the intersection of two lines on a layer you specify and return the intersection point.
  This means that the point must be given with two lines in the DXF file, and not a point entity.
  OriginPoint = dxf_cross(file="drawing.dxf", layer="SCAD.Origin",
			  origin=[0, 0], scale=1);
  Getting a dimension value
  You can read dimensions from a technical drawing. This can be useful to read a rotation angle, an extrusion height, or spacing between parts. In the drawing, create a dimension that does not show the dimension value, but an identifier. To read the value, you specify this identifier from your script:
  TotalWidth = dxf_dim(file="drawing.dxf", name="TotalWidth",
			  layer="SCAD.Origin", origin=[0, 0], scale=1);

  For a nice example of both functions, see Example009 and the image on the homepage of OpenSCAD.
*/
/*******************************************************************************
*** RunnerCyl_R IS CRITICAL - SETS SPROCKET SPACING = FRAME PERF SPACING!!!!
?? CALC FROM DIAMETER = numSprockets*Sprocket-pitch, SO RADIUS = numSprockets*Sprocket-pitch/2&pi

*******************************************************************************/


// draw without Outer Guide walls
module film_rollerPartial(){
    //First join all the cylinders into the roller shape
    union(){
        // central core cylinder
        //translate ([0,0,RunnerCyl_H - frameGap]) cylinder(h = CoreCyl_H, r = CoreCyl_R);
        cylinder(h = CoreCyl_H + 2 * RunnerCyl_H, r = CoreCyl_R);


        // runners .. film runs on these two cylinders
        translate ([0,0,RunnerCyl_H + CoreCyl_H + frameGap]) cylinder(h = RunnerCyl_H - frameGap, r = RunnerCyl_R);
        cylinder(h = RunnerCyl_H - frameGap, r = RunnerCyl_R);
    }
}

// draws the film roller based on pre-selected film standard size, #sprockets...
// sprockets are not drawn here, but # of sprocketcs does set runner radius
module film_rollerAll(){
    //First join all the cylinders into the roller shape
    union(){
        translate ([0,0,OuterCyl_H]) film_rollerPartial();
        translate ([0,0,CoreCyl_H + 2*RunnerCyl_H + OuterCyl_H]) cylinder(h = OuterCyl_H, r = OuterCyl_R);
        cylinder(h = OuterCyl_H, r = OuterCyl_R);
    }
}

module film_roller(addOGEdges = "yes"){
    if (addOGEdges == "yes"){
        difference() {
            film_rollerAll();
            // now difference (subtract) the mounting shaft hole
            //translate ([0,0,-(RunnerCyl_H + OuterCyl_H)])
            cylinder (h = (CoreCyl_H + 2*RunnerCyl_H + 2*OuterCyl_H), r = shaft_R);
        }
    }
    else{
        difference() {
            film_rollerPartial();
            // now difference (subtract) the mounting shaft hole
            //translate ([0,0,-(RunnerCyl_H + OuterCyl_H)])
            cylinder (h = (CoreCyl_H + 2*RunnerCyl_H + 2*OuterCyl_H), r = shaft_R);
        }
    }
}
// FILM_ROLLER END

// 2D_extruded_roller START
// changes here are NOT ALWAYS automatically compiled/reloaded. Need to press F5 in main app!

//TODO review rollerOutlineAll/Partial
// make rollerOutlineAll call rollerOutlinePartial???
// need think about shaft position....

// for module rollerOutlineAll
L0 = 0;                                 // first outer edge
L1 = L0 + OuterCyl_H;                   // + outer wall thickness
L2 = L1 + RunnerCyl_H - frameGap;       // + runner thickness
L3 = L2 + CoreCyl_H + 2 * frameGap;     // + central shaft
L4 = L3 + RunnerCyl_H - frameGap;       // + runner thickness
L5 = L4 + OuterCyl_H;                   // + outer wall thickness

// for module rollerOutlinePartial
LP0 = 0;                                // first outer edge
LP1 = LP0 + RunnerCyl_H - frameGap;     // + runner thickness
LP2 = LP1 + CoreCyl_H + 2 * frameGap;   // + central shaft
LP3 = LP2 + RunnerCyl_H - frameGap;     // + runner thickness


// complete with outer guide walls
module rollerOutlineAll(){
    // see Extruding a Polygon doco/help
	// each line below draws a line vertical to the shaft
	// lines ALONG/PARALLEL to shaft are drawn by {line:last to next_line:first} data pairs!
	polygon( points=[[shaft_R, L0], [OuterCyl_R, L0],
				[OuterCyl_R, L1-outerWallSlopeGap], [RunnerCyl_R, L1],	    //outer guide wall
				[RunnerCyl_R, L2], [CoreCyl_R, L2],	                        // runner
				[CoreCyl_R, L3], [RunnerCyl_R, L3], 			            // core
				[RunnerCyl_R, L4], [OuterCyl_R, L4 + outerWallSlopeGap],    // runner
                [OuterCyl_R, L5], [shaft_R, L5]     				        //outer guide wall
								]);
}

// complete with outer guide walls
module rollerOutlinePartial (){
    // see Extruding a Polygon doco/help
	// each line below draws a line vertical to the shaft
	// lines ALONG/PARALLEL to shaft are drawn by {line:last to next_line:first} data pairs!
	polygon( points=[[shaft_R, LP0], [RunnerCyl_R, LP0],	        //outer edge
				[RunnerCyl_R, LP1], [CoreCyl_R, LP1],	            // runner
				[CoreCyl_R, LP2], [RunnerCyl_R, LP2], 			    // runner
				[RunnerCyl_R, LP3], [shaft_R, LP3]    				//outer edge
								]);
}

//Draw with/out the outer guide edges, according to parameter passed in.
module TwoDExtrudeRoller(addOuterGuideEdges = "yes"){
    if (addOuterGuideEdges == "yes" ){
        //rotated 90 degrees to show how the rotation will look, the rotate_extrude() needs it flat).
        //rotate([90,0,0])
        rotate_extrude($fn=200) rollerOutlineAll();
    }
    else {
        rotate_extrude($fn=200) rollerOutlinePartial();
    }
}
// 2D_extruded_roller END
