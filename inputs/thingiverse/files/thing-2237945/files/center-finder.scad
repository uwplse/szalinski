/******************************************************************************
 *
 *  GLOBALS
 *
 ******************************************************************************/

/* [General] */

// Overall length
length = 100;
limiterDiameter = 6;
// Measured without plate thickness
limiterHeight = 16;
holeDiameter = 3;
plateWidth = 20;
plateThickness = 3;

/* [Hidden] */
$fa = 1;
$fs = 0.5;


/******************************************************************************
 *
 *  EXECUTION
 *
 ******************************************************************************/


plate();
limiters();


/***************************************************************************
 *
 *  DIRECT MODULES
 *
 ******************************************************************************/


module plate()
{
    difference()
    {
        linear_extrude(height = plateThickness, convexity = 8)
            _platePlane();
        translate([(length - plateWidth) / 2, plateWidth / 2, -0.0002])
            cylinder(plateThickness - 1, holeDiameter / 2 + plateThickness / 2, holeDiameter / 2 );
        translate([(length - plateWidth) / 2, plateWidth / 2, 0])
            cylinder(plateThickness + 1, holeDiameter / 2, holeDiameter / 2);
    }

}

module limiters()
{
    translate([-(plateWidth / 2 - limiterDiameter / 2), plateWidth / 2, plateThickness])
        cylinder(r = limiterDiameter / 2, h = limiterHeight);
    translate([length - plateWidth/2 - limiterDiameter / 2, plateWidth / 2, plateThickness])
        cylinder(r = limiterDiameter / 2, h = limiterHeight);
}



/******************************************************************************
 *
 *  HELPER AND COMPONENT MODULES
 *
 ******************************************************************************/

module _platePlane()
{
    difference()
    {
        union()
        {
            translate([0, plateWidth / 2, 0])
                circle(plateWidth / 2);
            square([length - plateWidth, plateWidth]);
            translate([length - plateWidth, plateWidth / 2, 0])
                circle(plateWidth / 2);
        }
        hull()
        {
            translate([-plateWidth / 2 + limiterDiameter + plateWidth / 3, plateWidth / 2, 0])
                circle(plateWidth / 3);
            translate([length / 2 - plateWidth / 2 - plateWidth / 3 - holeDiameter - plateThickness, plateWidth / 2, 0])
                circle(plateWidth / 3);
        }
        hull()
        {
            translate([length / 2 - plateWidth / 2 + plateWidth / 3 + holeDiameter + plateThickness, plateWidth / 2, 0])
                circle(plateWidth / 3);
            translate([length - limiterDiameter - plateWidth / 3 - plateWidth / 2, plateWidth / 2, 0])
                circle(plateWidth / 3);
        }
    }
}