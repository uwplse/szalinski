// Global parameters, specific for each spool brand
/*******************
*    ICE 0.75kg    *
* inner hole 54mm  *
*******************/
// Full size of spool
//spool_diameter=199;
// Inside height
//spool_height=50;
// Rack width = spool outside diameter - spool inside diameter
//rack_width=41;


/*******************
*    Sunlu 1kg     *
* inner hole 73mm  *
*******************/
// Full size of spool
//spool_diameter=200;
// Inside height
//spool_height=54;
// Rack width = spool outside diameter - spool inside diameter
//rack_width=61;


/*******************
*   Verbatim 1kg   *
* inner hole 51mm  *
*******************/
// Full size of spool
//spool_diameter=200;
// Inside height
//spool_height=61;
// Rack width = spool outside diameter - spool inside diameter
//rack_width=47;


/*******************
*      BQ 1kg      *
* inner hole 53mm  *
*******************/
// Full size of spool
//spool_diameter=190;
// Inside height
//spool_height=65;
// Rack width = spool outside diameter - spool inside diameter
//rack_width=44;

/* [Spool and Rack] */
// Full size of spool
spool_diameter=190;
// Inside height
spool_height=65;
// rack width = spool outside diameter - spool inside diameter
rack_width=44;

// Custom parameters, according to your needs
// Number of racks
rack_count=4; // [2,3,4,5,6]
// Number of separators in each rack
spacer_count=1; // [0,1,2,3,4]
// Spacer height (percent of rack height)
spacer_height=0.8; // [0:0.1:1]
// Number of floors
floor_count=1; // [1,2]
// Print only one rack ?
single_print = 1; // [0:false, 1:true]
// Mirror each rack
mirror_rack = 0;  // [0:false, 1:true]

/* [Handle and Hinge] */
// Handle (hole)
// Size of hole handle (0 = disabled)
handle_hole_size=20;

// Handle (grip)
// Size of grip handle (0 = disabled)
handle_grip_size=0; // 10
// Grip height (percent of rack height)
handle_grip_height=0.5; // [0:0.1:1]
// Grip width (percent of grip size)
handle_grip_width=0.8; // [0:0.1:1]

// Hinge
hinge_width=20;
drill_width=5; // [1:0.5:6]

/* [Advanced] */
// Global thickness
wall_thickness=1.5;
// Exploded view (recommended for printing)
explode_margin=4;

/* [Hidden] */
//$fa = 0.01; $fs = 0.01;
// Resolution
$fn = 100; // [1:100]

// Computed constants
spool_radius = spool_diameter/2;
hinge_radius = hinge_width/2;
hinge_angle = asin(hinge_radius/(spool_radius-hinge_radius));

// older versions of OpenSCAD do not support "angle" parameter for rotate_extrude
// this module provides that capability even when using older versions (such as thingiverse customizer)
module rotate_extrude2(angle=360, convexity=2, size=1000) {

    module angle_cut(angle=90, size=1000) {
        x = size*cos(angle/2);
        y = size*sin(angle/2);
        translate([0,0,-size])
        linear_extrude(2*size) polygon([[0,0],[x,y],[x,size],[-size,size],[-size,-size],[x,-size],[x,-y]]);
    }

    // support for angle parameter in rotate_extrude was added after release 2015.03
    // Thingiverse customizer is still on 2015.03
    angleSupport = (version_num() > 20150399) ? true*false : false; // Next openscad releases after 2015.03.xx will have support angle parameter
    // Using angle parameter when possible provides huge speed boost, avoids a difference operation

    if (angleSupport) {
        rotate_extrude(angle=angle,convexity=convexity)
            children();
    } else {
        rotate([0,0,angle/2]) difference() {
            rotate_extrude(convexity=convexity)
                children();
            angle_cut(angle, size);
        }
    }
}


module drill(width_1=10, width_2=10, height=10, hole=5) {
    difference() {
        translate ([0, 0, 0]) rotate ([-90, 0, 0]) cylinder (h=height, r1=width_1/2, r2=width_2/2);
        translate ([0, -0.1, 0]) rotate ([-90, 0, 0]) cylinder (h=height+0.2, r=hole/2);
    }
}

module sub_rack() {
    // Main rack
    rotate_extrude2(angle = 360/rack_count, convexity = 2, size=spool_radius+2)
    translate([spool_radius-rack_width, 0, 0])
    polygon(points=[
        [0,0],
        [0,(spool_height-1)/floor_count],
        [wall_thickness,(spool_height-1)/floor_count],
        [wall_thickness,wall_thickness],

        [rack_width-wall_thickness,wall_thickness],
        [rack_width-wall_thickness,(spool_height-1)/floor_count],
        [rack_width,(spool_height-1)/floor_count],
        [rack_width,0]]);
    // Wall
    if (rack_count>1) {
        // First
        translate([spool_radius-rack_width+1.1, 0, 0])
        cube([rack_width-2.2, wall_thickness, (spool_height-1)/floor_count]);
        // Second
        rotate([0, 0, 360/rack_count])
        translate([spool_radius-rack_width+1.1, -wall_thickness, 0])
        cube([rack_width-2, wall_thickness, (spool_height-1)/floor_count]);
    }
    // Spacer
    if (spacer_count>0) {
        for(spacer_nr = [0 : spacer_count-1]) {
            rotate([0, 0, (360/rack_count)/(spacer_count+1)*(spacer_nr+1)])
            translate([spool_radius-rack_width+1.1, 0, 0])
            cube([rack_width-2.2, wall_thickness, (spool_height-1)/floor_count*spacer_height]);
        }
    }
}

module handle_hole() {
    rotate([0, 90, 0])
    scale([1.25,1,1.25])
    sphere (r=handle_hole_size/2);
}

module handle_grip() {
    cube([handle_grip_size*2/3, handle_grip_size*2/3*handle_grip_width, (spool_height-1)/floor_count*handle_grip_height]);
    translate([handle_grip_size*2/3, (handle_grip_size*2/3*handle_grip_width)/2, 0])
    scale([1,handle_grip_width,1])
    cylinder(h=(spool_height-1)/floor_count*handle_grip_height, r=handle_grip_size*0.66/2);
}

module rack() {
    union() {
        difference() {
            // Main rack
            sub_rack();

            // Handle (hole)
            translate([spool_radius-1, handle_hole_size, (spool_height-1)/floor_count])
            handle_hole();

            // Hinge, drill hole
            rotate([0, 0, 360/rack_count-hinge_angle])
            translate ([spool_radius-hinge_radius, 0, -1])
            rotate([90, 0, 0])
            drill(width_1=hinge_width, width_2=hinge_width, height=(spool_height-1)/floor_count+2, hole=0);

            // Hinge, round corner
            rotate([0, 0, 360/rack_count-hinge_angle])
            translate ([spool_radius-hinge_radius, 0, -1])
            cube([hinge_width, hinge_width, (spool_height-1)/floor_count+2]);

            rotate([0, 0, 360/rack_count-wall_thickness])
            translate ([spool_radius-hinge_radius, 0, -1])
            cube([hinge_width/2, wall_thickness+1, (spool_height-1)/floor_count+2]);
        }

        // Handle (grip)
        translate([spool_radius-1-wall_thickness, wall_thickness, 0])
        handle_grip();

        // Hinge
        rotate([0, 0, 360/rack_count-hinge_angle])
        translate ([spool_radius-hinge_radius, 0, 0])
        rotate([90, 0, 0])
        drill(width_1=hinge_width, width_2=hinge_width, height=(spool_height-1)/floor_count, hole=drill_width);
    }
}

if (single_print) {
        mirror ([mirror_rack, 0, 0])
        rack();
} else {
    for (floor_nr = [0 : floor_count-1]) {
        for(rack_nr = [0 : rack_count-1]) {
            mirror ([mirror_rack, 0, 0])
            rotate([0, 0, 360/rack_count*rack_nr])
            translate([explode_margin/2, explode_margin/2, (spool_height-1)/floor_count*floor_nr+floor_nr*explode_margin])
                rack();
        }
    }
}

