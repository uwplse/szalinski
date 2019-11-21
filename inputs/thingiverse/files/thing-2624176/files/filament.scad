//Filament Diameter
filament = 2.85; //[0:0.01:10]

//Filament Spacing
filament_space = 0.5; //[0:0.01:10]

filament_d = filament + filament_space;

//Width of the inner Cube
w = 10; //[5:100]
//Height of the inner Cube
h = 30; //[10:100]
//Wall Thickness
wall = 3; //[1:0.1:30]

union() {
    difference() {
        cube(w+wall*2,w+wall*2,h+wall);
        
        translate([wall,wall,wall])
        cube([w,w,h]);
        
        translate([w/2+wall,w/2+wall,0])
        cylinder(d=filament_d,h=wall,$fn=100);
    }
    
    translate([w/2+wall,w/2+wall,wall])
    difference() {
        cylinder(d=filament_d+wall,h=wall,$fn=100);
        cylinder(d1=filament_d,d2=filament_d+wall,h=wall,$fn=100);
    }
}