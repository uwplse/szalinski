// Height (mm)
height = 10;

//Width (mm)
width = 25;

//Length (mm)
length = 50;

//Outer radius (mm)
radius = 42;

//Rod diameter (mm)
rodDia = 15.5;

//Rod offset (mm)
offset = -2;

//Rod gap (mm)
gap = 1;

//Bolt diameter (mm)
boltDia = 5;

$fn=50;

module PostClamp(){
    difference(){
        Whole();
       
        translate([0,(length/2)+1,offset]){
            rotate([90,0,0]){
                cylinder(h=length+2,d=rodDia+(2*gap));
            }
        }
        BoltHole(15.5,13.5);
        BoltHole(15.5,-13.5);
        BoltHole(-15.5,13.5);
        BoltHole(-15.5,-13.5);      
    
    }
}PostClamp();

module Half(){
    translate([-(radius-width),0,-gap]){
        intersection(){
            cylinder(h=height,r=radius);
            translate([(radius-width),-25,0])
                cube([width,length,height]);
        }
    }
}

module Whole(){
    Half();
    
    rotate([0,0,180])
        Half();
}

module BoltHole(x, y){
    translate([x,y,-2]){
        rotate([0,0,90])
          cylinder(d=boltDia,h=height+2);
    }
}


