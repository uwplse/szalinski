
// Which part to generate
part = "all"; // [knob:Main Body,fill:Engraving,all:All]

/* [Knob] */

// The width of the main shaft
knob_base_width = 15;
// Height of the top plane of the knob
knob_top_height = 11.5;
// The height that the circular shaft becomes a dome
dome_start_height = 4;
// Distance from the center to the triangle point
point_extent = 14;

/* [Spindle] */

// The diameter of the inserted spindle
spindle_shaft_diam = 6;
// How much the spindle flat cuts into the spindle
spindle_flat_depth = 1;
// How deep inside the knob the hole goes
spindle_shaft_height = 7;
// Orientation of the spindle hole. Top-view CCW, 0=Rear-facing 
spindle_shaft_rotation = 0; // [0:359]

// The maximum safe 3d-printing overhang angle (from vertical)
overhang_angle = 45; // [90]

/* [Hidden] */

point_rad = 0.7; // The radius of the curve at the point of the knob

point_lean_distance = 1.5; // How far back the top knob point is
back_lean_distance = 0.3; // How far forward the triangle top is
back_width = 10; // the width of the back of the knob
back_corner_length = 1.0;

engraving_depth = 0.2; // The depth of the top engraving marker

// Calculated values

// Height of the spindle-void-overhang area
spindle_overhang_height = tan(90-overhang_angle)*(spindle_shaft_diam/2);

// Actual knob plane height based on other parameters
knob_height = max(  knob_top_height,
                    dome_start_height+knob_base_width/2,
                    spindle_shaft_height+spindle_overhang_height+engraving_depth);
echo("Actual constrained height", knob_height);

// The [l, w] of the ellipse base
base_ellipse_size = [knob_base_width * 14/13,knob_base_width]; 
// How far the back cubes lean to give the right distance       
lean_angle = 90-atan(knob_height/back_lean_distance);

// How far back the base of the triangle goes. Extended because of cylinder
back_extent = let(
    back_offset = dome_start_height / tan(90-lean_angle) )
    base_ellipse_size[0]/2+back_offset;

// The half-angle of the back triangle corners
back_angle = let(
    base_length = back_extent + point_extent-point_rad,
    back_tri_len = back_width/2 - point_rad ) 
    atan(base_length/back_tri_len) / 2;
 
// Create the main knob body. (fn-1)/2 must be even
module mainBody(base_size, fn=21) {
    union() {
        // Create a cylinder base
        linear_extrude(height=dome_start_height,convexity=10) scale(base_size) circle(d=1, $fn=fn);
    
        // shift the dome up
        translate([0,0,dome_start_height])
        //scale([1,1,13])
        scale(concat(base_size,base_size[1]))
        // Make a radius 0.5 dome
        difference() {
            sphere(0.5, $fn=fn);
            
            translate([0,0,-0.5])
            cube(1,center=true);
        }
    }
}

// Make the main knob triangle body
module triangle() {
    module corner_cutters(back_extent, lean_angle) {
        // Calculate the angle to cut off the back corners

        module corner_slab(rotation=0) {
            rotate([0,0,180+rotation])
            rotate([0,-lean_angle,0]) translate([0,-back_width/2,-1])
            cube([back_lean_distance*4, back_width, knob_height+4]);
        }
        // Calculate the offset position for the cubes
        crn_inset = (back_corner_length/2)/tan(back_angle);
        dX = crn_inset*sin(back_angle);
        dY = crn_inset*cos(back_angle);
        translate([-back_extent+dX, -back_width/2+dY,0]) corner_slab(back_angle);
        translate([-back_extent+dX, back_width/2-dY,0])  corner_slab(-back_angle);
    }
    difference() {
    
        Mskew = [ [ 1  , 0  , -point_lean_distance  , 0   ],
          [ 0  , 1  , 0.0, 0   ],
          [ 0  , 0  , 1  , 0   ],
          [ 0  , 0  , 0  , 1   ] ] ;


        // Build the skewed triangle block with front
        scale([1,1,knob_height]) multmatrix(Mskew) linear_extrude(height=1,convexity=10) hull() {
            polygon([[-back_extent, back_width/2], [-back_extent, -back_width/2],[1-point_rad, -point_rad],[1-point_rad, point_rad]]);
            translate([point_extent-point_rad, 0]) circle(r=point_rad, $fn=30);
        }
        // Build a cube to cut off the back of the triangle
        translate([-back_extent,10,0]) rotate([0,-lean_angle,180]) scale([5,back_width*2,knob_height*1.2]) cube(1);
        // And cubes to cut off the triangle corners
       corner_cutters(back_extent=back_extent, lean_angle=lean_angle);
    }
}

module topEngraving(extra_height=1) {
    // Make the top engraving
    rCorner = 1.0;
    inset = 1.1;
    point_x = 8;
    
    // Calculate how far away from the back corner we need to be to be
    xOffset = inset+back_lean_distance+rCorner;
    d = xOffset / sin(back_angle);
    // Work out where to put the back circles
    xPos = -back_extent + xOffset;
    yPos = back_width/2 - d*cos(back_angle);
    
    // Calculate the nearest point on the circle to the wall
    phi = 90-(2*back_angle);
    circX = sin(phi)*rCorner;
    circY = cos(phi)*rCorner;
    // Now find the equation of the line through this point
    grad = -tan(90-2*back_angle);
    offset = (yPos+circY) - grad*(xPos+circX);
    // This gives us the width of the circle at the point_x
    pointR = grad*point_x + offset;
    
    translate([0,0,knob_height])
    translate([0,0,-engraving_depth])
    linear_extrude(engraving_depth+extra_height, convexity=10)
    union() {
        hull() {
            translate([xPos,yPos,0]) circle(rCorner,$fn=20);
            translate([xPos,-yPos,0]) circle(rCorner,$fn=20);
            translate([point_x,0]) circle(pointR, $fn=20);
        }
        // The main bulb of the engraved point
        translate([point_x,0,0]) circle(1,$fn=20);
    }
}


module spindle() {
    // Make the potentiometer spindle
    difference() {
        union() {
            translate([0,0,-0.1]) cylinder(spindle_shaft_height+0.1, d=spindle_shaft_diam, $fn=30);
            // Overhang so we don't just have an immediate void.
            // 1-micron adjustment because openscad preview sucks
            translate([0,0,spindle_shaft_height-0.001])
             cylinder(spindle_overhang_height, r=spindle_shaft_diam/2, r2=0, $fn=30);
        }
        
        translate([-spindle_shaft_diam/2,-spindle_shaft_diam/2,-0.5]) cube([spindle_flat_depth,spindle_shaft_diam,spindle_shaft_height+spindle_overhang_height+1]);
    }
}

//

if (part == "knob" || part == "all") {
    color([0.5,0.5,0.5]) difference() {
        union() {
            triangle();
            mainBody(base_ellipse_size, fn=90);
        }
        topEngraving();
        rotate([0,0,spindle_shaft_rotation]) spindle();
    }
}
if (part == "fill" || part == "all") {
    color("white") topEngraving(extra_height=0);
}

