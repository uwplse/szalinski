$fn = 100;

nozzleRadius = 0.35 / 2;
play = nozzleRadius;

plateThickness = 18.3;
mountLength = 15;
wallThickness = 3;
laserRadius = 12.09 / 2;

height = 2 * wallThickness + 2 * laserRadius;
width = 2 * wallThickness + plateThickness;
length = wallThickness + mountLength;

laserMount();

module laserMount()
{
    rotate([90, 0, 0])  //  Rotate the design to the most favourable orientation for FDM
    {
        difference()
        {
            union()
            {
                cube([width, length, height]);  //  Start with the base for the mount
                translate([-laserRadius, 0, wallThickness + laserRadius])
                {
                    rotate([-90, 0, 0])
                    {
                        cylinder(r = laserRadius + wallThickness, h = length);  //  Base for the laser mount
                    }
                }
            }
            translate([wallThickness, wallThickness, -0.1])
            {
                cube([plateThickness, mountLength + 0.1, height + 0.2]); // Cut out the shape of the plate the design is attached to
            }
            translate([-laserRadius, 0, wallThickness + laserRadius])
            {
                rotate([-90, 0, 0])
                {
                    translate([0, 0, -0.1])
                    {
                        cylinder(r = laserRadius + play, h = length + 0.2);   //  Cut out the shape of the laser with a little play to provide a nice fit
                    }
                }
            }
        }
    }
}