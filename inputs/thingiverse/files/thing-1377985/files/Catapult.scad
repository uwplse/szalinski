// model of a catapult with as many customizable parameters as possible to allow for various trajectory experiments in a physics demo

//************************************************************
//PARAMETERS
//************************************************************
// Base width
baseWidth = 7; //[5:30]
// Base length
baseLength = 15; //[5:30]
// Base height
baseHeight = 1; //[0.5:1]
// Base thickness
baseThick = 1; //[0.5:1]
// Arm length
armLength = 15; //[5:50]
// Arm width
armWidth = 0.5; //[0.25:3]
// Arm thickness
armThick = 0.25; //[0.25:1]
// Arm angle
angle = 45; //[5:90]
// Radius of bucket
bucketRad = 1; //[0.25:10]
// Bucket thickness
bucketThick = 0.25; //[0.25:1]
// Crossbar height (set to 0 if you don't want a crossbar)
barHeight = 5.5; //[0:40]
// Crossbar distance from front
barY = 4; //[0:20]
// Front support length (may be needed to prevent front flips)
suppLength = 0; //[0:15]

//************************************************************
//MATH
//************************************************************
holeWidth = baseWidth - (2*baseThick);
holeLength = baseLength - (2*baseThick);
holeHeight = baseHeight + 2;

armX = (baseWidth - armWidth)/2;
armY = baseThick/2;
armZ = baseHeight/2;

bucketX = baseWidth/2;
bucketY = ((baseThick/2) + ((armLength + bucketRad + bucketThick - armThick)*cos(angle)) - (armThick*sin(angle))) * 1.01;
bucketZ = ((baseHeight/2) + ((armLength + bucketRad + bucketThick - armThick)*sin(angle)) + (armThick*cos(angle))) * 1.01;

//************************************************************
//RENDERS
//************************************************************
$fn = 30;

// translate cube up to x-y plane to make printers happy
//translate([0,0,baseHeight/2]){
	catapult();
//}

//************************************************************
//MODULES
//************************************************************
module catapult(){
    union(){
        base();
        arm();
        bucket();
        if(barHeight != 0){
            crossbar();
        }
        if(suppLength != 0){
            support();
        }
    }
}

module base(){
    difference(){
        cube([baseWidth,baseLength,baseHeight],false);
        translate([baseThick,baseThick,-1]){
            cube([holeWidth,holeLength,holeHeight],false);        
        }
    }
}

module arm(){
    translate([armX,armY,armZ]){
        rotate([angle,0,0]){
            cube([armWidth,armLength,armThick],false);
        }
    }
}

module bucket(){
    translate([bucketX,bucketY,bucketZ]){
        rotate([angle,0,0]){
            translate([0,0,bucketRad*0.1]){
                difference(){
                    sphere(bucketRad+bucketThick);
                    sphere(bucketRad);
                    translate([0,0,(bucketRad*1.5)-(bucketRad*0.1)]){
                        cube([(bucketRad+1)*3,(bucketRad+1)*3,bucketRad*3],true);
                    }
                }
            }
        }
    }
}

module crossbar(){
    translate([0,barY,0]){
        cube([baseThick,baseThick,barHeight]);
    }
    translate([baseWidth-baseThick,barY,0]){
        cube([baseThick,baseThick,barHeight]);
    }
    translate([0,barY,barHeight]){
        cube([baseWidth,baseThick,baseThick]);
    }
}

module support(){
    translate([0,-suppLength,0]){
        cube([baseThick,suppLength,baseHeight]);
    }
    translate([baseWidth-baseThick,-suppLength,0]){
        cube([baseThick,suppLength,baseHeight]);
    }
}