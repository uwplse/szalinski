//
//  StapleBox.scad
//
//  EvilTeach
//
//  01/25/2017
//
//  A nice box with a slidable lid, with text on it
//  for holding staples or anything else.
//
//  This model is based on http://www.thingiverse.com/thing:468917
//  Thank you http://www.thingiverse.com/Aisjam/about for your quality work.
//
//  if you measure the size of the box that the staples come in
//  those dimensions will be reasonable values for the inner variables below.
//



/* [Box Dimensions] */
wallThickness = 3.0;   // [2:5]

innerWidth  = 100.0;   // [80:120]
innerDepth  = 100.0;   // [80:120]
innerHeight =  15.0;   // [4:30]

/* [Lid Text] */
topText    = "       SOME ";
bottomText = "     STAPLES";

/* [Finishing] */
$fn       = 180;
tolerance = 0.3;
edgeRoundness = wallThickness + 2.0;

// innerWidth  = 101;
// innerDepth  = 88;
// innerHeight = 20;
// topText     = "T50 9/16";
// bottomText  = "STAPLES";

// innerWidth  = 107.5;
// innerDepth  = 91;
// innerHeight = 15;
// topText     = "T50 5/16";
// bottomText  = "STAPLES";

//////////////////////////////////////////////////////////////////////////

/* [HIDDEN] */
width  = innerWidth + 2 * wallThickness;
depth  = innerDepth + 2 * wallThickness;
height = innerHeight;


innerBoxDimensions = [depth,width,height];

module add_outer_corners(x = 0, y = 0)
{
	translate([(innerBoxDimensions[0] - edgeRoundness * 2 + 0.1) * x,
               (innerBoxDimensions[1] - edgeRoundness * 2 + 0.1) * y,
               0] + [edgeRoundness, edgeRoundness, 0]
             )
    	cylinder(innerBoxDimensions[2] + wallThickness,
                 edgeRoundness,
                 edgeRoundness);
}


module add_inner_corners(x = 0, y = 0)
{
	translate(
                 [(innerBoxDimensions[0] - edgeRoundness * 2 + 0.1) * x,
                  (innerBoxDimensions[1] - edgeRoundness * 2 + 0.1) * y,
                  0] + [edgeRoundness, edgeRoundness, 0]
             )
	    cylinder(innerBoxDimensions[2],
                 edgeRoundness - wallThickness,
                 edgeRoundness - wallThickness);
}


module add_lid_corners(x = 0, y = 0)
{
	translate(
               [(innerBoxDimensions[0] - edgeRoundness * 2 - 0.1 +wallThickness) * x,
                (innerBoxDimensions[1] - edgeRoundness * 2 + 0.1) * y,
                0] + [edgeRoundness, edgeRoundness, 0]
             )
    	cylinder(wallThickness,
                 edgeRoundness - wallThickness + 1.5,
                 edgeRoundness - wallThickness + 0.5);
}


module lid(x = 0, y = 0)
{
    translate(
               [(innerBoxDimensions[0] - edgeRoundness * 2 - 0.1 + wallThickness - 2) * x,
                (innerBoxDimensions[1] - edgeRoundness * 2 + 0.1) * y,
                 0] + [edgeRoundness,edgeRoundness, 0]
             )
        cylinder(wallThickness,
                 edgeRoundness - wallThickness + 1.5 - tolerance,
                 edgeRoundness - wallThickness + 0.5 - tolerance);
}


module lid_label()
{
    color("cyan")
        translate([20, 5, 1])
            rotate([0, 0, 90])
            {
                translate([0, -10, 0])
                    linear_extrude(height = wallThickness - 1)
                        text(topText, size = 10);

                translate([0, -40, 0])
                    linear_extrude(height = wallThickness - 1)
                        text(bottomText, size = 10);
            }
}


module finger_pull()
{
    color("cyan")
        translate([depth - 20, width / 2, 10.5])
            rotate([0, 100, 0])
                cylinder(d = 15, h = 15);
}


module main()
{

    rotate([0, 0, 90])
    {
        // Shim so the lid stays in place
        color("blue")
            translate([depth - wallThickness, wallThickness, height])
                cube([wallThickness, width - 2 * wallThickness, 0.75]);
        
        // The box
        difference ()
        {
            hull()
            {
                add_outer_corners(0,0);
                add_outer_corners(1,0);
                add_outer_corners(0,1);
                add_outer_corners(1,1);
            }
            
            translate([0, 0, wallThickness])
                hull()
                {
                    add_inner_corners(0,0);
                    add_inner_corners(1,0);
                    add_inner_corners(0,1);
                    add_inner_corners(1,1);
                }

            translate([0, 0, innerBoxDimensions[2] + 0.1])
                hull()
                {
                    add_lid_corners(0,0);
                    add_lid_corners(1,0);
                    add_lid_corners(0,1);
                    add_lid_corners(1,1);
                }

            translate
            (
                [innerBoxDimensions[0] - wallThickness,
                 0,
                 innerBoxDimensions[2] + 0.1]
            )
                cube([wallThickness, innerBoxDimensions[1], wallThickness]);
        }
    }

    // The lid
    translate([0, depth, 0])
        rotate([0, 0, 90])
            difference ()
            {
                hull()
                {
                    lid(0,0);
                    lid(1,0);
                    lid(0,1);
                    lid(1,1);
                }
                
                lid_label();
                
                finger_pull();
            }
}


// Put it in the middle of the build plate
translate([depth, width / 2, 0])
    rotate([0, 0, 90])
        main();
