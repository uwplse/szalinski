//basic af box

//CUSTOMIZER VARIABLES

//Length
x = 50; // [1:150]
//Width
y = 50; // [1:150]
//Height
z = 25; // [1:150]

wall_thickness = 3; // [1:150]

base_thickness = 3; // [1:150]

rotate_angle = 0; // [0,15,30,45]

//CUSTOMIZER VARIABLES END

linear_extrude(z){
    difference(){
        square([x,y],true);                    
        square([x - wall_thickness,y - wall_thickness],true);
}}

linear_extrude(base_thickness){ 
    square([
    x - wall_thickness,
    y - wall_thickness],true);
}

translate([(x-wall_thickness)/2,(y-wall_thickness)/2,0])
rotate(rotate_angle)
linear_extrude(z){
    square(wall_thickness,true);
}

translate([(wall_thickness-x)/2,(wall_thickness-y)/2,0])
rotate(rotate_angle)
linear_extrude(z){
    square(wall_thickness,true);
}

translate([(x-wall_thickness)/2,(-y+wall_thickness)/2,0])
rotate(rotate_angle)
linear_extrude(z){
    square(wall_thickness,true);
}

translate([(-x+wall_thickness)/2,(y-wall_thickness)/2,0])
rotate(rotate_angle)
linear_extrude(z){
    square(wall_thickness,true);
}