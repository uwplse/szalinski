/*

Spool bar-holder

Fernando Jerez 2017

*/

rod_tube_diameter = 28;
spool_tube_diameter = 30;
spool_height = 80;
length = 160;
pin = "Yes"; // [Yes:Yes, No:No]

/* [Hidden] */

thickness = 3;
height = spool_height+20;
tube = rod_tube_diameter;
spooltube = spool_tube_diameter;


difference(){
    union(){
        hull(){
            cylinder(r = thickness+(tube/2),h = 10);
            translate([length,0,0]) cylinder(r = 5+(spooltube/2),h = 10);
        }
        cylinder(r = thickness+(tube/2),h = 10+height);
        translate([length,0,0]){
            cylinder(r = (spooltube/2),h = 10+height);
            translate([0,0,height]) cylinder(r1 = (spooltube/2), r2 = 5+(spooltube/2), h=10);
            translate([0,0,10]) cylinder( r1 = 5+(spooltube/2), r2 = (spooltube/2), h=10);
        }
        
        translate([0,-5,10]) cube([length,10,5]);
        translate([tube/2-8,-5,9]){
            rotate([0,-10,0]) cube([20,10,height*0.66]);
            translate([0,0,15]) rotate([0,100,0]) cube([10,10,height*0.66]);
        }
        if(pin=="Yes"){
            translate([length,0,height+10]) cylinder(r = 9.5,h = 10);
        }
    }
        
    
    cylinder(r = (tube/2),h = 10+height+0.1);
    translate([length,0,0]) cylinder(r = (10),h = height);
    
}