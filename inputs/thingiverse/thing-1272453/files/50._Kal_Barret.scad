$fn = 50;
module platte_u(){
module platte(){
    difference(){
    translate([0, -11, 0]){
    cube([56, 22, 3]);
    }
}
    module seite(){
    difference(){
        
        translate([0, 11, 0])
        cube([68, 20, 3]);
        
        translate([0, 11, -0.5])
        rotate(a = 60, v=[0, 0, 1]) 
            {cube([30, 30, 4]);}
           
        translate([82,-4, -0.5]) 
        rotate(a = 60, v=[0, 0, 1])
            {cube([30, 30, 4]);}
        }
}
    seite();
    mirror([0, 1, 0]){seite();
    }
}

module lauf(){
      
        translate([-0.5, 0, 13.72])
        rotate(a = 90, v = [0, 1, 0])
            {cylinder(d = 22.44, h = 45.6);}
            
        translate([45.0, 0, 13.72])
        rotate(a = 90, v = [0, 1, 0])
            cylinder(d=25.18, h=12);
}

difference(){
    platte();
    lauf();
}
}

platte_u();
mirror([0,0,1]) 
translate([0,0,-27.5]){platte_u();}

module rippen(){
translate([-1.2,9,0]){
rotate(a = 330, v=[0,0,1])
cube([3,30,27.5]);
}


translate([25.4,9,0]){
rotate(a = 330, v=[0,0,1])
cube([3,30,27.5]);
}

translate([51.5,9,0]){
rotate(a = 330, v=[0,0,1])
cube([3,30,27.5]);
}
}

module Rippen(){
rippen();
mirror([0,1,0]) rippen();
}
module lauf(){
      
        translate([-2.5, 0, 13.72])
        rotate(a = 90, v = [0, 1, 0])
            {cylinder(d = 22.44, h = 42.6);}
            
        translate([45.0, 0, 13.72])
        rotate(a = 90, v = [0, 1, 0])
            cylinder(d=25.18, h=12);
}

difference(){
Rippen();
    lauf();
}






