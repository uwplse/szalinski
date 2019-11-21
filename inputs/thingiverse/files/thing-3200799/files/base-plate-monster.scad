
/*[global settings]*/
//thickness of wall
inner_wall = 2; 
//dimension of inner square
inner_square = 26;
//height (including base height)
height = 7;
//thickness of base
base_height = 1;
//horizontal spacing
spacing_x = 1.7;
//vertical spacing
spacing_y = 1 ;

//length of base
outer_x = 160;
//breadth of base
outer_y = 80;
 
linear_extrude(base_height) 
offset(r= 10)
square([outer_x, outer_y], true);

linear_extrude(height)
difference(){
offset(r= 10)
square([outer_x, outer_y], true);
offset(r= 10-inner_wall )
square([outer_x, outer_y], true);
}

//row 3
for (i=[-1.5:1:1.5] ){
    offset = i*spacing_x*inner_square;
    translate([offset, spacing_y*inner_square, 0])
    base_shell();
}
//  row 2
for (i=[-1:1:1] ){
    offset = i*spacing_x*inner_square;
    translate([offset, 0,0])
    base_shell();
}  
//  row 1
for (i=[-1.5:1:1.5] ){
    offset = i*spacing_x*inner_square;
    translate([offset, -spacing_y*inner_square,0])
    base_shell();
}


module base_shell(){
    
    outer = inner_square + 2*inner_wall;
    rotate(45)
    linear_extrude(height)
    difference(){
    square([outer, outer],  true);
    square([inner_square, inner_square], true);
    } 
}