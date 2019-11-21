include <MCAD/units.scad>

$fn = 60;

width = 15;
length = 58;
thickness = 4;
groove = 2.8;
wall_height = 7;
wall_thickness = 2;

tolerance = 0.15;

tool_diameter = 11.5;
tool_tolerance = 1;
nut_trap_thickness = 1.8;
tool_holder_padding = 2.5;
tool_holder_length = tool_diameter + tool_tolerance + nut_trap_thickness + tool_holder_padding * 2;
tool_holder_height = 15;
nut_trap_diameter = 6;

difference() {
    union() {
        translate([-width/2, -length/2])
        cube([width, length, thickness]);
        
        translate([-tool_diameter/2-tool_holder_padding, length / 2 - tool_holder_length, 0])
        cube([tool_diameter + 2 * tool_holder_padding, tool_holder_length, tool_holder_height]);
    }
    
    translate([0, length / 2 - nut_trap_thickness - tool_holder_length / 2, -epsilon / 2])
    cylinder(h=tool_holder_height + epsilon, r=(tool_diameter + tool_tolerance) / 2);
    
    translate([0, length / 2 + epsilon, tool_holder_length / 2])
    rotate([90, 0, 0])
    cylinder(r=(M3 + tolerance)/2, h=tool_holder_length / 2);
    
    // nut trap
    translate([-(nut_trap_diameter + tolerance) / 2, length / 2 - nut_trap_thickness - (tool_holder_padding - nut_trap_thickness / 2), tool_holder_height / 2 - (nut_trap_diameter + tolerance) / 2])
    cube([6 + tolerance, nut_trap_thickness, tool_holder_height]);
}

translate([-width/2, -length/2, thickness])
cube([width, wall_thickness, wall_height]);

translate([-width/2, -length/2 + groove + wall_thickness, thickness])
cube([width, wall_thickness, wall_height]);
