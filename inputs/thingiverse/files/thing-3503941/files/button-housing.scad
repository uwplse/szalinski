hole_dia=16;
size=36;//size of cube to house button
front_flat=10;
slope=35;
wall_thickness=1.8;
button_num=1;

dotext=0; // 1=yes or 0=no .... please note will take more time to render if yes

/*[Custom text for up to 4 buttons]*/
button_1_text="START";
button_2_text="SW-2";
button_3_text="SW-3";
button_4_text="SW-4";


button_text = [
   [0,  button_1_text],
   [1,  button_2_text],
   [2,  button_3_text],
   [3,  button_4_text],
    ];


 
module profile(){
round2d(5.1,0){
difference(){
translate([0,-10,0]) square([size,size+10]);
translate([size,front_flat,-0.2]) rotate([0,0,slope]) square(size+5,size);
}
}
}

$fn=80;
 

module round2d(OR,IR){
    offset(OR)offset(-IR-OR)offset(IR)children();
}

module side(){
linear_extrude(height=wall_thickness) profile();
}


module wall(){
    difference(){
     profile();
offset(r = -wall_thickness) profile();
    }
}

module boxy() {
linear_extrude(height=size) wall();
side();
translate([0,0,size-wall_thickness]) side();
}

module housing(){
render(convexity = 1){
difference(){
boxy();
translate([0,-size*3/2,0]) cube([size*3,size*3,size*3],true);
}}
}

module body_with_hole (){
     render(convexity = 1){
    difference(){
translate([0,size*sin(slope)-front_flat*cos(slope)-(size-front_flat)/cos(30)/2,-size/2]) rotate([0,0,-slope]) housing();
translate([size*cos(slope)-wall_thickness,0,0]) rotate([0,90,0]) cylinder(  15, d1=hole_dia,  d2=hole_dia);
    }
    
}

}


module turn_body_with_hole (){
    translate([-size/2,size/2,0])
  rotate([90,0,0]){  
ken=-(size*sin(slope)-front_flat*cos(slope)-(size-front_flat)/cos(30)/2);
echo (ken);
rotate([0,0,slope])
translate([0,ken,size/2]) body_with_hole();
  }
}



module all(){
for (a =[1:1:button_num])
translate([0,-size/2+wall_thickness,0])    
translate([0,a*size-(a*wall_thickness),0]) turn_body_with_hole ();
}




module button_name (){
for (a = button_text){
    translate([0,size*a[0]-(a[0]*wall_thickness),0]) 
    translate([size/2,size/2,front_flat*0.2]) 
    rotate([90,0,90])
    linear_extrude(height=20)
    text(text = str(a[1]),size=front_flat*0.5,halign="center");
}
}
render(convexity = 1){
difference(){
all();
if (dotext==1) translate([-wall_thickness/2,0,0]) button_name ();
     }
}







