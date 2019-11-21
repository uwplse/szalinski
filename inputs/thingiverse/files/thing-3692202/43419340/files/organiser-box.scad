// X Length of the box
size_x=200;
// Y Length of the box
size_y=100;
// Height of the box
height=200;
// Number of rows of dividers
num_rows=5;
// Number of columns of dividers
num_columns=5;
// Wall thickness
wall_thickness=1;
// Base thickness (if applicable)
base_thickness=2;
// Bevel size on the X edge
bevel_size_x=25;
// Bevel size on the Y edge
bevel_size_y=25;

// Do you want a base on the box?
Base=1; // [1,0]
// Do you want a bevel on the X edge?
Bevel_X=1; // [1,0]
// Do you want a bevel on the Y edge?
Bevel_Y=1; // [1,0]

row_height=(size_x-wall_thickness)/num_rows;
column_width=(size_y-wall_thickness)/num_columns;

difference(){

    union(){

        for (i = [1 : 1 : num_columns+1]){
    
  translate([0, column_width*i-column_width, 0]) cube(size = [size_x,wall_thickness,height], center = false);

};

        for (i = [1 : 1 : num_rows+1]){
    
  translate([row_height*i-row_height, 0, 0]) cube(size = [wall_thickness,size_y,height], center = false);

};
if (Base==1) {
    cube(size = [size_x,size_y,base_thickness], center = false);
}
};

if (Bevel_X==1) {
translate([size_x/2, 0, height]) rotate(a=45, v=[1,0,0]) cube([size_x+10, bevel_size_x, bevel_size_x], center = true);
}

if (Bevel_X==1) {
translate([size_x/2, size_y, height]) rotate(a=45, v=[1,0,0]) cube([size_x+10, bevel_size_x, bevel_size_x], center = true);
}
if (Bevel_Y==1) {
translate([0, size_y/2, height]) rotate(a=45, v=[0,1,0]) cube([bevel_size_y, size_y+10, bevel_size_y], center = true);
}
if (Bevel_Y==1) {
translate([size_x, size_y/2, height]) rotate(a=45, v=[0,1,0]) cube([bevel_size_y, size_y+10, bevel_size_y], center = true);
}
};

