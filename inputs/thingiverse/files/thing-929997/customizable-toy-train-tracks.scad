// Customizable toy train tracks
// by atartanian (www.thingiverse.com/atartanian)
// license CC-BY-SA

// preview[view:west, tilt:top]

/*[Track Settings]*/
//length of track piece, in mm
length = 200; //[30:10:400]

//only one preset... for now
//track_type = 0; //[1:brio,0:custom]

//in order to print perfectly, set your printers extrusion width
extrusion_width = .4; //[.1:.05:1]

//track line thickness, in multiples of extrusion width
line_thickness = 4; //[2:2:10]

//spacing between male and female connectors, in mm
connector_tolerance = .3; //[.1:.05:1]

/*[Custom Dimensions]*/
use_custom_settings = 0; //[0:No,1:Yes]
custom_width_base = 60;
custom_width_middle = 20;
custom_height_base = 10;
custom_height_middle = 15;
custom_connector_length = 17.5;

/*[Hidden]*/
track_type = use_custom_settings ? 0 : 1;


/***************/
/*     CODE    */
/***************/
translate([-track_type_params()[track_type][1] / 2, -length / 2])
intersection(convexity = 20) {
    rotate([-90,0,0])
        linear_extrude(height = length, convexity = 20)
            scale([1,-1])
                track_profile_2D(
                    track_type_params()[track_type][1],
                    track_type_params()[track_type][2],
                    track_type_params()[track_type][3],
                    track_type_params()[track_type][4],
                    1
                );

    linear_extrude(height = track_type_params()[track_type][4], convexity = 20)
        union() {
            translate([0, track_type_params()[track_type][5] + line_thickness * extrusion_width]) {
                translate([track_type_params()[track_type][1] / 2, length - track_type_params()[track_type][5] * 2 - line_thickness * extrusion_width * 2])
                        brio_male_2D();
                
                flex_track_pattern_2D(
                    length - track_type_params()[track_type][5] * 2 - line_thickness * extrusion_width * 2,
                    track_type_params()[track_type][1],
                    track_type_params()[track_type][2],
                    line_thickness * extrusion_width,
                    line_thickness * extrusion_width,
                    line_thickness * extrusion_width
                );
            }
            translate([track_type_params()[track_type][1] / 2, track_type_params()[track_type][5] + line_thickness * extrusion_width])
                scale([1, -1])
                    brio_female_2D();
        }
}

/***************/
/*  FUNCTIONS  */
/***************/

function track_type_params() = 
[   
    [   //[0] template
        "custom",   //[0] name
        custom_width_base,         //[1] width base
        custom_width_middle,         //[2] width middle
        custom_height_base,         //[3] height base
        custom_height_middle,         //[4] height middle
        custom_connector_length
    ], 
    [   //[1] brio
        "brio",     //[0] name
        40,         //[1] width base
        20,         //[2] width middle
        8.9,        //[3] height base
        12,         //[4] height middle
        17.5        //[5] connector length
    ], 
];

/***************/
/*   MODULES   */
/***************/

module track_profile_2D(
    width_base = 40,
    width_middle = 20,
    height_base = 10,
    height_middle = 15,
    bevel_radius = 1
){
    difference() {
        translate([bevel_radius, 0]) {
            union() {
                offset(d = bevel_radius) {
                    square(
                        [
                            width_base - bevel_radius * 2,
                            height_base - bevel_radius
                        ]
                    );
                }
                offset(d = bevel_radius) {
                    translate([(width_base - width_middle) / 2, bevel_radius])
                        square(
                            [
                                width_middle - bevel_radius * 2,
                                height_middle - bevel_radius * 2
                            ]
                        );
                }            
            }
        }
        translate([-width_base/2, -width_base*2])
            square(width_base * 2);
    }   
}

module flex_track_pattern_2D(
    length = 100,
    width_base = 40,
    width_middle = 20,
    line_thickness = 1.6,
    connector_thickness = 1.6,
    gap_thickness = 1.6
){
    epsilon = .1;

    slice_thickness = line_thickness + gap_thickness;
    slices = floor(length / slice_thickness);
    leftover = length - (slice_thickness * slices) + gap_thickness;

    module bars(even = true, odd = true, cutter = false) {
        for (i = [0:slices-1]) {
            if (even == true && !(i % 2)) {
                if(cutter == true) {
                    translate([-epsilon/2,slice_thickness * i]) {
                        square([width_base + epsilon,line_thickness]);
                    }
                } else {
                    translate([0,slice_thickness * i]) {
                        square([width_base,line_thickness]);
                    }
                }  
            }
            if (odd == true && (i % 2)) {
                if(cutter == true) {
                    translate([-epsilon/2,slice_thickness * i]) {
                        square([width_base + epsilon,line_thickness]);
                    }
                } else {
                    translate([0,slice_thickness * i]) {
                        square([width_base,line_thickness]);
                    }
                }  
            }
        }
    }

    module bars_holes(even = true, odd = true, cutter = true) {
        for (i = [0:slices-2]) {
            if (even == true && !(i % 2)) {
                if(cutter == true) {
                    translate([-epsilon/2,slice_thickness * i + line_thickness]) {
                        square([width_base + epsilon, gap_thickness]);
                    }
                } else {
                    translate([0,slice_thickness * i + line_thickness]) {
                        square([width_base, gap_thickness]);
                    }
                }  
            }
            if (odd == true && (i % 2)) {
                if(cutter == true) {
                    translate([-epsilon/2,slice_thickness * i + line_thickness]) {
                        square([width_base + epsilon, gap_thickness]);
                    }
                } else {
                    translate([0,slice_thickness * i + line_thickness]) {
                        square([width_base, gap_thickness]);
                    }
                }  
            }
        }
    }

    translate([0, leftover / 2])
        bars();

    difference() {
        translate([(width_base - width_middle) / 2, 0])
            square([connector_thickness, length]);
        
        translate([0, leftover / 2])
            bars_holes(false, true);
    }

    difference() {
        translate([(width_base - width_middle) / 2 + width_middle - connector_thickness, 0])
            square([connector_thickness, length]);
        
        translate([0, leftover / 2])
            bars_holes(true, false);
    } 
}

module brio_male_2D() {
    stem_width = 6;
    stem_length = 11.5;
    post_radius = 6;

    translate([0, line_thickness * extrusion_width/2])
        square([track_type_params()[1][1], line_thickness * extrusion_width], center = true);
    
    translate([0, (stem_length + connector_tolerance) / 2 + line_thickness * extrusion_width])
        square([stem_width - connector_tolerance * 2, stem_length + connector_tolerance], center = true);
    
    translate([0, stem_length + connector_tolerance + line_thickness * extrusion_width])
        circle(r = post_radius - connector_tolerance, $fn = 32);
}

module brio_female_2D() {
    stem_width = 6.3;
    stem_length = 11.5;
    post_radius = 6.3;
    total_length = line_thickness * extrusion_width + stem_length + post_radius;

    difference() {
        translate([0, (total_length)/2])
            square([track_type_params()[1][1], total_length], center = true);
        
        translate([0, total_length - stem_length / 2])
            square([stem_width, stem_length], center = true);
        
        translate([0, total_length - stem_length])
            circle(r = post_radius, $fn = 32);        
    }

}
