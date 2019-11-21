//  The inner diameter of the spacer in mm
diameter = 35;

//  The thickness of the spacer in mm
thickness = 5;

//  The height of the spacer in mm
height = 50;

/* [Hidden] */
$fn = 1000;

difference()    {
    color("purple")
        linear_extrude(height = height)
            circle((diameter + thickness)/2, center = true);
color("red")
    translate([0,0,-1])
        linear_extrude(height = height+2)
                circle(diameter/2, center = true);
}