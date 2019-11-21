// Creality Ender 3 Pro comes with 5 Alan Keys 4, 3, 2.5, 2, 1.5 mm
// Radius is calculated by using the Pythagoras Theorem

ak40r=(0.5*4.0)/sin(60);   // Radius of Alan Key 4.0 mm
ak30r=(0.5*3.0)/sin(60);   // Radius of Alan Key 3.0 mm
ak25r=(0.5*2.5)/sin(60);   // Radius of Alan Key 2.5 mm
ak20r=(0.5*2.0)/sin(60);   // Radius of Alan Key 2.0 mm
ak15r=(0.5*1.5)/sin(60);   // Radius of Alan Key 1.5 mm

t=0.2;
h=10;

ak40x=0;
ak30x=ak40r+t+ak30r+t;
ak25x=ak40r+t+ak30r+t+ak25r+t+2.0;
ak20x=ak40r+t+ak30r+t+ak25r+t+ak25r+t+3.45;
ak15x=ak40r+t+ak30r+t+ak25r+t+ak20r+t+ak15r+t+5.25;



difference(){
    hull(){
        translate([0,0,0]) rotate(90) cylinder(r=3.8,h=h,$fn=60);
        translate([13.5,0,0]) rotate(90) cylinder(r=2.5,h=h,$fn=60);
    }
    union(){
        translate([ak40x,0,0]) rotate(90) cylinder(r=ak40r+t,h=h,$fn=6);
        translate([ak30x,0,0]) rotate(90) cylinder(r=ak30r+t,h=h,$fn=6);
        translate([ak25x,0,0]) rotate(90) cylinder(r=ak25r+t,h=h,$fn=6);
        translate([ak20x,0,0]) rotate(90) cylinder(r=ak20r+t,h=h,$fn=6);
        translate([ak15x,0,0]) rotate(90) cylinder(r=ak15r+t,h=h,$fn=6);
    }
}
