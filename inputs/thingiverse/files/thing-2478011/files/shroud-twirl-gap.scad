//Diameter of the bundle of cables (big ring)
cable_diameter = 11;
//Diameter of the filament/string/wire used as a spine (Should be less than double the cable diameter)
spine_diameter = 2.5;
//Thickness of the shroud
shroud_thickness = 0.8;
//Total height of the shroud, spacer and ring
total_height = 10;
//Size of the separation of the ring
gap_size = 2.4;
//Degrees of twist in the gap
twist = 50;
//Twist offset (0 to 1)
twist_offset = 0.5; // [0:0.01:1]
//Ratio of ring length to spacer length
shroud_to_spacer_ratio = 0.75; // [0:0.01:1]

//Advanced option: Changes the number of segments in the cylinders, shouldn't exceed 256.
cylinder_resolution = 64;



//Calculate the rotational width of the spine on either side of 0 degrees
//The spine diameter must be less than double the diameter of the shroud
angle_bounds_old = 2*atan((0.5*(spine_diameter/2+shroud_thickness))/
                      sqrt(pow((cable_diameter+shroud_thickness)/2,2) -0.25*pow(spine_diameter/2+shroud_thickness,2)));
angle_bounds = getAngleFromCord(spine_diameter/2+shroud_thickness, cable_diameter/2+shroud_thickness);

shroud_height = total_height * shroud_to_spacer_ratio;
spacer_height = total_height * (1-shroud_to_spacer_ratio);
ring();
spacer();

// Ring
module ring(){
    difference(){
    union(){
        linear_extrude(height=shroud_height)
        translate([0,cable_diameter/2 + shroud_thickness/2])
            circle(d=spine_diameter + shroud_thickness*2, $fn=cylinder_resolution);
        
        rotate(twist/2 + (twist_offset*2-1)*(180-angle_bounds-twist/2-getAngleFromCord(gap_size, cable_diameter/2+shroud_thickness)/2)){
            linear_extrude(height=shroud_height, twist=twist, slices=shroud_height * 2)
            difference(){
                circle(d=cable_diameter + shroud_thickness*2, $fn=cylinder_resolution);
                translate([0,-cable_diameter/2-shroud_thickness/2])
                    square(size=[gap_size,cable_diameter+shroud_thickness], center=true);
                circle(d=cable_diameter, $fn=cylinder_resolution);
            }
        }
    }
    translate([0,0,-2])
    linear_extrude(height=shroud_height+4)
    translate([0,cable_diameter/2 + shroud_thickness * 1/2])
    circle(d=spine_diameter, $fn=cylinder_resolution);
    }
}

// Spacer
module spacer(){
    difference(){
    translate([cable_diameter/2 + shroud_thickness + 10,0])
    linear_extrude(height=spacer_height)
        circle(d=spine_diameter+shroud_thickness*2, $fn=cylinder_resolution);
    translate([0,0,-2])
    linear_extrude(height=spacer_height+4)
    translate([cable_diameter/2 + shroud_thickness + 10,0])
        circle(d=spine_diameter, $fn=cylinder_resolution);
    }
}

//Functions
function getAngleFromCord(cordLen, radius) = 2*atan((0.5*cordLen) / sqrt(pow(radius,2) -0.25*pow(cordLen,2)));