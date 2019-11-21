// Hexagonal puzzle

/* [Shape] */

// Content width (mm)
CONTENT_WIDTH = 50;

// Content height (mm)
CONTENT_HEIGHT = 60;

// Content shape
CONTENT_SHAPE = 1; // [0:Hexagonal,1:Cylindric]

// Container wall thickness (mm)
CONTAINER_THICKNESS = 0;

// Container grips width (mm)
CONTAINER_GRIP = 4;

// Knob diameter (mm)
KNOB_WIDTH = 15;

// Knob height (mm)
KNOB_HEIGHT = 10;

/* [Options] */

// Choose wich part to render
PART_TO_RENDER = 0; // [0:All,1:Container only,2:Cap only]

// Number of container sides
NB_SIDES = 4; // [0:6]

// Number of container sides with grip
NB_SIDES_WITH_GRIP = 6; // [0:6]

// The container has a bottom or not
CONTAINER_BOTTOMLESS = 0; // [0:With bottom,1:Without bottom]

/* [Advanced] */

// Printer nozzle width (mm)
PRINT_NOZZLE = 0.4; // [0:0.05:1]

// Distance between nestables parts (mm)
CONTAINER_GAP = 0.2; // [0:0.05:2]

// Precision of rendering (the lower the faster)
PRECISION = 100; // [10:10:200]

/* [Hidden] */

//
// Layout of one box side with grips
//
// o------o--------------------------------o---------o------------o
// | STOP |              Hook 1            | N Hooks |    STOP    |
// o------o--------------------------------o---------o------------o
// | Grip | Gap | Grip | Grip | Gap | Grip |   ...   | Gap | Grip |
// o------o--------------------------------o---------o------------o
//
$fn=PRECISION;
NB_GRIP = min(NB_SIDES,NB_SIDES_WITH_GRIP);
GAP = max(0,CONTAINER_GAP);
GRIP_MIN = max( (CONTAINER_GRIP-3*GAP)/2, 3*PRINT_NOZZLE);
SIDE_T = max( CONTAINER_THICKNESS, 3*PRINT_NOZZLE );
BOX_D = CONTENT_WIDTH+2*SIDE_T;
CONTENT_R = CONTENT_WIDTH/2;
BOX_R = BOX_D/2;
BOX_H = max ( 2*SIDE_T+GAP, CONTENT_HEIGHT );
SIDE_W_MIN = 2*BOX_R*tan(30); // External side width
KNOB_D = max ( KNOB_WIDTH, 5 );
KNOB_d = max ( KNOB_D*50/100, 3*PRINT_NOZZLE );
KNOB_H = max ( KNOB_HEIGHT, 5 );
KNOB_R = KNOB_D/2;
KNOB_r = KNOB_d/2;

//
// 3 grips width by hook and 2 for STOPs
//   = GRIP_MIN*(3*HOOKS_N + 2)
// 2 gaps by hook and 1 for STOPs
//   = GAP*(2*HOOKS_N + 1)
// SIDE_W = GRIP*(3*HOOKS_N + 2) + GAP*(2*HOOKS_N + 1)
//
// Minimum 1 hook or this don't work
//
HOOKS_N = max ( 1, floor ( (SIDE_W_MIN -GAP -2*GRIP_MIN)/(2*GAP+3*GRIP_MIN) ) );
GRIP = max ( 3*PRINT_NOZZLE, (SIDE_W_MIN - GAP*(2*HOOKS_N + 1)) / (3*HOOKS_N + 2) );
SIDE_W = GRIP*(3*HOOKS_N + 2) + GAP*(2*HOOKS_N + 1);
GRIP_W = 2*GRIP_MIN+3*GAP;

echo ( "HOOKS_N =", HOOKS_N );
echo ( "GRIP =", GRIP );
echo ( "SIDE_W =", SIDE_W );

// Draw a 2D hook
module hook() {
    polygon ( points = [ 
        [ 0*GRIP, 0*GRIP_MIN+0*GAP ],
        [ 0*GRIP, 2*GRIP_MIN+2*GAP ],
        [ 2*GRIP, 2*GRIP_MIN+2*GAP ],
        [ 2*GRIP, 1*GRIP_MIN+2*GAP ],
        [ 1*GRIP, 1*GRIP_MIN+2*GAP ],
        [ 1*GRIP, 0*GRIP_MIN+0*GAP ]
    ]);
}

// Draw a 2D stops
module stop() {
    polygon ( points = [ 
        [ 0*GRIP, 0*GRIP_MIN+0*GAP ],
        [ 0*GRIP, 2*GRIP_MIN+2*GAP ],
        [ 1*GRIP, 2*GRIP_MIN+2*GAP ],
        [ 1*GRIP, 0*GRIP_MIN+0*GAP ]
    ]);
}

// Draw a 2D wall
module wall( offset=0 ) {
    width = SIDE_W+2*offset*tan(30);

    polygon ( points = [
        [ 0, -BOX_R-0.01 ],
        [ -width/2-0.01, offset ],
        [ +width/2+0.01, offset ]
    ]);
}

module hexagon( o=0, h=BOX_H, n=6 ) {
    for ( n=[0:60:n*60-1] ) {
        rotate ( [ 0, 0, n ] )
        translate( [ 0, BOX_R, 0 ] ) {
            wall( o );
        }
    }
}

module side() {
    for ( n=[0:HOOKS_N-1] ) {
        translate( [ GRIP+GAP+n*(3*GRIP+2*GAP)-SIDE_W/2, 0, 0 ] )
            hook();
    }
    translate( [ GRIP+GAP+HOOKS_N*(3*GRIP+2*GAP)-SIDE_W/2, 0, 0 ] ) stop();
}

module box( h=BOX_H ) {
    for ( n=[0:60:60*NB_GRIP-1] ) {
        rotate ( [ 0, 0, n ] )
        translate( [ 0, BOX_R, 0 ] ) {
            linear_extrude ( height=h )
                side();
        }
    }
    linear_extrude ( height=h )
        hexagon( n=NB_SIDES );
}

module content_circle( o=0 ) {
    circle(r=CONTENT_R+o);
}
module content_hexagonal( o=0 ) {
    hexagon ( o=-SIDE_T+o );
}
module content_surface( o=0, s=CONTENT_SHAPE ) {
    if ( s==1 ) {
        content_circle( o=o );
    }
    else {
        content_hexagonal( o=o );
    }
}

module container( h=BOX_H, s=CONTENT_SHAPE ) {
    box_h = BOX_H + (CONTAINER_BOTTOMLESS ? 0 : SIDE_T);
    difference() {
        box(h=box_h);
        translate( [0,0,-h] )
            linear_extrude ( height=3*h )
            translate( [0,0,-SIDE_T] )
                content_surface(s=s);
    }
    if ( CONTAINER_BOTTOMLESS==0 ) {
        linear_extrude ( height=SIDE_T )
            content_hexagonal( o=SIDE_T );
    }
}

module knob( s=CONTENT_SHAPE ) {
    translate( [0,0,0] )
    linear_extrude ( height=KNOB_H/2, scale=1.6 )
        content_surface ( o=-CONTENT_R+KNOB_r, s=s );
    translate( [0,0,KNOB_H/2] )
    linear_extrude ( height=KNOB_H/8, scale=2/1.6 )
        content_surface ( o=-CONTENT_R+KNOB_r*1.6, s=s );
    translate( [0,0,KNOB_H/2+KNOB_H/8] )
    linear_extrude ( height=2*KNOB_H/8, scale=1 )
        content_surface ( o=-CONTENT_R+KNOB_r*2, s=s );
    translate( [0,0,KNOB_H/2+3*KNOB_H/8] )
    linear_extrude ( height=KNOB_H/8, scale=1/1.4 )
        content_surface ( o=-CONTENT_R+KNOB_r*2, s=s );
}

module cap( s=CONTENT_SHAPE ) {
    translate( [0,0,BOX_H+50] ) {
        translate( [0,0,0] )
        linear_extrude ( height=SIDE_T )
            content_surface ( o=SIDE_T+(GRIP_W-GAP)/2, s=s );
        translate( [0,0,-SIDE_T] )
        linear_extrude ( height=SIDE_T )
            content_surface ( o=-GAP, s=s );
        translate( [0,0,SIDE_T] )
        knob( s=s );
    }
}

if ( PART_TO_RENDER==0 || PART_TO_RENDER==1 ) {
    color( "grey" )
    container( h=BOX_H, s=CONTENT_SHAPE );
}
if ( PART_TO_RENDER==0 || PART_TO_RENDER==2 ) {
    color( "white" )
    cap( s=CONTENT_SHAPE );
}

// For debug
*
%
for ( n=[0:60:359] ) {
    shape = floor(rands(0,1.99,1)[0]);
    rotate ( [ 0, 0, n ] )
    translate( [ (BOX_D+GRIP_W)*cos(30), (BOX_D+GRIP_W)*sin(30), 0 ] )
    rotate( [0, 0, 120 ] ) {
        if ( PART_TO_RENDER==0 || PART_TO_RENDER==1 ) {
            container( h=rands(5,CONTENT_HEIGHT+20,1)[0], s=shape );
        }
        if ( PART_TO_RENDER==0 || PART_TO_RENDER==2 ) {
            cap(s=shape);
        }
    }
}
