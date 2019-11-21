maxLength = 360;

outerRing = 55780;
outerWall = 1000;

innerRing = 496800;
innerWall = 1000;

/* [ Hidden ] */
enableCutouts = true;

$fn = 360;
scaleFaktor = maxLength / outerRing;
nozzleSize = 0.4;

ringOuterRadius = outerRing / 2 * scaleFaktor;

podLength = 5400 * scaleFaktor; //909px
podWidth = 2450 * scaleFaktor;
podHeight = 2650 * scaleFaktor;
podWalls = 5 * nozzleSize;
podFloorHeight = 1;

podWindowLength = 900 * scaleFaktor;
podWindowHeight = 900 * scaleFaktor;
podWindowPadding = 6 * nozzleSize;
podWindowPaddingBottom = 910 * scaleFaktor;

podDoorWidth = (podWidth - podWalls * 2 - podWindowPadding) / 3;
podWindowFrontWidth = (podWidth - podDoorWidth - podWalls * 2 - podWindowPadding * 2) / 2;
podWindowBackWidth = (podWidth - podWindowPadding - podWalls * 2) / 2;

podBodySnaponLength = (podLength - podWalls * 2) / 2;
podBodySnaponWidth = 2 * nozzleSize;
podBodySnaponHeight = 0.6;

podArmHeight = 4;
podArmLength = podHeight * 2 + podArmHeight * 2 + 2;
podArmWidth = podLength + podArmHeight * 2;

podHolderHeight = 4;
podHolderLength = podHeight * 2;
podHolderWidth = podLength + 2;

ringPodHolderWall = 5;
ringPodHolderRadius = ringOuterRadius - podHeight -2;
ringPodHolderRadiusInner = ringPodHolderRadius - podHolderWidth / 2;
ringBeamRadius = ringPodHolderRadius - (ringPodHolderRadius - ringPodHolderRadiusInner + ringPodHolderWall) / 2;
ringBeamLength = 20;
ringPodHolderHeight = podHolderHeight;

standHeight = ringOuterRadius + podHeight + 35;
standWall = 7;
standAngleFront = 43; // 30 each
standAngleSide = 18;

standLengthBottom = (standHeight / tan((standAngleFront / 2)) ) * 2;
standLengthBottomInner = (standHeight / tan(90 - (standAngleFront / 2)) ) * 2 - standWall * 2;
standHeightBottomInner = standLengthBottomInner / tan(standAngleFront / 2) / 2;

standWidthBottom = 0;

echo("height:", standHeight);
echo("length:", standLengthBottom);

printPodSpacing = 4;
printArmSpacing = 6;

//15PodBody();
//1PodBody();

//15PodRoof();
//1PodRoof();
  
//15PodArm();
//1PodArm();

//15PodArmEmpty();
//1PodArmEmpty();

//10RingSegments();
//1RingSegment();

//2Center();

//standTop();
//standBottom();

//stand();

//standFrontTop();
//standFrontTopMotor();
//standFrontBottom();

//4CrossBeams();

//coupling();

//modelView();
//8BaseSocket();

//baseSocket();

rotate([90 - standAngleSide, 0, 0])
wedge();

module wedge() {
// 6mm top
    wedgeLengthTop = 12;
    wedgeLengthBottom = 36;
    wedgeHeight = 30 + 2;
    wedgeWidth = 6 + 6;
    
    difference() {
        translate([0, standWall, standHeight - wedgeHeight - 15])
        rotate( [0,0,90])
        trapezoid(wedgeLengthBottom, wedgeLengthTop, wedgeHeight, wedgeWidth);
        
        translate([-wedgeLengthBottom / 2 - 1, 7, standHeight - wedgeHeight - 20])
        rotate([standAngleSide, 0, 0])
        cube([wedgeLengthBottom + 2, wedgeWidth, wedgeLengthBottom]);
        
        translate([0, standWall + 1, standHeight - 34]){
            rotate([90, 0, 0]){
                translate([0, 0, -standWall*2])
                cylinder(r=3, h=standWall * 3);
                
                translate([0, 4, -15])
                cylinder(r=10, h=standWall);
            }
        }
    }
}

module 8BaseSocket() {
    baseSocket();
    
    translate([25, 0, 0])
    baseSocket();
    
    translate([25, 25, 0])
    baseSocket();
    
    translate([0, 25, 0])
    baseSocket();
    
    
    translate([50, 0, 0])
    baseSocket();
    
    
    translate([50, 25, 0])
    baseSocket();
    
    translate([50, 50, 0])
    baseSocket();
    
    
    translate([0, 50, 0])
    baseSocket();
}

module baseSocket() {
    bottom = standWall * 2;
    cutout = standWall + 2.4;
    top = standWall + 1;
    height = 10;
    
    
    difference() {
        rotate([0, 0, 45])
        cylinder(r1 = bottom, r2 =top, h = height, $fn = 4);

        translate([-cutout / 2, -cutout / 2, 8])
        cube([cutout, cutout, height + 1]);
    }
    
}

module coupling() {
    height = 6;
    
    rotate([0, 180, 0]) {
        difference() {
            cylinder(r=6, h=height);
        
            translate([0, 0, -1])
            cylinder(r=1.5, h=height + 2);
            
            translate([0, 0, -1])
            cylinder(r=4, h=height / 2 + 1);
        }
    }
}

module 4CrossBeams() {
  crossBeams();
    
  translate([45, 0, 0])
  crossBeams();
    
  translate([0, 75, 0])
  crossBeams();
    
  translate([45, 75, 0])
  crossBeams();
    
}

module crossBeams() {
    translate([0, 0, 0]) {
        difference() {
            cube([standWall, 34, standWall]);
            
            translate([0, 34, 0])
            rotate([standAngleSide, -1, -1])
            cube([standWall + 2 , standWall + 2, standWall + 2]);
            
            rotate([0, 0, 90])
            for(i = [0 : 2]) {
                translate([5 + i * 11.5, -standWall - 1, standWall / 2])
                rotate([0 + 180 * (i % 2), 0, 90])
                triangle(standWall - 4 , standWall + 2);
            }
        }
    }
    
    translate([15, 0, 0]) {
        difference() {
            cube([standWall, 49, standWall]);
            
            translate([0, 49, 0])
            rotate([standAngleSide, -1, -1])
            cube([standWall + 2 , standWall + 2, standWall + 2]);
            
            rotate([0, 0, 90])
            for(i = [0 : 3]) {                
                translate([6 + i * 11.5, -standWall - 1, standWall / 2])
                rotate([0 + 180 * (i % 2), 0, 90])
                triangle(standWall - 4 , standWall + 2);
            }
        }
    }
    
    translate([30, 0, 0]) {
        difference() {
            cube([standWall, 64, standWall]);
            
            translate([0, 64, 0])
            rotate([standAngleSide, -1, -1])
            cube([standWall + 2 , standWall + 2, standWall + 2]);
            
            rotate([0, 0, 90])
            for(i = [0 : 4]) {
                translate([8 + i * 11.5, -standWall - 1, standWall / 2])
                rotate([0 + 180 * (i % 2), 0, 90])
                triangle(standWall - 4 , standWall + 2);
            }
        }
    }  
}

module TopMotor() {
    difference() {
        standFront();
        
        translate([0, standWall + 1, standHeight - 34]){
            rotate([90, 0, 0]){
                translate([0, 0, -20])
                cylinder(r=3, h=standWall*2);
                
                /*
                translate([0, 4, -17])
                cylinder(r=10, h=standWall);
                */
            }
        }
    }
}

module standFrontTop() {
    difference() {
        rotate([-standAngleSide - 90, 0, 0])
        standFrontTopMotor();
        
        translate([-100, -103, -82])
        cube([200,200, standWall +2 ]);
    }
}

module standFrontBottom() {
    rotate([0, 0, 90])
    difference() {
        rotate([-standAngleSide - 90, 0, 0])
        stand();
        
        translate([-100, 104 - standWall, -82])
        cube([200,200, standWall +20 ]);
    }
}

module 2Center() {
    center();
    
    translate([40, 0, 0])
    center();
}

module center() {
    innerRadius = 4;
    centerRadius = innerRadius + 14;
    height = 3;
    
    difference() {
        cylinder(r=centerRadius, h=height);
        
        translate([0, 0, -1])
        cylinder(r=innerRadius, h=height + 2);
        
        for(i = [1 : 30]) {
            x = (centerRadius - 2.4) * cos(i * 12);
            y = (centerRadius - 2.4) * sin(i * 12);
            
            translate([x, y, -1])
            cylinder(r=0.8, h=3 + 2);
        }
    }
}

module standBottom() {
    rotate([90, 0, 90])
    difference() {
        stand();
        
        translate([-standLengthBottom / 2, -1, -1 + 116])
        cube([standLengthBottom + 30, standWall + 2 , 116]);
    }  
}

module standTop() {
    rotate([90, 0, 0])
    difference() {
        standBack();
        
        translate([-standLengthBottom / 2, -1, -1])
        cube([standLengthBottom + 30, standWall + 2 , 116]);
    }
}

module standSideCutouts() {
    translate([83, 4.5, 0])
    rotate([0, -standAngleFront/2,0])
    for(i = [0 : 2]) {
        if(i != 0) {
            translate([0, -1, i * 10.5])
            rotate([90 + 180 * (i % 2), 0, 0])
            triangle(standWall - 4 , standWall + 2);
        }
    }
    
    
    translate([83, 4.5, 0])
    rotate([0, -standAngleFront/2,0])
    for(i = [4 : 7]) {
        if(i != 0) {
            translate([0, -1, -3 + i * 10.5])
            rotate([90 + 180 * (i % 2), 0, 0])
            triangle(standWall - 4 , standWall + 2);
        }
    }
    
    translate([83, 4.5, 0])
    rotate([0, -standAngleFront/2,0])
    for(i = [8 : 11]) {
        if(i != 0) {
            translate([0, -1, 3 + i * 10.5])
            rotate([90 + 180 * (i % 2), 0, 0])
            triangle(standWall - 4 , standWall + 2);
        }
    }
    
    
    translate([83, 4.5, 0])
    rotate([0, -standAngleFront/2,0])
    for(i = [13 : 18]) {
        if(i != 0) {
            translate([0, -1, i * 10.5])
            rotate([90 + 180 * (i % 2), 0, 0])
            triangle(standWall - 4 , standWall + 2);
        }
    }
}

module standBase() {    
    difference() {
        intersection() {
            translate([-standLengthBottom / 2, 0, 0])
            cube([standLengthBottom, standWall, standHeight]);
            
            translate([0, 0, standHeight])
            rotate([0, 90 + standAngleFront / 2, 0])
            cube([standLengthBottom, standWall, standHeight]);
            
            translate([0, standWall, standHeight])
            rotate([0, 90 + standAngleFront / 2, 180])
            cube([standLengthBottom, standWall, standHeight]);
        }
        
        translate([0, -1, -1])
        intersection() {
            translate([-standLengthBottomInner / 2, 0, 0])
            cube([standLengthBottomInner, standWall + 2, standHeightBottomInner]);
            
            translate([0, 0, standHeightBottomInner])
            rotate([0, 90 + standAngleFront / 2, 0])
            cube([standLengthBottomInner * 2, standWall + 2, standHeightBottomInner]);
            
            translate([0, standWall + 2, standHeightBottomInner])
            rotate([0, 90 + standAngleFront / 2, 180])
            cube([standLengthBottomInner * 2, standWall + 2, standHeightBottomInner]);
        }
        
        translate([-10, -1, standHeight - 15])
        cube([20, standWall + 2, 20]);
        
        standSideCutouts();
        
        mirror([1, 0, 0])
        standSideCutouts();
    }
    
    difference() {
        beamLength1 = 154;
        translate([-beamLength1 / 2, 0, 25])
        cube([beamLength1, standWall, standWall]);
        
        for(i = [-6 : 6]) {
            if(i != 0) {
                translate([0 + i * 10.5, - 1, 25 + standWall / 2])
                rotate([0 + 180 * (i % 2), 0, 90])
                triangle(standWall - 4 , standWall + 2);
            }
        }
    }
    
    difference() {
        beamLength2 = 120;
        translate([-beamLength2 / 2, 0, 70])
        cube([beamLength2, standWall, standWall]);

        for(i = [-4 : 4]) {
            if(i != 0) {
                translate([0 + i * 11.5, - 1, 70 + standWall / 2])
                rotate([0 + 180 * (i % 2), 0, 90])
                triangle(standWall - 4 , standWall + 2);
            }
        }
    }
    
    difference() {
        beamLength3 = 80;
        translate([-beamLength3 / 2, 0, 115])
        cube([beamLength3, standWall, standWall]);

        for(i = [-3 : 3]) {
            if(i != 0) {
                translate([0 + i * 10.5, - 1, 115 + standWall / 2])
                rotate([0 + 180 * (i % 2), 0, 90])
                triangle(standWall - 4 , standWall + 2);
            }
        }
    }
    
    closerLengthTop = 12;
    closerLengthBottom = 36;
    closerHeight = 30;
    
    translate([0, 0, standHeight - closerHeight - 17])
    rotate([0, 0, 90])
    trapezoid(closerLengthBottom, closerLengthTop, closerHeight, standWall);
}

module standBack() {
    difference() {
        standBase();
        
        translate([0, standWall + 1, standHeight - 34]){
            rotate([90, 0, 0]){
                cylinder(r=5, h=standWall + 2);
                
                translate([0, 0, -standWall + standWall - 2])
                cylinder(r=11.2, h=standWall + 1);
            }
        }
    }
}

module standFront() {
    bridgeLengthTop = 12;
    bridgeLengthBottom = 36;
    bridgeHeight = 30 + 2;
    
    difference() {
        union() {
            translate([0, standWall, standHeight - bridgeHeight - 15])
            rotate( [0,0,90])
            trapezoid(bridgeLengthBottom, bridgeLengthTop, bridgeHeight, standWall * 2);
            
            standFrontBase();
        }
        
        translate([-standLengthBottom / 8, standWall + 79, 0])
        rotate([standAngleSide, 0, 0])
        cube([standLengthBottom / 4, standWall * 3, standHeight + 30]);
        
        translate([0, standWall + 1, standHeight - 34]){
            rotate([90, 0, 0]){
                translate([0, 0, -10])
                cylinder(r=8, h=standWall + 2);
                
                translate([0, 0, -3])
                cylinder(r=11.2, h=standWall);
            }
        }
    }
}

module standFrontSideCutouts() {
    translate([83, 4.5, 0])
    rotate([0, -standAngleFront/2,0])
    for(i = [0 : 2]) {
        if(i != 0) {
            translate([0, -1, -10 + i * 10.5])
            rotate([90 + 180 * (i % 2), 0, 0])
            triangle(standWall - 4 , standWall + 2);
        }
    }
    
    
    translate([83, 4.5, 0])
    rotate([0, -standAngleFront/2,0])
    for(i = [3 : 6]) {
        if(i != 0) {
            translate([0, -1, 2 + i * 10.5])
            rotate([90 + 180 * (i % 2), 0, 0])
            triangle(standWall - 4 , standWall + 2);
        }
    }
    
    translate([83, 4.5, 0])
    rotate([0, -standAngleFront/2,0])
    for(i = [8 : 11]) {
        if(i != 0) {
            translate([0, -1, 0 + i * 10.5])
            rotate([90 + 180 * (i % 2), 0, 0])
            triangle(standWall - 4 , standWall + 2);
        }
    }
    
    
    translate([83, 4.5, 0])
    rotate([0, -standAngleFront/2,0])
    for(i = [13 : 18]) {
        if(i != 0) {
            translate([0, -1, i * 10.5])
            rotate([90 + 180 * (i % 2), 0, 0])
            triangle(standWall - 4 , standWall + 2);
        }
    }
}


module standFrontBase() {
    difference() {
        translate([0, 76, 8])
        //rotate([0, 0, 0]) {
        rotate([standAngleSide, 0, 0]) {
            difference() {
                intersection() {
                    translate([-standLengthBottom / 2 - 15, 0, -30])
                    cube([standLengthBottom + 30, standWall, standHeight + 30]);
                    
                    translate([0, 0, standHeight])
                    rotate([0, 90 + standAngleFront / 2, 0])
                    cube([standLengthBottom + 30, standWall, standHeight + 30]);
                    
                    translate([0, standWall, standHeight])
                    rotate([0, 90 + standAngleFront / 2, 180])
                    cube([standLengthBottom + 30, standWall, standHeight + 30]);
                }
                
                translate([0, -1, -1])
                intersection() {
                    translate([-standLengthBottomInner - 15, 0, -30])
                    cube([standLengthBottomInner * 2 + 30, standWall + 2, standHeightBottomInner + 30]);
                    
                    translate([0, 0, standHeightBottomInner])
                    rotate([0, 90 + standAngleFront / 2, 0])
                    cube([standLengthBottomInner * 2 + 30, standWall + 2, standHeightBottomInner + 30]);
                    
                    translate([0, standWall + 2, standHeightBottomInner])
                    rotate([0, 90 + standAngleFront / 2, 180])
                    cube([standLengthBottomInner * 2 + 30, standWall + 2, standHeightBottomInner + 30]);
                }
                
                translate([-10, -1, standHeight - 15])
                cube([20, standWall + 2, 20]);
                
                standFrontSideCutouts();
                
                mirror(0,1,0)
                standFrontSideCutouts();
            }
            
            difference() {
                beamLength1 = 160;
                translate([-beamLength1 / 2, 0, 19])
                cube([beamLength1, standWall, standWall]);

                for(i = [-7 : 7]) {
                    if(i != 0) {
                        translate([0 + i * 10, - 1, 19 + standWall / 2])
                        rotate([0 + 180 * (i % 2), 0, 90])
                        triangle(standWall - 4 , standWall + 2);
                    }
                }                
            }
            
            difference() {
                beamLength2 = 120;
                translate([-beamLength2 / 2, 0, 66])
                cube([beamLength2, standWall, standWall]);
                
                for(i = [-4 : 4]) {
                    if(i != 0) {
                        translate([0 + i * 12, - 1, 66 + standWall / 2])
                        rotate([0 + 180 * (i % 2), 0, 90])
                        triangle(standWall - 4 , standWall + 2);
                    }
                }
            }

            difference() {
                beamLength3 = 80;
                translate([-beamLength3 / 2, 0, 113])
                cube([beamLength3, standWall, standWall]);
                
                for(i = [-3 : 3]) {
                    if(i != 0) {
                        translate([0 + i * 10.5, - 1, 113 + standWall / 2])
                        rotate([0 + 180 * (i % 2), 0, 90])
                        triangle(standWall - 4 , standWall + 2);
                    }
                }
            }
            
            closerLengthTop = 12;
            closerLengthBottom = 36;
            closerHeight = 30;
            
            translate([0, 0, standHeight - closerHeight - 17])
            //rotate([0, standAngleSide, 90])
            rotate([0, 0, 90])
            trapezoid(closerLengthBottom, closerLengthTop, closerHeight, standWall);
        }
        
        translate([-standLengthBottom / 2 - 30, 0, -standWall * 5])
        cube([standLengthBottom + 60, 100, standWall * 5]);
        
        translate([-standLengthBottom / 2 - 30, -standWall, 0])
        cube([standLengthBottom + 60, standWall * 2, standHeight]);
        
        /*
        translate([-standLengthBottom / 2 - 30, 74 + standWall, 0])
        rotate([standAngleSide, 0, 0])
        cube([standLengthBottom + 60, standWall * 2, standHeight]);
        */
    }
}
    
module stand() {
    //standBack();
    standFront();
}


module 1RingSegment() {
    ringNew();
}

module 10RingSegments() {
    translate([-115, -10, 0]){
        for(k = [0 : 1]) {
            translate([0, 75 * k, 0])
            for(i = [0 : 4]) {
                translate([32 * i, 0, 0])
                ringNew();
            }
        }
    }
}

module rings() {
    intersection() {
        cylinder(r=ringPodHolderRadius, h=ringPodHolderHeight, $fn=30);
    
        // Those cubes describe the intersecting area
        cube([ringPodHolderRadius,ringPodHolderRadius,ringPodHolderHeight]);
        
        rotate([0, 0, -45])
        cube([ringPodHolderRadius,ringPodHolderRadius,ringPodHolderHeight]);
       
        translate([0, -ringPodHolderHeight / 2, 0])
        rotate([0, 0, 6]) 
        cube([ringPodHolderRadius,ringPodHolderRadius,ringPodHolderHeight]);
        
        translate([0, -ringPodHolderHeight / 2, 0])
        rotate([0, 0, -60]) 
        cube([ringPodHolderRadius,ringPodHolderRadius,ringPodHolderHeight]);
        
        union() {
            // Outer Ring
            difference() {
                innerRadius = ringPodHolderRadius - ringPodHolderWall;
                
                cylinder(r=ringPodHolderRadius, h=ringPodHolderHeight, $fn=30);

                translate([0, 0, -1])
                cylinder(r=innerRadius, h=ringPodHolderHeight + 2, $fn=30);
                
                if(enableCutouts) {
                    // Outer triangles
                    translate([0, 0, ringPodHolderHeight / 2])
                    for(j = [56 : 59]) {
                        rotate([-2 + j * 360 / 60, 90, 0])
                        for ( i = [0 : 2 : 2] ) {
                            x = (ringPodHolderRadius - ringPodHolderWall / 2) * cos(i);
                            y = (ringPodHolderRadius - ringPodHolderWall / 2) * sin(i);
                            
                            translate([0, y, x])
                            rotate([i * -1, 0, 0])
                            rotate([0, 90 + 180 * (i/2 % 2), 0])
                            triangleCentered(podArmHeight - 1.5 , ringPodHolderWall + 2);
                        }
                    }
                }
            }
            
            // InnerRing
            difference() {
                innerRadius = ringPodHolderRadiusInner - ringPodHolderWall;
            
                cylinder(r=ringPodHolderRadiusInner, h=ringPodHolderHeight, $fn=30);
                            
                translate([0, 0, -1])
                cylinder(r=innerRadius, h=ringPodHolderHeight + 2, $fn=30);
                           
                if(enableCutouts) {
                    // Inner triangles
                    translate([0, 0, podArmHeight / 2])
                    for(j = [56 : 59]) {
                        rotate([-3 + j * 360 / 60, 90, 0])
                        for ( i = [0 : 2 : 0] ) {
                            x = (ringPodHolderRadiusInner - ringPodHolderWall / 2) * cos(i);
                            y = (ringPodHolderRadiusInner - ringPodHolderWall / 2) * sin(i);
                            
                            translate([0, y, x])
                            rotate([i * -1, 0, 0])
                            rotate([0, 90 + 180 * (i/2 % 2), 0])
                            triangleCentered(podArmHeight - 1.5 , ringPodHolderWall + 2);
                        }
                    }
                }
            }
        }
    }    
}

module ringNew() {
    difference() {
        union() {
            rings();
            
            // The beams
            translate([0, 0, ringPodHolderHeight])
            rotate([0, 90, 0])
            for(i = [6 : 6 : 25]) {
                x = ringBeamRadius * cos(i);
                y = ringBeamRadius * sin(i);
                
                translate([0, y, x]) {
                    rotate([i * -1, 0, 0])
                        beam(4,4,20);   
                }
            }
            
            // The hangers
            translate([0, 0, ringPodHolderHeight])
            rotate([0, 90, 0])
            for(i = [12 : 12 : 30]) {
                x = (ringPodHolderRadiusInner - ringPodHolderWall) * cos(i);
                y = (ringPodHolderRadiusInner - ringPodHolderWall) * sin(i);
                
                translate([0, y, x]) {
                    rotate([i * -1, 0, 0])
                        hanger();
                }
            }
            
            // Pod arm trapezoid
            translate([0, 0, ringPodHolderHeight / 2])
            rotate([0, 90, 0])
            for(i = [12 : 12 : 30] ) {
                x = (ringPodHolderRadius - 1) * cos(i);
                y = (ringPodHolderRadius - 1) * sin(i);
                
                translate([0, y, x]) {
                    rotate([i * -1, 0, 0])
                        trapezoid(8, 4, 2.7, 2);
                }
            }
        }
        
        
        // Cutouts for the pod arms
        translate([0, 0, ringPodHolderHeight / 2])
        rotate([0, 90, 0])
        for ( i = [12 : 12 : 30] ) {
            x = ringOuterRadius * cos(i);
            y = ringOuterRadius * sin(i);
            
            translate([-podArmLength / 2, y, x]) {
                rotate([i * -1, 0, 0])
                    podArmCutout();
            }
        }   
    }
}

module beam(length, width, height) {
    translate([0, -length / 2, -height / 2])
    difference() {
        cube([length, width, height]);
        
        if(enableCutouts) {
            for(i = [0 : 2]) {
                translate([-1, podArmHeight / 2, 6 + i * 3.8])
                rotate([90 + 180 * (i % 2), 0, 0])
                triangle(podArmHeight - 1.5 , width + 2);
            }
        }
    }
}

module modelView() {
    //translate([podHolderLength / 2 +1,0,0])
    
    rotate([0, -90, 0])
    for(i = [0 : 14]) {
        rotate([0, 0, 24 * i])
        ringNew();
    }
    
    /*
    //for ( i = [0 : 96 : 360] ) {
    for ( i = [0 : 12 : 360] ) {
        x = ringOuterRadius * cos(i);
        y = ringOuterRadius * sin(i);
        
        translate([0, y, x]) {
            if(i % 24 == 0) {
                rotate([i * -1, 0, 0])
                    podArm();
                pod();
            }
            else {
                rotate([i * -1, 0, 0])
                    podArmEmpty();
            }
            
        }
    }
    */
}

// Obsolete
module ring() {
    difference() {
        union() {
            rotate([0,90,0]) {
                difference() {
                    cylinder(r=ringPodHolderRadius, h=ringPodHolderHeight, $fn=30);
                    
                    translate([0, 0, -1])
                    cylinder(r=ringPodHolderRadius - ringPodHolderWall, h=ringPodHolderHeight + 2, $fn=30);
                       
                    translate([0, 0, podArmHeight / 2])
                    for(j = [0 : 60]) {
                        rotate([-2 + j * 360 / 60, 90, 0])
                        for ( i = [0 : 2 : 2] ) {
                            x = (ringPodHolderRadius - ringPodHolderWall / 2) * cos(i);
                            y = (ringPodHolderRadius - ringPodHolderWall / 2) * sin(i);
                            
                            translate([0, y, x]) {
                                    rotate([i * -1, 0, 0])
                                        rotate([0, 90 + 180 * (i/2 % 2), 0])
                                            triangleCentered(podArmHeight - 1.5 , ringPodHolderWall + 2);
                            }
                        }
                    }
                }
                
                difference() {
                    cylinder(r=ringPodHolderRadiusInner, h=ringPodHolderHeight, $fn=30);
                    
                    translate([0, 0, -1])
                        cylinder(r=ringPodHolderRadiusInner - ringPodHolderWall, h=ringPodHolderHeight + 2, $fn=30);
                    
                    translate([0, 0, podArmHeight / 2])
                    for(j = [0 : 60]) {
                        rotate([-3 + j * 360 / 60, 90, 0])
                        for ( i = [0 : 2 : 0] ) {
                            x = (ringPodHolderRadiusInner - ringPodHolderWall / 2) * cos(i);
                            y = (ringPodHolderRadiusInner - ringPodHolderWall / 2) * sin(i);
                            
                            translate([0, y, x]) {
                                    rotate([i * -1, 0, 0])
                                        rotate([0, 90 + 180 * (i/2 % 2), 0])
                                            triangleCentered(podArmHeight - 1.5 , ringPodHolderWall + 2);
                            }
                        }
                    }
                }
            }
            
            for ( i = [0 : 12 : 360] ) {
                x = (ringPodHolderRadius - 1) * cos(i);
                y = (ringPodHolderRadius - 1) * sin(i);
                
                translate([0, y, x]) {
                    rotate([i * -1, 0, 0])
                        trapezoid(8, 4, 2.7, 4);
                }
            }
            
            for ( i = [0 : 12 : 360] ) {
                x = (ringPodHolderRadiusInner - ringPodHolderWall) * cos(i);
                y = (ringPodHolderRadiusInner - ringPodHolderWall) * sin(i);
                
                translate([0, y, x]) {
                    rotate([i * -1, 0, 0])
                        hanger();
                }
            }
            
            for ( i = [0 : 6 : 360] ) {
                x = ringBeamRadius * cos(i);
                y = ringBeamRadius * sin(i);
                
                translate([0, y, x]) {
                    rotate([i * -1, 0, 0])
                        beam(4,4,20);
                    
                }
            }
        }
        
        for ( i = [0 : 12 : 360] ) {
            x = ringOuterRadius * cos(i);
            y = ringOuterRadius * sin(i);
            
            translate([-podArmLength / 2 + 2, y, x]) {
                rotate([i * -1, 0, 0])
                    podArmCutout();
            }
        }
    }
}

module 1PodBody() {
    podBody();
}

module 15PodBody() {
    for(i = [0 : 4]) {
        for(j = [0 : 2]) {
            translate([(podLength + printPodSpacing) * j, (podWidth + printPodSpacing) * i, 0])
                podBody();
        }
        
    }
}

module 1PodRoof() {
    podRoof();
}

module 15PodRoof() {
    for(i = [0 : 4]) {
        for(j = [0 : 2]) {
            translate([(podLength + printPodSpacing) * j, (podWidth + printPodSpacing) * i, 0])
                podRoof();
        }
        
    }
}

module 1PodArm() {
    rotate([90, 0, 0])
    podArm();
}

module 15PodArm() {
    rotate([90, 0, 0]) {
        for(j = [0 : 2]) {
            translate([0, 0, (-podArmWidth - printArmSpacing * 2) * j]) {
                translate([podArmLength/2, 0, 0])
                for(i = [0 : 2]) {
                    translate([i * (podArmLength + printArmSpacing), 0, 0])
                    podArm();
                }
                
                translate([podArmLength + printArmSpacing / 2, 0, -68])
                rotate([0, 180, 0])
                for(i = [0 : 1]) {
                    translate([(-podArmLength - printArmSpacing) * i, 0, 0])
                    podArm();
                }
            }
        }
    }

}

module 1PodArmEmpty() {
    rotate([90, 0, 0])
    podArmEmpty();
}

module 15PodArmEmpty() {
    rotate([0, 0, 0]) {
        for(j = [0 : 2]) {
            translate([0, 0, (-podArmWidth - printArmSpacing * 2) * j]) {
                translate([podArmLength/2, 0, 0])
                for(i = [0 : 2]) {
                    translate([i * (podArmLength + printArmSpacing), 0, 0])
                    podArmEmpty();
                }
                
                translate([podArmLength + printArmSpacing / 2, 0, -68])
                rotate([0, 180, 0])
                for(i = [0 : 1]) {
                    translate([(-podArmLength - printArmSpacing) * i, 0, 0])
                    podArmEmpty();
                }
            }
        }
    }

}

module podArm() {    
    rotate([-90, 0, 0]) {
        podArmBase();
                
        translate([-podHolderLength / 2 -1, 0, 0])
            rotate([0, 90, 0])
                cylinder(h=2, r1=1.5, r2=0, $fn=360);
            
        translate([podHolderLength / 2 + 1, 0, 0])
            rotate([0, -90, 0])
                cylinder(h=2, r1=1.5, r2=0, $fn=360);
    }
}

module podArmEmpty() {
    rotate([-90, 0, 0]) {
        difference() {
            podArmBase();
                
            translate([-podHolderLength / 2 - podHolderHeight - 2, 0, 0])
                rotate([0, 90, 0])
                    cylinder(h=podHolderHeight + 2, r=0.8, $fn=360);
                
            translate([podHolderLength / 2 + podHolderHeight + 2, 0, 0])
                rotate([0, -90, 0])
                    cylinder(h=podHolderHeight + 2, r=0.8, $fn=360);
        }
    }
}

module podArmBase() {
    translate([-podArmLength / 2, -podArmHeight / 2, -podArmHeight / 2]) {
        difference() {
            cube([podArmLength, podArmWidth, podArmHeight]);
            
            translate([podArmHeight, -1, -1])
                cube([podArmLength - podArmHeight * 2, podHeight + 4 + 1, podHeight + 2]);
            
            translate([podArmLength / 2 + podArmHeight / 2, podHeight + 4 + podArmHeight, -1])
                cube([podArmLength, podArmWidth - podArmHeight * 4 - podHeight + 4, podArmHeight + 2]);
            
            translate([-podArmLength / 2 - podArmHeight / 2, podHeight + 4 + podArmHeight, -1])
                cube([podArmLength, podArmWidth - podArmHeight * 4 - podHeight + 4, podArmHeight + 2]);
            
            translate([-podArmHeight / 2, podArmWidth / 2 - 2, -1])
                cube([podArmHeight, podArmWidth, podArmHeight + 2]);
            
            translate([podArmLength - podArmHeight / 2, podArmWidth / 2 - 2, -1])
                cube([podArmHeight, podArmWidth, podArmHeight + 2]);
            
            for(i = [0 : 4]) {
                translate([-1, 5.5 + i * 3, podArmHeight / 2])
                    rotate([180 * (i % 2), 0, 0])
                        triangle(podArmHeight - 1.5 , podArmLength + 2);
            }
            
            for(i = [0 : 3]) {
                translate([-1, podArmWidth - podHeight + 1.5 + i * 3, podArmHeight / 2])
                    rotate([180 * (i % 2), 0, 0])
                        triangle(podArmHeight - 1.5 , podArmLength + 2);
            }
            
            for(j = [0 : 4]) {
                translate([6.3 + 3 * j, podArmWidth + 1, podArmHeight / 2])
                    rotate([180 * (j % 2), 0, -90])
                        triangle(podArmHeight - 1.5 , podArmWidth + 2);
            }
            
            for(j = [0 : 4]) {
                translate([podArmLength / 2 + 4.3 + 3 * j, podArmWidth + 1, podArmHeight / 2])
                    rotate([180 * (j % 2), 0, -90])
                        triangle(podArmHeight - 1.5 , podArmWidth + 2);
            }
        }
    }
}

module podArmCutout() {
    padding = 0.2;
    
    rotate([-90, 0, 0]) {
        translate([-podArmLength / 2, -podArmHeight / 2, -podArmHeight / 2 - padding / 2]) {
            difference() {
                cube([podArmLength, podArmWidth + padding / 2, podArmHeight + padding]);
                
                translate([podArmLength / 2 + podArmHeight / 2, podHeight + 4 + podArmHeight + padding / 2, -1])
                    cube([podArmLength, podArmWidth - podArmHeight * 4 - podHeight + 4 - padding, podArmHeight + 2]);
                
                translate([-podArmLength / 2 - podArmHeight / 2, podHeight + 4 + podArmHeight + padding / 2, -1])
                    cube([podArmLength, podArmWidth - podArmHeight * 4 - podHeight + 4 - padding, podArmHeight + 2]);
            }
        }
    }
}

module hanger() {
    rotate([180, 0, 0]) {
        difference() {
            trapezoid(8, 2, 4, 4);
            
            translate([-1, 0, 2])
                rotate([0, 90, 0])
                    cylinder(r=0.8, h=4 + 2);
        }
    }
}

module trapezoid(lengthBottom, lengthTop, height, depth) {
    topDelta = (lengthBottom - lengthTop) / 2;
    
    translate([0, -lengthBottom / 2, 0])
    polyhedron(
        points = [
            [0, 0, 0],
            [0, lengthBottom, 0],
            [depth, lengthBottom, 0],
            [depth, 0, 0],
    
            [0, topDelta, height],
            [0, topDelta + lengthTop, height],
            [depth, topDelta, height],
            [depth, topDelta + lengthTop, height],
        ],
        faces = [
            [2, 1, 0],
            [3, 2, 0],
    
            [4, 0, 1],
            [5, 4, 1],
    
            [2, 3, 6],
            [6, 7, 2],
            
            [4, 5, 6],
            [7, 6, 5],
            
            [4, 3, 0],
            [6, 3, 4],
            
            [1, 2, 5],
            [7, 5, 2]
        ]
    );
}

module triangleCentered(height, depth) {
    translate([-depth / 2, 0, 0])
        triangle(height, depth);
}

module triangle(height, depth) {
    side = sqrt(height * height + height * height / 4);
    
    translate([0, -side / 2, -height / 2])
        polyhedron(
            points = [
                [0, 0, 0],
                [0, side, 0],
                [depth, side, 0],
                [depth, 0, 0],
                [0, side/2,  height],
                [depth, side/2, height],
        
            ],
            faces = [
                [2, 1, 0],
                [3, 2, 0],
                
                [3, 0, 4],
                [4, 5, 3],
                
                [1, 2, 4],
                [2, 5, 4],
                
                [2, 3, 5],
                [0, 1, 4]
                
            ]
        );
}

module pod() {
    translate([-podLength / 2, -podWidth/2, -podHeight + 1.8]) {
        podBody();
    
        translate([0, 0, -3.4])
            podRoof();
    }
}

module podRoof() {
    difference() {
        union() {
            
            translate([0, -nozzleSize, podHeight - 0.4])
                cube([podLength, podWidth + nozzleSize * 2, 0.8]);
            
            translate([0, podWidth / 2, podHeight - 9.5])
                rotate([0, 90, 0])
                    cylinder(r=(podWidth + podWalls) / 2 + 3 + podWalls / 2, h=podLength);

        }

        translate([-1, -nozzleSize * 4, podHeight / 2])
            cube([podLength + 2, nozzleSize * 3, podHeight]);
        
        translate([-1, podWidth + nozzleSize * 1, podHeight / 2])
            cube([podLength + 2, nozzleSize * 3, podHeight]);

        translate([-1, -podWidth / 2, -podHeight - 0.4])
            cube([podLength + podWalls + 2, podWidth*2, podHeight *2]);
      
        translate([-podWalls +1, podWidth / 2, podHeight + 1.4])
            rotate([0, 90, 0])
                cylinder(r=1, h=podLength + 2);
    }
}

module podBody() {
    difference() {
         cube([podLength, podWidth, podHeight - 3.8]);
        
        // Inner part
        translate([podWalls, podWalls, podFloorHeight])
            cube([podLength - podWalls * 2, podWidth - podWalls * 2, podHeight]);
        
        // Windows
        translate([podLength / 2 - podWindowLength - podWindowPadding / 2, -1, podWindowPaddingBottom])
            cube([podWindowLength, podWidth + 2, podWindowHeight]);
        translate([podLength / 2 - podWindowLength * 2 - podWindowPadding * 1.5, -1, podWindowPaddingBottom])
            cube([podWindowLength, podWidth + 2, podWindowHeight]);
        translate([podLength / 2 + podWindowPadding / 2, -1, podWindowPaddingBottom])
            cube([podWindowLength, podWidth + 2, podWindowHeight]);
        translate([podLength / 2 + podWindowPadding * 1.5 + podWindowLength, -1, podWindowPaddingBottom])
            cube([podWindowLength, podWidth + 2, podWindowHeight]);
            
        // Window back
        translate([-1, podWidth - podWindowBackWidth - podWalls, podWindowPaddingBottom])
            cube([podWalls + 2, podWindowBackWidth, podWindowHeight]);
        translate([-1, podWalls, podWindowPaddingBottom])
            cube([podWalls + 2, podWindowBackWidth, podWindowHeight]);
            
        // Door front
        translate([podLength - podWalls - 1, (podWidth - podDoorWidth) / 2, podWindowPaddingBottom])
            cube([podWalls + 2, podDoorWidth, podWindowHeight]);
        translate([podLength - nozzleSize, (podWidth - podDoorWidth - podWalls / 2) / 2, podFloorHeight])
            cube([podWalls / 2 +1, podDoorWidth + podWalls / 2, podWindowHeight + podWindowPaddingBottom - podFloorHeight]);
            
        // Windows front
        translate([podLength - podWalls - 1, podWalls, podWindowPaddingBottom])
            cube([podWalls + 2, podWindowFrontWidth, podWindowHeight]);
        translate([podLength - podWalls - 1, podWidth - podWalls - podWindowFrontWidth, podWindowPaddingBottom])
            cube([podWalls + 2, podWindowFrontWidth, podWindowHeight]);
    }
}

