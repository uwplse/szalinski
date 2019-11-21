/******************************************************************************
 *
 *  GLOBALS
 *
 ******************************************************************************/


/* [General] */

// Effective (internal) length of the clip
armLength = 55;
// Should not be less than two times latch arm hickness plus movement gap :)
armThickness = 5;
height = 10;
latchArmThickness = 2; // [1:0.1:3]
// Simply just tollerance, must be positive for movement
latchGap = 0.4; // [0.2:0.05:0.8]
pivotGap = 0.4; // [0.2:0.05:0.8]
// Angle (in degrees) for printing area adjustment
initialArmsAngle = 30; // [15:15:90] 
/* [Hidden] */
$fa = 1;
$fs = 0.5;


/******************************************************************************
 *
 *  EXECUTION
 *
 ******************************************************************************/


lockArm();
freeArm();


/***************************************************************************
 *
 *  DIRECT MODULES
 *
 ******************************************************************************/

module lockArm()
{
    difference()
    {
        linear_extrude(height = height, convexity = 8)
            _lockArmPlane();
        translate([-armThickness - 1, -1, height / 4 - pivotGap / 2])
            cube([2 * armThickness + 1, armThickness + 1, height / 2 + pivotGap]);

        translate([armThickness + latchGap, armThickness + latchGap / 2, height / 2 - sqrt(2) / 2])
            rotate([45, 0, 0])
                cube([armLength, 1, 1]);
    }
}

module freeArm()
{
    translate([0, armThickness, 0])
        rotate([0, 0, -initialArmsAngle]) 
            translate([0, -armThickness, 0])
            {
                difference()
                {
                    union()
                    {
                        linear_extrude(height = height, convexity = 8)
                            _freeArmPlane();
                        translate([0, 0, height / 4 + pivotGap / 2])
                            cube([armThickness + pivotGap, armThickness - latchGap, height / 2 - pivotGap]);
                        translate([armThickness + pivotGap, armThickness - latchGap / 2, height / 2 - sqrt(2) / 2])
                            rotate([45, 0, 0])
                                cube([armLength, 1, 1]);
                    }
                    translate([0, 0, -1])
                        linear_extrude(height = height + 2, convexity = 8)
                            polygon([[-1, -1], [armThickness + pivotGap, 0], [0, armThickness / 2]]);

                    translate([0, 0, -1])
                        linear_extrude(height = height + 2, convexity = 8)
                            polygon([
                                [armLength + armThickness + latchGap, armThickness / 2],
                                [armLength + armThickness + latchGap + 1, armThickness / 2],
                                [armLength + armThickness + latchGap, armThickness + sqrt(2)],
                                [armLength + armThickness + latchGap - latchArmThickness, armThickness + sqrt(2)]
                                ], center = true);
                }
            }
}

/******************************************************************************
 *
 *  HELPER AND COMPONENT MODULES
 *
 ******************************************************************************/

module _freeArmPlane()
{
    translate([0, armThickness, 0])
        circle(armThickness / 2 - pivotGap / 2);
    translate([armThickness + pivotGap, 0, 0])
        square([armLength, armThickness - pivotGap / 2]);
}

 module _lockArmPlane()
 {
    union()
    {
        difference()
        {
            union()
            {
                translate([0, armThickness, 0])
                    circle(armThickness);
                translate([0, armThickness + latchGap / 2, 0])
                    square([armLength + armThickness + latchGap, armThickness - latchGap / 2]);
                translate([armLength + armThickness - 2 * latchArmThickness + latchGap, 2 * armThickness - latchArmThickness, 0])
                    square([3 * latchArmThickness + latchGap, latchArmThickness]);
                translate([armLength + armThickness + 2 * latchGap, - latchGap, 0])
                    square([latchArmThickness, 2 * armThickness + latchGap]);
                polygon([
                    [armLength + armThickness + 2 * latchGap + latchArmThickness, -latchGap],
                    [armLength + armThickness + latchGap - latchArmThickness * 0.75, -latchGap],
                    [armLength + armThickness + latchGap - latchArmThickness * 0.75, -latchGap - latchArmThickness / 2],
                    [armLength + armThickness + 2 * latchGap, -latchGap - latchArmThickness * 1.5],
                    [armLength + armThickness + 2 * latchGap + latchArmThickness, -latchGap - latchArmThickness * 1.5]
                    ]);
            }
            translate([0, armThickness, 0])
                circle(armThickness / 2 + pivotGap / 2);
            translate([armLength + armThickness - 2 * latchArmThickness, armThickness * 2 - latchArmThickness - latchGap, 0])
                square([2 * latchArmThickness + latchGap, latchGap]);
            translate([armLength + armThickness + 2 * latchGap + latchArmThickness, armThickness * 2 - latchArmThickness/2, 0])
                rotate([0, 0, 45])
                    square(latchArmThickness);
            
        }    
    }
 }