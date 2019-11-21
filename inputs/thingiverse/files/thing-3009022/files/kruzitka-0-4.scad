/*
 * Customizable Compasses - https://www.thingiverse.com/
 * by Majitelgalaxie - https://www.thingiverse.com/
 * created 2018-07-18
 * version v1.0
 *
 * Changelog
 * --------------
 * v1.0 - 2018-07-18:
 *  - initial design
 * --------------
 * 
 */


// preview[view:south, tilt:top diagonal]

/* [Global] */
// Choose, which part you want to see!
part = "all_parts__";  //[all_parts__:All Parts,angle__:Angle,ruler__:Ruler]

/* [Angle settings] */
// for angle
signature = "sign";
centerHoleDiameter = 2;// [2:10]    
stopSideHeight = 10;   // [5:20]
stopSideLenghtA = 30;  // [20:200]
stopSideLenghtB = 30;  // [20:200]
stopSideWidth = 2;     // [2:5]
angle = 90; // [5:180]
             // right angle (90°) for corners when exist hole in corner

/* [Ruler settings] */
rulerLenght = 50;      // [20:200]    
rulerHeight = 2;       // [2:5]    
rulerFirstHoleShift = 0;   // [0:20]    
rulerHoleDistance = 5;    // [2:10]    

/* [Hidden] */
$fn=20;

/* Program Section */

if(part == "angle__") {
    angle();
} else if(part == "ruler__") {
    ruler();
}else {
    //rotate(a=[0,0,90])angle();
    //translate([-10,-10,0])ruler();
    rotate(a=[180,0,45])angle();
    rotate(a=[180,0,15])translate([0,0,-3])ruler();
}


module ruler(){
    textRulerHoleDistance = str(rulerHoleDistance,"mm");
    difference(){
        union(){
            translate([0,-5,0])cube([rulerLenght,10,rulerHeight]);
            cylinder(d=10, h=rulerHeight);
            translate([rulerLenght,0,0])cylinder(d=10, h=rulerHeight);
            translate([0,0,rulerHeight])cylinder(d1=centerHoleDiameter-0.1, d2=centerHoleDiameter-0.3, h=rulerHeight-0.2);
            
            translate([centerHoleDiameter*2+5,-rulerHeight*1.1/2,0])cube([rulerLenght-centerHoleDiameter*2-3,rulerHeight*1.1,rulerHeight*2-0.4]);
        }
        for(distance =[rulerHoleDistance+rulerFirstHoleShift:rulerHoleDistance:rulerLenght]){
            translate([distance,0,0])cylinder(d1=3, d2=0.8, h=rulerHeight*2);
        } 
        translate([0,0,0])cylinder(d1=2, d2=0, h=rulerHeight/2);   // reserve hole for drill and spare pin, e.g. screw, when main pin was broken
        
        mirror([0,1,0])translate([0,-4,-rulerHeight/2])linear_extrude( height = 2){text(textRulerHoleDistance,font = "Black Ops One",size = 3,spacing=1);}
    }
    
}
module angle(){    
   difference(){
        union(){
            rotate(a=[0,0,-angle+90])translate([0,-stopSideWidth,0])cube([stopSideLenghtA,stopSideWidth,stopSideHeight]);
            translate([-stopSideWidth,0,0])cube([stopSideWidth,stopSideLenghtB,stopSideHeight]);
            
            cylinder(d=centerHoleDiameter*2, h=rulerHeight);
            rotate(a=[0,0,-angle+90])translate([stopSideLenghtA-5,0,rulerHeight-1])cube([5,1,1]);
            translate([0,stopSideLenghtB-5,rulerHeight-1])cube([1,5,1]);
            
            
    
            difference(){
                cylinder(d=stopSideWidth*2, h=stopSideHeight);
                cylinder(d=centerHoleDiameter, h=stopSideHeight);
                rotate(a=[0,0,-angle+90])translate([-stopSideWidth/2,0,0])cube([stopSideLenghtA+stopSideWidth,stopSideWidth,stopSideHeight]);
                translate([0,-stopSideWidth/2,0])cube([stopSideWidth,stopSideLenghtB+stopSideWidth,stopSideHeight]);
            }
        }
        cylinder(d=centerHoleDiameter, h=stopSideHeight);
        
        mirror([1,0,0])translate([stopSideWidth+1,+stopSideWidth,+stopSideHeight/2+2])rotate(a=[270,0,90])linear_extrude( height = 1.5 ){text(text = signature,font = "Black Ops One",size = 5,spacing=1);}

    }
}
