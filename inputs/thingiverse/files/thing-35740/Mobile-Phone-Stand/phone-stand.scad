//original
//base_width1 = 70
//base_width2 = 60
//base_length = 86
//base_height = 2

base_width = 70;
base_length = 86;
base_height = 3;

//base
cube([base_width,base_length,base_height]);

back_length = 110;
back_thickness = 3;
back_angle = 23;

//back
translate([0,base_length,0])
rotate(back_angle,[1,0,0])
cube([base_width,back_thickness,back_length]);

front_length = 62;
front_thickness = 3;
front_transY = sin(back_angle) * back_length;
front_transZ = cos(back_angle) * back_length;
front_angle = 240;

//front
translate([0,front_transY, front_transZ])
rotate(front_angle, [1,0,0])
cube([base_width,front_length,front_thickness]);

h_length = 22;

//houder
translate([0,16,49]) //-7, 46?
rotate(150,[1,0,0])
cube([base_width,h_length,base_height]);

s_length  = 10;

//stuff
translate([0,-2,56]) //-7, 46?
rotate(60,[1,0,0])
cube([base_width,s_length,base_height]);


