// 190 502 Tendeur  
// 02 Mai  2019

$fn = 100 ;!

union(){ 
// Support 
// Partie petit Diametre M6   
     difference(){
  translate([48,-14,-1]) 
         cube([32,30,18]);   
         rotate ([0,100,0]) 
   translate([-16,0,30]) 
        cylinder(d=10,h=70);
   } 
 // 2 trous de la surface plate 
 translate([0,0,0])
 difference(){
     minkowski ()
  {
     translate([49,-31,-6])
   cube([30,66,5]);   
      sphere (1, $fn=30);    
 }       
// 1 er trou    
 translate([65,-23,-8])
      cylinder(d=9,h=11); 
// 2 eme trou 
  translate([65,28,-8])
       cylinder(d=9,h=11);  
   rotate ([0,100,0]) 
   translate([-16,0,30]) 
        cylinder(d=10,h=70);
  } 

    }    
