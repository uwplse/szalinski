/****************** transform a jar or a can to a beggin bowl ********/
/******************            parametric                       ********/
/********************************************************************/
/******************      30/07/2017 J-F Rocchini              ********/
/******************      jfrocchini@yahoo.fr                   ********/
/******************      Enjoy !!!                             ********/
/********************************************************************/

$fn=100;
// 0 for assemby view, 1 to print export as STL
visu=1;
// your jar or can external diameter
diam=70;
// your label
label_length=60;
your_text="CAFE";
x_text=-28;
y_text=5;
font_text="Liberation Sans";
size_font=15;

module lower(diam){
difference(){
    cylinder(d=diam,h=10);
    translate([0,0,3]) cylinder(d=diam-4,h=10);
    cube([30,5,15], center=true);
   translate([0,20,0]) cube([10.5,2.5,15], center=true);
}
}

module label(label_length,your_text,x_text,y_text,font_text,size_font){
  difference(){  
   union(){
   cube([60,40,2], center=true);
   translate([0,-30,0])  cube([20,20,2],center=true); 
   }    
   translate([-7.5,-39,0])  cube([5,4,2],center=true); 
   translate([7.5,-39,0])  cube([5,4,2],center=true); 
   translate([-28,-5,-1])   linear_extrude(5) text("CAFE", font = "Liberation Sans",size=15);
   }
}  


if(visu==0){
    lower(diam);
    color("red") translate([0,20,-36]) rotate([90,180,0]) label(label_length,your_text,x_text,y_text,font_text,size_font);
}   
 if(visu==1){
    lower(diam);
    translate([0,80,1])  label(label_length,your_text,x_text,y_text,font_text,size_font);
}      