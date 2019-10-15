$fs = 0.5;

printerOffset = 0.2;
diameterAxis = 5;
heightAxis = 55;

//mainbody
depthMax = 35;
widthMax = 32;
height = 7-printerOffset;
angleAxis = 11.31;
heightAxis2= 35.7;
offsetAxis = 16;
offsetGetSmaller = 27;
heightOnTheMiddlePart = 30;

//wheelholder
wheelHolderOuterDiameter = 10; 
wheelHolderInnerDiameter = 3;
innerHeight = 14;
widthDown = 3;
widthTop = 3;
adiitionalDiameterTop = 7;
aditionalHeightTop = 1;

//plateOfWheelHolder
plateWidth = 16.5;
plateHeight = innerHeight+widthDown+widthTop;
plateThickness = 3;

//placement of wheelAxis
distanceFromPlate = 9;
offsetFromPlate = 8;

//posionAxisToHolder
positionAxisToHolderOffset = 12;

axisWithBase();


module axis(){
    translate([0,heightAxis+diameterAxis/2]){
        sphere(d=diameterAxis);
        translate([0, -heightAxis,0]) sphere(d=diameterAxis);
        rotate([90,0,0])cylinder(d=diameterAxis, h=heightAxis);
    }   
}



module axisWithBase() {
translate([-depthMax,0,0]) difference(){
    union(){
        hull(){
            cube([depthMax, widthMax, height]);
            translate([depthMax,widthMax,height/2]){
                rotate([0,-90,-angleAxis]){
                    cylinder(d=height, h=heightAxis2);
                }
            }
        }
        translate([depthMax,widthMax,height/2])rotate([90,-90,-angleAxis]) translate([0,-offsetAxis,0]) axis();
    }
    translate([0,widthMax,-0.5])rotate([0,0,190])cube([10,widthMax+10,height+1]);
}
}



module wheelHolder(){
    translate([0,0,plateHeight])mirror([1,0,0])rotate([180,0,-90])difference(){
        union(){
            hull(){
                cube([plateThickness, plateWidth, plateHeight]);    
                translate([distanceFromPlate+plateThickness, distanceFromPlate, 0]) cylinder(d=wheelHolderOuterDiameter, h=plateHeight);
            }  
        //translate([distanceFromPlate+plateThickness, distanceFromPlate, 0]) cylinder(d=adiitionalDiameterTop, h= plateHeight+aditionalHeightTop);
        }
        translate([plateThickness,-1,widthDown])cube([20, plateWidth+2, plateHeight-widthTop-widthDown]);
        translate([distanceFromPlate+plateThickness, distanceFromPlate, -0.5]) cylinder(d=wheelHolderInnerDiameter, h= plateHeight+aditionalHeightTop+1); 
    }
}

lengthCubeOnWheelHolder = 7.6;
heightCubeOnWheelHolder = 11.9;
topOffsetCubeOnWheelHolder = 1.4;

//SpareCube
widthSpareCube = 5.7;
lengthSpareCube = 13.3;
positionFromOuterEnd = 5.15;

DistandeBetweenWheelHolderPlateAndMainBody = 22.6;


//wheelHolderAxisSpare
wheelHolderAxisSpareWider = 4;
wheelHolderAxisSpareSmaller = 2.6;
positionSpareAxisY = 5;
positionSpareAxisZ = 10;


//21
//9

difference(){
    union(){
hull(){
translate([-plateWidth-positionAxisToHolderOffset,-DistandeBetweenWheelHolderPlateAndMainBody,0])translate([0,lengthCubeOnWheelHolder,plateHeight-heightCubeOnWheelHolder-topOffsetCubeOnWheelHolder])cube([plateWidth,1,heightCubeOnWheelHolder]);
translate([-heightOnTheMiddlePart,-1,0])cube([heightOnTheMiddlePart,1,height]);
}
translate([-plateWidth-positionAxisToHolderOffset,-DistandeBetweenWheelHolderPlateAndMainBody,0]){
wheelHolder();
translate([0,0,plateHeight-heightCubeOnWheelHolder-topOffsetCubeOnWheelHolder])cube([plateWidth,lengthCubeOnWheelHolder,heightCubeOnWheelHolder]);
}

}
translate([-plateWidth-positionAxisToHolderOffset,-DistandeBetweenWheelHolderPlateAndMainBody,0])translate([positionFromOuterEnd,0,0])cube([widthSpareCube,lengthSpareCube,plateHeight]);

translate([-plateWidth-positionAxisToHolderOffset-1,-DistandeBetweenWheelHolderPlateAndMainBody+positionSpareAxisY,positionSpareAxisZ])rotate([0,90,0])cylinder(d= wheelHolderAxisSpareWider, h= 7);

translate([-plateWidth-positionAxisToHolderOffset-1+positionFromOuterEnd+widthSpareCube,-DistandeBetweenWheelHolderPlateAndMainBody+positionSpareAxisY,positionSpareAxisZ])rotate([0,90,0])cylinder(d= wheelHolderAxisSpareSmaller, h= 8);
}

difference(){
translate([-5,12.5,(height-diameterAxis)/2])rotate([0,0,-angleAxis])cube([10,20,diameterAxis]);
translate([-7,2.5,(height-diameterAxis)/2-1])rotate([0,0,-30])cube([10,35,diameterAxis+2]);
}
