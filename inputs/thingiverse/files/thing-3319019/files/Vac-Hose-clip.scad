///OpenSCAD version 2015.03-2/////////////////// 
////////////////////////////////////////////////
// OpenSCAD File V2.0 by Ken_Applications //////
/////          27 - 12 - 2018              /////
/////            with hole                 /////
////////////////////////////////////////////////
////////////////////////////////////////////////

Diameter_to_grip=35;
Number_of_clips=1;
clip_height=12;
width_of_base=34;
depth_of_base=6;
clip_wall_thickness=3;
center_line_distance=56;

hole=5;


module contor1(){
 translate([0,-dist_from_cl,0]) square([width_of_base,depth_of_base],true);
 contor();
}


////calculations//////////////
the_fillet_r=(clip_wall_thickness/2)-0.1;
outer_dia=Diameter_to_grip+(2*clip_wall_thickness);
dist_from_cl=((Diameter_to_grip/2)+(depth_of_base/2))+0.1;
grip_offset=Diameter_to_grip/3;
blend_radius=(Diameter_to_grip/3)-0.1;
move_bit=(Diameter_to_grip/2)+depth_of_base;
//////////////////////////////


module clip_cyl(){
difference(){
cylinder(h=2, d1=outer_dia, d2=outer_dia, center=false,$fn=100);
translate([0,0,-1])cylinder(h=clip_height, d1=Diameter_to_grip, d2=Diameter_to_grip, center=false,$fn=100);
translate([-width_of_base,grip_offset,-1]) cube([width_of_base*2,width_of_base,2],false);
    }
}

module contor(){
projection(cut = true) 
clip_cyl();
}

module fillet(r) {
   offset(r = -r) {
     offset(delta = r) {
       contor1();
     }
   }
}

module fillet2(r) {
   offset(r = -r) {
     offset(delta = r) {
       clip();
     }
   }
}

module clip(){
fillet(blend_radius,false,$fn=100);
}

module clip_without_hole(){
linear_extrude(height=clip_height)
    fillet2(-the_fillet_r,false,$fn=100);
}


module finish(){
clip_without_hole();

for (x = [1:1:Number_of_clips-1] ){
translate([-x*center_line_distance,0,0]) clip_without_hole();
translate([-x*center_line_distance,-move_bit,0]) cube([x*center_line_distance,depth_of_base,clip_height],false);
}
}

difference(){
finish();
rotate([90,0,0])
translate([0,clip_height/2,Diameter_to_grip/2+depth_of_base]){
cylinder(h=depth_of_base*2+.5, d1=hole, d2=hole, center=true,$fn=60);
    
 translate([0,0,-depth_of_base]) cylinder(h=4, d1=hole*2.4, d2=hole, center=true,$fn=60); 
}  
}
