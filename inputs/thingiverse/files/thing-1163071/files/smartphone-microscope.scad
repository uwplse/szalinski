lens_distance = 35.5;
lens_radius = 2.5;
phone_thinkness = 7;

clip(lens_distance, lens_radius, phone_thinkness);

module semi_circle_shell(radius, shell_thickness = 2, shell_height = 15) {
    difference() {
        rotate_extrude(convexity = 10, $fn=72) 
            translate([radius, 0, 0]) 
                square([shell_thickness, shell_height]);
        
        outer_radius = radius + shell_thickness;
        
        translate([-outer_radius, -outer_radius, -1])
            cube([outer_radius * 2, outer_radius, shell_height + 2]);
    }
}

module curve_shell(radius, shell_thickness = 2,  shell_height = 15) {
    mask_thickness = radius * 0.5;
         
    translate([0, -mask_thickness, 0]) difference() {
        semi_circle_shell(radius, shell_thickness, shell_height);
        
        width = radius + shell_thickness;
        
        translate([-width, 0, -shell_thickness / 2]) 
            cube([width * 2, mask_thickness, shell_height + shell_thickness]);
    }   
}

module wave(l1, l2, shell_thickness = 2, shell_height = 15) {
    square_root_of_3 = 1.732050807568877;
    r1 = 2 * l1 / square_root_of_3;
    r2 = 2 * l2 / square_root_of_3;
    
    translate([l2 + shell_thickness, 0, 0]) 
        curve_shell(r2, shell_thickness, shell_height);
        
    mirror([0, 1, 0]) 
        translate([l1 + 2 * (shell_thickness + l2) + 0.2, 0, 0]) 
            curve_shell(r1, shell_thickness, shell_height);
}

module clip(lens_distance, lens_radius, phone_thickness, shell_thickness = 2, shell_height = 15) {
    l1 = (lens_distance - shell_thickness) / 7;
    l2 = 3 * l1;
    
    square_root_of_3 = 1.732050807568877;
    r1 = 2 * l1 / square_root_of_3;
    
    y_offset = r1 * 0.25 + shell_thickness + phone_thickness;   

    difference() {
        union() {
           wave(l1, l2, shell_thickness, shell_height);

           translate([0, -(phone_thickness + r1 * 0.25 + 2 * shell_thickness), 0]) 
               cube([(l1 + l2) * 2 + shell_thickness * 4, shell_thickness, shell_height]);
           
           translate([0, -y_offset, 0]) cube([shell_thickness, y_offset, shell_height]);
        }
        
        translate([lens_distance + shell_thickness, -y_offset + 2, shell_height / 2]) 
            rotate([90, 0, 0]) 
                cylinder(r=lens_radius, h=6, $fn=72);
    }
}

