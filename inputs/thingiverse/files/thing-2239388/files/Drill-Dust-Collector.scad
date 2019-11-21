// Drill Dust Collector by xifle
// Licensed under the CC BY-NC-SA 3.0
// 10.04.2017
// v1


// Height of the Dust Collector
HEIGHT=20;

// Diameter of your Drill (add some clearing, 0.1-0.2mm should be fine)
DRILL_DIA=5.2;

// Upper Diameter of the Dust Collector
UPPER_DIAMETER=60;

// Lower Diameter of the Dust Collector
LOWER_DIAMETER=40;

WALL=1;

$fn=100;

difference() {

union() {
difference() {

cylinder(r1=LOWER_DIAMETER/2+WALL, r2=UPPER_DIAMETER/2+WALL, h=HEIGHT+WALL, center=false);

translate([0,0,WALL+0.01])
cylinder(r1=LOWER_DIAMETER/2, r2=UPPER_DIAMETER/2, h=HEIGHT, center=false);

  
}

cylinder(r=DRILL_DIA/2+WALL,h=HEIGHT/2);

}

  
translate([0,0,-0.1])
cylinder(r=DRILL_DIA/2, h=HEIGHT);


}