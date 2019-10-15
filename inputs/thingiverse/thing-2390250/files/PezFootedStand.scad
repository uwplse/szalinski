//FootedPezStand
//Display stands for Pez Collectors
//By Dataman, Charley Jones PMP
//First Version 1.0 6/16/17
// Version 2.0 6/17 add length param
// Design: Break off extended key if not needed
// k                     k
// e shaft  BASE  shaft  e
// y                     y
// riser to catch pez feet

LengthAdjust=0; // 99.8mm undadjusted, - shorten, + lengthen
// LengthAdjust
// When LengthAdjust=0 total is 99.8mm
// Form smaller, go -, ie: -10, would allow for 5layer brim on smaller factor
// For larger, go +, ie: +130, for 10" machines.

rotate([0,0,-90])
difference(){
union(){

//base
cube([90+LengthAdjust,37,2]);

/* For alignment purposes
//key cutout
translate([95+LengthAdjust,13.5,0])
 #cube([5,10,2]);

//shaft cutout
translate([90+LengthAdjust,16.5,0])
 #cube([5,4,2]);
*/    
    
// key    
translate([95.2+LengthAdjust,13.7,0])
 cube([4.6,9.6,2]);

//shaft
translate([89.8+LengthAdjust,16.7,0])
 cube([5.4,3.6,2]);

//front riser    
translate([0,0,2])
 cube([90+LengthAdjust,2,2]);
translate([0,0,4])
 cube([90+LengthAdjust,4,2]);
//back riser
translate([0,35,2])
 cube([90+LengthAdjust,2,2]);
translate([0,33,4])
 cube([90+LengthAdjust,4,2]);
    
    
}
//key cutout
translate([5,13.5,0])
 cube([5,10,2]);

//shaft cutout
translate([0,16.5,0])
 cube([5,4,2]);
}