inner_radius = 24.25; //線圈內徑
outer_radius = 100; //線圈外徑
thickness = 2; //壁厚
height = 52; //高度
//numbers = 4; //個數
central_angle = 90;
screw_size = 5;
$fn = 360;

angles = [0, central_angle];

module arc(outer_radius,inner_radius){
points_outer_radius = [
    for(a = [angles[0]:1:angles[1]]) [outer_radius * cos(a), outer_radius * sin(a)]
];
points_inner_radius = [
    for(b = [angles[0]:1:angles[1]]) [inner_radius * cos(b), inner_radius * sin(b)]
];
difference(){
polygon(concat([[0, 0]], points_outer_radius));
polygon(concat([[0, 0]], points_inner_radius));
translate([outer_radius-8,8,0]){
circle(screw_size/2);}
translate([outer_radius-8,0,0]){
square(8);}
}
}

module shell(){
difference(){
arc(outer_radius,inner_radius);
offset(-thickness) arc(outer_radius,inner_radius);}
}

module handle(){
translate([outer_radius*cos(central_angle)+thickness*2*cos(central_angle-90),outer_radius*sin(central_angle)+thickness*2*sin(central_angle-90),1]){
rotate(central_angle)
offset(thickness) square([10,thickness]);    
}
}

module screw(){
difference(){
circle(8);
circle(screw_size/2);
}    
}

linear_extrude(thickness){
arc(outer_radius,inner_radius);
}
linear_extrude(height){
shell();
}
translate([outer_radius-8,8,0]){
linear_extrude(height){
screw();
}
}
linear_extrude(height){
handle();
}
