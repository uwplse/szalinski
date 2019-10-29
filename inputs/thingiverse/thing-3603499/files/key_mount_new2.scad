ds = 2.1;
//

difference(){
hull(){
sphere(d=14,$fn = 50);
translate([0,8,0]) sphere(d=8,$fn = 50);  
 translate([0,-8,0]) sphere(d=8,$fn = 50);    
}      
translate([-14,0,-(95/2-3)])rotate([0,90,0])cylinder(d=95,h=28,$fn=50);
translate([0,0,5.5])cylinder(d=16,h=28,$fn=50);
 cylinder(d=ds,h=67,$fn=33);   


//led
translate([0,-8,0.5]) sphere(d=5,$fn = 50);   
    
 translate([0,8,0.5]) sphere(d=5,$fn = 50);    
    }
  
 //drilling template
 /*   
difference(){
hull(){
sphere(d=14,$fn = 50);
translate([0,8,0]) sphere(d=10,$fn = 50);  
 translate([0,-8,0]) sphere(d=10,$fn = 50);    
}      
translate([-14,0,-(95/2-3)])rotate([0,90,0])cylinder(d=95,h=28,$fn=50);
translate([0,0,5.5])cylinder(d=16,h=28,$fn=50);
 cylinder(d=ds,h=67,$fn=33);   


//led
translate([0,-8,0.5]) cylinder(d=5.2,h=122,$fn = 50);    
    
 translate([0,8,0.5]) cylinder(d=5.2,h=122,$fn = 50);    
    }
     */ 