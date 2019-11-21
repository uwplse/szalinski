
// form for magnets: "none", "circle", "square"
slot_shape = "square";
slot_size = 11;

hooks_amount = 5;
hook_size = 12;
hook_width = 4;
hook_cutoff = 7;
hook_distance = 30;
hook_thickness = 10;
hook_base_height = 4;

support_length = 60;
support_width = slot_size;
support_height = 4;


frame();

module frame() {
    // hooks
    translate([0, 0, 0]) row();
    translate([0, support_length + hook_thickness, 0]) row();
    
    // horizontal bars
    support(10);
    y_slot_shift = hook_distance * (hooks_amount - 1) + support_width/2;
    support(y_slot_shift);
}


module row(){
    difference(){
        union(){
            for (i = [0 : hooks_amount-1]) {
                translate([i * hook_distance, 0, hook_base_height - hook_width]) hook();
            }
            translate([-2, 0, 0]) cube([hook_distance * hooks_amount, hook_thickness, hook_base_height]);
        }
        translate([-5, -5, -10]) cube([hook_distance * hooks_amount + 10, 2*hook_thickness, 10]);
    }
}

module hook() {
    hook_var = hook_size + hook_width;
    difference(){
        union(){
            translate([0, 0, hook_var]) rotate([-90, 0, 0]) cylinder(h = hook_thickness, r1 = hook_var, r2 = hook_var);
            cube([hook_var, hook_thickness, hook_var]);
            translate([hook_var, 0, 0]) cube([hook_size, hook_thickness, hook_var]);
        }
        union(){
            translate([0, -5, hook_var]) rotate([-90, 0, 0]) cylinder(h = hook_thickness * 2, r1 = hook_size, r2 = hook_size);
            translate([2*hook_size + hook_width, - 5, hook_var]) rotate([-90, 0, 0]) cylinder(h = hook_thickness * 2, r1 = hook_size, r2 = hook_size);
            translate([-2*(hook_var), -5, 0]) cube([2*(hook_var), hook_thickness * 2, 2*(hook_var)]);
            translate([-2*(hook_var) + hook_cutoff, -5, hook_var]) cube([2*(hook_var), hook_thickness * 2, 2*(hook_var)]);
        }
    }
}

module support(x_position) {
    slot_base_size = slot_size + 4;
    difference() {
        union() {
            translate([x_position, 0, 0]) cube([support_width, 2*hook_thickness + support_length, support_height]);
            // magnet slot bases
            translate([x_position + support_width/2, hook_thickness + slot_base_size/2, support_height/2]) centered_shape(slot_base_size);
            translate([x_position + support_width/2, hook_thickness + support_length - slot_base_size/2, support_height/2]) centered_shape(slot_base_size);
        }
        union() {
            // magnet slots 
            translate([x_position + support_width/2, hook_thickness + slot_base_size/2, support_height/2 + 0.5]) centered_shape(slot_size);
            translate([x_position + support_width/2, hook_thickness + support_length - slot_base_size/2, support_height/2 + 0.5]) centered_shape(slot_size);
        }
    }        

    module centered_shape(shape_size=slot_size) {
        if(slot_shape == "circle") {
            cylinder(h = support_height, d = shape_size, center = true);
        }
        else{
            if(slot_shape == "square") {
                cube([shape_size, shape_size, support_height], center = true);
            }
        }
    }
}




