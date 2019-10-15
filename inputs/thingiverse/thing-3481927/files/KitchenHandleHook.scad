$fa=1*1;
$fs=0.25*1;

// hook position: front/top or below of clip
hook_type = 0; // [0:front, 1:below, 2:below/double, 3:below/double/sideways, 4:below/double/frontback]

// precision adjustment (offset) for inner cut outs
cutout_adjust = 0.4;

// clip inner / handle diameter
clip_inner_diameter = 14.0;

// length of clip 
clip_length=25;

// thickness of clip wall
wall_thickness=4;

// diameter of perpendicual handle (where the actual handle is fixed to the cupboard)
support_diameter = 12;

// diameter of hook element
hook_diameter = 8;

// length of hook
hook_length = 15;

// angle in degrees of front(=0) hook. Top=90
front_hook_angle = 0;

// below clip hook: lengthen tip
tip_offset = 0;

hook_radius = hook_length-3;

clip_outer_diameter = clip_inner_diameter+2*wall_thickness;
clip_opening=clip_inner_diameter-4;


clip();

module select_hook() {
    if (hook_type == 0) {
        front_hook();
    } else if (hook_type == 1) {
        vertical_hook();
    } else if (hook_type == 2) {
        vertical_double_hook();
    } else if (hook_type == 3) {
        vertical_double_sideways_hook();
    } else if (hook_type == 4) {
        vertical_double_frontback_hook();
    }
}


module clip() {
    rotate([90,0,0])
    difference() {
        union() {
            cylinder(clip_length, d=clip_outer_diameter, center=true);
            rotate([-90,0,0])
                select_hook();
        }
        cylinder(clip_length, d=clip_inner_diameter+cutout_adjust, center=true);

        translate([-clip_inner_diameter/2, 0, 0])
            cube([clip_inner_diameter, clip_opening, clip_length], center=true);

        rotate([0,-90,0])
            cylinder(clip_outer_diameter, d=support_diameter+cutout_adjust);
    }    
}


module front_hook() {
    
    angle = front_hook_angle;
    d = clip_outer_diameter/2+hook_length;

    union() {
        hull() {
            rotate([0,90-angle,0])
                cylinder(hook_length, d=hook_diameter);

            translate([d*cos(angle), 0, d*sin(angle)])
                cylinder(hook_diameter*cos(angle)+0.1, d=hook_diameter, center=true);
        }

        translate([d*cos(angle), 0, d*sin(angle)+hook_diameter/2*cos(angle)])  
        union() {
            cylinder(hook_diameter, d=hook_diameter);
            translate([0, 0, hook_diameter])
                sphere(d=hook_diameter);
        }
    }
    //translate([clip_outer_diameter/2+hook_length, 0, hook_diameter])
}


module vertical_double_hook() {
    rotate([0,0,-60])
        vertical_hook();
    rotate([0,0,60])
        vertical_hook();
}


module vertical_double_frontback_hook() {
    vertical_hook();
    mirror([1,0,0])
        vertical_hook();
}


module vertical_double_sideways_hook() {
    rotate([0,0,90])
        vertical_double_frontback_hook();
}


module vertical_hook() {

    r = hook_radius;
    
    translate([r,0,-clip_outer_diameter])
    union() {
        
        // round part of hook
        rotate([90,0,0])
        difference() {
            rotate_extrude(convexity = 10, $fn = 100)
                translate([r, 0, 0])
                    circle(d = hook_diameter, $fn = 100);    
            // cut out upper half of hook
            translate([-(r+hook_diameter),0,-hook_diameter/2])
                cube([(r+hook_diameter)*2, r+hook_diameter, hook_diameter]);
        }

        // small vertical offset for hook tip
        translate([r, 0, 0])
            cylinder(tip_offset, d=hook_diameter);

        // round knob on hook
        translate([r, 0, tip_offset])
            sphere(d=hook_diameter);
    }
    
    // neck of hook
    h = clip_outer_diameter/2+1;
    translate([0,0,-clip_outer_diameter+h+1])
        mirror([0,0,1])
            smoothed_cylinder(hook_diameter/2, hook_diameter*0.75, h+1);

}


module torus(r1, r2, h) {
    torus_r=(r2-r1)/2;
    translate([0,0,h/2])
        rotate_extrude(convexity = 10)
            translate([r2-torus_r, 0, 0])
                scale([1, 1/(torus_r*2)*h, 1])
                    circle(r = torus_r);
}

module smoothed_cylinder(r1, r2, h) {
    difference() {
        cylinder(h=h, r1=r2, r2=r2);
        torus(r1=r1, r2=2*r2-r1, h=2*h);
    }
}



