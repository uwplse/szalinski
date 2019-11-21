//width of 1 long side of triangular base
base_w = 80;

//depth of base
base_dep = 70;

//angle of the base top faces
base_ang = 10;

//thickness of the base on the small sides
base_thk = 4;

//diameter of rod
rod_dia = 10;

//length of first rod that goes up from base
rod_h = 145;

//rod offset where it mounts to the base
rod_place_dist = 15;

//angle of rod
tilt_ang = 25;

//radius of rod curve
curve_r = 40;

//distance from rod end to front of base
top_ofst_frm_base = 40;

$fn=100;
module baseR(){
rotate(10,[0,1,0]){
    cube([base_w,base_dep,base_thk]);
}
}

module baseL(){
translate([0,base_dep,0]){
    rotate(180,[0,0,1]){
        rotate(10,[0,1,0]){
            cube([base_w,base_dep,base_thk]);
        }
    }
}
}
module base_whole(){
translate([0,-base_dep/2,0]){
    hull(){
        baseL();
        baseR();
    }
}
}

module vert_rod(){

rotate(-tilt_ang,[1,0,0])
    cylinder(r=rod_dia,h=rod_h);
y_loc1 = -curve_r*cos(tilt_ang)+rod_h*sin(tilt_ang);
x_loc1 = curve_r*sin(tilt_ang)+rod_h*cos(tilt_ang);

translate([0,y_loc1,x_loc1])
    rotate(-90,[0,1,0])
    rotate_extrude(angle = 90+tilt_ang)    
        translate([curve_r,0])
        circle(rod_dia);

x_loc2 = x_loc1+curve_r;
top_lg = top_ofst_frm_base+y_loc1+(base_w/2);

translate([0,y_loc1,x_loc2])
rotate(90,[1,0,0])
    cylinder(r=rod_dia,h=top_lg);   
}

union(){
translate([0,rod_place_dist,-0.5*base_w*sin(base_ang)])
vert_rod();
base_whole();
}