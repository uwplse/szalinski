//customizable clip round / rectangular


overall_height=12;
wall_thickness=5;

x_dimension=79;//rectangular 
y_dimension=9.15;

diameter_to_grip=25;
more_grip=2.6;


linear_extrude (height = overall_height){
round2d(0,y_dimension/2){
union(){
ret_clip();
 translate ([0, diameter_to_grip/2 +wall_thickness+y_dimension/2+wall_thickness      , 0])  round_clip_with_base();
}
}
}

radi=y_dimension/2-0.1;
radi_2=wall_thickness;
bulge=3+0.001;
$fn=100+0.001;

module round_clip_with_base(){
round2d(0,wall_thickness){
round_clip();
translate ([0, -diameter_to_grip/2-wall_thickness-wall_thickness/4, 0])  square ([ diameter_to_grip/2,wall_thickness ],center = true);
}
}


module round_clip(){
round2d(wall_thickness/2-0.2,0){
difference() { 
circle (d = diameter_to_grip+wall_thickness*2);
circle (d = diameter_to_grip);
translate ([0, diameter_to_grip*2, 0])  square ([ diameter_to_grip-more_grip,diameter_to_grip*4],center = true);
}
}
}

module ret_clip(){
round2d(wall_thickness/2-0.2,0){
difference() { 
round2d(radi_2,0){
square ([ x_dimension+wall_thickness*2,y_dimension +wall_thickness*2],center = true);
}
 round2d(radi,0){
square ([ x_dimension,y_dimension ],center = true);
}
translate ([0, -wall_thickness-1, 0])  square ([ x_dimension-radi-0.3-bulge,y_dimension ],center = true);
}
}
}



module round2d(OR,IR){offset(OR)offset(-IR-OR)offset(IR)children();}
