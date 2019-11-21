
height = 3;
layer_height = 0.3;
size = 40;
filament_size = 3.15; // Add 0.1mm to 0.2mm for tolerance

/* [Hidden] */

$fn=20;

difference(){
    cylinder(height, d=10);
    cylinder(height, d=filament_size);
}
for(h = [0:layer_height*2:height-layer_height])
    for(r = [0:20:360])
        rotate([0,0,r+h*8/layer_height])
        translate([1.5,0,h])
        cube([size,0.5,0.3]);