/* 
*  Copyright (c)..: 2018 janpetersen.com
*
*  Creation Date..: April. 7 2018
*  Discription....: Tool Caddy for 20x20 extrusion
*
*  Rev 1: Developed Model
*
*  This program is free software; you can redistribute it and/or modify
*  it under the terms of the GNU General Public License as published by
*  the Free Software Foundation; either version 2 of the License, or
*  (at your option) any later version.
*
*  This program is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*  GNU General Public License for more details.
*
*  If used commercially attribution is required (janpetersen.com)
*
*
*   Thingiverse Customizer documentation:
*   http://customizer.makerbot.com/docs
*
*
*/

/* ----- customizer view ----- */
//preview[view:south, tilt:top]

/* ----- parameters ----- */

/* [Hidden] */
$fn=50; // recomended value for smooth circle is 60
standardHexKeySizes = [
    ["M6", 5],
    ["M5", 4],
    ["M4", 3],
    ["M3", 2.5],
    ["M2.5", 2],
    ["M2", 1.5]
];


/* [Global] */
caddyHeight = 20; // [10:1:30]
caddyWidth = 10;  // [5:1:15]
caddyLength = 100; // [80:5:100]

/* [tool slot dimensions] */
brushWidth = 18;
brushLength = 16;
pliersWidth = 13;
pliersLength = 17;
largeWrenchWidth = 3;
largeWrenchLength = 21.5;
smallWrenchWidth = 2.5;
smallWrenchLength = 10.5;
tweezersWidth = 3;
tweezersLength = 7;
screwDriverDia = 4;
m6HexKey = 0;   // [1:yes,0:no]
m5HexKey = 1;   // [1:yes,0:no]
m4HexKey = 1;   // [1:yes,0:no]
m3HexKey = 1;   // [1.5:yes,0:no]
m25HexKey = 1;  // [1:yes,0:no]
m2HexKey = 1;   // [1:yes,0:no]
acupunctureNeedle = "yes"; // [yes, no]
scraberHookDia = 5; // [0:No Hook, 5:Slim Hook, 8:Normal Hook]
scraberHookDepth = 28;

/* ----- libraries ----- */

use <RoundedRectsModule.scad>;


/* ----- execute ----- */

hexKeySelection = [ m6HexKey, m5HexKey, m4HexKey, m3HexKey, m25HexKey, m2HexKey ];
rotate([ 0, 0, 180 ])
    mainModule();


/* ----- modules ----- */


module mainModule() {
    difference() {
        union() {
            caddy();
            translate([ 0, -caddyWidth / 2 - 1.5, 0 ])
                cube([ caddyLength - 10, 3, 6 ], center=true );
        }
        translate([ 12, 0, 0 ]) {
            translate([ 0, -caddyWidth / 2 - 2.1, 0 ])
                cube([ 20, 4.2, 6.2 ], center=true );
            rotate([ 90, 0, 0 ]) {
                cylinder( d=5.2, h=caddyWidth + 0.2, center=true );
                translate([ 0, 0, - caddyWidth / 2 - 0.1 ])
                    cylinder( d=8.5, h=( caddyWidth + 0.2 )/ 2 );
            }
        }
    }
}


module caddy() {
    
    difference() {
        hull()
            for ( i = [ -1:2:1 ] )
                translate( [ i * caddyLength / 2, 0, 0 ] )
                    cylinder( d=caddyWidth, h=caddyHeight, center=true );

        // Hex Keys
        for (i = [ 0:len(hexKeySelection) - 1 ]) {
            if ( hexKeySelection[i] == 1 ) {
                translate( [ caddyLength / 2 - calcHexKeyOffset(i, 0), 0, -0.05] )
                    cylinder( d=standardHexKeySizes[i][1] + 1, h=caddyHeight + 0.2, center=true, $fn=6 );
                }
            }

        // acupuncture needle
        if ( acupunctureNeedle == "yes" ) {
            translate( [ caddyLength / 2 - calcHexKeyOffset(5, 0) - 5, 0, -0.05] )
                cylinder( d=0.8, h=caddyHeight + 0.2, center=true );
        }
        
        // large wrength
        translate([ -5, 0, 0 ])
            cube([ largeWrenchLength, largeWrenchWidth, caddyHeight + 0.2 ], center=true );
        // small wrength
        translate([ -30, 0, 0 ])
            cube([ smallWrenchLength, smallWrenchWidth, caddyHeight + 0.2 ], center=true );
        // screw driver
        translate([ -42, 0, 0 ])
            cylinder( d=screwDriverDia, h=caddyHeight + 0.2, center=true );
        // tweezers
        translate([ -48, 0, 0 ])
            cube([ tweezersWidth, tweezersLength, caddyHeight + 0.2 ], center=true);
    }

    // copper brush
    translate([
        0,
        ( brushWidth + 4 + caddyWidth ) / 2 - 0.1,
        ( caddyHeight - 3 ) / 2
    ]) {
        eyelet( brushLength + 4, brushWidth + 4, 3, 3, brushLength, brushWidth, 2 );
    }

    // flush cut pliers
    translate([
        -( caddyLength / 2 - ( pliersLength + 4 + 5 ) / 2 ),
        ( pliersWidth + 4 + caddyWidth ) / 2 - 0.1,
        ( caddyHeight - 3 ) / 2
    ])
        eyelet( pliersLength + 4, pliersWidth + 4, 3, 3, pliersLength, pliersWidth, 2 );

    // scraber hook
    if ( scraberHookDia > 0 ) {
        translate([ 35, caddyWidth / 2 - 0.01, -scraberHookDia ]) {
            rotate([ -90, 0, 0 ])
                scale([ 1, 1.2, 1 ]) cylinder( d=scraberHookDia, h=scraberHookDepth );
            translate([ 0, scraberHookDepth, 0 ]) {
                scale([ 1, 1, 1.2 ]) sphere( d=scraberHookDia );
                cylinder( d=scraberHookDia, h=scraberHookDia * 1.5 );
                translate([ 0, 0, scraberHookDia * 1.5 ])
                    sphere( d=scraberHookDia );
            }
        }
    }
}


module eyelet(_x, _y, _z, _radius, _x1, _y1, _radius1) {
    difference() {
        union() {
            translate([ ( _x + _radius) / 2, - ( _y - _radius ) / 2, 0 ])
                rotate([ 0, 0, 180 ])
                    fillet(_radius, _radius );
            translate([ - ( _x + _radius) / 2, - ( _y - _radius ) / 2, 0 ])
                rotate([ 0, 0, -90 ])
                    fillet( _radius, _radius );
            hull() {
                translate([  0, -_radius, 0 ])
                    cube([ _x, _y - _radius * 2 - 0.1, _radius ], center=true );
                translate([ _x / 2 - _radius, _y / 2 - _radius, 0 ])
                    cylinder( r=_radius, h=_z, center=true );
                translate([ - _x / 2 + _radius, _y / 2 - _radius, 0 ])
                    cylinder( r=_radius, h=_z, center=true );
            }
        }
        roundedRect( _x1, _y1, _z + 0.2, 2 );
    }
}


module fillet(_radius, _height) {
    difference() {
        translate([ -0.01, -0.01, 0 ])
            cube([ _radius + 0.01, _radius + 0.01, _height ], center=true );
        translate([ -_radius / 2, -_radius / 2, 0 ])
            cylinder( r=_radius, h=_height + 0.2, center=true );
    }
}


function calcHexKeyOffset( lastKey = 5, currentKey = 0, first = 0 ) = (
    currentKey > lastKey  ? 0 : hexKeySelection[currentKey] * first * ( standardHexKeySizes[currentKey][1] / 2 + 4 ) + calcHexKeyOffset( lastKey, currentKey + 1, max( first, hexKeySelection[currentKey] ) )
);

// End Modules