
neckOuterRadius   = 10;
neckInletRadius   =  6;
neckEndRadius     =  6;
neckLength        =  5;
roundingRadius    =  0.3;
tubeLength        =  5;
tubeEndRadius     =  6;
wallThickness     =  0.8;
finThickness      =  0.4;
finRootLength     =  5;
finRootEndRadius  =  3.6;
finTipLength      =  5;
finTipInnerRadius =  5;
finTipOuterRadius = 12;

facets         = 120;

$fn=facets;

body();
// fins();

module body()
{ rotate_extrude()
    profile();
}

module fins()
{ fin();
  rotate( [0,0,120] )
    fin();
  rotate( [0,0,240] )
    fin();
}

module profile()
{ fillet( r=roundingRadius )
    rounding( r=roundingRadius )
      polygon(points=[[  neckInletRadius              ,                                   0 ],
                      [  neckOuterRadius              ,                                   0 ],
                      [  neckOuterRadius              ,                          neckLength ],
                      [    neckEndRadius+wallThickness,                          neckLength ],
                      [    tubeEndRadius+wallThickness,               tubeLength+neckLength ],
                      [ finRootEndRadius+wallThickness, finRootLength+tubeLength+neckLength ],
                      [ finRootEndRadius              , finRootLength+tubeLength+neckLength ],
                      [    tubeEndRadius              ,               tubeLength+neckLength ],
                      [    neckEndRadius              ,                          neckLength ]],
              paths =[[0,1,2,3,4,5,6,7,8,0]] );
}

module fin()
{ rotate( [90,0,0] )
    translate( [0,0,-finThickness/2] )
      linear_extrude( finThickness )
        rounding( r=roundingRadius )
          polygon(points=[[    tubeEndRadius+wallThickness/2,                            tubeLength+neckLength ],
                          [ finRootEndRadius+wallThickness/2,              finRootLength+tubeLength+neckLength ],
                          [ finTipInnerRadius               , finTipLength+finRootLength+tubeLength+neckLength ],
                          [ finTipOuterRadius               , finTipLength+finRootLength+tubeLength+neckLength ]], 
                  paths =[[0,1,2,3,0]] );
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
