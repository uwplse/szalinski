/******************************************************************************
 *
 *  GLOBALS
 *
 ******************************************************************************/

flashlightDiameter = 32;
collarThickness = 2;
collarHeight = 12;
overallHeight = 100;
diffuserWallThickness = 2;

/* [Hidden] */
$fa = 1;
$fs = 0.5;

overallDiameter = flashlightDiameter + 2 * collarThickness;
diffuserHeight = overallHeight - collarHeight;

/******************************************************************************
 *
 *  EXECUTION
 *
 ******************************************************************************/
union()
{
    collar();
    diffuser();
}

/***************************************************************************
 *
 *  DIRECT MODULES
 *
 ******************************************************************************/

module collar()
{
    linear_extrude(height = collarHeight, convexity = 10) 
    {
        _collarPlane();
    }
}

module diffuser()
{
    translate([0, 0, collarHeight])
        _diffuserShape();
}

/******************************************************************************
 *
 *  HELPER AND COMPONENT MODULES
 *
 ******************************************************************************/

module _collarPlane()
{
    difference()
    {
        circle(r = overallDiameter / 2);
        circle(r = flashlightDiameter / 2);
    }
}

module _diffuserShape() 
{
    difference()
    {
        resize([overallDiameter, overallDiameter, diffuserHeight * 2])
            sphere(r = diffuserHeight);
        resize([overallDiameter - 2 * diffuserWallThickness, overallDiameter - 2 * diffuserWallThickness, (diffuserHeight - diffuserWallThickness) * 2])
            sphere(r = diffuserHeight);            
        translate([0, 0, -overallHeight / 2 - 0.5])
            cube(size=[overallDiameter + 1, overallDiameter + 1, overallHeight + 1], center = true);
    }
}