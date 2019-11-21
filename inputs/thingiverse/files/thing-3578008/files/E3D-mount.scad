// E3D Titan mount
// Ryan Crosby 2019
//
// All units are in mm

//
// Constants
//

// Floating point errors can cause difference operations to leave really thin faces where there should be none.
// Add this to subtracted object dimensions where appropriate to prevent this.
SUBSTRACT_ERROR_MARGIN = 0.0001;

//
// Variables
//
        
// The front spacing between the motor and extruder. Tweak this depending on the length of the axle and flat edge of your stepper motor.
// See the E3D setup guide for hints on what this should be, ultimately your metal gear needs to be able to sit on the motor shaft such that the top surface is flush with the larger plastic gear top surface.
// The metal gear's grub screw should be closer to the motor so that the grub screw's hole doesn't mesh with and wear the plastic gear. The grub screw should ideally also screw down to the milled flat section of the stepper motor.
// Somewhere between 2-5mm should probably do it.
front_spacing = 3;

// The thickness of the supporting walls surrounding the stepper motor. Increase for more strength.
wall_thickness = 5;

// The stepper motor dimensions.
// Nema17 are 42.3 x 42.3 x depth
// Circle round motor axle is 22mm+-0.05mm
// Mounting holes are 31mm+-0.1mm apart
stepper_edge = 42.5; // 42.3mm with 0.2mm tolerence
// Change this to match the depth of your stepper motor
stepper_depth = 60;
stepper_circle_radius = 11.1; // 22mm diameter 0.2mm tolerence
stepper_screw_spacing = 31;
// Increase radius if holes are too tight
stepper_screw_radius = 1.5;

// Mount parameters
//
// Thickness of the mount. Increase for longer screws and higher strength.
// This also changes the thickness of the box roof.
mount_thickness = 7;
// Width of the mount
mount_width = stepper_edge + 50;
// Usually set the mounting depth to the width of your extrusion.
// 20mm for System 20 T slot.
mount_depth = 20;
// Offset from the front of the stepper.
// Increase this to move the mount backwards.
// This reduces torque when using a longer, heavier stepper motor.
// Set to 0 for support-free printing.
mount_offset_depth = 0;
// Offset from the front of the mount where the center of the screw hole will be located.
// Usually half the width of your extrusion, 10mm for System 20 T slot.
mount_screw_spacing_front = 20 / 2; // System 20 extrusion
mount_hole_spacing_side = 20 / 2;
// Increase radius if holes are too tight
mount_hole_radius = 2;


// The dimensions for the outer edges of the main box.
box_width = stepper_edge + 2 * wall_thickness;
box_height = stepper_edge + wall_thickness + mount_thickness;
box_depth = stepper_depth + front_spacing;

// Controls the triangular prism cutout on the end of the main box.
//
// The depth of the top edge.
// Must be big enough for connectors, may be larger for cooling.
cutout_depth_max = stepper_edge / 2 + wall_thickness;
cutout_depth_min = box_depth - (mount_depth + mount_offset_depth);

cutout_depth = min(cutout_depth_max, cutout_depth_min);
// The height of the prism. Can be smaller for more strength, larger for more cooling.
cutout_height = stepper_edge / 2 + wall_thickness;

//
// Modules
//

// Triangular prism
module prism(l, w, h){
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
}

module hole(r, h) {
    cylinder(h = h + 2 * SUBSTRACT_ERROR_MARGIN, r1 = r, r2 = r, center = true, $fs = 0.1);
}

//
// Part
//

difference() {
    // Create main mounting box
    translate([-box_width / 2, 0, 0])
    difference() {
        // The outer surround
        cube([box_width, box_depth, box_height]);

        // Subtract space for the stepper motor
        translate([wall_thickness, front_spacing, wall_thickness])    
        cube([stepper_edge, stepper_depth, stepper_edge]);
        
        // The diagonal cut-out, for connectors
        rotate([0,180,0])
        translate([-box_width - SUBSTRACT_ERROR_MARGIN, box_depth - cutout_depth + SUBSTRACT_ERROR_MARGIN, -box_height - SUBSTRACT_ERROR_MARGIN])
        prism(box_width + 2 * SUBSTRACT_ERROR_MARGIN, cutout_depth, cutout_height);
    }

    // Cut out stepper motor hole 
    translate([0, front_spacing / 2 + SUBSTRACT_ERROR_MARGIN, stepper_edge / 2 + wall_thickness])
    rotate([90, 0, 0])
    hole(stepper_circle_radius, front_spacing);
    
    // Cut out the four stepper mounting holes
    translate([stepper_screw_spacing / 2, front_spacing / 2 + SUBSTRACT_ERROR_MARGIN, stepper_screw_spacing / 2 + stepper_edge / 2 + wall_thickness])
    rotate([90, 0, 0])
    hole(stepper_screw_radius, front_spacing);
    
    translate([-stepper_screw_spacing / 2, front_spacing / 2 + SUBSTRACT_ERROR_MARGIN, stepper_screw_spacing / 2 + stepper_edge / 2 + wall_thickness])
    rotate([90, 0, 0])
    hole(stepper_screw_radius, front_spacing);
    
    translate([stepper_screw_spacing / 2, front_spacing / 2 + SUBSTRACT_ERROR_MARGIN, -stepper_screw_spacing / 2 + stepper_edge / 2 + wall_thickness])
    rotate([90, 0, 0])
    hole(stepper_screw_radius, front_spacing);
    
    translate([-stepper_screw_spacing / 2, front_spacing / 2 + SUBSTRACT_ERROR_MARGIN, -stepper_screw_spacing / 2 + stepper_edge / 2 + wall_thickness])
    rotate([90, 0, 0])
    hole(stepper_screw_radius, front_spacing);
}


difference() {
    // Mount for the extrusion
    translate([-mount_width / 2, mount_offset_depth, stepper_edge + wall_thickness])
    cube([mount_width, mount_depth, mount_thickness]);
    
    // Cut out the mounting holes
    translate([mount_width / 2 - mount_hole_spacing_side, mount_offset_depth + mount_screw_spacing_front, stepper_edge + wall_thickness + mount_thickness / 2 - SUBSTRACT_ERROR_MARGIN])
    hole(mount_hole_radius, mount_thickness);
    
    translate([-mount_width / 2 + mount_hole_spacing_side, mount_offset_depth + mount_screw_spacing_front, stepper_edge + wall_thickness + mount_thickness / 2 - SUBSTRACT_ERROR_MARGIN])
    hole(mount_hole_radius, mount_thickness);
}