moon_3d=true; //if true, 3d, else 2d
moon_diameter=24*25.4;
moon_offset_x=180; //offset for piece not full
moon_offset_y=130;
split_moon_in_half=true; //if needed to fit in your work area
shelf_length=20*25.4;
shelf_width=2.5*25.4;
shelf_rotate=-45;
shelf_offset_x=-2*25.4;
shelf_offset_y=-2*25.4;
shelf_subdivision=2*25.4; //width of each one
shelf_subdivision_offset=-10;//offset the beginning of the smaller sections of the shelf
shelf_subdivision_count=6;//number of subdivisions
shelf_securement_holes_diameter=4;
shelf_securement_holes_position_left=45;//distance from each end - 2 screws
shelf_securement_holes_position_right=60;//distance from each end - 2 screws
double_shelf=true; //if true, will double the thickness of the smaller shelves
wall_securement_holes_diameter=5;
wall_securement_holes_countersink_diameter=10;
wall_securement_holes_countersink_depth=0.75*25.4*0.5;
wall_securement_holes_position=15;
wall_securement_holes_position_x_1=-170;
wall_securement_holes_position_y_1=200;
wall_securement_holes_position_x_2=50;
wall_securement_holes_position_y_2=-250;
circle_shelf_diameter=5*25.4;
circle_shelf_depth_offset=0;//increase or decrease the depth of the circle shelf - will change diameter somewhat too
circle_shelf_tab_width=2*25.4;
circle_shelf_tab_tolerance=2; //increase hole for tab by this amount
circle_shelf_position_x_1=-250;
circle_shelf_position_y_1=-60;
circle_shelf_position_x_2=-125;
circle_shelf_position_y_2=-200;
circle_shelf_z_offset=0.75*25.4;
material_thickness=0.75*25.4;
material_thickness_tolerance=1;
//include <../Joints/bulb_joint.scad>; //only used if moon is split in half
//circle_diameter and number and width are for the bulb joint if used
circle_diameter=20;
circle_number=10; //number per side 200
width=circle_diameter*circle_number;
joint_offset=15;

$fn=50;

module moon_whole(){
difference(){
circle(d=moon_diameter);
translate([moon_offset_x,moon_offset_y])
circle(d=moon_diameter);
translate([shelf_offset_x,shelf_offset_y]){
rotate([0,0,shelf_rotate]){
translate([-shelf_length/2+shelf_securement_holes_position_left,0]){
circle(d=wall_securement_holes_diameter);
}
translate([shelf_length/2-shelf_securement_holes_position_right,0]){
circle(d=wall_securement_holes_diameter);
}
}
}
translate([circle_shelf_position_x_1,circle_shelf_position_y_1])
square([circle_shelf_tab_width+circle_shelf_tab_tolerance,material_thickness+material_thickness_tolerance]);
translate([circle_shelf_position_x_2,circle_shelf_position_y_2])
square([circle_shelf_tab_width+circle_shelf_tab_tolerance,material_thickness+material_thickness_tolerance]);

translate([shelf_length/2-shelf_securement_holes_position_right,0,0]){
circle(d=wall_securement_holes_diameter);
}

translate([wall_securement_holes_position_x_1,wall_securement_holes_position_y_1])
circle(d=wall_securement_holes_diameter);

translate([wall_securement_holes_position_x_2,wall_securement_holes_position_y_2])
circle(d=wall_securement_holes_diameter);
}}


module moon_top(){
difference(){
moon_whole();
rotate([0,0,-135])
translate([-moon_diameter/2,0])
square([moon_diameter,moon_diameter*2]);
}

rotate([0,0,-135])
translate([moon_diameter/2-sqrt(moon_offset_x*moon_offset_x+moon_offset_y*moon_offset_y)+joint_offset,10])
bulb_joint();
}

module moon_bottom(){
difference(){
moon_whole();
rotate([0,0,135])
translate([0,-moon_diameter/2])
square([moon_diameter,moon_diameter]);

rotate([0,0,-135])
translate([moon_diameter/2-sqrt(moon_offset_x*moon_offset_x+moon_offset_y*moon_offset_y)+joint_offset,10])
bulb_joint();
}}

if (moon_3d==false){
if (split_moon_in_half==false){
moon_whole();}
else if (split_moon_in_half==true){
translate([-5,5])
moon_top();
translate([25,-30])
moon_bottom();
}
translate([200+shelf_offset_x,50+shelf_offset_y,0]){
rotate([0,0,shelf_rotate]){
difference(){
square([shelf_length,shelf_width],center=true);
for (a=[-shelf_subdivision/2:shelf_subdivision_count/2]){
translate([shelf_length/shelf_subdivision_count*a+shelf_subdivision_offset,0])
rotate([0,0,45])
square([shelf_subdivision,shelf_length/shelf_subdivision_count]);
}
}
}
}
if (double_shelf==true){
translate([250+shelf_offset_x,100+shelf_offset_y,0]){
rotate([0,0,shelf_rotate]){
difference(){
square([shelf_length,shelf_width],center=true);
for (a=[-shelf_subdivision/2:shelf_subdivision_count/2]){
translate([shelf_length/shelf_subdivision_count*a+shelf_subdivision_offset,0])
rotate([0,0,45])
square([shelf_subdivision,shelf_length/shelf_subdivision_count]);
}
}
}
}
}

translate([-10,30]){
difference(){
circle(d=circle_shelf_diameter);
translate([-circle_shelf_diameter/2,circle_shelf_depth_offset])
square([circle_shelf_diameter,circle_shelf_diameter]);
}
translate([-circle_shelf_tab_width/2,circle_shelf_depth_offset])
square([circle_shelf_tab_width,material_thickness]);
}
translate([80,-50]){
difference(){
circle(d=circle_shelf_diameter);
translate([-circle_shelf_diameter/2,circle_shelf_depth_offset])
square([circle_shelf_diameter,circle_shelf_diameter]);
}
translate([-circle_shelf_tab_width/2,circle_shelf_depth_offset])
square([circle_shelf_tab_width,material_thickness]);
}
}

else if (moon_3d==true){
difference(){
cylinder(d=moon_diameter,h=material_thickness);
translate([moon_offset_x,moon_offset_y,-0.1])
cylinder(d=moon_diameter,h=material_thickness+0.2);
translate([shelf_offset_x,shelf_offset_y,0]){
rotate([0,0,shelf_rotate]){
translate([-shelf_length/2+shelf_securement_holes_position_left,0,0]){
cylinder(d=wall_securement_holes_diameter,h=material_thickness);
}
translate([shelf_length/2-shelf_securement_holes_position_right,0,0]){
cylinder(d=wall_securement_holes_diameter,h=material_thickness);
}
}
}
translate([circle_shelf_position_x_1,circle_shelf_position_y_1,-0.1])
cube([circle_shelf_tab_width+circle_shelf_tab_tolerance,material_thickness+material_thickness_tolerance,material_thickness+0.2]);
translate([circle_shelf_position_x_2,circle_shelf_position_y_2,-0.1])
cube([circle_shelf_tab_width+circle_shelf_tab_tolerance,material_thickness+material_thickness_tolerance,material_thickness+0.2]);

translate([wall_securement_holes_position_x_1,wall_securement_holes_position_y_1,-0.1])
cylinder(d=wall_securement_holes_diameter,h=material_thickness+0.2);

translate([wall_securement_holes_position_x_1,wall_securement_holes_position_y_1,material_thickness-wall_securement_holes_countersink_depth])
cylinder(d=wall_securement_holes_countersink_diameter,h=material_thickness);

translate([wall_securement_holes_position_x_2,wall_securement_holes_position_y_2,-0.1])
cylinder(d=wall_securement_holes_diameter,h=material_thickness+0.2);

translate([wall_securement_holes_position_x_2,wall_securement_holes_position_y_2,material_thickness-wall_securement_holes_countersink_depth])
cylinder(d=wall_securement_holes_countersink_diameter,h=material_thickness);
}

translate([shelf_offset_x,shelf_offset_y,material_thickness]){
rotate([0,0,shelf_rotate]){
difference(){
translate([0,0,material_thickness/2])
cube([shelf_length,shelf_width,material_thickness],center=true);
for (a=[-shelf_subdivision/2:shelf_subdivision_count/2]){
translate([shelf_length/shelf_subdivision_count*a+shelf_subdivision_offset,-0.1])
rotate([0,0,45])
cube([shelf_subdivision,shelf_length/shelf_subdivision_count,material_thickness+0.2]);
}
}
}
}
if (double_shelf==true){
translate([shelf_offset_x,shelf_offset_y,material_thickness*2]){
rotate([0,0,shelf_rotate]){
difference(){
translate([0,0,material_thickness/2])
cube([shelf_length,shelf_width,material_thickness],center=true);
for (a=[-shelf_subdivision/2:shelf_subdivision_count/2]){
translate([shelf_length/shelf_subdivision_count*a+shelf_subdivision_offset,-0.1])
rotate([0,0,45])
cube([shelf_subdivision,shelf_length/shelf_subdivision_count,material_thickness+0.2]);
}
}
}
}
}

translate([circle_shelf_position_x_1+circle_shelf_tab_width/2+circle_shelf_tab_tolerance/2,circle_shelf_position_y_1+material_thickness_tolerance/2,circle_shelf_z_offset]){
rotate([-90,0,0]){
difference(){
cylinder(d=circle_shelf_diameter,h=material_thickness);
translate([-circle_shelf_diameter/2,circle_shelf_depth_offset,-0.1])
cube([circle_shelf_diameter,circle_shelf_diameter,material_thickness+0.2]);
}
translate([-circle_shelf_tab_width/2,circle_shelf_depth_offset,0])
cube([circle_shelf_tab_width,material_thickness,material_thickness]);
}
}

translate([circle_shelf_position_x_2+circle_shelf_tab_width/2+circle_shelf_tab_tolerance/2,circle_shelf_position_y_2+material_thickness_tolerance/2,circle_shelf_z_offset]){
rotate([-90,0,0]){
difference(){
cylinder(d=circle_shelf_diameter,h=material_thickness);
translate([-circle_shelf_diameter/2,circle_shelf_depth_offset,-0.1])
cube([circle_shelf_diameter,circle_shelf_diameter,material_thickness+0.2]);
}
translate([-circle_shelf_tab_width/2,circle_shelf_depth_offset,0])
cube([circle_shelf_tab_width,material_thickness,material_thickness]);
}
}
}

//bulb joint modules follow
module bulb_joint_mirror(){
mirror([0,1])
bulb_joint();
}

module bulb_joint(){
difference(){
translate([0,-circle_diameter])
square([width,circle_diameter*1.5]);
top_half();
translate([0,sin(45)*circle_diameter/2])
square([width,circle_diameter*1.5]);
}
bottom_half();
}

module top_half(){
difference(){
for (a=[0:(circle_number-1)]){
translate([2*sin(45)*a*circle_diameter,0])
circle(d=circle_diameter);
}

translate([-circle_diameter/2,-circle_diameter/2])
square([circle_diameter/2,circle_diameter]);

translate([width,-circle_diameter/2])
square([100,circle_diameter*2]);
}

}

module bottom_half(){
difference(){
for (a=[0:(circle_number-1)]){
translate([circle_diameter*sin(45)+2*sin(45)*a*circle_diameter,circle_diameter*sin(45)])
circle(d=circle_diameter);
}

translate([-circle_diameter/2,-circle_diameter/2])
square([circle_diameter/2,circle_diameter]);

translate([width,-circle_diameter/2])
square([100,circle_diameter*2]);
}
}