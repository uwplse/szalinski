l=140;
w=140;
h=140;
scale([.25,.25,.25])

difference()
{
   translate([0,0,70])
    cube([l,w,h], center=true);

translate([0,0,0])
    cube([l/2,20,20],center=true);
    
translate([0,0,h])
    cube([l/2,20,20],center=true);
    
rotate([0,90,0])    
translate([-l/2,0,h/2])
    cube([l/2,20,20],center=true);
    
rotate([0,90,0])    
translate([-l/2,0,-h/2])
    cube([l/2,20,20],center=true);
    
        
  
translate([0,0,0])
    cube([20,w/2,20],center=true);
    
translate([0,0,h])
    cube([20,w/2,20],center=true);  
  
translate([0,-w/2,h/2])
    cube([20,20,h/2],center=true);  
 
 rotate([0,90,0])
 translate([-h/2,-w/2,0])
    cube([20,20,h/2],center=true); 
    
 translate([0,w/2,h/2])
    cube([20,20,h/2],center=true);  
    

}