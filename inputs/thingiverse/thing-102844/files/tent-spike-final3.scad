//Customizable Tent Spike
// This is a simple open-source parametric tent spike


//CUSTOMIZER VARIABLES

//Defines the depth of spike in mm
d=250;// [60:300]

//CUSTOMIZER VARIABLES END

//Defines the width of spike base in mm
w=25; 

//Defines the height of spike base  in mm
h= 10; 

//Defines the width of spike spine in mm
p=10; 

//Defines the height of spike spine in mm
s=25; 

//Defines the hole radius in mm
r=5; 


module spike() 
{
difference(){
difference(){
difference(){
difference(){
difference(){
difference(){
union(){
cube([w,h,d]); // spike base
translate([w/2-p/2,0,0]) cube([p,s, d]); //spike spine
}
rotate([-20,0,0]) cube([w,50,150]); //blade front
}
translate ([0,0,-20])rotate([0,-20,0]) cube ([w,w,100]);//blade right
}
translate ([0,0,-10])rotate([0,20,0]) cube ([w,w,100]);//blade left
}
translate([0,s-h,d-15])rotate([0,90,0])cylinder (h=w,r=r); // hole
}
translate([0,p,d-35])rotate([-30,0,0]) cube([w,2*p,p-2]); //square cut
}
translate([0,s-h,d-33])rotate([0,90,0])cylinder (h=w,r=r); // bottom of square cut
}
translate([0,0,d]) cube([s,s,h]); // hammer pad
}

spike();

