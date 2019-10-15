//basic af box
// preview[view:south, tilt:top]

//CUSTOMIZER VARIABLES
$fn = $fn + 250;

//Length
x = 10; // [1:150]
//Width
y = 10; // [1:150]
//Height
z = 10; // [1:150]

wall_thickness = 1; // [1:150]
base_thickness = 1; // [1:150]
chamfer_edge = 1; // [1:150]

//CUSTOMIZER VARIABLES END

difference(){
    roundedcube(x,y,z,chamfer_edge);
    translate([wall_thickness,wall_thickness,base_thickness])
    roundedcube(x-(wall_thickness*2),y-(wall_thickness*2),z,chamfer_edge);
}

module roundedcube(xdim ,ydim ,zdim,rdim){
hull(){
    translate([rdim,rdim,0])cylinder(h=zdim,r=rdim);
    translate([xdim-rdim,rdim,0])cylinder(h=zdim,r=rdim);
    translate([rdim,ydim-rdim,0])cylinder(h=zdim,r=rdim);
    translate([xdim-rdim,ydim-rdim,0])cylinder(h=zdim,r=rdim);
}}