$fn=20;

difference(){ 
    cylinder(8,8,8);
    translate([0,0,2])   sphere(2);
    translate([-8,0,6]) rotate([25,0,0])  cube([16,8,8]);    
    translate([-8,0,6]) rotate([65,0,0])  cube([16,8,8]);    
    translate([0,-8,6]) rotate([25,0,90])  cube([16,8,8]);    
    translate([0,-8,6]) rotate([65,0,90])  cube([16,8,8]);    
    cylinder(0.3,4,4);
    cylinder(1,1.6,1.6);
//    translate([0,0,1.2])   sphere(2);
    }
    translate([0,0,0.2]) 
    difference(){ cylinder(0.2,4,4); cylinder(1.2,1.8,0.5);}
 
