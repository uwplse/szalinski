// MOAB - MOther of All fan Brackets
// Design by Marius Gheorghescu, October 2013.
// Update log
// November 5th 2013: 
//  - fan cutout (and the screw holes) can be removed entirely now to produce spacers or PCB feet 
//  - hex nuts resize with screw size (need to vealidate in practice)
//  - cross-brace is configurable and can also be removed


// Typical values 40, 50, 60, 80. Set to 0 to not have a fan cutout.
fan_size = 40;

// Distance between two fan holes. Typical values: 32.00 for 40mm fan, 40.00 for 50mm fan, 50.00 for 60mm fan, 71.50 for 80mm fan, 105.00 for 120mm fan. Set to value larger than fan size to not have any screw holes
fan_hole_spacing = 32;

// Use 3.25mm for M3, 4.25mm for M4 and so on
screw_diameter = 3.25;

// width of the PCB. Common values: 60mm for RAMPS, 53.5mm for Arduino, 56mm for Raspberry Pi
pcb_width = 60.0;

// distance from bottom of the fan to PCB. Recommended value for RAMPS fuse clearance: 35mm
bracket_height = 36;

// how long the bracket needs to be, typically 10mm for mini brackets, or close to fan size for full brackets
bracket_length = 12;

// typically 2-4mm
bracket_thickness = 3.0;

// how tall is the cross brace that addds additional strength to the bracket, set to 0 to not have one
cross_bracket = 10;

/* [Hidden] */

// how much to go over the PCB
lip_size = 1.75;

// effective width of the bracket at the top
bracket_width = max(pcb_width, fan_size - 4);

module legs()
{

    difference() {
        union() {

            // left clip
            color([0,0,.5])
            translate([-pcb_width/2 + .5, -bracket_height + 2, 0])
                rotate([0, 0, 180]) 
                    cylinder(r=2.5, h=bracket_length, $fn=6, center=true);

            // left leg
            color([0,0,1])
            translate([-pcb_width/2 - bracket_thickness, -bracket_height + bracket_thickness/2, -bracket_length/2])
                cube([bracket_thickness, bracket_height, bracket_length]);


            // right clip
            color([0,0,.5])
            translate([pcb_width/2 - .5, -bracket_height + 2, 0])
                 rotate([0, 0, 180]) 
                     cylinder(r=2.5, h=bracket_length, $fn=6, center=true);

            // right leg
            color([0,0,1])
           translate([pcb_width/2 , -bracket_height + bracket_thickness/2, -bracket_length/2])
                cube([bracket_thickness, bracket_height, bracket_length]);

        }

        // left cutout
       translate([-pcb_width/2 + .5, -bracket_height + 2, 0])
            rotate([0, 0, 180]) 
                cylinder(r=1, h=bracket_length + 0.1, $fn=6, center=true);

        // right cutout
       translate([pcb_width/2 - .5, -bracket_height + 2, 0])
            cylinder(r=1, h=bracket_length + 0.1, $fn=6, center=true);

        // PCB lips clearance
        translate([0, -bracket_height + bracket_thickness + -.5,0])
            cube([pcb_width - 2*lip_size, 12, bracket_length + 0.1], center=true);

        // PCB
        translate([0, -bracket_height + 2, 0])
            cube([pcb_width, 1.75, bracket_length + 0.1], center=true);

    }

}

module fan_mask()
{
    // M3 screw
    translate([-fan_hole_spacing/2, -fan_hole_spacing/2, 0])
        cylinder(r=screw_diameter/2, h=bracket_height, $fn=20, center=true);
    translate([fan_hole_spacing/2, -fan_hole_spacing/2, 0])
        cylinder(r=screw_diameter/2, h=bracket_height, $fn=20, center=true);
    translate([-fan_hole_spacing/2, fan_hole_spacing/2, 0])
        cylinder(r=screw_diameter/2, h=bracket_height, $fn=20, center=true);
    translate([fan_hole_spacing/2, fan_hole_spacing/2, 0])
        cylinder(r=screw_diameter/2, h=bracket_height, $fn=20, center=true);

    // M3 nuts
    translate([-fan_hole_spacing/2, -fan_hole_spacing/2, 0])
        cylinder(r=screw_diameter, h=4, $fn=6, center=true);
    translate([fan_hole_spacing/2, -fan_hole_spacing/2, 0])
        cylinder(r=screw_diameter, h=4, $fn=6, center=true);
    translate([-fan_hole_spacing/2, fan_hole_spacing/2, 0])
        cylinder(r=screw_diameter, h=4, $fn=6, center=true);
    translate([fan_hole_spacing/2, fan_hole_spacing/2, 0])
        cylinder(r=screw_diameter, h=4, $fn=6, center=true);

    // fan blade clearance
    difference() {
        cylinder(r=fan_size/2, h=bracket_height, $fn=120, center=true);

        // $TODO - add support around the screws if they are too close to the blades
        // also need to add support if the bracket is not wide (tall) enough 
    }
}


module bracket()
{
    difference() {
        union() {

            // fan base
            translate([0, 0, 0])
                cube([bracket_width + 2*bracket_thickness, bracket_thickness, bracket_length], center=true);

            // extra strength 
            color([1,.5,0])
            translate([0, -cross_bracket/2, -bracket_length/2 + bracket_thickness/4])
                cube([pcb_width + 1, cross_bracket, bracket_thickness/2], center=true);

            legs();
        }


        translate([0, -bracket_thickness, -bracket_length/2 + fan_size/2 + bracket_thickness/2])
        rotate([90,0,0])
            fan_mask();

        }
}


module assembly() 
{
    color([1,0,0])
    translate([0, 0, -fan_size/2])
        bracket();

    color([1,0,0])
    //translate([0, 0, fan_size/2])
    rotate([0,180,0])
        bracket();

    color([0,.5,0])
    translate([0, -bracket_height + 2, 0])
        cube([pcb_width - 1, 1.75, fan_size*1.5], center=true);

}

//assembly();
bracket();
//fan_mask();