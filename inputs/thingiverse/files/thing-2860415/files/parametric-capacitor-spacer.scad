// Parametric capacitor spacer by Funkster (www.funkster.org)
// 
// Used for creating spacers for when replacement capacitors are smaller than
// the mechanical clamp that held the original parts in place.
//
// Print in a material that can handle the temperatures expected in the product
// that you're servicing - i.e. not PLA. ABS or Nylon recommended.
//
// for a demo see https://www.youtube.com/watch?v=wsz3VNNHLxw
//
// CC-by-nc-sa 3.0 Unported.


// set WALL_THICKNESS to your nozzle diameter
WALL_THICKNESS = 0.4;

// diameter that the clamp expects
OUTER_OUTSIDE_DIAMETER = 35.37;
// diameter of the replacement part
INNER_INSIDE_DIAMETER = 25.66;
// bare minimum is height of the clamp, max is the height of the old cap
HEIGHT = 12;
// how many supports between inner and outer. Use odd number otherwise
// you'll get one where the gap is!
LEGS = 7;
// radius to strengthen where the legs join the inner and outer rings (can be 0 if you like)
LEG_CORNER_RADIUS = 1;
// thicknesses of various parts, in multiples of nozzle diameter
LEG_SHELLS = 4;
INNER_SHELLS = 3;
OUTER_SHELLS = 3;
// for nice round circles leave this high (makes rendering slower!)
RESOLUTION_STEPS = 180;

// DON'T EDIT ANYTHING BELOW THIS LINE  :o)

// for convenience
OUTER_INSIDE_DIAMETER = OUTER_OUTSIDE_DIAMETER - (WALL_THICKNESS * OUTER_SHELLS * 2);
INNER_OUTSIDE_DIAMETER = INNER_INSIDE_DIAMETER + (WALL_THICKNESS * INNER_SHELLS * 2);
DISTANCE_BETWEEN_RINGS = (OUTER_INSIDE_DIAMETER - INNER_OUTSIDE_DIAMETER) / 2;
RADIUS_O = OUTER_INSIDE_DIAMETER / 2;
RADIUS_I = INNER_OUTSIDE_DIAMETER / 2;
LEG_WIDTH = WALL_THICKNESS * LEG_SHELLS;
H_OUTER = sqrt(pow(RADIUS_O, 2) - pow((LEG_WIDTH / 2) + LEG_CORNER_RADIUS, 2));
H_INNER = sqrt(pow(RADIUS_I, 2) - pow((LEG_WIDTH / 2) + LEG_CORNER_RADIUS, 2));
C_OUTER = H_OUTER - LEG_CORNER_RADIUS;
C_INNER = H_INNER + LEG_CORNER_RADIUS;

difference()
{
    union()
    {
        // outer ring (outside is a big square that will get trimmed off later - saves render time)
        difference()
        {
            cube([OUTER_OUTSIDE_DIAMETER, OUTER_OUTSIDE_DIAMETER, HEIGHT], center = true);
            cylinder(HEIGHT + 1, RADIUS_O, RADIUS_O, center = true, $fn=RESOLUTION_STEPS);
            translate([0,0,-((HEIGHT + 1) / 2)])
            {
                
                // gap to allow clamp to close supports onto new part
                pie((OUTER_OUTSIDE_DIAMETER / 2) + 1, 10, HEIGHT + 1, -5);
            }
            
        }

        // inner ring with LEGS gaps
        difference()
        {
            union()
            {
                cylinder(HEIGHT, RADIUS_I, RADIUS_I, center = true, $fn=RESOLUTION_STEPS);
                
                // support legs
                for (n = [0 : LEGS])
                {
                    rotate([0, 0, (360 / LEGS) * n])
                    {
                        difference()
                        {
                            translate([0 - (H_INNER + H_OUTER) / 2, 0, 0])
                            {
                                // leg, plus thickness that is deleted to form corner radii
                                cube([H_INNER, LEG_WIDTH + LEG_CORNER_RADIUS * 2, HEIGHT], center = true);
                            }
                            // corner radii, inner
                            translate([0 - C_INNER, LEG_CORNER_RADIUS + LEG_WIDTH / 2, 0])
                            {
                                cylinder(HEIGHT + 1, LEG_CORNER_RADIUS, LEG_CORNER_RADIUS, center = true, $fn=RESOLUTION_STEPS);
                            }
                            translate([0 - C_INNER, 0 - (LEG_CORNER_RADIUS + LEG_WIDTH / 2), 0])
                            {
                                cylinder(HEIGHT + 1, LEG_CORNER_RADIUS, LEG_CORNER_RADIUS, center = true, $fn=RESOLUTION_STEPS);
                            }
                            
                            // outer
                            translate([0 - C_OUTER, LEG_CORNER_RADIUS + LEG_WIDTH / 2, 0])
                            {
                                cylinder(HEIGHT + 1, LEG_CORNER_RADIUS, LEG_CORNER_RADIUS, center = true, $fn=RESOLUTION_STEPS);
                            }
                            translate([0 - C_OUTER, 0 - (LEG_CORNER_RADIUS + LEG_WIDTH / 2), 0])
                            {
                                cylinder(HEIGHT + 1, LEG_CORNER_RADIUS, LEG_CORNER_RADIUS, center = true, $fn=RESOLUTION_STEPS);
                            }
                            
                            // bits between the radii
                            translate([0 - (C_INNER + C_OUTER) / 2, LEG_CORNER_RADIUS + LEG_WIDTH / 2, 0])
                            {
                                cube([(C_OUTER - C_INNER), LEG_CORNER_RADIUS * 2, HEIGHT + 1], center = true);
                            }
                                
                            translate([0 - (C_INNER + C_OUTER) / 2, 0 - (LEG_CORNER_RADIUS + LEG_WIDTH / 2), 0])
                            {
                                cube([(C_OUTER - C_INNER), LEG_CORNER_RADIUS * 2, HEIGHT + 1], center = true);
                            }
                        }
                    }
                }

            }
            translate([0,0,-((HEIGHT + 1) / 2)])
            {
                // round hole through the middle
                cylinder(HEIGHT + 1, (INNER_INSIDE_DIAMETER / 2), (INNER_INSIDE_DIAMETER / 2), center = false, $fn=RESOLUTION_STEPS);
                // pie cuts that make the supports separate
                for (n = [0 : LEGS])
                {
                    pie(RADIUS_I + 1, 360 / (LEGS * 2), HEIGHT + 1, (0 - (360 / (LEGS * 4))) + (360 / LEGS) * n);
                }
            }
            
        }
    }
    // big square-with-a-circular-hole thing to trim all the bits off the outside
    difference()
    {
        cube([OUTER_OUTSIDE_DIAMETER * 2, OUTER_OUTSIDE_DIAMETER * 2, HEIGHT + 1], center = true);
        cylinder(HEIGHT + 1, OUTER_OUTSIDE_DIAMETER / 2, OUTER_OUTSIDE_DIAMETER / 2, center = true, $fn=RESOLUTION_STEPS);
    }
}


// the below attached as per its comments, to save you from having to download it separately.

/**
 * pie.scad
 *
 * Use this module to generate a pie- or pizza- slice shape, which is particularly useful
 * in combination with `difference()` and `intersection()` to render shapes that extend a
 * certain number of degrees around or within a circle.
 *
 * This openSCAD library is part of the [dotscad](https://github.com/dotscad/dotscad)
 * project.
 *
 * @copyright  Chris Petersen, 2013
 * @license    http://creativecommons.org/licenses/LGPL/2.1/
 * @license    http://creativecommons.org/licenses/by-sa/3.0/
 *
 * @see        http://www.thingiverse.com/thing:109467
 * @source     https://github.com/dotscad/dotscad/blob/master/pie.scad
 *
 * @param float radius Radius of the pie
 * @param float angle  Angle (size) of the pie to slice
 * @param float height Height (thickness) of the pie
 * @param float spin   Angle to spin the slice on the Z axis
 */
module pie(radius, angle, height, spin=0) {
    // Negative angles shift direction of rotation
    clockwise = (angle < 0) ? true : false;
    // Support angles < 0 and > 360
    normalized_angle = abs((angle % 360 != 0) ? angle % 360 : angle % 360 + 360);
    // Select rotation direction
    rotation = clockwise ? [0, 180 - normalized_angle] : [180, normalized_angle];
    // Render
    if (angle != 0) {
        rotate([0,0,spin]) linear_extrude(height=height)
            difference() {
                circle(radius);
                if (normalized_angle < 180) {
                    union() for(a = rotation)
                        rotate(a) translate([-radius, 0, 0]) square(radius * 2);
                }
                else if (normalized_angle != 360) {
                    intersection_for(a = rotation)
                        rotate(a) translate([-radius, 0, 0]) square(radius * 2);
                }
            }
    }
}