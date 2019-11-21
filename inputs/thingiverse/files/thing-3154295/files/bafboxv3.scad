//Basic af Box V3
//N_DALEY 2018
//preview[view:south, tilt:top]

//CUSTOMIZER VARIABLES
$fn = $fn + 250;

//Length
x = 50; // [1:150]
//Width
y = 50; // [1:150]
//Height
z = 50; // [1:150]

wall_thickness = 2; // [1:150]
base_thickness = 2; // [1:150]
chamfer_edge = 2; // [1:150]
shade = "gray"; // ["green":Green,"red":Red,"blue":Blue,"gray":Gray]

//CUSTOMIZER VARIABLES END
if(wall_thickness<chamfer_edge){
    wall_thickness = chamfer_edge;
}

if(!(chamfer_edge<x)||!(chamfer_edge<y)||!(base_thickness<z)){
    text("error");
}else{
   translate([-x/2,-y/2,0])color(shade)box();
}

module box(){
    difference(){
        rnd_box(x,y,z,chamfer_edge);
        translate([wall_thickness,wall_thickness,base_thickness])
        rnd_box(x-(wall_thickness*2),y-(wall_thickness*2),z,chamfer_edge);
}}

module rnd_box(x,y,z,chamfer_edge){
    minkowski(){
        sphere(chamfer_edge);
        cube([x,y,z]);
}}