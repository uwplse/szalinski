// Simple Customizable Hinge
// preview[view:south, tilt:top diagonal]

// TODO: 
// * Rounded Corners
// * offset the knuckle/pin to different places
// * alternate numbers/position of screw holes?

/* [Sizing] */

// height of the hinge
hinge_height = 60;
// width of the flat part of the hinge (not including the knuckle/cylinder)
leaf_width=30; 
// how thick the leaf is
leaf_gauge=4;
// diameter of the screw hole
screw_hole_diameter=5;
// x-offset away from from center for the screw hole
screw_hole_offset=0;
// amount of extra room for the pin (makes hole bigger)
pin_hole_gap=1;

/* [Layout] */
// offset between the 2 parts on the x-axis
gap_between_parts_X=-40;
// offset between the 2 parts on the y-axis
gap_between_parts_Y=20;

/* [Parts] */
part = "both"; // [bottom:Bottom Hinge,top:Top Hinge,both:Full Hinge]

/* [Hidden] */
leaf_height=hinge_height;
knuckle_diameter=leaf_gauge*2;
knuckle_y_offset = -(knuckle_diameter/2-leaf_gauge/2);
pin_diameter=knuckle_diameter/2;

PrintPart();

module PrintPart() {
    if (part == "bottom") {
        PrintBottom();
    }
    else if (part == "top") {
        PrintTop();
    }
    else {
        PrintBottom();
        PrintTop();
    }
}

module PrintBottom() {
    translate([
        -gap_between_parts_X/2, 
        -gap_between_parts_Y/2, 
        hinge_height/2]) {
        BottomHinge();    
    }    
}

module PrintTop() {
    rotate(180)
    mirror([0,1,0])
    translate([-gap_between_parts_X/2, gap_between_parts_Y/2, hinge_height/2]) {
        TopHinge();
    }
}


module BottomHinge() {
    translate([-knuckle_diameter/2, 0, 0]) {
        BottomKnuckle();
    
        translate([-(leaf_width+knuckle_diameter/2), 0, 0]) {
            Leaf(-screw_hole_offset);
            LeafKnuckleJoiner(true);
        }
    }
}

module TopHinge() {
    translate([-knuckle_diameter/2, 0, 0]) {
        TopKnuckle();
    
        translate([-(leaf_width+knuckle_diameter/2), 0, 0]) {
            translate([0, -knuckle_diameter/2, 0])
            Leaf(-screw_hole_offset);
            mirror([0,1,0])
            LeafKnuckleJoiner(true);
        }
    }
}


module TopKnuckle() {

    difference() {

        // full height fat part
        translate([0, 0, -leaf_height/4])    
        cylinder(
            h=hinge_height/2, 
            d=knuckle_diameter, 
            center=true, 
            $fn=100);
        
        // remove pin part
        cylinder(
            h=hinge_height+1, 
            d=pin_diameter+pin_hole_gap, 
            center=true, 
            $fn=100);
    }
}


module BottomKnuckle() {

    difference() {

        //  fat part
        translate([0, 0, -leaf_height/4])    
        cylinder(
            h=hinge_height/2, 
            d=knuckle_diameter, 
            center=true, 
            $fn=100);
    }
    
    // pin part
    cylinder(
        h=hinge_height, 
        d=pin_diameter, 
        center=true, 
        $fn=100);
    
}

module Leaf(hole_offset=0) {  
    difference() {
        translate([0,0,-leaf_height/2])
        cube([leaf_width, leaf_gauge, leaf_height]);
        
        ScrewHoles(leaf_width/2+hole_offset);
    }
}


// used to draw the base 2D polygon for the Knuckle Joiner
module KnuckleJoiner2D(extra=0) { 
    polygon([
        [leaf_width-extra, -extra], 
        [leaf_width, leaf_gauge+extra], 
        [leaf_width+knuckle_diameter/2+extra, leaf_gauge+extra], 
        [leaf_width, -extra]
    ]);
}

module LeafKnuckleJoiner(top) {
    
    difference() {
        // full height
        linear_extrude(height=leaf_height, center=true)
        KnuckleJoiner2D();

        factor = (top) ? 1 : -1;
        z_offset = factor * (leaf_height/4+1);
    
        // half height
        translate([0, 0, z_offset]) 
        linear_extrude(height=(leaf_height/2+2), center=true)
        KnuckleJoiner2D(1);
    }
}

module ScrewHoles(x_offset) {
    translate([x_offset, 5, leaf_height/4])
    rotate([90,0,0]) 
    cylinder(
        h=leaf_gauge+10, 
        d=screw_hole_diameter, 
        center=true, 
        $fn=100);

    translate([x_offset, 5, -leaf_height/4])
    rotate([90,0,0]) 
    cylinder(
        h=leaf_gauge+10, 
        d=screw_hole_diameter, 
        center=true, 
        $fn=100);
}