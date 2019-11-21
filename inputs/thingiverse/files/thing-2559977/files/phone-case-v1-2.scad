//Rev.1-1 added cutout location parameters
//Rev.1 added IR remote opening, clean up.


//Phone dimensions
//Nubia My Prague
w=73;
l=149;  
d=6.5;
shell_thk=1;
clearance=0.9;  //phone thickness clearance
r=7; //corner rounding radius
cam_hole_width=10.25;
cam_hole_length=10.25;
cam_hole_y=65.75;  //from center of phone
cam_hole_x=16;   //from center of phone
flash_hole_width=5;
flash_hole_length=5;
flash_hole_y=65.75;  //from center of phone
flash_hole_x=24;  //from center of phone

fp_hole_width=7;
fp_hole_length=7;
fp_hole_y=65.75;  //from center of phone
fp_hole_x=0;  //from center of phone
speaker_y=69.25;
IR_x=22.5;

/* Le622
w=75;
l=152;  
d=8;
shell_thk=1;
clearance=1.5;  //phone thickness clearance
r=7; //corner rounding radius
cam_hole_width=17;
cam_hole_length=17;
cam_hole_y=53;  //from center of phone
cam_hole_x=0;   //from center of phone
flash_hole_width=6;
flash_hole_length=6;
flash_hole_y=53;  //from center of phone
flash_hole_x=-13;  //from center of phone

fp_hole_width=14;
fp_hole_length=14;
fp_hole_y=31.5;  //from center of phone
fp_hole_x=0;  //from center of phone
speaker_y=75.5 //from center of phone
IR_x=19;
*/

case_height=d+2*shell_thk+clearance;  

 module round_square(w=75,l=152,r=7){
  minkowski() {
    square([w-2*r,l-2*r],center=true);
    circle(r); 
}}

module right_cutout(){
    d=60; w=60;
 y1=12;x1=45;
 
  translate([x1,y1*2,0])
     resize([d,w])circle(d); //side
     translate([x1,-y1*2,0])
     resize([d,w])circle(d); 
}
 
module 2d_base(){
 thk=1; //shell thickness
 difference(){
 round_square(w=w+2*thk,l=l+2*thk,r=r);
 //square([160,90],center=true);
     right_cutout();
     mirror([1,0,0]) right_cutout();
     translate([cam_hole_x,cam_hole_y,0])  round_square(cam_hole_width,cam_hole_length,r=3);  //camera
     translate([flash_hole_x,flash_hole_y,0])  round_square(flash_hole_width,flash_hole_length,r=2);   //flash
      translate([fp_hole_x,fp_hole_y,0])  round_square(fp_hole_width,fp_hole_length,r=3); //finger print
     translate([0,-speaker_y,0])  round_square(w=54,l=14,r=5); //speaker
 
    }
    }
    
 //phone dim
    module letv622(height=case_height){
   intersection(){
    translate([0,0,0]) linear_extrude(height) round_square(w,l,r);
    translate([0,0,147.3]) rotate([90,0,0])   cylinder(r=150,h=260, $fn=100, center=true);  //side rounding
    translate([0,0,208]) rotate([0,90,0])   cylinder(r=220,h=260, $fn=100, center=true); //top and bottom rounding
   }
   }
   
   
   module shellbase(height=case_height-shell_thk){
   difference(){
      linear_extrude(height)2d_base(); 
      translate([0,0,1])  letv622();
       }
   }

module rim(){
       thk=1;
   rim=2;
   difference(){
        linear_extrude(height=1)2d_base();
         linear_extrude(height=1)
   round_square(w=w-rim,l=l-rim,r=10.5);
   }
   }
   
   module phone_case(){
 difference(){
union(){
  translate([0,0,case_height]) rim();
   intersection(){
   shellbase(height=case_height);
  translate([0,0,147.3-1]) rotate([90,0,0])   cylinder(r=150,h=260, $fn=100, center=true);  //sides rounding
      translate([0,0,208-1]) rotate([0,90,0])   cylinder(r=220,h=260, $fn=100, center=true);  //top and bottom rounding
   }} 
    translate([-IR_x,l/2,case_height/2]) rotate([90,0,0])   cylinder(r=2.5,h=60, $fn=100, center=true);  //IR remote or specker jack
}
}

phone_case();

//debug
    // rim();
   //shellbase();
  // 2d_base();
  