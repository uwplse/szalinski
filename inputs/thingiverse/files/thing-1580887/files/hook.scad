$fa = 0.5; // default minimum facet angle is now 0.5
$fs = 0.5; // default minimum facet size is now 0.5 

hook_radius = 6;
turn_radius = 15;

tilt = 5;
backplate_radius = 30;
backplate_x = 50;
backplate_y = 20;

backplate_height = 5;
length_to_plate = 55;
length = 40;

module corner(turn_radius, hook_radius) {
    difference() {
        rotate_extrude(angle = 90, convexity = 10)
        translate([turn_radius, 0, 0])
        circle(r = hook_radius);
        
        translate([0, (turn_radius+hook_radius)/2+1,0])
        cube([2* (turn_radius + hook_radius)+2, turn_radius+hook_radius+2,         2*(hook_radius+2)], true);
        
        rotate([0,0,90])
        translate([0, (turn_radius+hook_radius)/2+1,0])
        cube([2* (turn_radius + hook_radius)+2, turn_radius+hook_radius+2,         2*(hook_radius+2)], true);
    }
}

// backside of hook
translate([turn_radius,length_to_plate/2,0])
rotate([90,0,0])
cylinder(h=length_to_plate+backplate_height/2, r=hook_radius, center=true);

// corner
corner(turn_radius, hook_radius);

// backplate round
// translate([turn_radius, backplate_height/2+length_to_plate, 0])
// rotate([90,0,0])
// cylinder(h=backplate_height, r=backplate_radius, center=true);

// backplate square
translate([turn_radius, backplate_height/2+length_to_plate, 0])
rotate([90,0,tilt])
cube([backplate_x, backplate_y, backplate_height], center=true);

// frontside of hook
translate([-length/2,-turn_radius,0])
rotate([0,90,0])
cylinder(h=length, r=hook_radius, center=true);

// hat
translate([-length,-turn_radius,0])
sphere(hook_radius);