// Universal Quadpod end part of the arm 
cube_width=20;
cube_lenght=35;
cube_height=20;
screw_dia=6;
hole_dia=10;
difference(){
    cube([cube_width,cube_lenght,cube_height], center=true); 
    translate([0,-cube_lenght/2+7,0])cylinder(h = cube_height+2 , d = screw_dia, center=true); 
    rotate([0,90,0])translate([0,hole_dia/2,0])cylinder(h = cube_width+2 , d = hole_dia, center=true);
}