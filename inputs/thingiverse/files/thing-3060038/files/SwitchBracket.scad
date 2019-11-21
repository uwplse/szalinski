// Matthew Sparks
// 2018-08-14
//
// units in 1mm
// Bracket with screw hole for mounting Xiaomi Aquara dual switch

switchWidth = 86.07; // measured at widest point
//sensorHeight = 9.8;
switchHeight = 86.45; // measured at widest point
switchThickness = 8;

switchFrontWidth = 85.56;
switchFrontHeight = 85.68;

widthTolerance = 0.5;
heightTolerance = 0.5;

bracketThickness = 4;
rearThickness = 2;

frontHoleSize = 30;

holeWidth = 8;
holeRoundness = 5;

//fastenerType = "NONE";
fastenerType = "SCREW";
//fastenerType = "NAIL";

screwDistance = 50;
screwOffset =-20;
screwAngle = 90;
nailHeadSize = 7.5;
shaftSize = 5;

$fn = 100;

difference(){
    
    // frame
    hull(){
        translate([0,0,(switchThickness+rearThickness)/2]){
            cube([switchFrontWidth+bracketThickness,switchFrontHeight+bracketThickness,switchThickness+rearThickness],true);
        }
        translate([0,0,(0.01)/2]){
            cube([switchWidth+bracketThickness,switchHeight+bracketThickness,0.01],true);
        }
    }
    
    // cutout of switch
    translate([0,0,rearThickness+0.1]){
        hull(){
            translate([0,0,((switchThickness)/2)]){
                cube([switchFrontWidth,switchFrontHeight,switchThickness],true);
            }
            translate([0,0,(0.01)/2]){
                cube([switchWidth,switchHeight,0.01],true);
            }
        }
    }
    
    // cut off top
    translate([0,0,rearThickness+0.1]){
        translate([0,switchHeight,((switchThickness)/2)]){
            cube([switchWidth*2,switchHeight*2,switchThickness*2],true);
        }
    }
    
    translate([screwDistance/2,screwOffset,0]){
        if(fastenerType=="SCREW") {
            // screw hole
            union(){
                //main hole
                translate([0,0,-0.1]){
                    cylinder(rearThickness+0.2,d=shaftSize,false);
                }
                //countersink
                cylinder(rearThickness+0.2,d1=shaftSize,d2=shaftSize+(rearThickness*tan(screwAngle/2)),false);        
            }
        }
        else if(fastenerType=="NAIL"){        
            union(){
                //main hole
                translate([0,0,-0.1]){
                    cylinder(rearThickness+0.2,d=shaftSize,false);
                }
                //countersink
                translate([0,0,rearThickness/2]){
                    cylinder(rearThickness/2+0.2,d=nailHeadSize,false);
                }
            }
        }
    }
    translate([-screwDistance/2,screwOffset,0]){
        if(fastenerType=="SCREW") {
            // screw hole
            union(){
                //main hole
                translate([0,0,-0.1]){
                    cylinder(rearThickness+0.2,d=shaftSize,false);
                }
                //countersink
                cylinder(rearThickness+0.2,d1=shaftSize,d2=shaftSize+(rearThickness*tan(screwAngle/2)),false);        
            }
        }
        else if(fastenerType=="NAIL"){        
            union(){
                //main hole
                translate([0,0,-0.1]){
                    cylinder(rearThickness+0.2,d=shaftSize,false);
                }
                //countersink
                translate([0,0,rearThickness/2]){
                    cylinder(rearThickness/2+0.2,d=nailHeadSize,false);
                }
            }
        }
    }
    
    
}

    