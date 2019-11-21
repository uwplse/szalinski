//Dice face to face thickness in mm
thickness=75;
//Rounds edges and corners.  Set to 0 for sharp edges
roundness=10; //[0:20]
//separate face 1 message and face 7 message with a slash
faces_1_and_7="Taco Bell/Qdoba"; 
//separate face 2 message and face 8 message with a slash
faces_2_and_8="Chipotle/Naugles"; 
//separate face 3 message and face 9 message with a slash
faces_3_and_9="Mc Donalds/Burger King"; 
//separate face 4 message and face 10 message with a slash
faces_4_and_10="Wendy's/Hardees"; 
//separate face 5 message and face 11 message with a slash
faces_5_and_11="Olive Garden/Chili's"; 
//separate face 6 message and face 12 message with a slash
faces_6_and_12="Red Lobster/Houlihans"; 

module rhombic_dodecahedron() {
   intersection(){
      rotate([ 0,45, 0]) difference() 
         cube([(1-roundness/100)*thickness,(1-roundness/100)*thickness*sqrt(2),(1-roundness/100)*thickness],center=true);
      rotate([ 0,45,90]) difference()
         cube([(1-roundness/100)*thickness,(1-roundness/100)*thickness*sqrt(2),(1-roundness/100)*thickness],center=true);
      rotate([90, 0,45]) difference()
         cube([(1-roundness/100)*thickness,(1-roundness/100)*thickness*sqrt(2),(1-roundness/100)*thickness],center=true);       
   }
}

module rhombic_text() {
   rotate([0,45,0]){  
         translate([-search("/",faces_1_and_7)[0]*thickness/27,-thickness/22,thickness/2-1])
            for(i=[0:1:search("/",faces_1_and_7)[0]-1]){
               translate([i*thickness/14,0,0])linear_extrude(3)text(font="cousine",faces_1_and_7[i],thickness/10,$fn=50);
            } 
      rotate([0,180,0])
         translate([(-search("/",faces_1_and_7)[0]-len(faces_1_and_7))*thickness/27,-thickness/22,thickness/2-1])
            for(i=[search("/",faces_1_and_7)[0]+1:1:len(faces_1_and_7)-1]){
               translate([i*thickness/14,0,0])linear_extrude(3)text(font="cousine",faces_1_and_7[i],thickness/10,$fn=50);
            }
      rotate([0, 90,0])
         translate([-search("/",faces_2_and_8)[0]*thickness/27,-thickness/22,thickness/2-1])
            for(i=[0:1:search("/",faces_2_and_8)[0]-1]){
               translate([i*thickness/14,0,0])linear_extrude(3)text(font="cousine",faces_2_and_8[i],thickness/10,$fn=50);
            } 
      rotate([0,270,0])
         translate([(-search("/",faces_2_and_8)[0]-len(faces_2_and_8))*thickness/27,-thickness/22,thickness/2-1])
            for(i=[search("/",faces_2_and_8)[0]+1:1:len(faces_2_and_8)-1]){
               translate([i*thickness/14,0,0])linear_extrude(3)text(font="cousine",faces_2_and_8[i],thickness/10,$fn=50);
            } 
   }   
   rotate([0,45,90]){  
         translate([-search("/",faces_3_and_9)[0]*thickness/27,-thickness/22,thickness/2-1])
            for(i=[0:1:search("/",faces_3_and_9)[0]-1]){
               translate([i*thickness/14,0,0])linear_extrude(3)text(font="cousine",faces_3_and_9[i],thickness/10,$fn=50);
            } 
      rotate([0,180,0])
         translate([(-search("/",faces_3_and_9)[0]-len(faces_3_and_9))*thickness/27,-thickness/22,thickness/2-1])
            for(i=[search("/",faces_3_and_9)[0]+1:1:len(faces_3_and_9)-1]){
               translate([i*thickness/14,0,0])linear_extrude(3)text(font="cousine",faces_3_and_9[i],thickness/10,$fn=50);
            }
      rotate([0, 90,0])
         translate([-search("/",faces_4_and_10)[0]*thickness/27,-thickness/22,thickness/2-1])
            for(i=[0:1:search("/",faces_4_and_10)[0]-1]){
               translate([i*thickness/14,0,0])linear_extrude(3)text(font="cousine",faces_4_and_10[i],thickness/10,$fn=50);
            } 
      rotate([0,270,0])
         translate([(-search("/",faces_4_and_10)[0]-len(faces_4_and_10))*thickness/27,-thickness/22,thickness/2-1])
            for(i=[search("/",faces_4_and_10)[0]+1:1:len(faces_4_and_10)-1]){
               translate([i*thickness/14,0,0])linear_extrude(3)text(font="cousine",faces_4_and_10[i],thickness/10,$fn=50);
            } 
   }   
   rotate([90,0,45]){  
         translate([-search("/",faces_5_and_11)[0]*thickness/27,-thickness/22,thickness/2-1])
            for(i=[0:1:search("/",faces_5_and_11)[0]-1]){
               translate([i*thickness/14,0,0])linear_extrude(3)text(font="cousine",faces_5_and_11[i],thickness/10,$fn=50);
            } 
      rotate([0,180,0])
         translate([(-search("/",faces_5_and_11)[0]-len(faces_5_and_11))*thickness/27,-thickness/22,thickness/2-1])
            for(i=[search("/",faces_5_and_11)[0]+1:1:len(faces_5_and_11)-1]){
               translate([i*thickness/14,0,0])linear_extrude(3)text(font="cousine",faces_5_and_11[i],thickness/10,$fn=50);
            }
      rotate([0, 90,0])
         translate([-search("/",faces_6_and_12)[0]*thickness/27,-thickness/22,thickness/2-1])
            for(i=[0:1:search("/",faces_6_and_12)[0]-1]){
               translate([i*thickness/14,0,0])linear_extrude(3)text(font="cousine",faces_6_and_12[i],thickness/10,$fn=50);
            } 
      rotate([0,270,0])
         translate([(-search("/",faces_6_and_12)[0]-len(faces_6_and_12))*thickness/27,-thickness/22,thickness/2-1])
            for(i=[search("/",faces_6_and_12)[0]+1:1:len(faces_6_and_12)-1]){
               translate([i*thickness/14,0,0])linear_extrude(3)text(font="cousine",faces_6_and_12[i],thickness/10,$fn=50);
            } 
   }    
}

difference() {
   minkowski() { 
      sphere(roundness/100*thickness/2,$fn=50); 
      rotate ([45,0,90]) rhombic_dodecahedron(); 
   }    
   rotate ([45,0,90]) rhombic_text();
}