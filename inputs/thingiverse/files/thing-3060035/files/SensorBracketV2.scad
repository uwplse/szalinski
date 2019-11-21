// Matthew Sparks
// 2018-05-13
//
// units in 1mm
// Bracket with screw hole for mounting Xiaomi Mi Temperature and Humidity Sensor
// Does not fit Xiaomi Aqara

sensorWidth = 35.6;
//sensorHeight = 9.8;
sensorHeight = 9;

widthTolerance = 0.5;
heightTolerance = 0.5;

internalSensorWidth = sensorWidth+widthTolerance;
internalSensorHeight = sensorHeight+heightTolerance;

bracketThickness = 4;
rearThickness = 2;

frontHoleSize = 30;

holeWidth = 8;
holeHeight = internalSensorHeight/3;
holeRoundness = 5;

//fastenerType = "NONE";
fastenerType = "SCREW";
//fastenerType = "NAIL";

screwOffset = 7;
screwAngle = 90;
nailHeadSize = 7.5;
shaftSize = 5;

$fn = 100;

difference(){
    union(){
        
        difference(){
            // outside shape
            cylinder(internalSensorHeight+rearThickness,d=internalSensorWidth+bracketThickness,false);
            
            // inside diameter
            translate([0,0,rearThickness]){
                cylinder(internalSensorHeight+rearThickness,d=internalSensorWidth,false);
            }
            
            // cutout bottom hole
            translate([-holeWidth/2,(-internalSensorWidth/2)+5.5,(rearThickness+(holeRoundness/2))+((internalSensorHeight)-(holeHeight+holeRoundness))/2]){
                rotate([90,0,0]){
                    minkowski(){
                        cube([holeWidth,holeHeight,10],false);
                        cylinder(1,d=holeRoundness,false);
                    }

                }
            }
        }
        
        // add front
        translate([0,0,internalSensorHeight+rearThickness]){
            cylinder(rearThickness,d=internalSensorWidth+bracketThickness,false);
        }
    }
   
    // cut off top
    translate([-((internalSensorWidth+bracketThickness+1)/2),0,rearThickness]){
        cube([internalSensorWidth+bracketThickness+1,(internalSensorWidth+bracketThickness+1)/2,20],(internalSensorHeight+rearThickness+1));
    }
    
    // cut off front
    translate([0,0,rearThickness+internalSensorHeight-1]){
        cylinder(bracketThickness+2,d=frontHoleSize,false);
    }
    
    translate([0,screwOffset,0]){
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

    