use <write/Write.scad>  
// Name for the handle
text="Test Name";
//Height of the handle (in mm)
height=100; //[10:150]
// Text height
text_height=10; // [5:Short, 10:Normal, 15:Tall]
// Text width
text_width=5; // [2:Narrow, 5:Normal, 8:Wide] 
difference() {cylinder(h=15,r=55,center = true); cylinder(h=18,r=50,center=true);}  
translate([-63,0,0]) {cube([20,15,15],center=true);};  
translate([-70,0,(0-height/2)+7.5]) {cylinder(h=height,r=8,center=true);};  
writecylinder(text, [0,0,0],t=text_width,h=text_height, 55,15,center=true,east=90);