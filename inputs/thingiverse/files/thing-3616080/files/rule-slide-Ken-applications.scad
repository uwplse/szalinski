
length_1=13.1;
length_2=0.8;
Thickness=2.0;
height=15;
fillet=0.39;

hole_diameter=5;
num_holes=3;
hole_pitch=10;
show_part=3;  // 1 = left hand  2= right hand  3=both


length_of_pointer=50;//pointer parameters ******************
Arrow_head_angle=20;
point_rad=5;
depth=3;


//#translate([0,-length_2/2,0]) square([length_1-0.4,length_2],true);


width=height;

if(show_part==1)rule_slide ();
if(show_part==2) mirror([0,1,0]) translate([0,50,0]) rule_slide ();

if(show_part==3)rule_slide ();
if(show_part==3) mirror([0,1,0]) translate([0,50,0]) rule_slide ();

module rule_slide (){
    difference(){
    union(){
rotate([90,0,0]) translate([length_1/2,0,-Thickness]) linear_extrude(height = depth, center = false, convexity = 10) pointer();
clip();
    }
 
 for (a =[1:1:num_holes])   
 rotate([90,0,0]) translate([(length_1/2)+a*hole_pitch,height/2,-length_2*6]) cylinder(  20,d1=hole_diameter, d2=hole_diameter, center=false,$fn=60);
    }
}



module round2d(OR=3,IR=1){
    offset(OR)offset(-IR-OR)offset(IR)children();
}

$fn=100;
module clip(){
linear_extrude(height=height){
  
round2d(OR=fillet,IR=fillet){
translate([-length_1/2-Thickness,0,0]) square([length_1+Thickness+Thickness,Thickness],false);
translate([length_1/2,-length_2,0]) square([Thickness,length_2],false);    
translate([-length_1/2-Thickness,-length_2,0]) square([Thickness,length_2],false);  
translate([-length_1/2-Thickness,-length_2-Thickness,0]) square([Thickness*1.5,Thickness],false);  
translate([+length_1/2-Thickness/2,-length_2-Thickness,0]) square([Thickness*1.5,Thickness],false);  
}
}
}



module pointer(){
len_minus_point=point_rad/tan(Arrow_head_angle/2);
mirror([1,0,0]) translate([-length_of_pointer,0,0]){
difference(){
$fn=60;    
round2d(OR=point_rad,IR=0   ){
radius = 500;
angles = [0, Arrow_head_angle];
points = [
    for(a = [angles[0]:1:angles[1]]) [radius * cos(a), radius * sin(a)]
];

translate([-len_minus_point+point_rad,0,0]) polygon(concat([[0, 0]], points));
}  
 


translate([length_of_pointer,-0.1,0]) square(1000);
translate([0,width,0]) square(1000);
}
}
}




