/* [Basic parameters] */

// Blade piece length minus blade tip (the visible part)
blade_inner_length = 107;
handle_length = 150;

/* [Extended parameters] */

blade_width = 12;
blade_thickness = 0.5;
blade_hole_diameter = 4;
blade_teeth_thickness = 1;
blade_teeth_width = 2;

// Make at least 6 mm more than Blade Width
handle_width = 18;
handle_height = 10;
// Scale width down to the end of the handle
scale_width = 0.75;
// Scale height down to the end
scale_height = 0.6;
grip_offset = 6;
facet_radius = 4;
slot_angle = 30;

pin_cap_diameter = 7;

tolerance = 0.2;

/* [Hidden] */

// Calculate some values

pin_height = handle_height*((1 - scale_height)*(handle_length-blade_inner_length+blade_width/2)/(handle_length-grip_offset)+scale_height);

$fn = 32;

module handle_shape()
{
    translate([-handle_width/2+facet_radius,-handle_height/2+facet_radius,0]) {
        minkowski() {
            square([handle_width-facet_radius*2,handle_height-facet_radius*2]);
            circle(r=facet_radius);
        }
    }
}

module slot_shape(tol=tolerance)
{
    translate([-blade_width/2,0,0])
    polygon(points=[[tol,blade_thickness/2],
            [blade_width-tol,blade_thickness/2],
            [blade_width-tol-((handle_height-blade_thickness)/2)*tan(slot_angle), handle_height/2],
            [((handle_height-blade_thickness)/2)*tan(slot_angle)+tol,handle_height/2]]);
}

module body()
{
            translate([0,0,grip_offset]) {
                linear_extrude(height=handle_length-grip_offset, scale=[scale_width,scale_height])
                    handle_shape();
                rotate([180,0,0])
                    linear_extrude(height=grip_offset, scale=[scale_width,scale_height])
                        handle_shape();
            }
}

module pin(hole=false, tol=tolerance)
{
    translate([0,0,blade_inner_length-blade_width/2]) {
        rotate([-90,0,0]) {
            cap_height = pin_height/2-(blade_thickness/2+1);
            
            cylinder(h=(hole ? handle_height+2 : pin_height), r=blade_hole_diameter/2-tol, center=true);

            translate([0,0,blade_thickness/2+1])
            cylinder(h=(hole ? handle_height/2 : cap_height), r=pin_cap_diameter/2-tol);
        }
    }
}

module blade(tol=tolerance)
{
    translate([0,0,blade_inner_length/2-8.5])
        cube([blade_width+tol*2,blade_thickness,blade_inner_length+16], center=true);
    translate([(blade_width-blade_teeth_width)/2+tol,0,blade_inner_length/2-8.5])
        cube([blade_teeth_width+tol,blade_teeth_thickness,blade_inner_length+16], center=true);
}

module body_with_blade()
{
    difference() {
        body();

        blade(tol=tolerance);
        pin(hole=true, tol=0);
    }
}

module slot_cutout()
{
    translate([0,0,-1])
        linear_extrude(height=handle_length+2)
            slot_shape(0);
}

module slide_cutout()
{
    difference() {
        translate([0,0,handle_length/2+0.5])
            cube([handle_width,handle_height,handle_length+2], center=true);

        translate([0,0,-1])
            linear_extrude(height=handle_length+2)
                slot_shape(tolerance);
    }
}

module body_with_slot()
{
    difference() {
        body_with_blade();
        slot_cutout();
    }
}

module slide()
{
    difference() {
        body_with_blade();
        slide_cutout();
    }
}

module show()
{
    body_with_slot();
    slide();
    #blade(tol=0);
    pin(hole=false, tol=tolerance);
}

module print()
{
    translate([handle_width/2+2,-grip_offset,0])
        rotate([atan((1-scale_height)*handle_height/2/(handle_length-grip_offset)),0,0])
            translate([0,grip_offset,0])
                rotate([90,0,0])
                    translate([0, handle_height/2, 0])
                        body_with_slot();

    translate([-handle_width/2-2,0,0])
        rotate([90,0,0])
            translate([0, -blade_thickness/2, 0])
                slide();
    
    translate([handle_width*3/2+4,-handle_length/2,pin_height/2])
        rotate([-90,0,0])
            translate([0,0,-(blade_inner_length-blade_width/2)])
                pin(hole=false, tol=tolerance);
}

//show();
print();
