/******************************************************************************
 *
 *  GLOBALS
 *
 ******************************************************************************/

thickness = 2;
edgeLength = 40;
// If enabled, screw holes distance will be used as rouding radius.
roundCorners = 1; // [0: No, 1: Yes]
// Distance from edge to screw hole center
screwHolesDistance = 4;
screwHolesDiameter = 3;
grillThickness = 1.2;
grillHoleDiameter = 36;
grillPattern = 2; // [1: Grid, 2: Honeycomb, 3: Triangle, 4: Stripe]
patternAngle = 0; // [0:15:90]
// Used differently for varius patterns, just experiment with it
grillPatternElementsInRow = 6;
// Used differently for varius patterns, just experiment with it
grillPatternElementsDistance = 1;
/* [Hidden] */
$fa = 1;
$fs = 0.5;


/******************************************************************************
 *
 *  EXECUTION
 *
 ******************************************************************************/

frame();
grill();

/***************************************************************************
 *
 *  DIRECT MODULES
 *
 ******************************************************************************/

module frame()
{
    linear_extrude(thickness)
        _framePlane();
}

module grill()
{
    grillTranslation = grillHoleDiameter / 2 + (edgeLength - grillHoleDiameter) / 2;
    translate([grillTranslation, grillTranslation, 0])
        linear_extrude(grillThickness)
            _grillPlane();
}


/******************************************************************************
 *
 *  HELPER AND COMPONENT MODULES
 *
 ******************************************************************************/

module _framePlane()
{
    difference()
    {
        square(edgeLength);
        translate([edgeLength / 2, edgeLength / 2, 0])
        {
            circle(r = grillHoleDiameter / 2);
            _screwHolesPlane();
            _roundingsPlane();
        }
    }
}

module _screwHolesPlane()
{
    __multiply()
        _screwHolePlane();
}

module _screwHolePlane()
{
    circle(d = screwHolesDiameter);
}

module _roundingsPlane()
{
    if(roundCorners == 1)
    {
        __multiply()
            _roundingPlane();
    }
}

module _roundingPlane()
{
    rotate([0, 0, -45])
    difference()
    {
        square(screwHolesDistance);
            circle(r = screwHolesDistance);
    }
}

module __multiply()
{
    for(i = [45 : 90 : 405])
    {
        rotate([0, 0, i])
            translate([((edgeLength - 2 * screwHolesDistance)) * sqrt(2) / 2, 0, 0]) // yeah, this could be done easier :D
                children();
    }
}

module _grillPlane()
{
    intersection()
    {
        circle(d = grillHoleDiameter);

        rotate([0, 0, patternAngle])
            _grillPatternPlane();
    }
}

module _grillPatternPlane()
{
    translate([-grillHoleDiameter / 2, -grillHoleDiameter / 2, 0])
        difference()
        {
            square(grillHoleDiameter);

            if(grillPattern == 1)
            {
                _gridPatternPlane();
            }
            else if(grillPattern == 2)
            {
                _honeycombPatternPlane();
            }
            else if(grillPattern == 3)
            {
                _trianglePatternPlane();
            }
            else
            {
                _stripesPatternPlane();
            }
        }
}

module _gridPatternPlane()
{
    squareDimension = grillHoleDiameter / grillPatternElementsInRow - grillPatternElementsDistance;
    
    translate([grillPatternElementsDistance / 2, grillPatternElementsDistance / 2, 0])
        for(i = [0 : grillPatternElementsInRow - 1])
        {
            for(j = [0 : grillPatternElementsInRow - 1])
            {
                translate([(squareDimension + grillPatternElementsDistance) * i , (squareDimension + grillPatternElementsDistance) * j, 0])
                square(squareDimension);
            }
        }
}

module _honeycombPatternPlane()
{
    circleDimension = grillHoleDiameter / grillPatternElementsInRow - grillPatternElementsDistance;
    XTranslation = (circleDimension * 0.75 + grillPatternElementsDistance * sqrt(3) / 2);
    YTranslation = (circleDimension / 2 * sqrt(3) + grillPatternElementsDistance);

    translate([grillPatternElementsDistance / 2, grillPatternElementsDistance / 2, 0])
    for(i = [0 : grillPatternElementsInRow * 2])
    {
        for(j = [0 : grillPatternElementsInRow * 2])
        {
                translate([XTranslation * i, YTranslation * (j + 0.5 * (i % 2)), 0])
                    circle(d = circleDimension, $fn = 6);
        }
    }

}

module _trianglePatternPlane()
{
    difference()
    {
        square(grillHoleDiameter);
        translate([grillHoleDiameter / 2, grillHoleDiameter / 2, 0])
            for(i = [0 : 2])
            {
                rotate([0, 0, 60 * i])
                    translate([-grillHoleDiameter, -grillHoleDiameter, 0])
                        for(j = [0 : grillPatternElementsInRow * 2])
                        {
                            translate([(grillHoleDiameter / grillPatternElementsInRow) * j - grillPatternElementsDistance / 2, 0, 0])
                                square([grillPatternElementsDistance,grillHoleDiameter * 2]);
                        }
            }
    }
}

module _stripesPatternPlane()
{
    translate([grillPatternElementsDistance/2, 0, 0])
    for(i = [0 : grillPatternElementsInRow])
    {
        translate([grillHoleDiameter / grillPatternElementsInRow * i, 0, 0])
            square([grillHoleDiameter / grillPatternElementsInRow - grillPatternElementsDistance, grillHoleDiameter]);
    }
}