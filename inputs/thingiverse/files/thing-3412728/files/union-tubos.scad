tubo1 = 20;     //diametro externo

tubo2 = 16;

union() {
//
  translate([0,0,10])  
  difference() {

cylinder(h=10,r=tubo1/2+2,center=false); 

cylinder(h=10,r=tubo1/2,center=false); 
  }
  
  

  
  
  translate([0,0,0])  
    difference() {

cylinder(h=10,r1=tubo2/2+2,r2=tubo1/2+2,center=false); 

cylinder(h=10,r1=tubo2/2,r2=tubo1/2,center=false); 
  }
  
  
  
  translate([0,0,-10])  
    difference() {

cylinder(h=10,r=tubo2/2+2,center=false); 

cylinder(h=10,r=tubo2/2,center=false); 
  }
    }