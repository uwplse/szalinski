// The width of the wall or post that the support will be pressed against.
wall_width = 89;

// The width of the piece of the gate that will be pressed against the support.
gate_bar_diameter = 34;

// The distance from the end of the support that the inset section should be. Leave 0 for a centered inset.
inset_offset=0;

module baby_gate_support(wall_width=0, gate_bar_diameter=0, inset_offset=0) {
    support_thickness = 7;
    inset_thickness = 3;
    support_height = gate_bar_diameter + 4;
    gate_support_indent_width = gate_bar_diameter + 4;
    clip_length = 15;
    
    difference() {
        union() {
            translate([-support_thickness, 0, 0]) cube([support_thickness, clip_length + support_thickness, support_height ]);
            cube([wall_width+2, support_thickness, support_height ]);
            translate([wall_width+2, 0, 0]) cube([support_thickness, clip_length + support_thickness, support_height ]);
        }
        
        if (inset_offset == 0) {
            translate([(wall_width + 2 - gate_support_indent_width) / 2, -(support_thickness - inset_thickness), -support_height/2]) cube([gate_support_indent_width, (support_thickness - inset_thickness)*2, support_height * 2]);
        } else {
            translate([inset_offset+1, -(support_thickness - inset_thickness), -support_height/2]) cube([gate_support_indent_width, (support_thickness - inset_thickness)*2, support_height * 2]);
        }
    }
}

baby_gate_support(wall_width=wall_width, gate_bar_diameter=gate_bar_diameter, inset_offset=inset_offset);