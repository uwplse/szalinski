inner = 48.875; //Spool inner RADIUS - replace with your inner radius in mm
outer = 100; //Spool Outer RADIUS - replace with your outer radius in mm
thick = 2; //Wall thickness in mm - 2mm seemed plenty thick for me
height = 60.5; //height of drawer in mm
central_angle = 90; //How much of the spool in degrees the drawer will cover - 180 for 2 drawers, 90 for 4 and 45 for 8
screw_size = 3.75; //diameter of screw hole in mm
screw_wall = 6; //size of the circle around the screw
handle_length = 10; //how far out the handle will stick out
$fn = 360; //number of circle segments on rounded corner at screw - leave at 360
angles = [0, central_angle]; //Change 0 to something else to get drawer segment with no screw hole

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
translate([outer-screw_wall,screw_wall,0]){
circle(screw_size/2);}
translate([outer-screw_wall,0,0]){
square(screw_wall);}
}
}

module shell(){
difference(){
arc(outer,inner);
offset(-thick) arc(outer,inner);}
}

module handle(){
translate([outer*cos(central_angle)+thick*2*cos(central_angle-90),outer*sin(central_angle)+thick*2*sin(central_angle-90),1]){
rotate(central_angle)
offset(thick) square([handle_length,thick]);    
}
}

module screw(){
difference(){
circle(screw_wall);
circle(screw_size/2);
}    
}

linear_extrude(thick){
arc(outer,inner);
}
linear_extrude(height){
shell();
}
translate([outer-screw_wall,screw_wall,0]){
linear_extrude(height){
screw();
}
}
linear_extrude(height){
handle();
}