
middle_hole_diameter=16; // Diameter of your center hole.  Likely the outer diameter of your bearing.

satellite_hole_diameter=19.06; // Diameter of satellite holes.

// Distance from the center of the spinner to the center of a satellite.
satellite_distance_from_center=21;

height=5; // Height of spinner.

wall_thickness=3; // Thickness of walls around all holes.

tolerance=.1; // Extra space added to hole diameters for printer tolerance.

cap_post_diameter=8;
cap_post_height=2;
cap_rest_thickness=0.5;
cap_rest_height=1;
cap_height=1;

/* Hidden */
satellite_count=3;
detail=50;

module spinner() {
    h=satellite_distance_from_center;
    d=360/satellite_count-90;
    x=cos(d)*h;
    y=sin(d)*h;

    difference()
    {
        union() {
            hull() {
                color("blue") cylinder(h=height, d=middle_hole_diameter+wall_thickness*2, $fn=detail);
                color("green") translate([0, h, 0]) cylinder(h=height, d=satellite_hole_diameter+wall_thickness*2, $fn=detail);
            }
            hull() {
                color("blue") cylinder(h=height, d=middle_hole_diameter+wall_thickness*2, $fn=detail);
            color("green") translate([x, -y, 0]) cylinder(h=height, d=satellite_hole_diameter+wall_thickness*2, $fn=detail);
            }
            hull() {
                color("blue") cylinder(h=height, d=middle_hole_diameter+wall_thickness*2, $fn=detail);
            color("green") translate([-x, -y, 0]) cylinder(h=height, d=satellite_hole_diameter+wall_thickness*2, $fn=detail);
            }
        }

        cylinder(h=height*10, d=middle_hole_diameter+tolerance, $fn=detail, center=true);
        color("green") translate([0, h, 0]) cylinder(h=height*10, d=satellite_hole_diameter+tolerance, $fn=detail, center=true);
        translate([x, -y, 0]) cylinder(h=height*10, d=satellite_hole_diameter+tolerance, $fn=detail, center=true);
        translate([-x, -y, 0]) cylinder(h=height*10, d=satellite_hole_diameter+tolerance, $fn=detail, center=true);
    }
}

module cap() {    
    // adjustments and easier reference for object creation:
    post_d=cap_post_diameter-tolerance;
    rest_d=cap_post_diameter+cap_rest_thickness;
    cap_d=middle_hole_diameter;
    
    cap_h=cap_height;
    rest_h=cap_h+cap_rest_height;
    post_h=rest_h+cap_post_height;

    union() {
        // cap
        cylinder(d=cap_d, h=cap_h, $fn=detail);
        // rest
        cylinder(d=rest_d, h=rest_h, $fn=detail);
        // post
        cylinder(d=post_d, h=post_h, $fn=detail);
    }
}

spinner();

translate([satellite_distance_from_center*2,0,0]) cap();
translate([satellite_distance_from_center*2,satellite_distance_from_center,0]) cap();