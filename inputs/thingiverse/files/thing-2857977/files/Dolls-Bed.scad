// Doll's Bed
// Copyright 2018 Harald Mühlhoff, 58300 Wetter, Germany

// Thickness
a=6; 
// Width
b=80; 
// Length
c=140; 
// Letter
l="E"; 

cube([b,a,34]);

translate([(b-68)/2,-c,a])
cube([68,c,a]);

difference() {
    translate([0, -c-a, 0])
    cube([b,a,48]);
        
    translate([b/2-10, -c+2 , 20])
    rotate([90,0,0])
    linear_extrude(height=8)
    text(l, size=20);
}


difference() {
    translate([b/2,-c, -95])
    rotate([90,0,0])
    cylinder(a,d=300,$fn=100);

    union() {
        translate([-200, -150, -300])
        cube([400,300,300]);

        translate([b, -c-a, -50])
        cube([100, 100, 100]);    
            
        translate([-100, -c-a, -50])
        cube([100, 100, 100]);    
            
        translate([0, -c-a, 0])
        cube([b,8,48]);
    }
}

translate([(b-68)/2, -c, 12])
cube([2, c, 4]);

translate([(b-68)/2 + 68 -2, -c, 12])
cube([2, c, 4]);




