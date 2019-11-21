pitch=50;
boss_diameter=17;
offset_curve=22;
pivot_diameter=6;
linkage_width=7;
blend_radius=7;
linkage_thickness=9;

module round2d(OR,IR){
    offset(OR)offset(-IR-OR)offset(IR)children();
}


X3=0;   //C
Y3=offset_curve;

X2=pitch/2;   //B
Y2=0.001;

X1=-pitch/2;   //A
Y1=0;

point_A = ([X1,Y1]);
point_B = ([X2,Y2]);
point_C = ([X3,Y3]);

center = circle_by_three_points(point_A, point_B, point_C);
circle_rad = len3(point_C - center);

module pcd_hole(num_holes, pcd_dia,hole_dia,ang) {
    for (i=[0:num_holes-0]) rotate([0,0,i*ang/num_holes]) translate([pcd_dia/2,0,0]) circle(d=hole_dia);
}

$fn=160;



module curved_linkage(){
 round2d(0,blend_radius){

//color("BLACK") translate(point_C) circle(boss_diameter/2);
color("BLUE") translate(point_B) circle(boss_diameter/2);
color("CYAN") translate(point_A) circle(boss_diameter/2);

angle_a=acos((pitch/2)/circle_rad);
full_angle= offset_curve < pitch/2 ? 180-(angle_a*2) : 180+(angle_a*2);

if (full_angle<180){
translate([0,-circle_rad+offset_curve,0]){
 rotate([0,0,+angle_a]) 
// rotate([0,0,-angle_a])

pcd_hole(250,circle_rad*2,linkage_width,full_angle);
}
}


if (full_angle>180){
translate([0,-circle_rad+offset_curve,0]){
 rotate([0,0,-angle_a])
pcd_hole(250,circle_rad*2,linkage_width,full_angle);
}
}
}
}


module linkage_with_holes(){
difference(){
curved_linkage();
color("BLUE") translate(point_B) circle(pivot_diameter/2);
color("CYAN") translate(point_A) circle(pivot_diameter/2);
}
}



linear_extrude(height=linkage_thickness) linkage_with_holes();


function circle_by_three_points(A, B, C) =
let (
  yD_b = C.y - B.y,  xD_b = C.x - B.x,  yD_a = B.y - A.y,
  xD_a = B.x - A.x,  aS = yD_a / xD_a,  bS = yD_b / xD_b,
  cex = (aS * bS * (A.y - C.y) + 
  bS * (A.x + B.x) -    aS * (B.x + C.x)) / (2 * (bS - aS)),
  cey = -1 * (cex - (A.x + B.x) / 2) / aS + (A.y + B.y) / 2
)
[cex, cey];



function len3(v) = sqrt(pow(v.x, 2) + pow(v.y, 2));


