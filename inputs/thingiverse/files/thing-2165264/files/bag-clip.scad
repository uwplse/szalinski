/* https://www.thingiverse.com/thing:2165264 */

// The diameter of the hinge
axis_diameter = 5.0;
// The gap left around the hinge (subtracted from the diameter)
axis_margin = 0.6;
// Z-wise separation near parts
axis_margin_z = 0.4;

// The length of the arms (from hinge center)
arm_length = 80.0;
// The height of the arms
arm_height = 10.0;
// The width/thickness of one arm
arm_width  =  5.0;

// The size of the hinge attached to the second arm
mount_height = 3.0;

// Size of the channel/potrusion in the arms, 0 to disable
channel_d = 2;

// Length of the locking hook
hook_tooth_length = 4.5;

/* [Hidden] */

hook_margin = 1.0;
hook_thickness = 1.5;
hook_trim_length = 3.0;

_cyl_fn = 24;

base_arm();
color("red") rotate(-20) second_arm();

module base_arm() {
    difference() {
        union() {
            // Main arm
            translate([-arm_width, 0])
                    cube([arm_width, arm_length, arm_height]);
            // Hinge outer
            cylinder(r=arm_width, h=arm_height, $fn=_cyl_fn);
            
            // Hook
            translate([-arm_width, arm_length, 0]) {
                cube([hook_thickness, hook_thickness+hook_margin, arm_height]);
                translate([0, hook_margin, 0])
                    cube([arm_width*2+hook_margin, hook_thickness, arm_height]);
                translate([arm_width*2+hook_margin, -hook_tooth_length+hook_margin+hook_thickness, 0])
                    difference() {
                        cube([hook_thickness, hook_tooth_length, arm_height]);
                        translate([0,0,-1]) rotate(-45)
                            cube([hook_thickness*1.5, hook_thickness*1.5, arm_height+2]);
                    }
            }
        }
        // Hook trim
        translate([-arm_width+hook_thickness, arm_length-hook_trim_length, -1])
            cube([hook_margin, hook_trim_length+hook_margin, arm_height+2]);
        
        channel(0.25);
        
        // Remove slot for arm to rotate in
        translate([0,-arm_width, (arm_height-mount_height)/2])
            cube([arm_width, arm_width*2, mount_height]);
        
        c_h = (arm_height - mount_height) / 2;
        // Trim slot a bit more
        translate([0, 0, c_h])  hull() {
            cylinder(d=axis_diameter+axis_margin*2, h=mount_height, $fn=_cyl_fn);
            translate([0, -arm_width, 0]) cube([0.01, arm_width, mount_height]);
        }
        
        // Big center hole
        translate([0,0,-1]) cylinder(d=axis_diameter+axis_margin*2, h=arm_height+2, $fn=_cyl_fn);
    }
}


module channel(delta=0) {
    if (channel_d > 0) {
        translate([0,arm_length/2+axis_diameter/2, arm_height/2]) rotate([0, 45, 0])
            cube([channel_d+delta, arm_length-axis_diameter, channel_d+delta], center=true);
    }
}

module second_arm() {
    c_h = (arm_height - mount_height) / 2 + axis_margin_z;
    difference() {
        translate([0, 0])
            cube([arm_width, arm_length, arm_height]);
        
        // Remove lower piece
        translate([0, 0, -1])
            cylinder(r=arm_width+axis_margin, h=c_h+1, $fn=_cyl_fn);
        // Remove upper piece
        translate([0, 0, arm_height-c_h])
            cylinder(r=arm_width+axis_margin, h=c_h+1, $fn=_cyl_fn);
    
    }
    // Potrusion
    channel(-0.25);
    
    // Center cylinder
    cylinder(d=axis_diameter, h=arm_height, $fn=_cyl_fn);
    
    // Attach to arm
    translate([0, 0, c_h])  hull() {
        cylinder(d=axis_diameter, h=arm_height-c_h*2, $fn=_cyl_fn);
        cube([arm_width, 0.01, arm_height-c_h*2]);
    }
}
