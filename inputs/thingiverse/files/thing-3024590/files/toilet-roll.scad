/* chosen special dimensions, mm */
p_clearance = 0.2;
p_hook_depth = p_clearance + 0.9;
p_slope = 1.0;

/* chosen dimensions, mm */
p_outer_diameter = 38.1;
p_shoulder_diameter = 17;
p_shoulder_length = 5;
p_max_barrel_length = 128;
p_min_barrel_length = p_max_barrel_length - 10;
p_spring_rest_length = 77;
p_spring_diameter = 19 + p_clearance;
p_wall_thick = 0.8;
p_tab_length = 4;
p_tab_cut = p_outer_diameter * 0.3;

// intermediate useful quantities
inner_outer_diameter = p_outer_diameter - (p_wall_thick + p_hook_depth + p_clearance) * 2;
spring_flat_half_length = p_spring_rest_length / 2;
spring_taper_half_length = spring_flat_half_length - p_slope * (inner_outer_diameter - p_wall_thick - p_spring_diameter)/2;
compression_length = p_max_barrel_length - p_min_barrel_length;
echo(compression_length);

// z-length of the hook
hook_length = p_hook_depth / p_slope;
// length of one half up to the hook
visible_shell_length = p_max_barrel_length / 2 + p_hook_depth;
// length of one half behind the hook
hidden_shell_length = spring_taper_half_length - compression_length - hook_length * 2;

hook_z = hidden_shell_length;
shell_end_z = visible_shell_length + hidden_shell_length;
spring_flat_z = hook_z + spring_flat_half_length;
spring_taper_z = hook_z + spring_taper_half_length;

if (false) {
    clearance_test();
} else {
    difference() {
        printing_parts();
        *cube([1000, 1000, 1000]);
    }
}

module clearance_test() {
    difference() {
        union() {
            assembled(0);
            translate([0, p_outer_diameter * 2, 0]) assembled(compression_length / 2);
        }
        
        translate([0, -500, -500])
        cube([1000, 1000, 1000]);

    }
    
    module assembled(compression_half) {
        translate([0, 0, -hidden_shell_length - hook_length - compression_half])
        outer_part();
        
        rotate([0, 180, 0])
        translate([0, 0, -hidden_shell_length - hook_length - compression_half])
        inner_part();
        
    }
}

module printing_parts() {
    outer_part();

    translate([50, 0, 0])
    inner_part();
}

module outer_part() {
    roll_3d(p_outer_diameter, hook_outer=false);
}

module inner_part() {
    roll_3d(inner_outer_diameter, hook_outer=true);
}

module roll_3d(outer_diameter, hook_outer) {
    difference() {
        rotate_extrude(angle=90)
        roll_hollowed(outer_diameter, hook_outer);
        
        if (hook_outer) {
            cut_z = hook_z + p_tab_length;
            cut_dia = p_tab_cut;
            for (i = [0:3]) {
                rotate([0, 0, i * 90])
                translate([0, -p_outer_diameter * 0.4, hook_z]) {
                    cylinder(d=cut_dia, h=p_tab_length*2, center=true);
                    translate([0, 0, p_tab_length - 0.01])
                    cylinder(d1=cut_dia, d2=0, h=cut_dia / 2);
                }
            }
        }
    }
}

module roll_hollowed(outer_diameter, hook_outer=false) {
    difference() {
        roll_polygon(outer_diameter, slope=p_slope / 2, hook=hook_outer);
        interior_polygon(outer_diameter, hook=!hook_outer);
    }
}

module roll_polygon(outer_diameter, slope, hook=false) {
    end_slope_z = shell_end_z - slope * (outer_diameter - p_shoulder_diameter)/2;
    polygon([
        [0, 0],
        [outer_diameter/2, 0],
        [outer_diameter/2, hook_z],
        [outer_diameter/2 + (hook?1:0) * p_hook_depth, hook_z + hook_length],
        [outer_diameter/2, hook_z + hook_length],
        // spring_taper_z is the same as how far the parts slide together
        [outer_diameter/2, spring_taper_z],
        [p_outer_diameter/2, spring_taper_z + (p_outer_diameter - outer_diameter)/2],
        [p_outer_diameter/2, end_slope_z],
        [p_shoulder_diameter/2, shell_end_z],
        [p_shoulder_diameter/2, shell_end_z + p_shoulder_length],
        [0, shell_end_z + p_shoulder_length],
    ]);  
}

module interior_polygon(outer_diameter, hook=false) {
    inner_r = outer_diameter/2 - p_wall_thick;
    bottomz = hook_z + (hook ? -1 : p_wall_thick);
    hook_inset = (hook?1:0) * p_hook_depth;
    polygon([
        [0, 0],
        [inner_r - hook_inset, 0],
        [inner_r - hook_inset, max(0, bottomz)],
        [inner_r - hook_inset, hook_z + hook_length],
        [inner_r, hook_z + hook_length],
        [inner_r, spring_taper_z],
        [p_spring_diameter / 2, spring_flat_z],
        [0, spring_flat_z],
    ]);  
}