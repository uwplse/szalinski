// Panel length (mm)
length = 155;

// Support bar position (mm)
barPos =100;

// Panel angle (max 55 degrees)
angle = 45;

// Channel witdh
channel = 1.5;

// Screw hole diameter (mm)
diameter = 3.5;

// Mirror model?
mirror = 0;

module solarBracket(){
    if(mirror == 0){
        Bracket();
    } else {
       translate([0,-50,0]){
            mirror([0,1,0])
                    Bracket();
        }
    }
}solarBracket();

module Bracket(){
    a =tan(angle)*barPos;                  // support lenght
    h = sqrt(pow(barPos,2)+pow(a,2));     // Base lenght
    difference(){
        rotate([0,-angle,0]){
            difference(){
                cube([length+20,10,10]);       
                
                translate([0,3,5])
                    cube([length+20,17,channel]);
                
                translate([0,0,5])
                    cube([22,10,10]);
            }
           
            translate([barPos,0,-a])
                cube([5,10,a]);
            
            rotate([0,angle,0]){
                difference(){
                    cube([h,10,5]);
                    
                    spacing = h/4;
                    translate([spacing,5,0])
                         cylinder(h=10, d=diameter,$fn=180);
                    
                    translate([3*spacing,5,0])
                        cylinder(h=10, d=diameter,$fn=180);
                }
            }
        }
        translate([20,20,0])
            cube([20,20,20]);
    }
}