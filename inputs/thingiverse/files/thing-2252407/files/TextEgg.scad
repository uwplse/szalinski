/*  Configurable Easter-egg with custom back- and front-text
    (c)copyright 2017 by Gerald Wodni
*/

/* Text */
// Front / Single Text
Text = "SISI";
Text1 = Text;
// Back Text
Text2 = "FRANZ";
// Angle between letters, reduce for more letters
TextAngle = 30;
// Text Size in mm
TextSize = 10;
// Cutting Depth into egg
TextDepth = 3;

/* Egg */
// Egg Radius (lower half is a sphere)
EggRadius = 20;
// Scaling of upper half
EggScale = 1.5;

/* Base */
// Radius for base, use 0 for no base
BaseRadius = 10;

/* [Expert Settings] */
// Overlapping-Extension
Epsilon = 0.05;
// Smoothness of curves
$fn = 128;

module halfSphere( r ) {
    c = r * 2;
    difference() {
        sphere( r = r );
    
        /* subtract lower half */
        translate([0,0,-r])
        cube( [ c, c, c ], center = true );
    }
}

module donut( r, d ) {
    rotate_extrude()
    translate([r,0])
    circle( d = d );
}

module egg( r, eggScale = 1.3 ) {
    /* mount */
    rotate([0,0,75])
    translate([0,0,eggScale*r])
    rotate([90,0,0])
    donut( 4, 3 );

    
    /* upper half */
    s = 1 / eggScale;
    bigR = eggScale * r;
    scale( [s, s, 1 ] )
    halfSphere( bigR );
    
    /* lower half */
    translate([0,0,Epsilon])
    rotate([180,0,0])
    halfSphere( r );
}

module letter( text, size, height ) {
    translate([0,height,0])
    rotate([90,0,0])
    linear_extrude(height=height+Epsilon)
    text( text, size, valign="center", halign="center" );
}

module textOrbit( r, text, textAngle, textSize ) {
    union()
    for( i = [0:len(text)-1] ) {
        rotate([0, 0, textAngle * i])
        translate([ 0, -r, 0 ])
        letter( text[i], textSize, TextDepth );
    }
}

module textEgg( r, eggScale, text, textAngle, textSize ) {
    difference() {
        egg( r, eggScale );    
        textOrbit( r, text, textAngle, textSize );
    }
}

module duoTextEgg( r, eggScale, text1, text2, textAngle, textSize, foot = 0 ) {
    difference() {
        union() {
            egg( r, eggScale );
            if( foot > 0 )
                translate([0, 0, -r])
                cylinder(r = foot, h = r);
        }
        angleWidth1 = ( len(text1) - 1 ) * textAngle;
        angleWidth2 = ( len(text2) - 1 ) * textAngle;
        
        angleOffset = ( 360 - angleWidth1 )/2 + angleWidth1 - angleWidth2/2;
        
        textOrbit( r, text1, textAngle, textSize );
        rotate([0,0,angleOffset])
        textOrbit( r, text2, textAngle, textSize );
    }
}

//textEgg( EggRadius, EggScale, Text, TextAngle, TextSize );
duoTextEgg( EggRadius, EggScale, Text1, Text2, TextAngle, TextSize, BaseRadius );

