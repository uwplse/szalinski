///OpenSCAD version version 2019.05 //////////// 
////////////////////////////////////////////////
// OpenSCAD File V1.0 by Ken_Applications //////
/////          04 - 07 - 2019              /////
////////////////////////////////////////////////
////////////////////////////////////////////////


Diameter_to_grip=20;
handed="right";//([left,right])


////////////////////////////////////////////////

module pcd_hole(num_holes, pcd_dia,hole_dia,hole_hgt) {
    for (i=[0:num_holes-1]) 
	rotate([0,0,i*360/num_holes])
	translate([pcd_dia,0,0]) 
	cylinder(d=hole_dia, h=hole_hgt,$fn=30);
}

if (handed=="right"){
$vpr = [55, 0, 226];
$vpt = [9, -60, 9];
$vpd=400;
}

if (handed=="left"){
$vpr = [62, 0, 300];
$vpt = [23, 73, -4];
$vpd=400;
}

clip_wall_thickness=4*1;
retangle_x=90*1;
retangle_y=65*1;

shift_x=retangle_x/2+Diameter_to_grip/2+clip_wall_thickness+1;

if (handed=="left"){
mirror([0,1,0]){
difference() { 
pegs();
translate ([0, -shift_x, 50+20-13.5]) scale (v = [1, 1.4, 1])  sphere (d = 100);
}
}
}

if (handed=="right"){
mirror([0,0,0]){
difference() { 
pegs();
translate ([0, -shift_x, 50+20-13.5]) scale (v = [1, 1.4, 1])  sphere (d = 100);
}
}
}




module pegs(){
translate ([0, -shift_x, 0]) {
pcd_hole(1,0,4,20);
pcd_hole(6,17,7,20);
rotate (a = [0, 0, 90])  pcd_hole(2,35,8,20);
rotate (a = [0, 0, 120])  pcd_hole(2,35,8,20);
rotate (a = [0, 0, -120])  pcd_hole(2,35,8,20);
}
}



module  inner(){
translate ([-3, -shift_x, 5]) 
rotate (a = [0, 0, retangle_x]) 
rotate (a = [-7, 0, 0]) {
linear_extrude (height = 25)
round2d(OR=12,IR=0) square ([ retangle_x,retangle_y ],center = true);
}
}




clip_height=20*1;
width_of_base=65*1;
depth_of_base=100*1;



module contor1(){
 translate([0,-dist_from_cl,0]) square([width_of_base,depth_of_base],true);
 contor();
}


////calculations//////////////
the_fillet_r=(clip_wall_thickness/2)-0.1;
outer_dia=Diameter_to_grip+(2*clip_wall_thickness);
dist_from_cl=((Diameter_to_grip/2)+(depth_of_base/2))+0.1;
grip_offset=Diameter_to_grip/2.7;
blend_radius=(Diameter_to_grip/3)-0.1;
move_bit=(Diameter_to_grip/2)+depth_of_base;
//////////////////////////////


module clip_cyl(){
difference(){
cylinder(h=2, d1=outer_dia, d2=outer_dia, center=false,$fn=100);
translate([0,0,-1])cylinder(h=clip_height, d1=Diameter_to_grip, d2=Diameter_to_grip, center=false,$fn=100);
translate([-width_of_base,grip_offset,-1]) cube([width_of_base*2,width_of_base,2],false);
    }
}

module contor(){
projection(cut = true) 
clip_cyl();
}

module fillet(r) {
   offset(r = -r) {
     offset(delta = r) {
       contor1();
     }
   }
}

module fillet2(r) {
   offset(r = -r) {
     offset(delta = r) {
       clip();
     }
   }
}

module clip(){
fillet(blend_radius,$fn=100);
}

module clip_without_hole(){
linear_extrude(height=clip_height)
    fillet2(-the_fillet_r,$fn=100);
}


module finish(){
clip_without_hole();

for (x = [1:1:1-1] ){
translate([-x*center_line_distance,0,0]) clip_without_hole();
translate([-x*center_line_distance,-move_bit,0]) cube([x*center_line_distance,depth_of_base,clip_height],false);
}
}

module round2d(OR=3,IR=1){offset(OR)offset(-IR-OR)offset(IR)children();}

if (handed=="left"){
mirror([0,1,0]){
difference() { 
finish();
inner();
}
}
}


if (handed=="right"){
mirror([0,0,0]){
difference() { 
finish();
inner();
}
}
}
