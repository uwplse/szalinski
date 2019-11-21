$fn=90;



difference(){
    hull(){
        cylinder(d=25,h=6);    
        translate([55,0,0])
        cylinder(d=14,h=6);    
    }
    
    difference(){
        hull(){            
            translate([20,0,-1])
            cylinder(d=15,h=8);
            translate([41,0,-1])
            cylinder(d=11.5,h=8);
        }
        translate([3.5,0,0])
        cylinder(d=18,h=10);
    }
    
    translate([0,0,-2])
    cylinder(d=12.9,h=10);
    translate([-20,-5.5,-2])
    cube([20,11,10]);
    
    translate([0,0,1])
    difference(){
        cylinder(d=18.2,h=10);
        translate([-1.25,7,0])        
        cube([2.5,6.05,8]);
        translate([-1.25,-6.05-7,0])        
        cube([2.5,6.05,8]);        
        translate([7,-1.25,0])        
        cube([6.05,2.5,8]);
        
    }
    translate([55,0,-3])
    cylinder(d=8.5,h=10,$fn=6);
    
    //#translate([12,-50,-50])
    //cube([100,100,100]);
}
