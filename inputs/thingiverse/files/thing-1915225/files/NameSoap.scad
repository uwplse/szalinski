
labelString = "Dustin";
fast        = 1;   // [0:Smoothed Text, 1:Fast Render]
pourHeight  = 35;  // [5:1:200]
pourWidth   = 90;  // [5:1:300]
pourThick   = 12;  // [1:1:150]
taper       = 0.8; // [0.1:0.01:1.0]
labelDepth  = 2;   // [0.5:0.1:25]
labelSmooth = 0.5; // [0.2:0.1:2.0]
fontSize    = 15;  // [2:1:80]
moldWall    = 6;   // [1:1:12]
moldWidth   = pourWidth  + moldWall*2;
moldHeight  = pourHeight + moldWall*2;
floorThick  = moldWall   + labelDepth;
moldThick   = pourThick  + floorThick;
texDepth    = 2*1;
texLine     = 1*1;
texC2C      = 8*1;
texWidth    = texC2C/sin(60)-texLine;
extra       = 1*1;

difference()
  { moldBlock();
    union()
      { pourCavity();
        if ( fast > 0.5 )
          fastLetters();
        if ( fast <= 0.5 )
          { letters();
            texture();
          }
      }
  }

module pourCavity()
{ translate( [0,0,floorThick] )
    linear_extrude( height=pourThick+extra, scale=1/taper )
      translate( [-pourWidth*taper/2,-pourHeight*taper/2] )
        square( [pourWidth*taper,pourHeight*taper] );
}

module moldBlock()
{ translate( [-moldWidth/2,-moldHeight/2] )
    linear_extrude( moldThick )
      square( [moldWidth,moldHeight] );
}

module letters()
{ font1 = "Baloo Bhai:style=Bold"; // here you can select other font type
  $fn=8;
  translate( [0,0,moldWall] )
    minkowski()
      { linear_extrude( height=(labelDepth+extra-labelSmooth) )
          fillet( labelSmooth )
            rounding( labelSmooth )
              rotate( [0,180,0] )
                text( labelString, font = font1, size = fontSize, direction = "ltr", spacing = 1, halign="center", valign="center" );
          
        sphere( labelSmooth );
      }
}

module fastLetters()
{ font1 = "Baloo Bhai:style=Bold"; // here you can select other font type
  translate( [0,0,moldWall] )
    linear_extrude( height=(labelDepth+extra-labelSmooth) )
      rotate( [0,180,0] )
        text( labelString, font = font1, size = fontSize, direction = "ltr", spacing = 1, halign="center", valign="center" );
}

// Waffle like cuts to make removal from build plate easier
module texture()
{ wid = moldWidth;
  hei = moldHeight;
  translate( [-wid/2,-hei/2] )
  {  
  vo = sin(60)*2;
  for ( i = [wid/2:texC2C:wid] )
    for ( j = [0:texC2C*vo:hei+texC2C*vo] )
      translate( [i,j,0] )
        textureCone( texDepth );
  for ( i = [wid/2+texC2C/2:texC2C:wid] )
    for ( j = [texC2C*vo/2:texC2C*vo:hei+texC2C*vo] )
      translate( [i,j,0] )
        textureCone( texDepth );
    
  for ( i = [wid/2:-texC2C:0] )
    for ( j = [0:texC2C*vo:hei+texC2C*vo] )
      translate( [i,j,0] )
        textureCone( texDepth );
  for ( i = [wid/2-texC2C/2:-texC2C:0] )
    for ( j = [texC2C*vo/2:texC2C*vo:hei+texC2C*vo] )
      translate( [i,j,0] )
        textureCone( texDepth );
  }
}

module textureCone( h=1 )
{ translate( [0,0,-0.001] )
    linear_extrude( height=h,scale=0.5 )
      polygon(points=[[cos(030)*texWidth/2,sin(030)*texWidth/2 ],
                      [cos(090)*texWidth/2,sin(090)*texWidth/2 ],
                      [cos(150)*texWidth/2,sin(150)*texWidth/2 ],
                      [cos(210)*texWidth/2,sin(210)*texWidth/2 ],
                      [cos(270)*texWidth/2,sin(270)*texWidth/2 ],
                      [cos(330)*texWidth/2,sin(330)*texWidth/2 ]],
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
