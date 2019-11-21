/*
Toilet paper holder by Jkk79.
It started as a copy of something I have on my bathroom's wall and then expanded into fully customizable thing.
Well, originally, I broke the arm on the one I have and decided to print a replacement arm (it would have been faster and perhaps cheaper to just go and buy a new one), and then I thought that It would be cool to make the whole thing, but the holder part would be impossible to print with the original locking mechanism, at least without support structures, so I had to make my own design.
*/


//
part=1;//[1:Arm,2:Holder]
//Higher quality takes longer time to render and creates a bigger file. 60 is good enough already. 20 is good for preview.
quality=20;//[20,28,36,44,52,60,68,76,84,92,100]
/*[Arm settings]*/
orientation=0;//[0:Left,1:Right]
//
armDiameter=15; 
//
armWidth=160;
//
armHeight=100;
//The inner diameter of the corners in the arm.
armCorner=10;//[0:30]
//This is to make the printing easier. Also doubles as a part of the arm's locking mechanism.
armBottomCutDepth=3;//[2,3,4]
//Width of the notch that locks the arm into it's place. It's counterpart in the holder will be 2mm smaller.
armLockMechanismWidth=6;
/*[Holder settings]*/
//
wallPartWidth=100;
//
wallPartHeight=65;
//Default 4. Thinner than 4 might make the loop that holds the arm too weak.Thicker than 4 seems excessive.
wallPartThickness=4;//[3.0:0.5:8.0]
//The width of the loop that holds the arm.
holderWidth=65;
//Screw placement options
screwPlacements=1;//[0:No screws.1:Sides,2:Corners;3:Top and bottom]
//The diameter of the holes for screws. 
//
screwDistanceFromEdge=10;
//
screwHoleSize=3.2;
//
screwEndSinkAngle=50;
//The depth for the previous setting.
screwEndSinkDepth=2;
//Due to the inaccuracies in printing among other things, the hole for the arm needs to be slightly bigger than the arm itself.
extraSpaceForArm=0.4;

armBendLength=armCorner+armDiameter;
print_part();

module print_part(){
    if(part==1){
        mirror([orientation,0,0])arm();
    }else{
        wallPart();
    }
}

module donut(innerDiameter,donutDiameter){
    rotate_extrude(convexity=10,$fn=quality)translate([innerDiameter+donutDiameter/2,0,0])rotate([0,0,45])circle(r=donutDiameter/2,$fn=quality);
    }
    
module armBend(){
    translate([-(armCorner+armDiameter/2),0,0]){
        difference(){
            donut(armCorner,armDiameter);
            translate([-(armDiameter+armCorner+1),0,-armDiameter/2-1])cube([(armDiameter+armCorner)*2+2,armDiameter+armCorner+1,armDiameter+2]);
            translate([-(armDiameter+armCorner+1),-(armDiameter+armCorner+1),-armDiameter/2-1])cube([(armDiameter+armCorner)+1,armDiameter+armCorner+2,armDiameter+2]);
            }
      }
}

module armPart(length){
hull(){
        translate([0,0,0])sphere(r=armDiameter/2,$fn=quality);
        translate([length,0,0])sphere(r=armDiameter/2,$fn=quality);
}
    }

module armLockCut(){
    difference(){
        translate([0,-armDiameter/2,-armDiameter/2])cube([armLockMechanismWidth,armDiameter,armDiameter]);
        translate([0,0,0])rotate([0,90,0])cylinder(armLockMechanismWidth,armDiameter/2-armBottomCutDepth,armDiameter/2-armBottomCutDepth,$fn=quality);
    }
}
 
module arm(){
    difference(){
        union(){
            translate([0,-armDiameter/2,armDiameter/2-armBottomCutDepth]){
                if((armWidth-2*armBendLength)/2<holderWidth/2){
                    echo(armBendLength);
                    difference(){
                        translate([armBendLength+armWidth-armBendLength*2,0,0])armPart(-(wallPartWidth-armDiameter/2-(wallPartWidth-holderWidth)/2+2));
                        translate([armWidth-armBendLength-armLockMechanismWidth/2-wallPartWidth/2+(wallPartWidth-holderWidth)/2-2,0,0])armLockCut();
                    }
                }else{
                    difference(){
                        
                        translate([armBendLength+armWidth-armBendLength*2,0,0])armPart(-(armWidth/2-armBendLength+wallPartWidth/2-armDiameter/2));
                        translate([armWidth/2-armLockMechanismWidth/2,0,0])armLockCut();
                    }
                }
                translate([armWidth-armBendLength,0,0])rotate([0,0,90])armBend();
                translate([armWidth-armDiameter/2,-armCorner-armDiameter/2,0])rotate([0,0,-90])armPart(armHeight-2*armBendLength);
                translate([armWidth-armDiameter/2,-armHeight+armBendLength+armDiameter/2,0])rotate([0,0,0])armBend();
                translate([armBendLength,-armHeight+armDiameter,0])rotate([0,0,0])armPart(armWidth-armBendLength*2);
                translate([armBendLength,-armHeight+armDiameter,0])rotate([0,0,-90])armBend();
                translate([armDiameter/2,-armHeight+armBendLength+armDiameter/2,0])sphere(r=armDiameter/2,$fn=quality);
            }
        } 
        translate([0,-armHeight,-50])cube([armWidth,armHeight,50]);
    }  
}


module holderFillet(){
    difference(){
        cube([holderWidth,wallPartThickness,wallPartThickness]);
        translate([-1,wallPartThickness,wallPartThickness])rotate([0,90,0])cylinder(holderWidth+2,wallPartThickness,wallPartThickness,$fn=quality);
    }
}

module screwHole(){
    translate([0,0,-1])rotate([0,0,0])cylinder(wallPartThickness+2,screwHoleSize/2,screwHoleSize/2,$fn=quality);
    translate([0,0,wallPartThickness-screwEndSinkDepth])rotate([0,0,0])cylinder(wallPartThickness/2+1,screwHoleSize/2,tan(screwEndSinkAngle)*wallPartThickness/2+screwHoleSize/2,$fn=quality);
}

module wallPart(){
    difference(){
        union(){
            hull(){
                translate([wallPartThickness,wallPartThickness,0])sphere(r=wallPartThickness,$fn=quality);
                translate([wallPartWidth-wallPartThickness,wallPartThickness,0])sphere(r=wallPartThickness,$fn=quality);
                translate([wallPartThickness,wallPartHeight-wallPartThickness,0])sphere(r=wallPartThickness,$fn=quality);
                translate([wallPartWidth-wallPartThickness,wallPartHeight-wallPartThickness,0])sphere(r=wallPartThickness,$fn=quality);
            }
            hull(){
                translate([wallPartWidth/2-holderWidth/2,wallPartHeight/2,armDiameter/2+wallPartThickness])rotate([0,90,0])cylinder(holderWidth,armDiameter/2+wallPartThickness,armDiameter/2+wallPartThickness,$fn=quality);
                translate([wallPartWidth/2-holderWidth/2,wallPartHeight/2,-armDiameter/2])rotate([0,90,0])cylinder(holderWidth,armDiameter/2+wallPartThickness,armDiameter/2+wallPartThickness,$fn=quality);
            }
            translate([wallPartWidth/2-holderWidth/2,wallPartHeight/2+armDiameter/2+wallPartThickness,wallPartThickness])rotate([0,0,0])holderFillet();
            translate([wallPartWidth/2-holderWidth/2,wallPartHeight/2-armDiameter/2-wallPartThickness,wallPartThickness])rotate([90,0,0])holderFillet();
        }
        translate([-1,-1,-100])cube([wallPartWidth+2,wallPartHeight+2,100]);
        difference(){
            hull(){
                    translate([wallPartWidth/2-holderWidth/2-0.001,wallPartHeight/2,armDiameter/2+wallPartThickness])rotate([0,90,0])cylinder(holderWidth+0.002,armDiameter/2+extraSpaceForArm/2,armDiameter/2+extraSpaceForArm/2,$fn=quality);
                    translate([wallPartWidth/2-holderWidth/2,wallPartHeight/2,-armDiameter/2])rotate([0,90,0])cylinder(holderWidth,armDiameter/2+extraSpaceForArm/2,armDiameter/2+extraSpaceForArm/2,$fn=quality);
            }
            translate([wallPartWidth/2-armLockMechanismWidth/2,wallPartHeight/2-armDiameter/2-1,0])cube([armLockMechanismWidth-2,armBottomCutDepth+1-extraSpaceForArm,armDiameter*2]);    
        }
        if(screwPlacements==0){
            
        }else if(screwPlacements==1){
            translate([screwDistanceFromEdge,wallPartHeight/2,0])screwHole();
            translate([wallPartWidth-screwDistanceFromEdge,wallPartHeight/2,0])screwHole();
        }else if(screwPlacements==2){
            translate([screwDistanceFromEdge,wallPartHeight-screwDistanceFromEdge,0])screwHole();
            translate([wallPartWidth-screwDistanceFromEdge,wallPartHeight-screwDistanceFromEdge,0])screwHole();
            translate([screwDistanceFromEdge,screwDistanceFromEdge,0])screwHole();
            translate([wallPartWidth-screwDistanceFromEdge,screwDistanceFromEdge,0])screwHole();
        
        }else if(screwPlacements==3){
            translate([wallPartWidth/2,screwDistanceFromEdge,0])screwHole();
            translate([wallPartWidth/2,wallPartHeight-screwDistanceFromEdge,0])screwHole();
        }
    }
}

