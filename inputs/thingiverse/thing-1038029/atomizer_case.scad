///////////////////////////////////////////////
// Title:  Parametric Atomizer Case
// Author: Gotsanity
// Date:   9/26/15
///////////////////////////////////////////////
//                Params                     //
///////////////////////////////////////////////

// Radius of the Atomizer
atomizerRadius = 10;

// Height of the Atomizer
atomizerHeight = 50;

// Don't Edit these
atomizerDiameter = atomizerRadius*2;
caseRadius = atomizerRadius+7;
caseHeight = atomizerHeight+10;
baseHeight = caseHeight/4;
topHeight = caseHeight-5;
$fn = 100;

///////////////////////////////////////////////
//                Renders                    //
///////////////////////////////////////////////
translate([caseRadius+30, 0, 0]){
    base();
}
top();

///////////////////////////////////////////////
//                Modules                    //
///////////////////////////////////////////////

module base() {
    difference(){
        cylinder(baseHeight, caseRadius, caseRadius);
        translate([0,0,7]){
            cylinder(baseHeight-2, caseRadius-3, caseRadius-3); 
        }
        translate([0,0,5]){
            difference(){
                cylinder(baseHeight-4, caseRadius+1, caseRadius+1);
                cylinder(baseHeight-4, caseRadius-2, caseRadius-2);
            }
        }
        translate ([0,0,1]){
            postHole();
        }
    }
}

module top() {
    difference(){
        cylinder(topHeight, caseRadius, caseRadius);
        translate([0,0,5]){
            cylinder(topHeight, caseRadius-2, caseRadius-2);
        }
        translate([0,0,topHeight+5-baseHeight]){
            cylinder(baseHeight-4, caseRadius-1, caseRadius-1);
        }
    }
}


module postHole() {
    cylinder(7,3.5,3.5);
}