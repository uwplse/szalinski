// Hook type: 1 = wall, 2 = desk
part = 1; // [1,2]

// Overall hook thickness
thickness = 3; // [1:10]
// Width of the hook
depth = 15; // [10:50]
// Hook inner radius
radius = 25; // [10:100]
// How long to make the mounting tabs
tabs = 45; // [20:100]

// For a wall hook, the radius of the nail holes
nails = 1; // [0:4]

// For a desk hook, how thick the desk is
height=25; // [10:50]


// The hook itself
difference() {
    cylinder(r=radius,h=depth);
    translate([0,0,-1]) cylinder(r=radius-thickness,h=depth+2);
    translate([-radius,0,-1]) cube([radius,radius+thickness,depth+2]);
    rotate([0,0,30]) translate([-radius,0,-1]) cube([radius,radius+thickness,depth+2]);
}

// Hook's tab
difference() {
    translate([-tabs,radius-thickness,0]) cube([tabs+thickness,thickness,depth]);
    if (part == 1) {
        translate([-tabs + 5, radius + 5, depth/3]) rotate([90,0,0]) cylinder(r=nails,h=10);
        translate([-tabs + 5, radius + 5, depth*2/3]) rotate([90,0,0]) cylinder(r=nails,h=10);
        translate([-tabs + 10, radius + 5, depth/2]) rotate([90,0,0]) cylinder(r=nails,h=10);
    };
}

// Desk clip
if (part == 2) {
    translate([0,radius-thickness,0]) cube([thickness,height+2*thickness,depth]);
    translate([-tabs,radius+height,0]) cube([tabs+thickness,thickness,depth]);
}
