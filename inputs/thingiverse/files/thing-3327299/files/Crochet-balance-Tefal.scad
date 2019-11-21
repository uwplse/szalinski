head_inner_radius=11.4;
head_outer_radius=20.5;
head_thickness=3.1;
head_space=10;

module scale_obj() {
    union() {
        translate([0,0,head_thickness]) difference() {
            cylinder(head_thickness,head_outer_radius,head_outer_radius);
            cylinder(head_thickness,head_inner_radius,head_inner_radius);
        }
        translate([-head_outer_radius,0,0]) cube([2*head_outer_radius,4*head_outer_radius,head_thickness]);
    }
    
}

module head() {
    cylinder(head_space+head_thickness,head_inner_radius,head_inner_radius);
}


module ring() {
    difference() {
        cylinder(head_space,head_outer_radius,head_outer_radius);
        cylinder(head_space,0.75*head_inner_radius,0.75*head_inner_radius);
    }
}

module support() {
    union() {
        cylinder(head_thickness,head_inner_radius,head_inner_radius);
        translate([-head_inner_radius,0,0]) cube([2*head_inner_radius,head_inner_radius,head_thickness]);
        translate([0,head_inner_radius,0]) cylinder(head_thickness,head_inner_radius,head_inner_radius);
    }
}

module hook() {
    difference() {
        head();
        scale([1.05,1.05,10]) scale_obj();
        ring(); 
    }
}

module final() {
    union() {
        hook();
        support();
    }
}

final();

