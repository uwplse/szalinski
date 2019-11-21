$fn = 96;

printLayerHeight = 0.15;

wallThickness = 1.2;
bottomPlate = 0.9;

height = 7;
crossHeight = height*1.2;
width = 20;
length = 60;

cableHeight = 3.3;
cableWidth = 6; 

screwHeadRad = 4;
screwHeadHeight = 4; 

guideHeight = height *1.2;
guideWidth = 1.2;

moveDistance = 0.2;

hingePinRadius = 0.8;
hingePinLength = 1.6;
hingeNuckleInnerRadius = hingePinRadius * 1.5;
hingeNuckleOuterRadius = hingeNuckleInnerRadius * 1.5;

hingeWidth = 2.4;
hingeNuckleLength = hingePinLength + moveDistance;
hingeAngle = 18;

innerWallThickness = 1.2;

insetHinge = wallThickness+0.1;

supportWidth = 0.4;
supportZdistance = 0.05;

caseDistance = hingeNuckleOuterRadius*2;

clipWidth = 6; 
clipNoseHeight = 2; 

module case(translate, rotate){
    xt = translate[0];
    yt = translate[1];
    zt = translate[2];

    // xa = x-Angle
    xa = rotate[0];
    ya = rotate[1];
    za = rotate[2];
    
    translate([xt,yt,zt]){
            rotate([xa,ya,za]){
            union(){ // case free part

                cube([length,width,bottomPlate]); //bottom plate}

                // long walls
                cube([length, wallThickness, height]); 
                translate([0, width-wallThickness, 0]){ 
                    cube([length, wallThickness, height]);    
                }

                // short cutted walls
                difference(){ 
                    cube([wallThickness,width,height],0);
                    translate([-0.5,(width/2)-(cableWidth/2),height-(cableHeight/2)]){
                        cube([wallThickness+1,cableWidth,height-cableHeight],0);
                    }
                }
                translate([length-wallThickness,0,0]){
                    difference(){
                        cube([wallThickness,width,height],0);
                        translate([-0.5,(width/2)-(cableWidth/2),height-(cableHeight/2)]){
                            cube([wallThickness+1,cableWidth,height-cableHeight],0);
                        }
                    }
                }
            }    
        }  
    }
}

module hinge(translate, rotate, extraThickness=0){
    
    xt = translate[0];
    yt = translate[1];
    zt = translate[2];

    // xa = x-Angle
    xa = rotate[0];
    ya = rotate[1];
    za = rotate[2];
    
    translate([xt,yt,zt]){
        rotate([xa,ya,za]){
            union(){ 
                cylinder(hingeWidth + extraThickness, hingeNuckleOuterRadius, hingeNuckleOuterRadius);
                translate(0, hingeNuckleOuterRadius, 0){
                    cube([height, hingeNuckleOuterRadius, hingeWidth + extraThickness]);
                }   
            }
        }
    }
}

module hingeSystem(translate, rotate, mirror=[0,0,0]){
    xt = translate[0];
    yt = translate[1];
    zt = translate[2];
 
    // xa = x-Angle
    xa = rotate[0];
    ya = rotate[1];
    za = rotate[2];
    
    xm = mirror[0];
    ym = mirror[1];
    zm = mirror[2];
    
    nuckleExtraThickness = 1;
        
    translate([xt,yt,zt]){
        rotate([xa,ya,za]){
            mirror([xm,ym,zm]) {
                union(){  // hinge pin
                    hinge();
                    translate([0,0,hingeWidth]){
                        cylinder(hingePinLength, hingePinRadius, hingePinRadius);
                    }
                }
                difference(){ // hinge nuckle
                    hinge(translate = [0,0,hingeWidth*2+moveDistance+nuckleExtraThickness], rotate = [180,0,0], extraThickness = nuckleExtraThickness);
                    translate([0,0,hingeWidth+moveDistance/2]){
                        cylinder(hingeNuckleLength+moveDistance, hingeNuckleInnerRadius, hingeNuckleInnerRadius);
                    }    
                    }
                }
        }
    }
}



module clip(translate, rotate){
    xt = translate[0];
    yt = translate[1];
    zt = translate[2];
 
    // xa = x-Angle
    xa = rotate[0];
    ya = rotate[1];
    za = rotate[2];
        
    translate([xt,yt,zt]){
        rotate([xa,ya,za]){
            union(){  // clip 
                    difference(){ 
                        union(){
                            cube([clipWidth, wallThickness, height*2+printLayerHeight+clipNoseHeight]);
                            translate([0,-wallThickness, height*2+printLayerHeight]){
                                cube([clipWidth, wallThickness, clipNoseHeight]);
                            }
                        }
                        translate([0,-wallThickness, height*2]){
                            translate([-0.1,-wallThickness*2,0.5]){
                                rotate([-35,0,0]){
                                    cube([clipWidth*2, wallThickness*2, clipNoseHeight*2]);
                                }
                            }
                        }
                }
            }
        }
    }
}



union(){ // case cross part
    
    // Shell guides
    translate([wallThickness, width-wallThickness-guideWidth, 0]){
        cube([guideWidth, guideWidth, guideHeight]);
    }

    translate([length-wallThickness-guideWidth, width-wallThickness-guideWidth, 0]){
        cube([guideWidth, guideWidth, guideHeight]);
    }


    // center cross
    translate([length/2-wallThickness/2, wallThickness, 0]){
        cube([innerWallThickness, width-(2*wallThickness), crossHeight]);
    }
    translate([length/3, width/2-innerWallThickness/2, 0]){
        cube([length/3, innerWallThickness, crossHeight]);
    }
    
    // Holder clips
    translate([0, width, 0]){
        cube([wallThickness, wallThickness, height]);
    }
    translate([insetHinge/2, width, 0]){
        cube([wallThickness, wallThickness, height]);
    }
    
    translate([length-wallThickness-insetHinge/2, 0, 0]){
        translate([0, width, 0]){
            cube([wallThickness, wallThickness, height]);
        }
        translate([insetHinge/2, width, 0]){
            cube([wallThickness, wallThickness, height]);
        }
    }
}





case();
case(translate = [0,-width-caseDistance,0]);


clip(translate = [clipWidth+wallThickness*2,-width-wallThickness*3,0], rotate = [0,0,180]);
clip(translate = [length-wallThickness*2,-width-wallThickness*3,0], rotate = [0,0,180,]);

hingeSystem(translate = [insetHinge,-caseDistance/2,height]
            ,rotate = [0,90,0]);
hingeSystem(translate = [length-insetHinge,-caseDistance/2,height]
            ,rotate = [180,90,0] 
            ,mirror = [0,1,0]);

hingeSystem(translate = [insetHinge*length/2,-caseDistance/2,height]
            ,rotate = [0,90,0]);
hingeSystem(translate = [length-insetHinge*length/2,-caseDistance/2,height]
            ,rotate = [180,90,0] 
            ,mirror = [0,1,0]);




