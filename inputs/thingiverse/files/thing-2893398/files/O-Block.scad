// CSG-modules.scad - Basic usage of modules, if, color, $fs/$fa

// Change this to false to remove the helper geometry
debug = true;

// Global resolution
$fs = 0.1;  // Don't generate smaller facets than 0.1 mm
$fa = 5;    // Don't generate larger angles than 5 degrees

TP_lower = 12.5/2;
TP_upper = 13.6/2;
TP_depth = 20;  // cube hieght
LowerWall = 3;
SideWall = 3;
ConnectionDepth = 10;

Letter = "O";
LetterSize = TP_depth *2/3;
LetterHeight = 2;
LetterFont = "Liberation Sans";

// Main geometry

intersection()    // to make the wall part without rounded corners
{
    difference() {
        translate([-TP_upper-SideWall,-TP_upper-SideWall,0]){
            cubeX([TP_upper*2+SideWall*2, TP_upper*2+SideWall*2 + ConnectionDepth + 20, TP_depth], radius=2);
        }
        translate([0,0,LowerWall]){
            cylinder(h = TP_depth-LowerWall, r1 = TP_lower, r2 = TP_upper, center = false);
        }
        cylinder(h = TP_depth, r = TP_lower*0.6, center = false);
        translate([0, -TP_depth/2 + LetterHeight, TP_depth/2]) rotate([90, 0, 0]) letter(Letter);
    }
    translate([-TP_upper-SideWall,-TP_upper-SideWall,0]){
        cube([TP_upper*2+SideWall*2, TP_upper*2+SideWall*2 + ConnectionDepth, TP_depth]);
    }
}


//
// Simple and fast corned cube!
// Anaximandro de Godinho.
//

module cubeX( size, radius=1, rounded=true, center=false )
{
	l = len( size );
	if( l == undef )
		_cubeX( size, size, size, radius, rounded, center );
	else
		_cubeX( size[0], size[1], size[2], radius, rounded, center );
}

module _cubeX( x, y, z, r, rounded, center )
{
	if( rounded )
		if( center )
			translate( [-x/2, -y/2, -z/2] )
			__cubeX( x, y, z, r );
		else
			__cubeX( x, y, z, r );
	else
		cube( [x, y, z], center );
}

module __cubeX(	x, y, z, r )
{
	//TODO: discount r.
	rC = r;
	hull()
	{
		translate( [rC, rC, rC] )
			sphere( r );
		translate( [rC, y-rC, rC] )
			sphere( r );
		translate( [rC, rC, z-rC] )
			sphere( r );
		translate( [rC, y-rC, z-rC] )
			sphere( r );

		translate( [x-rC, rC, rC] )
			sphere( r );
		translate( [x-rC, y-rC, rC] )
			sphere( r );
		translate( [x-rC, rC, z-rC] )
			sphere( r );
		translate( [x-rC, y-rC, z-rC] )
			sphere( r );
	}
}

module letter(l) {
  // Use linear_extrude() to make the letters 3D objects as they
  // are only 2D shapes when only using text()
  linear_extrude(height = LetterHeight) {
    text(l, size = LetterSize, font = LetterFont, halign = "center", valign = "center", $fn = 16);
  }
}