necklace_hole=0;//[1:true,0:false]
//10 characters (optional slash /) 10 more characters
heart1="Customizer/Hearts"; 
//10 characters (optional slash /) 10 more characters
heart2="Be My/Valentine"; 
//10 characters (optional slash /) 10 more characters
heart3="Your text"; 
//10 characters (optional slash /) 10 more characters
heart4="Openscad/Dad"; 
/* [Hidden] */
face_number=30;
thickness=45;

module hole() {
   difference() {
      minkowski() {
         difference() {
            cylinder(3,1,1,center=true,$fn=face_number,center=true);
            cylinder(4,.99,.99,center=true,$fn=face_number,center=true);
         }
         sphere(.5,$fn=face_number); 
      }
      translate([0,0,-5])cube(10,center=true); 
   }      
}    

module heart_shape() {
   cube([10,10,1]);
   translate([0,5,0])cylinder(1,5,5,$fn=50);
   translate([5,0,0])cylinder(1,5,5,$fn=50);
}    

module heart() {
   difference() { 
      translate([-12,-12,0])
         minkowski() {
            heart_shape();  
            sphere(1,$fn=face_number);
         }
      if(necklace_hole==1) {
         translate([-11.75,-11.75,0])cylinder(11,.9,.9,center=true,$fn=face_number);
      }    
      translate([0,0,-20])cube([40,40,40],center=true);     
   }
   if(necklace_hole==1) {
      translate([-11.75,-11.75,0])hole();
   }    
}  

module heart_text() {
   rotate([0,0,45]) { 
      if(search("/",heart1)==[]) { 
         //single line
         for(i=[0:1:len(heart1)]) { 
            translate([i*thickness/14-len(heart1)*thickness/14/2,24,3])linear_extrude(2)text(font="cousine",heart1[i],thickness/10,$fn=50);
         } 
      } 
      else {
         //double line
         for(i=[0:1:search("/",heart1)[0]-1]) { 
            translate([i*thickness/14-(search("/",heart1)[0])*thickness/14/2,27,3])linear_extrude(2)text(font="cousine",heart1[i],thickness/10,$fn=50);
         } 
         for(i=[search("/",heart1)[0]+1:1:len(heart1)]) {
            translate([(i-search("/",heart1)[0]-1)*thickness/14-(len(heart1)-search("/",heart1)[0]-1)*thickness/14/2,20,3])linear_extrude(2)text(font="cousine",heart1[i],thickness/10,$fn=50);
         }   
      }
   }
   rotate([0,0,135]) { 
      if(search("/",heart2)==[]) { 
         //single line
         for(i=[0:1:len(heart2)]) { 
            translate([i*thickness/14-len(heart2)*thickness/14/2,24,3])linear_extrude(2)text(font="cousine",heart2[i],thickness/10,$fn=50);
         } 
      } 
      else {
         //double line
         for(i=[0:1:search("/",heart2)[0]-1]) { 
            translate([i*thickness/14-(search("/",heart2)[0])*thickness/14/2,27,3])linear_extrude(2)text(font="cousine",heart2[i],thickness/10,$fn=50);
         } 
         for(i=[search("/",heart2)[0]+1:1:len(heart2)]) {
            translate([(i-search("/",heart2)[0]-1)*thickness/14-(len(heart2)-search("/",heart2)[0]-1)*thickness/14/2,20,3])linear_extrude(2)text(font="cousine",heart2[i],thickness/10,$fn=50);
         }   
      }
   }
   rotate([0,0,225]) { 
      if(search("/",heart3)==[]) { 
         //single line
         for(i=[0:1:len(heart3)]) { 
            translate([i*thickness/14-len(heart3)*thickness/14/2,24,3])linear_extrude(2)text(font="cousine",heart3[i],thickness/10,$fn=50);
         } 
      } 
      else {
         //double line
         for(i=[0:1:search("/",heart3)[0]-1]) { 
            translate([i*thickness/14-(search("/",heart3)[0])*thickness/14/2,27,3])linear_extrude(2)text(font="cousine",heart3[i],thickness/10,$fn=50);
         } 
         for(i=[search("/",heart3)[0]+1:1:len(heart3)]) {
            translate([(i-search("/",heart3)[0]-1)*thickness/14-(len(heart3)-search("/",heart3)[0]-1)*thickness/14/2,20,3])linear_extrude(2)text(font="cousine",heart3[i],thickness/10,$fn=50);
         }   
      }
   }
   rotate([0,0,315]) { 
      if(search("/",heart4)==[]) { 
         //single line
         for(i=[0:1:len(heart4)]) { 
            translate([i*thickness/14-len(heart4)*thickness/14/2,24,3])linear_extrude(2)text(font="cousine",heart4[i],thickness/10,$fn=50);
         } 
      } 
      else {
         //double line
         for(i=[0:1:search("/",heart4)[0]-1]) { 
            translate([i*thickness/14-(search("/",heart4)[0])*thickness/14/2,27,3])linear_extrude(2)text(font="cousine",heart4[i],thickness/10,$fn=50);
         } 
         for(i=[search("/",heart4)[0]+1:1:len(heart4)]) {
            translate([(i-search("/",heart4)[0]-1)*thickness/14-(len(heart4)-search("/",heart4)[0]-1)*thickness/14/2,20,3])linear_extrude(2)text(font="cousine",heart4[i],thickness/10,$fn=50);
         }   
      }
   }   
}   

difference() {
   for(i=[0:90:270]) {
      rotate([0,0,i])scale(2)heart();
   }    
   heart_text();
} 

