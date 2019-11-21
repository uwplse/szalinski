

length         = 150.0; // [50.0:10.0:300.0]
baseThickness  =   1.9; // [ 1.0: 0.1:  5.0]
baseFlare      =   4.0; // [ 1.0: 0.1: 10.0]
spineThickness = baseThickness;
spineFlare     = baseFlare;
spineDepth     =  10.0; // [ 3.0: 0.5: 20.0]
ribThickness   = spineThickness;
flareLength    =  30.0; // [ 5.0: 1.0:100.0]
headThickness  = ribThickness;
tipWidth       =  10.0; // [ 5.0: 1.0: 30.0]
tipLength      = tipWidth;
tipDepth       = tipWidth/2.0;
headWidth      =  25.0; // [15.0: 1.0: 50.0]
headDepth      = spineDepth;
hookWidth      =   5.0; // [ 3.0: 0.5: 10.0] 
hookHole       =   8.0; // [ 3.0: 0.5: 10.0] 
hookLength     =  10.0; // [ 3.0: 0.5: 15.0] 
hookSlope      =   4.0; // [ 0.0: 0.1: 10.0] 
hookBack       =   8.0; // [ 3.0: 0.5: 20.0] 
hookTop        =   3.0; // [ 0.0: 0.1: 10.0] 
cornerRadius   =   2.4; // [ 0.1: 0.1:  5.0]
hookSide       = hookWidth+hookHole;
headSide       = headWidth-(hookSide+spineFlare);
hookTaper      = hookHole+hookWidth/4.0;
taperEndLength = length-(headThickness+hookBack+hookTaper);
tipSide        = (tipWidth-spineThickness)/2.0;
facets         = 120;

$fn=facets;

stakeOnPlate();


module stakeOnPlate()
{ translate( [length/2,0,0] )
    rotate( [0,0,90] )
      stake();
}

module stake()
{ basePlate();
  baseRamp();
  head();
  spine();
  spineRamp();
  rib(0.00);
  rib(0.38);
  rib(0.71);
  rib(0.984);
}

module basePlate()
{ linear_extrude( baseThickness ) 
    fillet(r=cornerRadius)
      polygon(points=[[                          0,                                            0 ],
                      [           -spineThickness ,                                            0 ],
                      [ -( tipSide+spineThickness), tipLength                                    ],
                      [ -(headSide+spineFlare    ), taperEndLength                               ],
                      [ -(headSide+spineFlare    ),    length                                    ],
                      [   hookHole+hookWidth      ,    length                                    ],
                      [   hookHole+hookWidth      ,    length- headThickness                     ],
                      [   hookHole+hookWidth      ,    length-(headThickness+hookTop+hookLength) ],
                      [   hookHole                ,    length-(headThickness+hookTop+hookLength-hookSlope) ],
                      [   hookHole                ,    length-(headThickness+hookTop)            ],
                      [                          0,    length-(headThickness+hookTop)            ],
                      [                          0,    length-(headThickness+hookBack)           ],
                      [   hookTaper               , taperEndLength                               ],
                      [    tipSide                , tipLength                                    ]],
              paths =[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,0]] );
}

module baseRamp()
{ difference()
    { linear_extrude( baseFlare ) 
        polygon(points=[[                          0,                                            0 ],
                        [           -spineThickness ,                                            0 ],
                        [ -( tipSide+spineThickness), tipLength                                    ],
                        [ -(headSide+spineFlare    ), taperEndLength                               ],
                        [ -(headSide+spineFlare    ),    length                                    ],
                        [                          0,    length                                    ]],
                paths =[[0,1,2,3,4,5,0]] );
        
      rotate( [0,-90,0] )
        linear_extrude( headSide+spineFlare+1 ) 
          polygon(points=[[                      -1,                               -1 ],
                          [                      -1, length-headThickness-flareLength ],
                          [           baseThickness, length-headThickness-flareLength ],
                          [           baseFlare    , length-headThickness             ],
                          [           baseFlare    , length+1                         ],
                          [           baseFlare  +1, length+1                         ],
                          [           baseFlare  +1,                               -1 ]],
                  paths =[[0,1,2,3,4,5,6,0]] );
    }
}

module head()
{ translate( [0,length,0] )
    rotate( [90,0,0] )
      linear_extrude( headThickness ) 
        polygon(points=[[ -(headSide+spineFlare),                        0 ],
                        [ -(headSide+spineFlare), baseFlare                ],
                        [           -spineFlare , baseThickness+spineDepth ],
                        [   hookSide-headSide   , baseThickness+spineDepth ],
                        [   hookSide            , baseThickness            ],
                        [   hookSide            ,                        0 ]],
                paths =[[0,1,2,3,4,5,0]] );
}

module spine()
{ rotate( [0,-90,0] )
    linear_extrude( spineThickness ) 
      polygon(points=[[                       0,                        0 ],
                      [ baseThickness          ,                        0 ],
                      [ baseThickness+ tipDepth, tipLength                ],
                      [ baseThickness+headDepth,    length- headThickness ],
                      [ baseThickness+headDepth,    length                ],
                      [                       0,    length                ]],
              paths =[[0,1,2,3,4,5,0]] );
}

module spineRamp()
{ difference()
    { rotate( [0,-90,0] )
        linear_extrude( spineFlare ) 
          polygon(points=[[                       0,                        0 ],
                          [ baseThickness          ,                        0 ],
                          [ baseThickness+ tipDepth, tipLength                ],
                          [ baseThickness+headDepth,    length- headThickness ],
                          [ baseThickness+headDepth,    length                ],
                          [                       0,    length                ]],
                  paths =[[0,1,2,3,4,5,0]] );
        
        linear_extrude( headDepth+baseThickness+1 ) 
          polygon(points=[[               1,                               -1 ],
                          [               1, length-headThickness-flareLength ],
                          [ -spineThickness, length-headThickness-flareLength ],
                          [     -spineFlare, length-headThickness             ],
                          [     -spineFlare, length+1                         ],
                          [   -1-spineFlare, length+1                         ],
                          [   -1-spineFlare,                               -1 ]],
                  paths =[[0,1,2,3,4,5,6,0]] );
    }
}

module rib( f=0.5 )
{ f2 = f * taperEndLength / length;
    lengthRange = taperEndLength-tipLength;
      sideRange = headSide+spineFlare-spineThickness-tipSide;
  holeSideRange = hookTaper-tipSide;
     depthRange = headDepth-tipDepth;
  translate( [0,tipLength+ribThickness+f*lengthRange,0] )
    rotate( [90,0,0] )
      linear_extrude( ribThickness ) 
        polygon(points=[[ -(tipSide+sideRange*f+spineThickness),                                   0 ],
                        [ -(tipSide+sideRange*f+spineThickness),baseThickness                        ],
                        [                      -spineThickness ,baseThickness+tipDepth+depthRange*f2 ],
                        [                      -              0,baseThickness+tipDepth+depthRange*f2 ],
                        [   tipSide+holeSideRange*f            ,baseThickness                        ],
                        [   tipSide+holeSideRange*f            ,                                   0 ]],
                paths =[[0,1,2,3,4,5,0]] );
}


// Copyright (c) 2013 Oskar Linde. All rights reserved.
// License: BSD
//
// This library contains basic 2D morphology operations
//
// outset(d=1)            - creates a polygon at an offset d outside a 2D shape
// inset(d=1)             - creates a polygon at an offset d inside a 2D shape
// fillet(r=1)            - adds fillets of radius r to all concave corners of a 2D shape
// rounding(r=1)          - adds rounding to all convex corners of a 2D shape
// shell(d,center=false)  - makes a shell of width d along the edge of a 2D shape
//                        - positive values of d places the shell on the outside
//                        - negative values of d places the shell on the inside
//                        - center=true and positive d places the shell centered on the edge

module outset(d=1) {
	// Bug workaround for older OpenSCAD versions
	if (version_num() < 20130424) render() outset_extruded(d) children();
	else minkowski() {
		circle(r=d);
		children();
	}
}

module outset_extruded(d=1) {
   projection(cut=true) minkowski() {
        cylinder(r=d);
        linear_extrude(center=true) children();
   }
}

module inset(d=1) {
	 render() inverse() outset(d=d) inverse() children();
}

module fillet(r=1) {
	inset(d=r) render() outset(d=r) children();
}

module rounding(r=1) {
	outset(d=r) inset(d=r) children();
}

module shell(d,center=false) {
	if (center && d > 0) {
		difference() {
			outset(d=d/2) children();
			inset(d=d/2) children();
		}
	}
	if (!center && d > 0) {
		difference() {
			outset(d=d) children();
			children();
		}
	}
	if (!center && d < 0) {
		difference() {
			children();
			inset(d=-d) children();
		}
	}
	if (d == 0) children();
}


// Below are for internal use only

module inverse() {
	difference() {
		square(1e5,center=true);
		children();
	}
}
