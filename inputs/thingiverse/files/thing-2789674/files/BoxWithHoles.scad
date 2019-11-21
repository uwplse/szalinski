
boxWidth      = 44.45;  // [5.0:0.1:1000]
boxDepth      = 44.45;  // [5.0:0.1:1000]
boxHeight     = 21  ;   // [5.0:0.1:1000]
floorThick    =  2.5;   // [0.1:0.1:  10]
wallThick     =  2.0;   // [0.1:0.1:  10]
cornerRadius  =  8.0;   // [0.1:0.1:  50]
lidLip        =  2.0;   // [0.1:0.1:  10] 
lidThick      =  2.5;   // [0.1:0.1:  10]
lidGap        =  0.5;   // [0.1:0.1:   2]
tabWidth      = 12  ;   // [5.0:0.1:  30]
tabLength     = 12  ;   // [5.0:0.1:  30] 
tabThick      =  2.0;   // [0.5:0.1:  10] 
tabDepth      =  1.5;   // [0.5:0.1:  10]
tabEnd        = tabThick+tabDepth;
tabSnub       =  1.5;   // [0.5:0.1:  10]
tabSlant      = tabThick-tabSnub+tabDepth;

sideHoleDia   =  6.5;
sideHoleInset = 13.0;
sideHoleElev  = floorThick + sideHoleDia/2 + 5;

baseHoleDia   =  7.0;
baseHoleInset = 14.0;

sideSlitDia   =  4.0;
sideSlitDepth = 10.0;
sideSlitInset = 24.0;

facets        =120  ;

$fn=facets;

box();
lidOnPlate();

module boxWithHoles()
{ difference()
    { box();
        
      sideHole();
      baseHole();
      sideSlit();
    }
}

module box()
{ difference()
    { linear_extrude( boxHeight )
        base();
      
      union()
        { translate([0,0,floorThick])
            linear_extrude( boxHeight )
              inside();  
            
          tabs( 0.5 );
        }
    }
}

module lidOnPlate()
{ translate([0,-5,boxHeight+lidLip])
    rotate( [180,0,0] )
      lid();
}

module lid()
{ translate( [0,0,boxHeight] )
    linear_extrude( lidLip )
      base();
    
  translate( [0,0,boxHeight+lidLip-lidThick] )
    linear_extrude( lidThick )
      inset(d=wallThick+lidGap)
        base();
    
  tabs();
}

module sideHole()
{ translate( [sideHoleInset,wallThick*1.5,sideHoleElev] )
    rotate( [90,0,0] )
      linear_extrude( wallThick*2 )
        circle( d=sideHoleDia );
}

module baseHole()
{ translate( [boxWidth-baseHoleInset,baseHoleInset,-floorThick/2] )
    linear_extrude( floorThick*2 )
        circle( d=sideHoleDia );
}

module sideSlit()
{ translate( [sideSlitInset,boxDepth+wallThick/2,boxHeight-sideSlitDepth] )
    rotate( [0,-90,90] )
      linear_extrude( wallThick*2 )
        union()
          { circle( d=sideSlitDia );
            polygon(points=[[ sideSlitDepth+1, sideSlitDia/2 ],
                            [ sideSlitDepth+1,-sideSlitDia/2 ],
                            [               0,-sideSlitDia/2 ],
                            [               0, sideSlitDia/2 ]],
                    paths =[[0,1,2,3,0]] );
          }
}

module inside()
{ inset(d=wallThick)
    base();
}

module base()
{ rounding(r=cornerRadius)
    polygon(points=[[ boxWidth, boxDepth ],
                    [        0, boxDepth ],
                    [        0,        0 ],   
                    [ boxWidth,        0 ]],
            paths =[[0,1,2,3,0]] );
}


module tabs( gapSpace=1 )
{ translate( [wallThick+lidGap*gapSpace,boxDepth/2-tabWidth/2,0] )
    tab( gapSpace*lidGap*2 ); 
    
  translate( [boxWidth-wallThick-lidGap*gapSpace,boxDepth/2+tabWidth/2,0] )
    rotate( [0,0,180] )
      tab( gapSpace*lidGap*2 ); 
    
}

module tab( tabGap=0 )
{ translate( [0,0,boxHeight] )
    rotate( [270,0,0] )
      translate( [0,0,tabGap/2] )
        linear_extrude( tabWidth-tabGap )
          polygon(points=[[                0,                                  0 ],
                          [ tabThick        ,                                  0 ],
                          [ tabThick        ,tabLength                           ],
                          [ tabThick-tabSnub,tabLength                           ],
                          [-tabDepth        ,tabLength-tabSlant                  ],
                          [-tabDepth        ,tabLength-tabSlant-tabSnub          ],
                          [                0,tabLength-tabSlant-tabSnub-tabDepth ]],
                  paths =[[0,1,2,3,4,5,6,0]] );
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
