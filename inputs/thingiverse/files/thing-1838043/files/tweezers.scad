

bodyDepth     = 6;      // [1:0.1:50]
bodyLength    = 150;    // [15:0.1:250]
bodyOpening   = 12;     // [1:0.1:50]
bodyThickness = 5;      // [0.5:0.1:20] 
jointLength   = 45;     // [1:0.1:100]
tipLength     = 15;     // [0:0.1:50]
hingeDepth    = 5;      // [1:0.1:50]
hingeFillet   = 2.5;    // [0:0.1:10]
blunt         = 0.2;    // [0.25:0.01:5]
overlap       = 0.01*1;
facets        = 80;

$fn=facets;
rotate( [0,0,270] )
  translate( [0,-bodyLength/2,0] )
    linear_extrude( height=bodyDepth )
      fillet(r=hingeFillet)
        union()
          { circle( bodyThickness/2 );
            leg();
            mirror()
              leg();
          }
  
module leg()
{ polygon(points=[[ bodyThickness/2              , 0                      ],
                  [ bodyThickness + bodyOpening/2, bodyLength-jointLength ],
                  [ bodyThickness + bodyOpening/2, bodyLength-tipLength   ],
                  [ bodyOpening/2+blunt          , bodyLength             ],
                  [ bodyOpening/2                , bodyLength             ],
                  [ bodyOpening/2                , bodyLength-jointLength ],
                  [ -overlap/2                   , hingeDepth             ],
                  [ -overlap/2                   , 0                      ]],
          paths =[[0,1,2,3,4,5,6,7,0]] );
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
