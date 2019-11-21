inner = 29; //線圈內徑
outer = 100; //線圈外徑
thick = 3; //壁厚
hight = 50; //高度
//numbers = 4; //個數
centrial_angle = 90;
screw_size = 5;
$fn = 360;

angles = [0, centrial_angle];

module arc(outer,inner){
points_outer = [
    for(a = [angles[0]:1:angles[1]]) [outer * cos(a), outer * sin(a)]
];
points_inner = [
    for(b = [angles[0]:1:angles[1]]) [inner * cos(b), inner * sin(b)]
];
difference(){
polygon(concat([[0, 0]], points_outer));
polygon(concat([[0, 0]], points_inner));
translate([outer-8,8,0]){
circle(screw_size/2);}
translate([outer-8,0,0]){
square(8);}
}
}

module shell(){
difference(){
arc(outer,inner);
offset(-thick) arc(outer,inner);}
}

module handle(){
translate([outer*cos(centrial_angle)+thick*2*cos(centrial_angle-90),outer*sin(centrial_angle)+thick*2*sin(centrial_angle-90),1]){
rotate(centrial_angle)
offset(thick) square([10,thick]);    
}
}

module screw(){
difference(){
circle(8);
circle(screw_size/2);
}    
}

linear_extrude(thick){
arc(outer,inner);
}
linear_extrude(hight){
shell();
}
translate([outer-8,8,0]){
linear_extrude(hight){
screw();
}
}
linear_extrude(hight){
handle();
}