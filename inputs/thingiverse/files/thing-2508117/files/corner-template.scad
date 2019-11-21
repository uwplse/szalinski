/******************************************************************************
 *
 *  GLOBALS
 *
 ******************************************************************************/

// Overall width of template (with walls)
width = 100;
// Plate thickness
thickness = 4;
wallThickness = 6;
wallHeight = 10;
// Walls distance from rounding ends.
wallCornerDistance = 10;
textDepth = 1;
radius1 = 16;
radius2 = 24;

/* [Hidden] */
$fa = 1;
$fs = 0.5;


/******************************************************************************
 *
 *  EXECUTION
 *
 ******************************************************************************/


rotate([90, 0, 0])
{
    difference()
    {
        plate();
        descriptions();
    }
    walls();
    
}

/***************************************************************************
 *
 *  DIRECT MODULES
 *
 ******************************************************************************/

module plate()
{
    linear_extrude(thickness)
        _platePlane();
}

module walls()
{
    linear_extrude(wallHeight)
        _wallsPlane1();

    translate([0, 0, thickness - wallHeight])        
        linear_extrude(wallHeight)
            _wallsPlane2();
}

module descriptions()
{
    translate([radius1 * sqrt(2) - radius1, radius1 * sqrt(2) - radius1, 1])
        rotate([180, 0, 45])
            linear_extrude(textDepth + 1)
                text(text = str("←", radius1, "mm"), size = radius1 / 2, valign = "center");

    
    translate([width - 2 * wallThickness - radius2 * sqrt(2) + radius2, width - 2 * wallThickness - radius2 * sqrt(2) + radius2, thickness - textDepth])
        rotate([0, 0, 225])
            linear_extrude(textDepth + 1)
                #text(str("←", radius2, "mm"), size = radius2 / 2, , valign = "center");
                
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
        square(width - 2 * wallThickness);
        _roundingsPlane();
    }
}

module _roundingsPlane()
{
    _cornerRoundingPlane(radius1);
    translate([width - 2 * wallThickness, width - 2 * wallThickness, 0])
        rotate([0, 0, 180])
            _cornerRoundingPlane(radius2);
}

module _cornerRoundingPlane(radius)
{
    translate([radius, radius, 0])
        rotate([0, 0, 180])
            difference()
            {
                square(radius + 1);
                circle(r = radius);
            }
}

module _wallsPlane1()
{
    translate([-wallThickness, radius1 + wallCornerDistance, 0])
        square([wallThickness, width - radius1 - wallCornerDistance - wallThickness ]);
    translate([radius1 + wallCornerDistance, -wallThickness, 0])
            square([width - radius1 - wallCornerDistance - wallThickness, wallThickness]);
}

module _wallsPlane2()
{
    translate([width - 2 * wallThickness, -wallThickness, 0])
            square([wallThickness, width - radius2 - wallCornerDistance]);
    translate([-wallThickness, width - 2 * wallThickness, 0])
            square([width - radius2 - wallCornerDistance, wallThickness]);
}


