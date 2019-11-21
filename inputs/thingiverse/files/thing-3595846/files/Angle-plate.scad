bracket_wall_thickness=5;
bracket_base_len=35;
bracket_height=45;
bracket_width=50;
bracket_angle=90;
number_braces=3;
bracket_hole_dia=7;


module bracket (){
gap=(bracket_width-bracket_wall_thickness)/(number_braces-1);
echo ( gap);
linear_extrude (height = bracket_width){
$fn=60;
round2d(0.6,bracket_wall_thickness/2){
square ([bracket_base_len ,bracket_wall_thickness ]);
   rotate (a = [0, 0, bracket_angle])   square ([bracket_height ,bracket_wall_thickness ]);
}
}
for (i=[0:gap:bracket_width]){
translate ([0, 0, i]) 
linear_extrude (height = bracket_wall_thickness){
$fn=160;
round2d(0.6,bracket_height*0.9){
square ([bracket_base_len ,bracket_wall_thickness ]);
 rotate (a = [0, 0, bracket_angle])   square ([bracket_height ,bracket_wall_thickness ]);
}
}
}
}

module bracket_rotated (){
rotate (a = [90, 0, 0]) {
difference() { 
bracket();
translate ([0, -50.01, 0])      cube (size = [1000, 100, 1000] , center = true  );
}
}
}

difference() { 
bracket_rotated();
the_holes();
the_holes_at_90();
}

module the_holes (){
rotate (a = [0, -bracket_angle, 0]) {
gap2=(bracket_width-bracket_wall_thickness)/(number_braces-1);
for (h=[0:gap2:bracket_width]){
translate ([0, -gap2/2, 0]) {
hull(){
translate ([(bracket_height/3)+bracket_wall_thickness/2, -h-bracket_wall_thickness/2, -bracket_wall_thickness/1.2])    cylinder (h = 11, d = bracket_hole_dia, center = false,$fn=60);
translate ([(bracket_height/1.3), -h-bracket_wall_thickness/2, -0.1])    cylinder (h = 11, d = bracket_hole_dia, center = false,$fn=60);

}

}
}
}
}

module the_holes_at_90 (){
rotate (a = [0, 0, 0]) {
gap2=(bracket_width-bracket_wall_thickness)/(number_braces-1);
for (h=[0:gap2:bracket_width]){
translate ([0, -gap2/2, 0]) {
translate ([bracket_base_len/1.5, -h-bracket_wall_thickness/2, -0.1])    cylinder (h = 11, d = bracket_hole_dia, center = false,$fn=60);
}
}
}
}



module round2d(OR,IR){ offset(OR)offset(-IR-OR)offset(IR)children();}
