// model: Prusa i3 MK2 Y Chassis Bearing Straps
//        This replaces the zip ties that tend to stretch and can reduce accuracy over time. Optionally, also replace the entire strap and bearing with a 1-piece printed version that has been tested extensively across multiple users and show to both improve accuracy print accuracy over the stock zip-ties of the MK2, and reduces printer noise over using Prusa LM8UU linear bearings included in both the MK2 and MK2S.
// author: fiveangle@gmail.com
// date: 2017nov18
// notes: Big thanks to @nicw who performed extensive empirical and objective testing, and wrote original installation steps below.
// - Print 2x "left" and 1x "right". Use 6x M3x10mm button-head or socket-head screws to secure. If using the integrated bearing version, use this procedure for the best experience:
// - Drill rinse rods with isopropyl alcohol
// - Mount both left bushings snug but not tight to bed carriage
// - Use drill + rods through both left side bushings. Keep spinning rod until the bracket itself slides down by gravity alone (slight angle). Okay to have some stiction, but shouldn't take a lot of force to move.  Keep the rods moist with isopropyl alcohol to ensure PLA bearing surfaces are not melted due to friction during the process.  You want the bearings to stretch/wear, but not melt.
// - Tighten the bearings on the left rod evenly while moving rod through both bearings to ensure they are in perfect alignment with each other.
// - Do the same wear-in procedure with the single right bearing without mounting to bed (you will align right bearing parallel to left rod after bed installation).
// - Mount the right bearing snug but not tight to the bed carriage
// - Mount bed carriage with rods on Prusa, adjust width and skew of threaded rods until the right rod is perfectly parallel to the left. When parallel, the bed moves without belt connected smoothly the entire length of the bed (bearings will stick at either end or in the middle if rods are not parallel to each other).
// - Begin to tighten the mounting screws for the right bracket.  This should result in the bed sticking again at some point(s) of it's travel.  Continue to adjust the threaded rods until the bed moves smoothly and consistently the entire range of motion.  This will be the most tedious part of the installation due to threaded rods changing alignment after tightening [Protop: this process also just happens to be the best method to align the Y axis smooth rods, even if you intend to replace the integrated bearings with standard ones after alignment, since linear bearings will dig into rods instead of sticking if not parallel].
// - Slide bed all the way forward away from end-stop switch. Then tighten down fully, keeping bracket there for reinforcement. 
// - Check that the stiction isn't too great. There should be NO stiction if you could theoretically push with equal force on both sides.
// - Attach belt attachment bracket to bed.
// - Double-check your y-axis belt angles. 
// - Print like nobody's watching. 
//
// history:
//     -1.2.1 - 2017nov19 - Integrated @andyhomes stringed LM8UU bushing library so will work with Customizer
//                        - Fixed layerHeight calculation and other Customizer bugs introduced with 1.2.0
//     -1.2.0 - 2017nov18 - Removed all bearing options other than @andyhomes version
//                        - Added printed bearing install instructions from @nicw
//     -1.1.4 - 2017jul02 - Added @mightynozzle https://www.thingiverse.com/thing:2202854 option
//     -1.1.3 - 2017jun04 - Added @wbrucem https://www.thingiverse.com/thing:2144803 "heavy duty" option
//     -1.1.2 - 2017feb26 - Added @ksa https://www.thingiverse.com/thing:396232 option
//     -1.1.1 - 2017jan02 - Added @Argutus http://www.thingiverse.com/thing:1864526 option
//     -1.1.0 - 2016dec29 - Incorporated @andyhomes stringed LM8UU bushing https://www.thingiverse.com/make:282174
//     -1.0.2 - 2016nov04 - Increased width of tabs and introduced adjustable screw length so holes don't go all the way through, to help some with poor layer adhesion causing PLA-printed straps to crack
//     -1.0.1 - 2016nov01 - Fixed incorrect tab thickness calculation (tab thickness would actually reduce when increasing shells or nozzle width, causing Customizer versions to potentially be unusable)
//     -1.0.0 - 2016oct11 - Released
//
$fn = 120;

// use <stringed_bushing.scad> ; // import @andyhomes LM8UU replacement library

bearingDiameter = 15; // [15.00:Tight - 15.00mm, 15.05:default - 15.05mm, 15.1:Loose - 15.10mm, 15.2:Lucy Goosey - 15.20mm]
bearingLength = 24; // [15.0:Tight - 15.00mm, 15.1:default (to ridge) - 15.05mm, 15.2:Loose - 15.20mm, 24.2:Full bearing length - 24.20mm]
bearingType = "left"; // [left:Left, right:Right]
nozzleWidth = 0.45; // used to calculate strap thickness
shellsForStrap = 0; // [0:Printed Bearing - 0 shells, 5:default - 5 shells] // adjust with nozzleWidth to get desired strap thickness
bearingRidgeDiameter = bearingDiameter - 1.0;
bearingRidgeWidth = 0.0; // [0:Printed Bearing - 0mm, 0.8:default - 0.8mm]
mountLength = bearingLength + 2 * bearingRidgeWidth;
screwDiameter = 2.8; // [2.8:Tight - 2.8mm, 2.9:default - 2.9mm, 3.0:Loose 3.0mm]
screwLength = 9.6; // [9-10]
mountHoleSeparation = 22.9 - (22.9 - 17.2) / 2;
strapThickness = shellsForStrap * nozzleWidth;
shellsForScrews = 2.0;
mountWidth = mountHoleSeparation + 2 * screwDiameter + 4.8;
prusaYChassisThickness = 6.2; // Measurement of your Y Chassis thickness
prusaYChassisBearingSlotWidth = bearingDiameter - 2;
prusaYChassisbearingSinkage = 4.3; // Measure Y chassis to bearing distance using depth gauge in bearing slot minus about 0.2 mm for pretension
mountTabThickness = (prusaYChassisThickness - prusaYChassisbearingSinkage) + 5 +
    shellsForStrap * nozzleWidth;
mountDiameter = bearingDiameter + (2 * strapThickness);
mountHeight = mountDiameter;


// polyhole cylinder fitment method: http://hydraraptor.blogspot.com/2011/02/polyholes.html
module polyhole(d, h) {
    n = max(round(2 * d), 3);
    rotate([0, 0, 180])
        cylinder(h = h, r = (d / 2) / cos(180 / n), $fn = n);
} // polyhole cylinder fitment method: http://hydraraptor.blogspot.com/2011/02/polyholes.html


// @andyholmes stringed bearing LM8UU replacement modules

// Outer diameter correction (mm). Positive values increase diameter.
bushingODCorrection = 0.1; // [-0.5:0.05:0.5]

// Inner diameter correction (mm).  Positive values increase diameter.
bushingIDCorrection = 0.05; // [-0.5:0.05:0.5]

// Bushing length (mm).
bushingLength = bearingLength; // [5:1:50]

// Layer height (mm).
layerHeight = 0.30; // [0.05:0.01:1.0]

// Each subsequent layer is twisted on (degrees)
layerTwistAngle = 19; // [15:60]

bushingOD = bearingDiameter + bushingODCorrection;
bushingID = 8 + bushingIDCorrection;

module bushing_simple(od = 15, id = 8, len = 24, lh = 0.2, lta = 30) {
    union()
		for (i = [0: len/lh-1]) {
        li = lta * i %120;
			  translate([0, 0, i * lh])
				    render() layer(od, id, lh, li);
		}
}


module layer(od = 15, id = 8, lh = 0.2, twa=0) {
    difference()  {
        cylinder(d = od, h = lh, $fn = 48);
      
        rotate(a = twa, v = [0,0,1])
				    cylinder(r = id, h = lh*2, $fn = 3);
	  }
} // @andyholmes stringed bearing LM8UU replacement modules



module bearing() {
    difference() {
        // mount body
        union() {
            cube([mountWidth, mountLength, mountTabThickness]);

            translate([mountWidth / 2, 0, (bearingDiameter / 2) + strapThickness])
                rotate([-90, 0, 0])
                    cylinder(r = (bearingDiameter / 2) + strapThickness, h = mountLength);
        } // mount body

        // bearing core
        union() {
            translate([mountWidth / 2, 0, (bearingDiameter / 2) + strapThickness])
                rotate([-90, 0, 0])
                    cylinder(r = ((bearingRidgeDiameter / 2)), h = mountLength);

            translate([mountWidth / 2, (mountLength - bearingLength) / 2, (bearingDiameter / 2) + strapThickness])
                rotate([-90, 0, 0])
                    polyhole(bearingDiameter, bearingLength);
        } // bearing core

        // prusa bearing sink
        cube([mountWidth + 10, mountLength, prusaYChassisThickness - prusaYChassisbearingSinkage + strapThickness]);

        if (bearingType == "left")
            cube([
                mountWidth,
                mountLength - (mountLength / 2 + screwDiameter / 2 + shellsForScrews),
                bearingDiameter + 2 * shellsForScrews
            ]);

        translate([mountWidth / 2 - prusaYChassisBearingSlotWidth / 2, 0, 0])
            cube([
                prusaYChassisBearingSlotWidth,
                mountLength,
                (bearingDiameter + 2 * strapThickness) / 2
            ]); // prusa bearing sink


        // screw holes
        translate([(mountWidth - mountHoleSeparation) / 2, mountLength / 2, 0])
            rotate([0, 0, 0])
                cylinder(
                    r = screwDiameter / 2,
                    h = screwLength - prusaYChassisThickness + mountTabThickness - prusaYChassisbearingSinkage
                );

        translate([mountWidth - (mountWidth - mountHoleSeparation) / 2, mountLength / 2, 0])
            rotate([0, 0, 0])
                cylinder(
                    r = screwDiameter / 2,
                    h = screwLength - prusaYChassisThickness + mountTabThickness - prusaYChassisbearingSinkage
                ); // screw holes
    }

}


// doit
echo("/////////////////////////////////////////////////////////////////////////");
echo("// Build Parameters:");
echo("//     bearingType = ", bearingType);
echo("//     mountlength = ", mountLength);
echo("//     bushingID = ", bushingID);
echo("//     prusaYChassisThickness = ", prusaYChassisThickness);
echo("/////////////////////////////////////////////////////////////////////////");

translate([0, -(prusaYChassisThickness - prusaYChassisbearingSinkage) -
    strapThickness, mountLength
])
rotate([-90, 0, 0])
union() {
    translate([mountWidth / 2, 0, (bearingDiameter / 2) + strapThickness])
        rotate([-90, 0, 0])
            bushing_simple(bushingOD, bushingID, bushingLength, layerHeight, layerTwistAngle);
  
    bearing();
}