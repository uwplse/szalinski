
l= 140;
w= 140;
h= 140;
scale([.25,.25,.25])

difference()
{
    
   translate([0,0,h/2])
    cube([l,w,h], center=true);

rotate([0,0,45])
translate([0,0,0])
    cube([l/2,20,20],center=true);
    
 rotate([0,0,45])   
translate([0,0,h])
    cube([l/2,20,20],center=true);
    
rotate([0,90,0])    
translate([-l/2,0,h/2])
    cube([l/2,20,20],center=true);
    
rotate([0,90,0])    
translate([-l/2,0,-h/2])
    cube([l/2,20,20],center=true);
    
        
  rotate([0,0,45])
translate([0,0,0])
    cube([20,w/2,20],center=true);

rotate([0,0,45])    
translate([0,0,h])
    cube([20,w/2,20],center=true);  

   
translate([0,-w/2,h/2])
rotate([0,135,0])  
    cube([20,20,h/2],center=true); 
   
translate([l/2,w/4,h/2])
rotate([0,90,0])  
    cylinder(h=20, r1=10, r2=10,center=true); 
    
translate([l/2,-w/4,h/2])
rotate([0,90,0])  
    cylinder(h=20, r1=10, r2=10,center=true); 
    
translate([-l/2,w/4,h/2])
rotate([0,90,0])  
    cylinder(h=20, r1=10, r2=10,center=true); 
    
translate([-l/2,-w/4,h/2])
rotate([0,90,0])  
    cylinder(h=20, r1=10, r2=10,center=true); 
    
translate([-l/4,w/2,h/2])
rotate([90,0,0])  
    cylinder(h=20, r1=10, r2=10,center=true); 
    
translate([l/4,w/2,h/2])
rotate([90,0,0])  
    cylinder(h=20, r1=10, r2=10,center=true);
 

 translate([0,-70,70])
  rotate([0,45,0])
    cube([20,20,70],center=true); 
    
 translate([0,70,70])
    cube([20,20,70],center=true);  
    

}