/*
 * General
 */
materialThickness = 1.2;

/*
 * Bracket
 */
totalBracketWidth = 120.8-3.5;
bracketHeight = 18.5;

/*
 * PCB mount
 */
mountWidth = 8;
mountDepth = 13.4;

mountLeft = 4.8;
mountSpacing = 31.6;

mountingHoleDistance = 4.4;
mountingHoleRadius = 2.6/2;

/*
 * Bottom flap
 */
flapWidth = 7.5;
flapHeight = 10.3;
flapTransition = 4;

/*
 * Top flap
 */
topFlapDepth = 11.42;
topFlapHoleDepth = 4.3;
topFlapHoleHeight = 6.6;

topFlapOffset = -3.5;
drawBottomHole = true;

/*
 * SFP
 */
sfpLeft = 30.3;
sfpBottom = 3.35;

sfpWidth = 15.2;
sfpHeight = 10.3;

/*
 * LED
 */
ledLeft = 4.4;
ledBottom = 2;

ledWidth = 2.6;
ledHeight = 5;

$fn = 50;

/*
 * Calculated
 */
totalFlapWidth = flapWidth + flapTransition;
bracketWidth = totalBracketWidth - totalFlapWidth;

// Draw flap
translate([0, 0, bracketHeight/2-flapHeight/2]) cube([flapWidth, materialThickness, flapHeight]); // Flap
translate([flapWidth, 0, 1]) cube([flapTransition, materialThickness, bracketHeight-2]); // Transition

difference()
{
    group()
    {
        // Move main part before flap
        translate([totalFlapWidth, 0, 0])
        {
            cube([bracketWidth, materialThickness, bracketHeight]); // Main bracket
            
            // Move mounting flaps in front of bracket
            translate([mountLeft, -mountDepth, 0])
            {
                difference()
                {
                    cube([mountWidth, mountDepth, materialThickness]); // First mounting flap
                    translate([mountWidth/2, mountingHoleDistance+mountingHoleRadius, -1]) cylinder(r=mountingHoleRadius, h=materialThickness+2); // Mounting hole
                }
                
                // Move to second mounting flap
                translate([mountWidth+mountSpacing, 0, 0])
                {
                    difference()
                    {
                    cube([mountWidth, mountDepth, materialThickness]); // Second mounting flap
                    translate([mountWidth/2, mountingHoleDistance+mountingHoleRadius, -1]) cylinder(r=mountingHoleRadius, h=materialThickness+2); // Mounting hole
                    }
                }
            }
        }

        // Move to top mounting flap
        translate([totalBracketWidth-materialThickness, 0, topFlapOffset])
        {
            difference()
            {
                cube([materialThickness, topFlapDepth, bracketHeight]); // Top mounting flap
                
                if(drawBottomHole)
                    translate([-1, topFlapDepth/2-topFlapHoleDepth/2, -1]) cube([materialThickness+2, topFlapHoleDepth, topFlapHoleHeight+1]);
            }
        }
    }

    translate([sfpLeft, -1, sfpBottom]) cube([sfpWidth, materialThickness+2, sfpHeight]); // SFP slot
    translate([sfpLeft+sfpWidth+ledLeft, -1, ledBottom]) cube([ledWidth, materialThickness+2, ledHeight]); // LED slot
}