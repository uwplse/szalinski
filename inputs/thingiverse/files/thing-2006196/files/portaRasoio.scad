
module round_cube(x,y,z,r){
hull(){ translate([r,r,r])sphere(r=r);
        translate([x-r,r,r])sphere(r=r);
        translate([r,y-r,r])sphere(r=r);
        translate([x-r,y-r,r])sphere(r=r);
        translate([r,r,z-r])sphere(r=r);
        translate([x-r,r,z-r])sphere(r=r);
        translate([r,y-r,z-r])sphere(r=r);
        translate([x-r,y-r,z-r])sphere(r=r);}}


/// VARIABLES
height=5;
internal_side=36;
thickness=2;
rounding_radius=2;
screw_head=3;
delta_mount_y=4;

// CALCULATED VARIABLES
external_side=internal_side+thickness*2;
invito=screw_head/4;
delta_wall=delta_mount_y+rounding_radius;

// Razor Holder
difference(){
    translate([0,-delta_wall,0])
        cube([external_side,external_side+delta_wall,height]);
    translate([thickness,thickness,-thickness])
    round_cube(internal_side,internal_side,height*1.5,height*2);}


// Wall mount
translate([0,rounding_radius-delta_wall,0])
rotate([90,0,1]) 
difference(){
    hull(){
        round_cube(external_side,height,height,rounding_radius);
        translate([20,38,2.5]) sphere(rounding_radius);}
    translate([external_side/2,external_side*4.5/6,-1]) cylinder(height+2,screw_head,invito);
    translate([external_side/2,external_side*1.5/6,-1]) cylinder(height+2,screw_head,invito);}
    
    
    
