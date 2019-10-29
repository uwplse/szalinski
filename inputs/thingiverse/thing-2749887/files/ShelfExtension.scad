/* Shelf Extension
Daniel Urquhart 2017

This is a brance intended to sit under my monitor and allow it to be
pushed back past the edge of the desk by a few cm further.

*/

//total depth of the support
totalDepth= 140;

//portion of support that extends beyond table edge
extDepth = 75;

//length of support (z axis)
length = 110;

//thickness under monitor
topHeight = 4; //[0.8:10]

//thickness of table edge
gapHeight = 19; //[5,50]

//min thickness of lower support
minBaseHeight = 4; //[2:10]

//thickness of lower support just below table edge
maxBaseHeight = 18;//[4:10]

//Epsilon used to improve openSCAD visualziation... some small value >= 0
e=0.01;

extraBaseRadius = (maxBaseHeight)/2;

difference(){
    hull()
    {
    translate([extDepth-gapHeight/2,0,0])
        cube([totalDepth-extDepth+gapHeight/2,topHeight+gapHeight+minBaseHeight, length]);
    translate([(topHeight)/2,(topHeight)/2,0])
        cylinder(length, r=(topHeight)/2,$fn=50);
    translate([extDepth-gapHeight/2,topHeight+gapHeight,0])
        cylinder(length, r=extraBaseRadius,$fn=20);
    
    }
    translate([extDepth,topHeight,0-e]) {
        cube([totalDepth,gapHeight, length+2*e]);
    }
    translate([extDepth,topHeight+gapHeight/2,0-e]) {
        cylinder(length+2*e,r=gapHeight/2);
    }
    
}