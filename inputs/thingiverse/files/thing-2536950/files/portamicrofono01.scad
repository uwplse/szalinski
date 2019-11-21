include <threads.scad>

PI=3.141592;
$fn=50;
    difference() {  
          minkowski() {
              hull(){
                  translate([-20,0,0]) 
        cylinder(h=15, r=11);
             
         cylinder(h=20, r=6);
              }
      sphere(2); 
            
        }
    
        translate([-20,0,-2]){
        cylinder(h=15, r=10.2);}
        
        translate([-20,0,10]){
        cylinder(h=15, r=10.8);}
        
        translate([-20,0,10]) {
        sphere(10.8);}
        translate([-20,0,0]) {
        sphere(10.6);}
         translate([0,0,-2.1]) 
        {
             
english_thread (diameter=3/8, threads_per_inch=16, length=0.8);          

            cylinder(3,5,4);
         }
}