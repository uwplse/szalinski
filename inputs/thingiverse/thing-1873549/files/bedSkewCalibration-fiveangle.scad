// model: Bed XY Skew Calibration Strips
//        Generates calibration strips that allow you to determine approximate level of skew in XY axes for 3D printers with Cartesian gantry systems.
// filename: bedSkewCalibration-fiveangle.scad
// original: http://www.thingiverse.com/thing:1873549
// author: fiveangle@gmail.com
// date: 2016nov05
// ver: 0.9.1
// notes: Set generateOrthogonalBisector to "True" to generate second calibration strip. Insert a segment of filament into the hole end of printed calibration strip to align them; read the resulting skew on the vernier scale on the other end. If center marks are aligned, XY axes are square within the resolution of your extrusion width.  If they are off.  Adjust, wash, rinse, repeat. I'll probably update again shortly, so please send me bugfixes/improvement (and your history entry) if you wish, and I will incorporate/atribute.
// printing notes:
//     * Perform all other normal calibrations first (decent summary here: https://www.3dhubs.com/talk/thread/howto-calibrate-tune-and-fine-tune-your-printer-and-filament)
//     * Print with one shell
//     * Print with PLA
//     * Print with lowest temperature possible
//     * If printing on heated bed, wait for bed to get close to room temperature before removing print
//     * Use a filament color with good reflectivity for easiest reading of vernier scale (silver, for example). 
// todo: Fix scaling for greater than 1mm, add math to maximumize available bed length, currently testing different methods to produce clearer verniers
// history:
//     -0.9.1 - 2016nov12 - fiveangle@gmail.com - Fixed Customizer bugs:
//                                                    - apparently Customizer doesn't work with Boolean value/comment pairs
//                                                    - fixed filamentDiameter Customizer value/comment pairs transposed
//                                              - Changed maximumSkew math to account for +1 value of vernier for 
//                                              - Reduced maximum skew from 11mm to 6mm (if your bed is more than that, you got problems :)
//                                              - Fixed 3mm filament diameter to the true value of 2.85mm (I've never owned a printer that used it myself)
//
//     -0.9.0 - 2016nov05 - fiveangle@gmail.com - Released on thingiverse in order to facilitate ongoing XY calbiration discussion at https://github.com/MarlinFirmware/Marlin/issues/5116

// adjust to increase/decrease polygon count at expense of processing time (above 100 is probably useless)
$fn = 100;
bedX = 250;
bedY = 210;

// Which diagonal to make (you need to generate one of each) ?
generateOrthogonalBisector = 1; // [0:XY Bisector Diagonal, 1:XY Orthogonal Diagonal]

filamentDiameter = 1.75; // [1.75:1.75mm, 2.85:2.85mm]

// Should be at least the Extrusion Width set in your slicer or the measurement marks will not print. +0.02 to +0.04 mm seems to work well to allow most slicers to generate correct markings
extrusionWidth = 0.42;
layerHeight = 0.2;
stripWidth = 6 * extrusionWidth;
stripHeight = 4 * layerHeight;

// Math to auto-adjust for spacing other than 1 extrusion width is not implemented yet so this currently works for only "1"
scaleSpacing = 1;

originAlignmentSpacing = 4; 

bufferLength = 2 * stripWidth; // to ensure we don't run out of bed. With new alignment method of using a piece of filament, probably need to make this calculation more rigorous to support all printers (e.g. ones with 1.2mm nozzles, etc) but this should be enough for most typical printers, while still using most of the bed to get highest accuracy.

// WARNING: Calibration strip length will be optimized to measure no more than this amount of skew between axes.  Set to as small as possible maximize the distance being measured accross your bed, but this should be no smaller than the maximum physical skew size possible.  If you are confident your printer is pretty square, feel free to drop this lower.  If you go too small on this value, there may not be enough measurement marks available on the XY bisector strip needed in order to read the vernier scale, so you'll have re-Customize setting this larger.
maximumSkew = 6;

// polyhole cylinder fitment method: http://hydraraptor.blogspot.com/2011/02/polyholes.html
module polyhole(h, d) {
    n = max(round(2 * d), 3);
    rotate([0, 0, 180])
    cylinder(h = h, r = (d / 2) / cos(180 / n), $fn = n);
}
bisectorLength = pow(pow(bedX - (maximumSkew-1), 2) + pow(bedY - (maximumSkew-1), 2), 1 / 2) - 2 * pow(2, 1 / 2) * 4 * extrusionWidth;

// output length of calibration strip to console during compile (for sanity check)
echo("bisectorLength", bisectorLength);

module calibrationStrip() {
    difference() {
        union() {
            // main strip
            translate([(filamentDiameter + 4 * extrusionWidth) / 2, 0, 0])
                cube([bisectorLength - (filamentDiameter + 4 * extrusionWidth) / 2, stripWidth, stripHeight]);
            translate([(4 * extrusionWidth + filamentDiameter) / 2, stripWidth / 2, 0])
                cylinder(d = filamentDiameter + extrusionWidth * 6, h = stripHeight);
        }
        translate([(4 * extrusionWidth + filamentDiameter) / 2, stripWidth / 2, 0])
            polyhole(stripHeight, filamentDiameter);
    }

    // alignment pins (now just a single one used for visual confirmation of filament method)
    for (i = [0])
        translate([originAlignmentSpacing * extrusionWidth * (i) + 3 * extrusionWidth + filamentDiameter, 0, stripHeight])
    cube([2 * extrusionWidth, stripWidth, 10 * layerHeight]);
    // abandoned alignment pin method that generated interlocking pins that would snap together, but it resulted in slight offsets - may revisit
    //for(i=[(generateOrthogonalBisector ? 1 : 0):4])
    //    translate([originAlignmentSpacing*extrusionWidth*(i)-(generateOrthogonalBisector ? extrusionWidth : 0),0,stripHeight])
    //        cube([extrusionWidth,stripWidth,3*layerHeight]);

    // center measure
    translate([bisectorLength - (20 + 2 * (maximumSkew-1)) / 2 - extrusionWidth - extrusionWidth / 2, -extrusionWidth / 2, stripHeight])
        cube([extrusionWidth, stripWidth + extrusionWidth, 8 * layerHeight]);

    // major measures
    for (i = [0: (10 + (generateOrthogonalBisector ? 0 : (maximumSkew-1))) / 5])
        translate([bisectorLength - (20 + 2 * (maximumSkew-1)) / 2 - extrusionWidth, 0, 0]) {
            translate([(generateOrthogonalBisector ? i * 0.9 * scaleSpacing * 5 : i * scaleSpacing * 5) - extrusionWidth / 2, 0, stripHeight])
                cube([extrusionWidth, stripWidth, 6 * layerHeight]);
            mirror([1, 0, 0]) // I first tried to nest a for loop to generate the other half of measures (and minor measures) but it didn't work so just copy/paste/mirror made quick work of it (in case it was an OpenSCAD issue) :)
                translate([(generateOrthogonalBisector ? i * 0.9 * scaleSpacing * 5 : i * scaleSpacing * 5) - extrusionWidth / 2, 0, stripHeight])
                    cube([extrusionWidth, stripWidth, 6 * layerHeight]);
        }

    // minor measures
    for (i = [0: (10 + (generateOrthogonalBisector ? 0 : (maximumSkew-1)))])
        translate([bisectorLength - (20 + 2 * (maximumSkew-1)) / 2 - extrusionWidth, 0, 0]) {
            translate([(generateOrthogonalBisector ? i * 0.9 * scaleSpacing : i * scaleSpacing) - extrusionWidth / 2, (generateOrthogonalBisector ? extrusionWidth : 0), stripHeight])
                cube([extrusionWidth, stripWidth - extrusionWidth, 4 * layerHeight]);
            mirror([1, 0, 0]) // ibid
                translate([(generateOrthogonalBisector ? i * 0.9 * scaleSpacing : i * scaleSpacing) - extrusionWidth / 2, (generateOrthogonalBisector ? extrusionWidth : 0), stripHeight])
                    cube([extrusionWidth, stripWidth - extrusionWidth, 4 * layerHeight]);
        }
}

rotate((generateOrthogonalBisector ? -1 : 1) * atan(bedY / bedX)) calibrationStrip(); // rotate model to correct angle since most slicers won't auto-center/align correctly for models longer than longest X or Y axis