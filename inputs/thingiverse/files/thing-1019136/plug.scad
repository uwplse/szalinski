//  Measure for the smoothness
$fn = 50;

baseHeight = 1;
baseDiameter = 5.5;
midInnerDiameter = 2.5;
midOuterDiameter = 4.5;
midHeight = 10.5;

//  The extra height and with of the top
topDiameter = 5.5;
angleDownSide = 45;
angleUpside = 30;

//  The width of the cut through the middle
cutWidth = 1;

//  The height at which the cut begins
cutHeight = 3;

//  Create a fillet in the cut out for strenght, 1 for yes, 0 for no
cutFillet = 1;  //  [1, 0]

//  To make the bottom hollow, 1 for yes, 0 for no
solidBase = 1;    //  [1, 0]

//  To create a fillet between the base and the middle part, 1 for yes, 0 for no. Only available if solidBase = 1
baseFillet = 1;   //  [1, 0]

//  To make the top pointy
pointyTop = 1;      //  [1, 0]

//  To remove the side bits of the top, makes it easier to put it through a hole, 1 for yes, 0 for no
removeSides = 0;    //  [1, 0]

module base(rOuter, rInner, height, solid){
    difference(){
        cylinder(r = baseDiameter / 2, h = height);
        if (solid == 0){
            translate(  [   0,
                            0,
                            -0.1]){
                cylinder(r = rInner, h = height + 0.2);
            }
        }
    }
}

module middle(rInner, rOuter, height, cutHeight, cutWidth, cutFillet, baseFillet, solidBase){
    difference(){
        //  Make the tube shape
        cylinder(r = rOuter, h = height);
        
        //  Cut out the base with optional fillet
        if(baseFillet == 1 && solidBase == 1){
            translate(  [   0,
                            0,
                            rInner  ]){
                sphere(r = rInner);
                cylinder(r = rInner, h = height);
                            }
        }
        
        //  No base fillet
        else{
            translate(  [   0,
                            0,
                            -0.1    ]){
                cylinder(r = rInner, h = height + 0.2);
            }
        }
        
        //  Cut out the groove with optional fillet    
        translate(  [   -rOuter,
                        -cutWidth / 2,
                        cutHeight]){
            if(cutFillet == 1){
                translate(  [   -0.1,
                                1/2 * cutWidth,
                                1/2 * cutWidth  ]){
                    rotate( [   0,
                                90,
                                0   ]){
                        cylinder(r = cutWidth / 2, h = height + 0.2);
                    }
                }
            }
            translate(  [   -0.1,
                            0,
                            1/2 * cutWidth * cutFillet ]){
                cube(   [   2 * rOuter + 0.2,
                            cutWidth,
                            height  ]);
            }
        }
    }
}

module top(rInner, rMid, rOuter, cutWidth, angleDown, angleUp, pointy, removeSides){
    delta = 0.000000000000001;
    
    //  Determine scale factor for morfing top in shape
    scaleFactor = (rMid / rOuter - 1) * removeSides + 1;
    
    bottomHeight = (rOuter - rMid) / tan(angleDown) - delta;
    
    //  Calculating topheight and implementing (optional) pointy top
    topRadius = (rInner - rMid) * pointy + rMid;
    topHeight = (rOuter - topRadius) / tan(angleUp) - delta;
    
    difference(){
        union(){
            hull(){
                cylinder(r = rMid, h = delta);
                translate(  [   0,
                                0,
                                bottomHeight]){
                    scale(  [   scaleFactor,
                                1,
                                1]){
                        cylinder(r = topDiameter / 2, h = delta);
                    }
                    translate(  [   0,
                                    0,
                                    topHeight]){
                        cylinder(r = topRadius, h = delta);
                    }
                }
            }
        }
        
        translate(  [   -rOuter - 0.1,
                        -1/2 * cutWidth,
                        -0.1    ]){
            cube(   [   2 * rOuter + 0.2,
                        cutWidth,
                        bottomHeight + topHeight + 0.2   ]   );
        }
        translate(  [   0,
                        0,
                        -0.1    ]){
            cylinder(r = rInner, h = bottomHeight + topHeight + 0.2);
        }
    }
}

module plug(){
    union(){
        //  The base
        base(baseDiameter / 2, midInnerDiameter / 2, baseHeight, solidBase);
        
        //  The middle part
        translate(  [   0,
                        0,
                        baseHeight] ){
            middle(midInnerDiameter / 2, midOuterDiameter / 2, midHeight, cutHeight, cutWidth, cutFillet, baseFillet, solidBase);
        }
        
        //  The top part
        translate(  [   0,
                        0,
                        baseHeight + midHeight] ){
            top(midInnerDiameter / 2, midOuterDiameter / 2, topDiameter / 2, cutWidth, angleDownSide, angleUpside, pointyTop, removeSides);
        }
    }
}

plug();