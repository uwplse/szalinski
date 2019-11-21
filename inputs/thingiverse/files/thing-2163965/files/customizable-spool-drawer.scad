inner = 29; //inner radius
outer = 100; //outer radius
thick = 2; //wall thickness
hight = 50; //wall hight
centrial_angle = 90;    // part of 360 degrees one drawer should get
screw_size = 3; //diameter of the screw or rod. Impacts the next 2 variables
pole_pos = screw_size*1.34; // changes automatic the position of the screw hole
pole_thick = screw_size*1.33; // changes automatic the wallsize around the pole
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
translate([outer-pole_pos,pole_pos,0]){
circle(screw_size/2);}
translate([outer-pole_pos,0,0]){
square(pole_pos);}
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
circle(pole_thick);
circle(screw_size/2);
}    
}

linear_extrude(thick){
arc(outer,inner);
}
linear_extrude(hight){
shell();
}
translate([outer-pole_pos,pole_pos,0]){
linear_extrude(hight){
screw();
}
}
linear_extrude(hight){
handle();
}