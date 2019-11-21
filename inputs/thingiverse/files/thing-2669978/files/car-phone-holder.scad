//Rev.1 made clip recess wider for better fit

display_clip=1;
display_holder=1;
clip_angle=15;


//Large: width 75 to 80 mm
//Maximum thickness 14 mm
// Minimum height 140mm
w=75+4;
l=152;  
d=8+2; 
/*
//Small:width 70 to 74 mm
//Maximum thickness 12 mm
// Minimum height 120mm
w=75;
l=132;  
d=8;
*/

//-------------------------------
back_thk=4;
shell_thk=3;
clearance=3;  //phone thickness clearance
r=7; //corner rounding radius

speaker_y= l/2.01; //75.5; //from center of phone

sr=0;//150; //phone bottom side rounding radius, 0=no rounding 150
br=0;//220; //phone bottom  top rounding radius, 0=no rounding 0
//end of phone definition

case_height=d+shell_thk+back_thk+clearance;  

 module round_square(w=75,l=152,r=7){
  minkowski() {
    square([w-2*r,l-2*r],center=true);
    circle(r); 
}}

module right_cutout(){
    d=l/2.53; w=l/2.53;
 y1=12;x1=45;
 
  translate([x1,y1*2,0])
     resize([d,w])circle(d,$fn=100); //side
     translate([x1,-y1*2,0])
     resize([d,w])circle(d,$fn=100); 
}
 
module 2d_base(){
 thk=shell_thk; //shell thickness
 difference(){
 round_square(w=w+2*thk,l=l+2*thk,r=r);
 //square([160,90],center=true);
     right_cutout();
     mirror([1,0,0]) right_cutout();
     translate([0,-speaker_y,0])  round_square(w=54,l=14,r=5); //speaker
 
    }
    }
    
 //phone dim, height add clearance
    module letv622(height=d+2*clearance){
   intersection(){
    translate([0,0,0]) linear_extrude(height) round_square(w,l,r);
       if (sr!=0){
   translate([0,0,147.3]) rotate([90,0,0])  cylinder(r=sr,h=260, $fn=100, center=true);  //side rounding
       }
       if (br!=0){
    translate([0,0,208]) rotate([0,90,0])  cylinder(r=br,h=260, $fn=100, center=true); //top and bottom rounding
       }
   }
   }
   
   
   module shellbase(height=case_height){
   difference(){
      linear_extrude(height)2d_base(); 
      translate([0,0,back_thk])  letv622();
       }
   }

module rim(){
       thk=shell_thk;
   rim=6;
   difference(){
        linear_extrude(height=thk)2d_base();
         linear_extrude(height=thk)
   round_square(w=w-rim,l=l-rim,r=10.5);
   }
   }
   
   module phone_case(){
 difference(){
union(){
  translate([0,0,case_height]) rim();
   intersection(){
   shellbase(height=case_height);
    if (sr!=0){   
  translate([0,0,147.3-1]) rotate([90,0,0])   cylinder(r=sr,h=260, $fn=100, center=true);  //sides rounding
    }
    if (br!=0){
     translate([0,0,208-1]) rotate([0,90,0])   cylinder(r=br,h=260, $fn=100, center=true);  //top and bottom rounding
   }} }
}
}
module step_cylinder(od1=25,od2=20,len1=2,len2=5){
cylinder(r=od1/2,h=len1, $fn=100); 
translate([0,0,len1]) cylinder(r=od2/2,h=len2, $fn=100); 
}

module squareBase(){
difference(){
translate([0,0,7.5])
cube([10,14.8,14.8], center=true);
//cylinder(5,10,5)
    translate([-8,0,7.5])
    rotate([0,90,0]) cylinder(r=1.25,h=15,$fn=50); 
}

}

module Lclip(){
    union(){
translate([4,1.5,0])
  rotate([0,0,-2.1]) cube([25,2.5,15]);
translate([28,0.1,0])
  rotate([0,0,15]) cube([5,2.5,15]);
    }
} 

module clips(){
Lclip();
translate([0,0,15])
rotate([180,0,0]) Lclip();
}

module ventClip(){
union(){
translate([7.5,0,0]) rotate([0,-90,0]) clips();
rotate([0,0,clip_angle]) translate([7.5,0,0]) rotate([0,-90,0]) squareBase();}
}

if (display_clip==1){
translate([50,0,5]) rotate([0,0,0])
ventClip();
}


if (display_holder==1){
difference(){
phone_case();
translate([0,l/1.72,3]) rotate([0,0,0]) cube([100,40,40],center=true);
    translate([-6,5,-.5]) rotate([0,0,0]) cube([15.2,15.2,2],center=true);
translate([-6,5,-.5]) step_cylinder(od1=3,od2=6,len1=3,len2=2);
}
} 


//translate([0,l/2-5,11]) cube([77.24,10,12.50],center=true);  //large demension check
//translate([0,l/2-5,11]) cube([74,10,12.50],center=true);  //small demension check

//rim();

 