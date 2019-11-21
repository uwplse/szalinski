$fn=150;

catchLip=8;
catchClearance=.3;
catchHeight=15; // don't include any tolerance 
catchToCatch=14.9;
catchTravel=4.7;
centerRibWidth=2.2;
crossbar1Width=centerRibWidth;
flexFilletR=1;
glideLength=15;
glidePivotSeparation=2;
glidePlateThickness=2;
glideRadius=2;
glideSideWidth=2;
glideThickness=7;
glideWidth=25;
maleProfileRadius=1;
maleProfileWidth=24.8;
pivotGuideSlot=3;
pivotCoverClearance=.2;

color("red")
    maleBuckle();

color("yellow")
    pivotCover();

color("blue")
    pivotGuide();

module fillet(r,Length){
    difference(){
        translate([-.01,-.01,0])
            cube([r+.01,r+.01,Length]);
        translate([r,r,-1])
            cylinder(h=Length+2, r=r);
    };
}

module flexNeg(){
    difference(){
        translate([centerRibWidth/2,-5,0]){
            cube([catchToCatch/2-centerRibWidth/2,10,catchHeight]);
            translate([0,0,catchHeight])
                cube([catchTravel,10,99]);
        }
        translate([catchToCatch/2,5,0])
            rotate(a=[90,-90,0])
                fillet(flexFilletR,10);
    }
}

module glide(addon){
    difference(){
        union(){
            mirror([0,addon,0]){
                // sides
                glideSide();
                mirror([1,0,0])
                    glideSide();
            }
            
            // crossbar 2
            translate([(glideWidth-2*glideSideWidth)/2,glideThickness/2-3.5,-9.2])
                rotate(a=[0,-90,0])
                    linear_extrude(height=glideWidth-2*glideSideWidth)
                        polygon([
                            [1.7,0],
                            [5.4,1.2],
                            [5.4,3],
                            [1,3],
                            [0,1.3]    
                        ]);
                        
            // crossbar 3
            translate([(glideWidth-2*glideSideWidth)/2,-glideThickness/2,-glideLength])
                rotate(a=[0,-90,0])
                    linear_extrude(height=glideWidth-2*glideSideWidth)
                        polygon([
                            [0,0],
                            [0,3],
                            [4.7,0]
                        ]);
        }
    }  
}

module glideSide(){
    difference(){
        translate([glideWidth/2-glideSideWidth,-glideThickness/2,-glideLength])
            cube([glideSideWidth,glideThickness+glidePivotSeparation,glideLength]);
        translate([glideWidth/2,glideThickness/2+glidePivotSeparation,-glideLength-1])
            rotate(a=[0,0,-180])
                fillet(glideRadius,glideLength+2);
        translate([glideWidth/2,-glideThickness/2,-glideLength-1]) 
            rotate(a=[0,0,90])
                fillet(glideRadius,glideLength+2);
        translate([-glideWidth/2,glideThickness/2+glidePivotSeparation,-glideLength-1])
            rotate(a=[0,0,-90])
                fillet(glideRadius,glideLength+2);
        translate([-glideWidth/2,-glideThickness/2,-glideLength-1]) 
            rotate(a=[0,0,0])
                fillet(glideRadius,glideLength+2);  
   }
}

module keyhole(keyholeD1,keyholeD2,keyholePassage,height){
    tanX=keyholeD1/2+keyholePassage/2;
    tanY=sqrt(pow(keyholeD1,2)-pow(tanX,2));
    //tanX2=(keyholeD1/2+keyholeD2/2)/2+keyholePassage/2;
    tanY2=sqrt(pow((keyholeD1/2+keyholeD2/2),2)-pow(tanX,2));

    linear_extrude(height=height){
        difference(){
            union(){
                circle(d=keyholeD1);
                polygon([
                    [0,0],
                    [tanX/2,-tanY/2],
                    [tanX*(keyholeD2/(keyholeD1+keyholeD2)),-tanY-keyholeD1/2],
                    [-tanX*(keyholeD2/(keyholeD1+keyholeD2)),-tanY-keyholeD1/2],
                    [-tanX/2,-tanY/2]
                ]);
                translate([0,-tanY2-tanY])
                    circle(d=keyholeD2);
            };
            translate([tanX,-tanY,0])
                circle(d=keyholeD1);
            translate([-tanX,-tanY,0])
                circle(d=keyholeD1);

        };
    };  
};    

module maleBuckle(){
    difference(){
        union(){
            // bottom tapered part
            linear_extrude(height=8.1,scale=[.88,1]) //heigh was 2.6 before, I think
                maleProfile();
            // straight part
            translate([0,0,catchLip])
                scale([.88,1,1])
                    linear_extrude(height=catchHeight,scale=.92)
                        maleProfile();
            // clip part
            difference(){
                translate([0,0,catchLip+catchClearance])
                    linear_extrude(height=catchHeight-catchClearance,scale=.92)
                        maleProfile();
                translate([0,0,catchLip+catchClearance])
                    scale([maleProfileWidth/2,10,(maleProfileWidth/2)/2.8])
                        rotate(a=[0,45,0])
                            cube(size=sqrt(2),center=true);
            }
        };

        translate([0,0,crossbar1Width]){
            flexNeg();
            mirror([1,0,0])
                flexNeg();
        };
    }
    glide();
    translate([-(glideWidth/2-glideSideWidth),-2.5,0])
        rotate(a=[-90,0,0])
            fillet(2,5);
    translate([(glideWidth/2-glideSideWidth),-2.5,0])
        rotate(a=[-90,90,0])
            fillet(2,5);
    *translate([-glideWidth/2,-glideThickness/2,-glideLength-glideSideWidth])
        linear_extrude(height=glideSideWidth){
            minkowski(){
                square([glideWidth,glideThickness+glidePivotSeparation]);
                circle(r=glideRadius);
            }
        } 
}

module maleProfile(){
    maleProfileQuarter();
    mirror([1,0,0])
        maleProfileQuarter();
    mirror([0,1,0])
        maleProfileQuarter();
    mirror([0,1,0])
        mirror([1,0,0])
            maleProfileQuarter();
}

module maleProfileQuarter(){
    hull(){
        polygon([
            [0,2.8],
            [10,2.4],
            [maleProfileWidth/2-maleProfileRadius,maleProfileRadius],
            [maleProfileWidth/2-maleProfileRadius,0],
            [0,0]
        ]);
        translate([maleProfileWidth/2-maleProfileRadius,0,0])
            circle(r=maleProfileRadius);
    }
}

module pivotCover(){
    difference(){
        translate([-glideWidth/2,-glideThickness/2,-glideLength])
            linear_extrude(height=glideLength){
                minkowski(){
                    square([glideWidth,glideThickness+glidePivotSeparation]);
                    circle(r=glideRadius); // this needs a translate if glideRadius != glidePlateThickness
                }
            }
        translate([0,0,1]){   
            resize([glideWidth+2*pivotCoverClearance,glideThickness+glidePivotSeparation+2*pivotCoverClearance,glideLength+2]){
                translate([-glideWidth/2+glideRadius,-glideThickness/2,-glideLength])
                    cube([glideWidth-glideSideWidth*2,glideThickness+glidePivotSeparation,glideLength]);
                glideSide();
                mirror([1,0,0])
                    glideSide();
            };
        };
        // bottom opening for strap
        translate([-glideWidth/2+glideSideWidth,-glideThickness,-glideLength+3])
            cube([glideWidth-glideSideWidth*2,glideThickness,glideLength-6]);
    };
    
    // catch
    catchHeight=glideThickness/2+glidePivotSeparation+glidePlateThickness-8.5/2; // 8.5 is thickness of female buckle
    difference(){
        translate([0,glideThickness/2+glidePivotSeparation+glidePlateThickness-catchHeight/2,0])
            linear_extrude(height=glidePlateThickness)
                    square([glideWidth+2*glidePlateThickness,catchHeight],center=true);          
        translate([glideWidth/2+glidePlateThickness,glideThickness/2+glidePivotSeparation+glidePlateThickness,-1])
            rotate(a=[0,0,180])
                fillet(glideRadius,glidePlateThickness+2);
        translate([-glideWidth/2-glidePlateThickness,glideThickness/2+glidePivotSeparation+glidePlateThickness,-1])
            rotate(a=[0,0,-90])
                fillet(glideRadius,glidePlateThickness+2);
    }
   
    // keyhole pin
    translate([0,glideThickness/2+glidePivotSeparation+glidePlateThickness,-glideLength/2])
        rotate(a=[-90,0,0]){
            cylinder(d=3.9,h=1.5);
            translate([0,0,1.5])
                cylinder(d=7,h=1.5);
        }
}

// ---PIVOT GLIDE---
/*translate([glideWidth+5,0,0])
    glide(1);*/

/*
// triangular
translate([-glideWidth/2,glideThickness*2,0])
difference(){
    linear_extrude(height=1)
        offset(r=glideRadius)
            polygon([
                [glideRadius,glideRadius],
                [glideWidth-glideRadius,glideRadius],
                [glideWidth-glideRadius,pivotGuideSlot*3],
                [glideWidth/2,glideLength-glideRadius],
                [glideRadius,pivotGuideSlot*3]
            ]);
    translate([glideSideWidth,pivotGuideSlot,-.5])
        cube([glideWidth-glideSideWidth*2,pivotGuideSlot,2]);
}*/

module pivotGuide(){
    translate([0,-glideThickness,-glideLength])
        difference(){
            translate([-glideWidth/2,0,0])
                rotate(a=[90,0,0]){
                        cube([glideWidth,pivotGuideSlot,glideLength]); // plate
                        translate([0,pivotGuideSlot,0])
                            pivotGuideBrace();
                        translate([glideWidth-glideSideWidth,pivotGuideSlot,0])
                            pivotGuideBrace();
                        translate([0,2*pivotGuideSlot,glideLength/2-pivotGuideSlot/2])
                            rotate(a=[90,0,90]){
                                cube([pivotGuideSlot,pivotGuideSlot,glideWidth]);
                                translate([pivotGuideSlot/2,0,0])
                                    cylinder(h=glideWidth,d=pivotGuideSlot);
                                 translate([pivotGuideSlot/2,pivotGuideSlot,0])
                                    cylinder(h=glideWidth,d=pivotGuideSlot);       
                            };
                }
            translate([0,-glideLength/2,0]){
                keyhole(4.4,7.7,3.7,1);
                translate([0,0,1])
                    keyhole(7.7,13.5,7.3,3);    
            };
            translate([glideWidth/2,-glideLength-1,0])
                rotate(a=[90,0,-180])
                    fillet(glideRadius,glideLength+2);
            translate([glideWidth/2,-glideLength-1,3*pivotGuideSlot])
                rotate(a=[-90,90,0])
                    fillet(glideRadius,glideLength+2);
            translate([-glideWidth/2,1,0])
                rotate(a=[90,0,0])
                    fillet(glideRadius,glideLength+2);
            translate([-glideWidth/2,1,3*pivotGuideSlot]) 
                rotate(a=[90,90,0])
                    fillet(glideRadius,glideLength+2);  
        };
};

module pivotGuideBrace(){
    rotate(a=[0,90,0])
        linear_extrude(height=glideSideWidth)
            polygon([
                [0,0],
                [-glideLength/2+pivotGuideSlot/2,pivotGuideSlot*2],
                [-glideLength/2-pivotGuideSlot/2,pivotGuideSlot*2],
                [-glideLength,0]
            ]);
}