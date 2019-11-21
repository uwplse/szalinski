// Parametric Trapezoidal Flange in OpenSCAD, for Thingiverse customizer, Tyler Montbriand, 2019

// Diameter of stem, in mm
STEM_D=10.2;
// Diameter of base, in mm
BASE_D=22;
// Thickness of base, in mm
BASE_THICK=3.5;
// Height of stem, in mm
STEM_HEIGHT=10;
// Hole pattern diameter, in mm
F=16;
// Hole diameter, in mm
F2=3.5;
// How much to bevel, in mm
BEVEL=1;
// Outside diameter of thread, in mm
DMAJ=8;
// Pitch of thread, in mm
PITCH=2; // [0.5:0.25:10]
STARTS=4; // [0:1:6]
// Number of screw holes
HOLES=4;    // [0:1:8]

// Whether screw holes connect to edges.
OPEN=1; // [0:1]

// Added to outside thread diameters, in mm.
$OD_COMP=-0.25;
// Added to inside thread diameters, in mm.
$ID_COMP=1;
// Thickness offset for leadscrews, in mm
$PE=0.35;
$fs=1;
$fa=3;

difference() {
    taper(d=DMAJ,h=BASE_THICK+STEM_HEIGHT, off=BEVEL, in=true)
    flange(B=STEM_HEIGHT, C=STEM_D,G=BASE_THICK,H=BASE_D, F=F, F2=F2, off=BEVEL,
    holes=HOLES?([0:360/HOLES:360-(360/HOLES)]):[],
    open=OPEN);
    comp_thread(DMAJ=DMAJ, L=BASE_THICK+STEM_HEIGHT+PITCH,
    PITCH=PITCH, A=30, H1=0.5/2, H2=0.5/2, STARTS=STARTS, in=true);
}

 /**
 * Generates truncated, symmetrical thread profiles like UTS or ACME
 * A is pitch angle
 * MIN is distance below centerline in pitch units
 * MAX is distance above centerline in pitch units
 * TOL makes tooth narrower/wider and deeper/shallower than perfect by TOL amount,
 * again in units of pitch
 *
 * Resuls biased to zero and inverted -- just like tsmthread() likes them.
 */
function prof(A,MIN,MAX)=let(
        M=tan(90-(A/2)), // Slope of tooth
        X1=((M/2)-(MIN*2))/M, // Given a Y of MIN, calculate X
        X2=((M/2)+(MAX*2))/M, // Given a Y of MAX, calculate X
    OFF=-X1*M) [
    [0, OFF + M*X1], // Starting point, always
    [X1+X1,OFF + M*X1],
    [X1+X2,OFF+M*X2],
    [X1+2-X2,OFF+M*X2],
    // Profile wraps here
]/2;

/**
 * Profile Interpolation
 *
 * prof() generates, and tsmthread expects, a profile of [X,Y] values like
 * [ [0,0.25], [0.25, 1], [0.5,0.25] ]
 * The first X must be 0.  The last X cannot be 1.  All values are in pitch units.
 *
 * Get a value out with interpolate(PR, X).
 *      interpolate(PR, 0.25) would return 1,
 *      interpolate(PR, 0) would give 0.25,
 *      interpolate(PR, 0.125) would  give someting between.
 *      interpolate(PR, 0.5) would give 0.25.
 *      interpolate(PR,0.75) would wrap, interpolating between P[2]-p[0].
 *
 * Should wrap cleanly for any positive or negative value.
 */

/**
 * Helper function for interpolate().  Allows
 * a thread profile to repeat cleanly for increasing
 * values of N, with growing X accordingly.
 *
 * P=[ [0,0], [0.5,0.5] ];
 * echo(wrap(P,0)); // should be [0,0]
 * echo(wrap(P,1)); // should be [0.5,0.5]
 * echo(wrap(P,2)); // should be [0,0]+[1,0]
 * echo(wrap(P,3)); // should be [0.5,0.5]+[1,0]
 * echo(wrap(P,4)); // should be [0,0]+[2,0]
 * etc.
 */
function wrap(V, N, ACC=[1,0])=let(M=floor(N/len(V))) V[N%len(V)] + M*ACC;

/* Very basic interpolation.  mix(A,B,0)=A, mix(A,B,1)=B, 0 <= X <= 1 */
function mix(A,B,X)=(A*(1-X)) + B*X;

/**
 * Line-matching.  V1-V2 are a pair of XY coordinates describing a line.
 * Returns [X,Y] along that line for the given X.
 */
function mixv(V1,V2,X)=let(XP=X-V1[0]) mix(V1,V2,XP/(V2[0]-V1[0]));
/* Same, but X for given Y */
function mixvy(V1,V2,Y)=let(OUT=mixv([ V1[1],V1[0] ], [V2[1],V2[0]], Y)) [ OUT[1],OUT[0] ];

/**
 * Returns Y for given X along an interpolated Y.
 * V must be a set of points [ [0,Y1], [X2,Y2], ..., [XN,YN] ] X<1
 * X can be any value, even negative.
 */
function interpolate(V, X, ACC=[1,0], N=0)=
//  Speedup that doesn't help much
    (X>1) ? interpolate(V, (X%1),ACC,N)+floor(X)*ACC[1]:
//      Unneeded case
//    (X<0) ? interpolate(V, 1+(X%1),ACC,N)+floor(X)*ACC[1] :
    (X>wrap(V,N+1)[0]) ?
    interpolate(V,X,ACC,N+1)
:   mixv(wrap(V,N,ACC),wrap(V,N+1,ACC),X)[1];

/**
 *  V = [ [X0,Y0], [X1,Y1], ..., [XN,YN] ] where X0 < X1 < X2 ... < XN
 *
 *  Finds N where XN > X.
 */
function binsearch(PR,X,MIN=0,IMAX=-1)=let(MAX=(IMAX<0)?len(PR):IMAX,
    N=floor((MIN+MAX)/2))
    ((MAX-MIN) <= 1) ? N
    :   X < PR[N][0] ?
        binsearch(PR,X,MIN,ceil((MIN+MAX)/2))
    :   binsearch(PR,X,floor((MIN+MAX)/2),MAX);

/**
 *  V = [ [X0,Y0], [X1,Y1], .., [XN,YN] ] where X0 < X1 < ... < XN and XN < 1
 *
 *  Returns N for given XN like binsearch(), except it wraps X > 1 to 0-1
 *  and returns correspondingly higher N.
 */
function binsearch2(PR,X)=binsearch(PR,X%1)+floor(X)*len(PR);

/**
 * Faster lookup for interpolate().  log(N)
 */
function interpolate2(V,X,ADD=[1,0])=V[binsearch(V,(X%1))][1]+floor(X)*ADD[1];

function interpolaten(V,X,ADD=[1,0])=binsearch(V,(X%1))+floor(X);

module tsmthread(DMAJ=20    // Major diameter
    , L=50,                 // Length of thread in mm.  Accuracy depends on pitch.
    , PITCH=2.5,            // Scale of the thread itself.
    , PR=prof(60,0.8660*(7/16), 0.8660*(3/8)) // Thread profile, i.e. ACME, UTS, other
    , STARTS=1,             // Want a crazy 37-start thread?  You're crazy.  but I'll try.
    , TAPER=0,              // Adds an offset of [1,tan(TAPER)] per thread.
    , STUB=0,               // Extends a cylinder below the thread.  In pitch units.
    , STUB_OFF=0            // Reduces the diameter of stub.  In pitch units.
    ) {

    /* Minimum number of radial points required to match thread profile */
    POINTS_MIN=len(PR)*STARTS*2;

    // OpenSCAD-style fragment generation via $fa and $fs.
    // See https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Other_Language_Features
    function points_r(r)=ceil(max(min(360.0 / $fa, (r*2)*3.14159 / $fs), 5));

    // Rounds X up to a nonzero multiple of Y.
    function roundup(X,Y) = Y*max(1,floor(X/Y) + (((X%Y)>0)?1:0));

    // Points can be forced with $fn
    POINTS=($fn>0) ? $fn :
        // Otherwise, it decides via $fs and $fa, with a minimum of
        // 16, rounded up to POINTS_MIN
        max(roundup(16,POINTS_MIN), roundup(points_r(DMAJ/2),POINTS_MIN));

    if(POINTS % POINTS_MIN )
    {
        echo("WARNING:  DMAJ",DMAJ,"PITCH",PITCH,"STARTS",STARTS, "POINTS", POINTS);
        echo("WARNING:  POINTS should be a multiple of",POINTS_MIN);
        echo("WARNING:  Top and bottom geometry may look ugly");
    }

    ADD=add_npt(TAPER); /* How much radius to add to pitch each rotation */

    // 1*STARTS rows of thread tapper happens which isn't drawn
    // Add this to radius to compensate for it
    TAPER_COMP=STARTS*ADD[1]*PITCH;


    // [X,Y,Z] point along a circle of radius R, angle A, at position Z.
    function traj(R,A,Z)=R*[sin(A),cos(A),0]+[0,0,Z];

    /**
     * The top and bottom are cut off so more height than 0 is needed
     * to generate a thread.
     */
    RING_MIN=(STARTS+1)*len(PR);

    // Find the closest PR[N] for a given X, to estimate thread length
    function minx(PR,X,N=0)=(X>wrap(PR,N+1,ADD)[0])?minx(PR,X,N+1):max(0,N);

    // Calculated number of rings per height.
    RINGS=let(SEG=floor(L/PITCH), X=(L%PITCH)/PITCH) max(RING_MIN+1,
        RING_MIN+SEG*len(PR) + minx(PR,X));

    SHOW=0;     // Debug value.  Offsets top and bottom to highlight any mesh flaws
    
    /**
     * How this works:  Take PR to be the outside edge of a cylinder of radius DMAJ.
     * Generate points for 360 degrees.  N is angle along this circle, RING is height.
     *
     * Now, to turn this circle into a spiral, a little Z is added for each value of N.
     * The join between the first and last vertex of each circle must jump to meet.
     */
    function zoff(RING,N)=(wrap(PR, RING,ADD)[0] + STARTS*(N/POINTS));
    FLAT_B=zoff(len(PR)*STARTS,0);  // Z coordinates of bottom flat
    FLAT_T=zoff(RINGS-len(PR),0);   // Z coordinates of top flat
   
    /**
     * Deliminate what spiral coordinates exist between the top and bottom flats.
     * Used for loops, so that only those polygons are joined and nothing outside it.
     */
    // function ringmin(N)=binsearch2(PR,FLAT_B - (N/POINTS)*STARTS)+1;
    // function ringmax(N)=binsearch2(PR,FLAT_T - (N/POINTS)*STARTS);

    // Fast-lookup arrays
    MIN=[for(N=[0:POINTS-1]) binsearch2(PR,FLAT_B - (N/POINTS)*STARTS)+1 ];
    MAX=[for(N=[0:POINTS-1]) binsearch2(PR,FLAT_T - (N/POINTS)*STARTS) ];
        
    // Array-lookup wrappers which speed up ringmax/ringmin manyfold.
    // binsearch makes them fast enough to be tolerable, but still much better
    function ringmax(N)=MAX[N%POINTS];
    function ringmin(N)=MIN[N%POINTS];
    
    /**
     * Difficult difficult lemon difficult.
     * Interpolate along the profile to find the points it cuts through
     * the main spiral.
     *
     * Some difficulty is RING coordinates increase P, while N decreases
     * it as it crosses the spiral!
     *
     * Taper must be accounted for as well.
     */
    function radius_flat(RING,N)=
        TAPER_COMP+
        (DMAJ/2)-PITCH*interpolate(PR,wrap(PR,len(PR)*STARTS+RING,ADD)[0] - 
            // Modulous because this is all the same taper
            (STARTS*(N/POINTS))%1 - STARTS,ADD)
            // Of course we have to un-taper too, sigh
            -ADD[1]*STARTS*(((N/POINTS)*STARTS)%1);
    /**
     * Radius is generated differently for the top&bottom faces than the spiral because 
     * they exist in different coordinate spaces.  Also, the top&bottom faces must be
     * interpolated to fit.
     */
    function cap(RING,ZOFF=0,ROFF=0)=[
        for(N=[0:POINTS-1])
        let(P=N/POINTS, A=-360*P,R=radius_flat(RING,N)+ROFF)
            traj(R,A,zoff(RING,0)+ZOFF) 
        ];

    /**
     * Debug function.
     * Draws little outlines at every ring height to compare spiral generation
     * to face generation.
     */
    module test() {
        for(RING=[0:RINGS-1]) {
            POLY=cap(RING, ROFF=0.1);
            LIST=[ [ for(N=[0:POINTS-1]) N ] ];

            polyhedron(POLY,LIST);
        }
    }

    /**
     * Helper array for generating polygon points.
     * DATA[0]+N, N=[0:POINTS-1] for a point on the bottom face
     * DATA[1]+N, N=[0:POINTS-1] for a point on the top face
     * DATA[2]+N + (M*POINTS), N=[0:POINTS-1], M=[0:RINGS-1] for
     * a point on the main spiral.
     */
    DATA=[ 0,                          // 0 = bottom face
           POINTS,                     // 1 = top face
           4*POINTS,                   // 2 = main spiral
           2*POINTS,                   // 3 = stub top
           3*POINTS,                   // 4 = stub bottom
           2*POINTS+POINTS*len(PR),    
           2*POINTS+POINTS*len(PR) + 
                RINGS*POINTS
        ];
    
    /**
     * This is it, this is where the magic happens.
     * Given a point in RING,N spiral coordinates, this decides whether it
     * ends up in the top, the spiral, or the bottom so I don't have to.
     *
     * TODO:  Optimize this.  This is a pinch point.
     */
    function point(RING,N)=
        (RING<ringmin(N)) ? DATA[0]+(N%POINTS) // Bottom flat
       :(RING>ringmax(N))? DATA[1]+(N%POINTS)  // Top flat
       :DATA[2]+RING*POINTS + (N%POINTS);       // Inbetween

    // Like above but takes a vector to transform into a triangle
    function pointv(V)=[ for(N=V) point(N[0],N[1]) ];

    
    /**
     * List of points, organized in sections.
     * 0 - RINGS-1          Bottom cap
     * RINGS - (2*RINGS)-1  Top cap
     * RINGS - (3*RINGS)-1  Stub
     * (2*RINGS) - end      Spiral
     * Do not change this arrangement without updating DATA to match!
     */
    POLY=concat(
        // Bottom cap, top cap
        cap(len(PR)*STARTS,-SHOW),cap(RINGS-len(PR),SHOW),
        // Stub top
        [ for(N=[0:POINTS-1]) let(R=(DMAJ/2)-(STUB_OFF*PITCH)) traj(R,-360*(N/POINTS), 1) ],
        // Stub bottom
        [ for(N=[0:POINTS-1]) let(R=(DMAJ/2)-(STUB_OFF*PITCH)) traj(R,-360*(N/POINTS),
           -STUB) ],
        //cap(len(PR)*STARTS, -STUB),
    
        // Main spiral
        [ for(RING=[0:RINGS-1], N=[0:POINTS-1])
            let(A=-360*(N/POINTS),
                P1=wrap(PR,RING,ADD),
                P2=wrap(PR,RING+len(PR)*STARTS,ADD),
                UV=mix(P1,P2,N/POINTS),
                R=TAPER_COMP+(DMAJ/2)-PITCH*UV[1], Z=UV[0])
                traj(R, A, Z)
        ]);


    /**
     * Remove redundant points from polygons.
     * collapse([0,1,1,2,3,4,0]) == [0,1,2,3,4]
     */
    function collapse(V)=[ for(N=[0:len(V)-1]) if(V[(N+1)%len(V)] != V[N]) V[N] ];

    // Should we use quads here?  Will fewer loops be faster?
    // Probably shouldn't alter the hard-won mesh maker, but
    // can we do more per loops somehow?
    PLIST=concat(
        // Main spiral A
        [   for(N=[0:POINTS-2], RING=[ringmin(N)-1:ringmax(N)])
            pointv([ [RING,N+1],[RING,N],[RING+1,N] ])
        ],
        // Main spiral B
        [   for(N=[0:POINTS-2], RING=[ringmin(N+1)-1:ringmax(N+1)])
            pointv([[RING+1,N+1],[RING,N+1],[RING+1,N]])
        ],
        // stitch A
        [   for(N=POINTS-1, RING=[ringmin(N)-1:ringmax(0)])
            let(P=pointv([ [RING,N],[RING+1,N],[RING+len(PR)*STARTS,0] ]))
            if((P[0] != P[1]) && (P[0] != P[2]) && (P[1] != P[2])) P
        ],
        // Stitch B
        [
            for(N=0, RING=[ringmin(N)-1:ringmax(N)])
            let(P=pointv([[RING+1,N],[RING,N],[RING+1-len(PR)*STARTS,POINTS-1]]))
            if((P[0] != P[1]) && (P[0] != P[2]) && (P[1] != P[2])) P
        ],

        // Bottom extension
        [ if(STUB) for(WELD=[[0,3],[3,4]], N=[0:POINTS-1])
            [ DATA[WELD[0]]+N, DATA[WELD[0]]+(N+1)%POINTS, DATA[WELD[1]]+(N+1)%POINTS ] ],
        [ if(STUB) for(WELD=[[0,3],[3,4]], N=[0:POINTS-1])
            [ DATA[WELD[1]]+N, DATA[WELD[0]]+N, DATA[WELD[1]]+(N+1)%POINTS ] ],
        
        // Bottom flat
        [ [ for(N=[0:POINTS-1]) N+DATA[(STUB>0)?4:0] ] ],
        // top flat.  Note reverse direction to mirror the normal.
        [ [ for(N=[0:POINTS-1], N2=POINTS-(N+1)) N2+DATA[1] ] ]
    );


    // Screw it, scale after, PITCH=1 is so much less math
    scale([1,1,PITCH]) translate([0,0,STUB?STUB:-FLAT_B]) polyhedron(POLY, PLIST, convexity=5);
}

// Compensated Threads.
// Threads are thinned by $PE mm.  Diameter is adjusted $OD_COMP/$ID_COMP amount
// depending on whether they're inside or outside threads.
// Only use this with leadscrews.
// A and H values as with prof().
module comp_thread(DMAJ=11, L=20, PITCH=2, A=30, H1=0.5/2, H2=0.5/2, STARTS=1, in=false)
{
    PE2=(in?$PE :-$PE)*(2.0/PITCH)*cos(A);
//    echo("PE",PE2,"$PE",$PE);
    PR=prof(A, H1-PE2, H2+PE2);
//    echo("comp_thread","DMAJ",DMAJ,"L",L,"PITCH",PITCH,"A",A,"H1",H1,"H2",H2,"=",PR);

   tsmthread(DMAJ+(in?$ID_COMP:$OD_COMP), L=L, PITCH=PITCH, STARTS=STARTS, PR=PR);
}



/******************************************************************************/
/********************************NPT THREAD************************************/
/******************************************************************************/

/**
 * Tapering only works without distorting teeth because of the special
 * prof_npt thread profile.
 */
module thread_npt(DMAJ=10, L=10, PITCH=2.5, TAPER=1+(47/60), STUB=0) {
    PR=prof_npt(TAPER);
//    echo(PR);
    echo(add_npt(TAPER));
//    echo(TAPER);
    tsmthread(DMAJ=DMAJ, L=L, PITCH=PITCH, TAPER=TAPER, PR=PR, STUB=STUB);
}

/**
 * Differentiate an array.  delta([0,1,2,3,4,5])=[1,1,1,1]
 * Works on vectors too.
 */
function delta(V)=[ for(N=[0:len(V)-2]) V[N+1]-V[N] ];

// Integrate an array up to element N.
function integ(A, ADD=[ [1,0], [0,1] ], KEEP=[ [0,0], [0,0] ])=[
    for(N=[0:len(A)-2]) integ2(A, N, ADD, KEEP)	];
function integ2(A, N,
    ADD=[ [1,0], [0,1] ],
    KEEP=[ [0,0],[0,0] ])=
        (N<=0)?
            A[0]
        :(A[N]*KEEP) + (A[N]*ADD) + (integ2(A, N-1, ADD, KEEP) * ADD);

function normy(V)=V/V[1];               // Normalize a vector along Y, i.e. [3,0.5] -> [6,1]
function add_npt(TAPER)=[1,tan(TAPER)]; // Why so easy? tan(ANGLE) is the slope of an angle.

/**
 * NPT magic:  Length is added to one specific tooth so the
 * distorted half is bent back up to the correct angle.
 *
 * Only one value needs adding to.  The other fixes itself
 * via adding [1,M] per wraparound.
 */
function prof_npt(TAPER=30, H1=0.8/2, H2=0.8/2) =
    let(M=tan(TAPER), PR2=delta(prof(60,H1,H2))) 
    integ([
            [0,0],  // Replace origin deleted by delta()
            PR2[0], // bottom flat, OK
            // This is already a perfect 60 degrees, only scale it.
            // Have to add length of line AND length of flat!  Arrrrgh.
            PR2[1]+M*normy(PR2[1])*(PR2[1][0]+PR2[0][0]),
            PR2[2], // top flat
            PR2[3] ]);

/******************************************************************************/
/******************************MISC UTILITIES**********************************/
/******************************************************************************/

/**
 *  Scales up objects to imperial inches and and alters $fs accordingly, so
 *  imperial() cylinder(d=1, h=1); renders a satisfying number of facets
 *  instead of freaking 5.
 */
module imperial(F=25.4) { 
    // modified $... values will be seen by children
    $fs     =$fs     /F;
    $OD_COMP=$OD_COMP/F;
    $ID_COMP=$ID_COMP/F;
    $PE     =$PE     /F;
    $SCALE  =         F;
    scale(F) children();
}

/**
 * A double-pointed cone or pyramid of exactly 45 degrees for tapers.
 * obeys $fn, $fs, $fa, r, d, center=true in a manner like cylinder().
 * example:
 *
 *  // Outside taper
 *  taper(d=10, h=10, off=1) cylinder(d=10, h=10);
 *
 *  // Inside taper
 *  difference() { cylinder(d=10, h=10); taper(in=true, d=5, h=10, off=1) cylinder(d=5, h=10); }
 */
module taper(d=1,h=1,off=0,r=0, center=false, in=false) {
    function points_r(r)=$fn?$fn:(ceil(max(min(360.0 / $fa, (r*2)*3.14159 / $fs), 5)));

    if(r) taper(r*2, h, off, r=0, center=center, in=in);
    else {
        // Calculate number of fragments same way openscad does
        U=points_r(d/2);

        if(in) difference() {
            children();
            translate(center?[0,0,0]:[0,0,h/2]) union() {
                for(M=[[0,0,1],[0,0,0]]) mirror(M)
                translate([0,0,h/2-d/2-off]) cylinder(d1=0, d2=d*2, h=d, $fn=points_r(d/2));
            }
        }
        else intersection() { 
            children();
            translate(center?[0,0,0]:[0,0,h/2]) scale(h+d-off) polyhedron(
                concat( [ for(N=[0:U-1]) 0.5*[cos((N*360)/U),sin((N*360)/U),0] ],
                        // Top and bottom of pyramid
                        [ 0.5*[ 0,0,1], -0.5*[0,0,1] ] ),
                concat( [ for(N=[0:U-1]) [ N, U, (N+1)%U]],
                        [ for(N=[0:U-1]) [ (N+1)%U, U+1, N]]
                ));
        }
    }
}

// Flange pattern as described by this URL:
// https://www.helixlinear.com/Product/PowerAC-38-2-RA-wBronze-Nut/
//
//      /---\   <--------
//      |   |           |
// ---> |>>>|           |
// |    |   |           |
// |    |   \---\ <--   |
// |    |       |   |   |
// F*2  |       |   C   H
// |    |       |   |   |
// |    |   /---/ <--   |
// |    |   |           |
// ---> |>>>|           |
//      |   |           |
//      \---/   <--------
//      ^   ^   ^
//      |-G-|-B-|
//
//      B is height of stem
//      C is diameter of stem
//      F is the radius of the screw pattern
//      F2 is the diameter of the screw holes.
//      G is the thickness of the base
//      H is width of base.
//
//      holes is the pattern of holes to drill.  default is 4 holes, 1 every 90 degrees.
//      when open is true, the holes are sots extending to the edge.
//      off is how much to bevel.
module flange(B,C,F,F2,G,off=0,holes=[45:90:360], open=false) {
    taper(d=H,h=G,off=off) linear_extrude(G, convexity=3) offset(off/2) offset(-off/2) difference() {
        circle(d=H);
        for(A=holes) hull() {
            translate(F*[sin(A),cos(A)]/2) circle(d=F2);
            if(open) translate(3*F*[sin(A),cos(A)]/2) circle(d=F2);
        }
    }
    if(B && C) taper(d=C,h=G+B,off=off) cylinder(d=C, h=G+B);
}

// What the hell is this?  I don't know.
module garnet() intersection_for(A=[[0,0,1],[0,1],[1,0]]) rotate(45*A) cube(10*[1,1,1],center=true);

//garnet();