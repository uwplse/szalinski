//Reis Jones
//MY 5777
//Customizable Project

$fn = 100;

//Head Height
head_h = 20;
//Head Width
head_w = 20;
//Head Length
head_l = 10;
//Eye Diameter
eye_d = 10;
//Body Height
body_h = 40;
//Body Width
body_w = 30;
//Body Length;
body_l = 20;


mouth_w = 1/2*head_w;
mouth_h = 1/7*head_h;


module head(){
    union(){
        cube([head_l,head_w,head_h]);       //head base
        translate([10/11*head_l,5/7*head_w,2/3*head_h])sphere(d=eye_d); //right eye
        translate([10/11*head_l,2/7*head_w,2/3*head_h])sphere(d=eye_d); //left eye
        translate([10/11*head_l,1/2*head_w,1/5*head_h])hull(){          //Mouth creation
            cube([2,mouth_w,mouth_h],center = true);
            translate([2,0,0])rotate([-90,0,0])cylinder(d=mouth_h,h=mouth_w,center = true);
        }
        translate([1/2*head_l,1/2*head_w,-1/8*head_h])cylinder(d = 4/7*head_l, h = 1/4*head_h,center = true); //Head Post to fit into body
}}
module headtrans(){
    translate([0,-2*head_w,0])head();
}

module body(){
    difference(){
        minkowski(){                //Body base
            cube([body_l,body_w,body_h]); 
            translate([1/20*body_w,1/20*body_w,0])cylinder(d=1/10*body_w,0);
        }
        translate([1/2*body_l,1/2*body_w,body_h-1/2*(1/4*head_h)])cylinder(d = 4/7*         head_l, h = 1/4*head_h,center = true); //Head Post hole
        for (i = [1:10]){
            translate([body_l-i/20*body_l,1/2*body_w,1/2*body_h])cube([1/10*body_l,1/i*4/5*body_w,1/i*4/5*body_h],center = true);
        }
}
}

body();
headtrans();

