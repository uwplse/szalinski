strength = 6;
pole_radius = 4.5;
pole_mount_height = 50;

width = 60;
height = 40;
line_hole_height = 40;
line_hole_width = 8;
top_hook_height = 7;
top_hook_width = 5;
rotate([90,0,0]) {
difference() {
    cylinder(pole_mount_height,pole_radius+strength,pole_radius+strength);
    cylinder(pole_mount_height,pole_radius,pole_radius);
}

translate([0,pole_radius+strength,pole_mount_height]) { rotate([90,0,0]) {
linear_extrude(strength*2+pole_radius*2)polygon([
    [-pole_radius-strength,0],
    [-width/2-strength,strength*2+line_hole_height],
    [-width/2-strength,strength*2+line_hole_height+height],

//top hook
    [-width/2-strength+top_hook_width,strength*2+line_hole_height+height+top_hook_height],
    [-width/2-strength+top_hook_width+strength,strength*2+line_hole_height+height+top_hook_height],




    [-width/2,strength*2+line_hole_height+height],
    [-line_hole_width/2,strength*2+line_hole_height],
    
    [-line_hole_width/2,strength*2],
    [line_hole_width/2,strength*2],
    
    
    [line_hole_width/2,strength*2+line_hole_height],
    [width/2,strength*2+line_hole_height+height],

//top hook
    [width/2+strength-top_hook_width-strength,strength*2+line_hole_height+height+top_hook_height],
    [width/2+strength-top_hook_width,strength*2+line_hole_height+height+top_hook_height],


    [width/2+strength,strength*2+line_hole_height+height],
    [width/2+strength,strength*2+line_hole_height],
    [pole_radius+strength,0]
    ]);

}
}
}