// Attachment for CF rod to brace Kossel delta printer towers.

// Width of the aluminum extrusion beam
railWidth=20;

// Width of the slot in the aluminum extrusion beam
railSlotWidth=6.2;

attachBlockThickness=railSlotWidth+0;

railSlotInsertLength=railSlotWidth*2/3;
railSlotInsertDepth=railSlotWidth/3;

railSlotInsertClearance=0.1+0;

// Diameter of the bold used to attach to the aluminum beam
railAttachScrewHoleDia=4;

// diameter of the bold used for clamping
rodClampScrewHoleDia=2.5;

railSlotInsertWidth=railSlotWidth-railSlotInsertClearance*2;

// Angle up/down from vertical for the brace rod
rodAngle=45;

// delta printer towers are arranged as equilateral triangles
// so this angle should be fixed.  Applied around y-axis
// in this model to angle in the rod clamp and align it
// parallel with one of the "side faces" of the printer.
//                  -----------------
//                     *  \  60
//                    * *  \
//    top view       *   *  \
//                  *     *  \ 
//                 * * * * *
//
// Note: If the rod starts out at 90, this needs to be
// 60-90 or -30
rodRailAlignmentAngle=-30+0; 

// Amount the clamp ears stick out past the rod
rodClampEarLength=9;

// Width of the slot that allows clamping around the rod.
rodClampEarGap=1;

// Diameter of the CF rod to be used
rodDia=6;

// Amount of material between the rod and the edge
rodClampInset=5;

// Top to bottom measurement for the rod clamp block
rodClampThickness=10;

// Radius of the corners on the block parts
smoothnessRadius=1;

rodClampWidth=rodClampInset*2+rodDia;
rodClampLength=rodClampInset+rodDia+rodClampEarLength;

/*
 * Move the top plate of the clamp over enough to match the angle
 * of the rod hole.
 * tan(angle) = opposite/adjacent --> tan(angle)*adjacent = opposite
 * so then it gets multiplied by the actual thickness of the block.
 *              |--------need this
 *              v
 *    -------- ---|- <--- this is rodClampThickness
 *    \        \  | 
 *     \        \*| <--- this is rodAngle (from vertical)
 *      \        \|
 *       ---------
 */
topSlopeTranslateY=tan(rodAngle)*rodClampThickness;

overlap=0.01+0;
$fn=50+0;

attachBlock();
// position
translate([railWidth/2,railWidth/2-rodClampWidth/2,0])
// move back up after rotation to re-align bottom
translate([0,0,attachBlockThickness])
rotate([0,-rodRailAlignmentAngle,0])
// move down before rotation to align edge
translate([0,0,-attachBlockThickness])
// reposition after mirror
translate([0,+rodClampWidth,0])
mirror([0,1,0])
    rodClamp();

module rodClamp() {
    
    difference() {
        // fix minkowski shift across axes
        translate([smoothnessRadius, smoothnessRadius, smoothnessRadius])
        minkowski() {
            hull() {
                cube([rodClampLength-smoothnessRadius*2, 
                    rodClampWidth-smoothnessRadius*2, overlap]);
                translate([0, topSlopeTranslateY, 
                        rodClampThickness-overlap-smoothnessRadius*2])
                    cube([rodClampLength-smoothnessRadius*2, 
                        rodClampWidth-smoothnessRadius*2,overlap]);
            }
            sphere(r=smoothnessRadius, $fn=20);
        }
        // rod hole
        translate([rodClampInset+rodDia/2,rodClampWidth/2,0]) // position
            rotate([-rodAngle,0,0]) // slant
            translate([0,0,-rodClampThickness*3]) // shift to fully cut block
                cylinder(d=rodDia, h=rodClampThickness*6);
        // slot
        translate([rodClampInset+rodDia,
            rodClampWidth/2-rodClampEarGap/2,0]) // position
            rotate([-rodAngle,0,0]) // slant
            // shift to fully cut block
            translate([-rodClampEarLength/2,0,-rodClampThickness*3]) 
                cube([rodClampEarLength*2, rodClampEarGap,
                    rodClampThickness*6]);
        // screw hole
        translate([rodClampInset+rodDia+rodClampEarLength/2,
            0,rodClampThickness/2])
        rotate([-90,0,0])
        translate([0,0,-rodClampWidth*3])
        cylinder(d=rodClampScrewHoleDia, h=rodClampWidth*6);
        
        // Note: countersink amount calculated by a ratio of
        // the rod angle and then limited by a little less than
        // half of the total width less half the slot gap to 
        // prevent cutting into the slot gap.
        counterSinkAmount = min(topSlopeTranslateY*(rodAngle/60),
                rodClampWidth*0.45-rodClampEarGap/2);

        // Cut flat round countersink for screw head
        translate([rodClampInset+rodDia+rodClampEarLength/2,
            counterSinkAmount,
            rodClampThickness/2])
        rotate([-90,0,0])
        translate([0,0,-rodClampWidth]) // start below z-axis
        cylinder(d=rodClampScrewHoleDia*2.5, h=rodClampWidth);
        
        // Cut flat hex countersink for nut
        translate([rodClampInset+rodDia+rodClampEarLength/2,
            rodClampWidth+topSlopeTranslateY-counterSinkAmount,
            rodClampThickness/2])
        rotate([-90,0,0])
        cylinder(d=rodClampScrewHoleDia*2.5, h=rodClampWidth, $fn=6);
    }
}


module attachBlock() {
    difference() {
        union() {
            // main block
            translate([-railWidth/2,0,0])
            // fix minkowski shift across axes
            translate([smoothnessRadius, smoothnessRadius, smoothnessRadius])
            minkowski() {
                cube([railWidth-smoothnessRadius*2, 
                    railWidth-smoothnessRadius*2, 
                    attachBlockThickness-smoothnessRadius*2]);
                sphere(r=smoothnessRadius, $fn=20);
            }

            // insert tab 1
            railSlotInsertPosition1 = railWidth/6-railSlotInsertLength/2;
            translate([-railSlotInsertWidth/2,railSlotInsertPosition1,
                attachBlockThickness-overlap])
            cube([railSlotInsertWidth, railSlotInsertLength,
                railSlotInsertDepth]);

            // insert tab 2    
            railSlotInsertPosition2 = railWidth*5/6-railSlotInsertLength/2;
            translate([-railSlotInsertWidth/2,railSlotInsertPosition2,
                attachBlockThickness-overlap])
            cube([railSlotInsertWidth, railSlotInsertLength,
                railSlotInsertDepth]);    
        }
        translate([0,railWidth/2,-overlap])
            cylinder(d=railAttachScrewHoleDia, 
                h=attachBlockThickness+overlap*2);
    }
}