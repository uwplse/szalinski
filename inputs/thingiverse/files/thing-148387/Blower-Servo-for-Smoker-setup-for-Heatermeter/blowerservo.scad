plate_width=40;
plate_height=43.5;
plate_thickness=3;
wall_thickness=.83;
blower_width=25.15;
blower_height=20.05;

body_width=blower_width+2*wall_thickness;
body_height=blower_height+2*wall_thickness;
body_length=40;

motor_height=7.2;
motor_width=11.72;
motor_length=22.5;
motor_offset=5.2;
shaft=1.65;

module plate(){
difference(){
cube(size=[plate_height,plate_width,plate_thickness], center=true);
cube(size=[blower_height,blower_width,plate_thickness+10], center=true);
}
}

module body(){
difference(){
translate([0,0,body_length/2])cube(size=[body_height,body_width,body_length], center=true);
translate([0,0,body_lenght/2])cube(size=[blower_height,blower_width,body_length+100], center=true);
}
}

module motor(){
translate([motor_offset,blower_width/2+motor_height/2,body_length/2])rotate([0,90,0])
difference(){
cube(size=[motor_width+2*wall_thickness,motor_height,motor_length+10], center=true);
translate([0,1,0])cube(size=[motor_width,motor_height-1,motor_length], center=true);
}
}

module support(){
translate([0,body_width/2+motor_height-wall_thickness,body_length/2-motor_width/2-wall_thickness])rotate([90,90,270])linear_extrude(height = body_height, center = true, convexity = 10)  polygon([[0,0],[0,motor_height],[motor_height,motor_height]]);

translate([plate_width/2-1,body_width/2-.925,0])cube(size=[2.5,motor_height,body_length/2]);
}

difference(){
union(){
plate();
body();
motor();
support();
}

translate([1.65,body_width/2+motor_height/2,body_length/2-.1])cube(size=[blower_height-5,motor_height+5,motor_width], center=true);

translate([0,0,body_length/2])rotate([90,0,0])cylinder(h=60, r=shaft, $fn=80);

}

