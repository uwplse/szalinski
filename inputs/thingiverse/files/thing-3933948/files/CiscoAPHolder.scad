//AIR-AP1852i-E-K9
$fn=100;

$bolt_hole_diameter=5;
$x_bolt_distance=107.5;
$y_bolt_distance=66.5;
$x_offset=20;
$y_offset=35;



$base_rounding_diameter=5;
$base_thickness=8;
$base_reinforcement_thickness=12;
$holder_height=50.5;
$holder_thickness=8;

$tube_diameter=34;

$arm_x_length=50;
$arm_y_width=2*$y_offset+$y_bolt_distance-2-2*$base_rounding_diameter;

$retaining_bolt_diameter=5.4;
$retaining_bolt_z_offset=25;
//***********************************************************
difference(){
union(){
difference(){
//base
translate([0,0,-$base_thickness/2]){
linear_extrude($base_thickness){
minkowski(){
square([2*$x_offset+$x_bolt_distance-2*$base_rounding_diameter,2*$y_offset+$y_bolt_distance-2-2*$base_rounding_diameter], center=true);
circle($base_rounding_diameter);
};
};
};
//BOLT1 Hole - LEFT-TOP
translate([-$x_bolt_distance/2,$y_bolt_distance/2,0]) cylinder(d=$bolt_hole_diameter,h=$base_thickness, center=true);
//BOLT1 Hole - LEFT-BOTTOM
translate([-$x_bolt_distance/2,-$y_bolt_distance/2,0]) cylinder(d=$bolt_hole_diameter,h=$base_thickness, center=true);
//BOLT1 Hole - RIGHT-TOP
translate([$x_bolt_distance/2,$y_bolt_distance/2,0]) cylinder(d=$bolt_hole_diameter,h=$base_thickness, center=true);
//BOLT1 Hole - RIGHT-BOTTOM
translate([$x_bolt_distance/2,-$y_bolt_distance/2,0]) cylinder(d=$bolt_hole_diameter,h=$base_thickness, center=true);
};

//HOLDER
translate([$x_bolt_distance/2+$x_offset+$arm_x_length+$tube_diameter/2,0,-$holder_thickness/2]){
    cylinder(d=$tube_diameter+2*$holder_thickness,h=$holder_height+$holder_thickness);   
};
//HOLDER ARM
translate([0,0,-$holder_thickness/2])
linear_extrude($holder_thickness){
hull(){
translate([$x_bolt_distance/2+$x_offset,$arm_y_width/2,0])circle(0.1);
translate([$x_bolt_distance/2+$x_offset,-$arm_y_width/2,0])circle(0.1);
    
translate([$x_bolt_distance/2+$arm_x_length+$x_offset+$holder_thickness+$tube_diameter/2,$tube_diameter/2,0])circle(0.1);
translate([$x_bolt_distance/2+$arm_x_length+$x_offset+$holder_thickness+$tube_diameter/2,-$tube_diameter/2,0])circle(0.1);
    
};
};


//Base reinforcement
translate([0,$base_reinforcement_thickness/2,+$holder_thickness/2]){
rotate([90,0,0]){
linear_extrude($base_reinforcement_thickness){
hull(){
translate([-$x_bolt_distance/2-$x_offset,0,0])circle(0.1);
translate([$x_bolt_distance/2+$arm_x_length+$x_offset,0,0])circle(0.1);
translate([$x_bolt_distance/2+$arm_x_length+$x_offset,$holder_height+$holder_thickness-$base_thickness,0])circle(0.1);
};
};
};
};
};
translate([$x_bolt_distance/2+$x_offset+$arm_x_length+$tube_diameter/2,0,-$holder_thickness/2]){
    cylinder(d=$tube_diameter,h=$holder_height);
};
translate([$x_bolt_distance/2+$x_offset+$arm_x_length+$tube_diameter-$holder_thickness/2,0,$retaining_bolt_z_offset-$holder_thickness/2])rotate([0,90,0])cylinder(d=$retaining_bolt_diameter,h=2*$holder_thickness);

};
