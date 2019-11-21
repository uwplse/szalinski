// Universal quadpod by OK1CDJ
// midle part of arm
cube_width=20;
cube_lenght=30;
cube_height=20;
screw_dia=6;
difference(){
    cube([cube_width,cube_lenght,cube_height], center=true); 
    cylinder(h = 20 , d = screw_dia, center=true); 
    
}