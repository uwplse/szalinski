/*
Water-nozzle with simple clamp for garden hoses etc..
Philipp Klostermann
*/

/*[clamp]*/
// length of jaws
BackenLaenge = 9;
// thickness of jaws
BackenDicke = 10;
// distance between jaws
BackenAbstand = 2.9;
// distance of inner edge of upper clamp
KlammerAbstandOben = 0;
// distance of inner edge of lower clamp
KlammerAbstandUnten = 6;
// length of clamps
KlammernLaenge=7;
// length of joint of both clamps
VerbinderLaenge = 10;
// width of clamp
KlammerBreite = 20;

/*[hose connector]*/
// positions of the starts of the arms connecting clamp and tube
AnschlussBefestigungen = [[24,22],[16,22],[8,22]];
// position of the axis of the hose-connector
AnschlussPosition = [30,50];
// length of thread
GewindeLaenge = 15;
// BSP (non-US) and NPT (US) standard pitch is 1.814 mm, GHT is 2.209
ThreadPitch = 1.814;
// BSP standard major diameter is 26.441 mm NPT is 26.568 
MajorDiameter = 26.441;
// Wall thickness;
wt=2;
// thickness of the arms
ath=3;
// rotation around axis (for nozzle-direction)
AnschlussRotation = 280;

/*[nozzle]*/
// length of nozzle connector
AnschlussLaenge = 12;
// thread pitch of nozzle 
Nozzle_ThreadPitch = 1.5;
// thread diameter of nozzle 
Nozzle_MajorDiameter = 14;
// angle of bending of nozzle
Nozzle_Angle = 50;
// additional length of nozzle
NozzleAdditionalLength = 19;
// inner radius of end of nozzle
Duesenradius = 1;
// thickness of wall at end of nozzle
Duesenspitzenwanddicke = 1;
// radius of bending of nozzle
Duesenrundungsradius = 35;

/*[non-printables]*/
// show the other parts?
show_nonprintables = 1; // [0:no, 1:yes]
// position of center of grinding/cutting weel
WheelCenter=[-2.5, 132.0, 10];
// diameter of grinding/cutting weel
WheelDiameter=222;
// thickness of grinding/cutting weel
WheelThickness=3;
// orientation of grinding/cutting weel
WheelOrientation=[0,90,0];
// Place to reserve for hose
HoseThickness=35;
HoseLenght=100;
// fender-profile
VFender=[[10,-10],[10,12],[6,15],[6,17],[7,17],[13,12],[13,-10]];
FenderDiameter=219.5;

/*[printing]*/
// half space between moving parts
ws = 0.32;
// distance between objects on printer
print_objectdistance = 5;
// support bridges?
support_bridges=1; //[1:yes, 2:no]
// distance between supports
support_abstand = 4;
// vertical distance between support an object
support_objdistance = 0.2;
// thickness of support
support_thickness=0.4;
// resolution of roundings in steps/360°
fn = 128; // [8,16,32,64,128,256]
// Only set this to no if you want to see both parts together
print_layout = 1; // [0:no, 1:yes]
// It is recommended to print the parts seperately. Which part do you want to print?
part_to_print = 0; //[0:all, 1:body, 2:nozzle]
// Only set this to true if you want to have a sectioned view
view_sectioned = 0; // [0:no, 1:yes]

/*[hidden]*/

/*
from https://en.wikipedia.org/wiki/Garden_hose

The thread standard for garden hose connectors in the United States and its 
territories is known as "garden hose thread" (GHT), which is 3/4" diameter 
straight (non-tapered) thread with a pitch of 11.5 TPI (male part has an 
outer diameter of 1 1⁄16 inches (26.99 mm)). This fitting is used with 1/2", 
5/8", and 3/4" hoses.
Outside the United States, the BSP standard is used, which is 3/4" and 14 TPI 
(male part OD is 26.441 mm or 1.04 in). 
The GHT and BSP standards are not compatible, and attempting to connect a GHT 
hose to a BSP fitting will damage the threads, and vice versa.


G/R size:               3⁄4 inch
Thread pitch:           14/inch         1.814mm
Major diameter:         1.0410 inch     26.441 mm
Minor diameter:         0.9495 inch     24.117 mm
Gauge length:           3⁄8	inch        9.5 mm
Tapping drill:
    Taper thread:       24.25 mm
    Straight thread:    24.50 mm
*/

tol=0.01;

MinorDiameter = MajorDiameter - 2*ThreadPitch*5/8;
NozzleThreadLen=KlammerBreite-AnschlussLaenge;
Nozzle_MinorDiameter = Nozzle_MajorDiameter - 2*Nozzle_ThreadPitch*5/8;
Duesenanschluss_Dia = Nozzle_MajorDiameter+wt*2+ws*2;

////////////////////////////////
if ((part_to_print==0) || (part_to_print==1))
    Body();

if ((part_to_print==0) || (part_to_print==2))
    translate([
                print_layout ?
                Nozzle_MajorDiameter/2+wt+ws:
                // (BackenLaenge+KlammernLaenge+VerbinderLaenge+MinorDiameter/2-wt-ThreadPitch/4)
                (AnschlussPosition[0]),

                print_layout ?
                -(Nozzle_MajorDiameter/2+wt+ws+print_objectdistance):
                //MinorDiameter/2,
                AnschlussPosition[1],

                print_layout ?
                NozzleThreadLen
                :0
            ])
        rotate([0,print_layout?0:180,print_layout?180:90])
            rotate([0,0,print_layout?0:AnschlussRotation])
                Duese();
 
if (!print_layout && show_nonprintables)
{
    translate(WheelCenter)
    {
        rotate(WheelOrientation)
        {
            color([0,0.5,0,0.75])
            {
                echo ("Fender:",VFender);
                intersection()
                {
                    rotate_extrude(convexity=8)
                        translate([FenderDiameter/2,0,0])
                            polygon(VFender);
                    translate([-(FenderDiameter-WheelCenter[2]-wt),-(FenderDiameter),-FenderDiameter/2])
                        cube([FenderDiameter,FenderDiameter*2,FenderDiameter]);
                }
            }
            color([0.5,0,0,0.75])
                translate([0,0,-WheelThickness/2])
                    cylinder(r=WheelDiameter/2, h=WheelThickness);
        }
            
    }
    translate([AnschlussPosition[0],AnschlussPosition[1],NozzleThreadLen+AnschlussLaenge+ThreadPitch*0.5])
        color([0,0,0.5,0.5]) 
            cylinder(r=HoseThickness/2, h=HoseLenght);
}

////////////////////////////////

module Bruecke()
{
    for (AnschlussBefestigung=AnschlussBefestigungen)
    {
        AnschlussWinkel = atan2(AnschlussPosition[1]-AnschlussBefestigung[1],AnschlussPosition[0]-AnschlussBefestigung[0]);
        echo("AnschlussWinkel: ", AnschlussWinkel);
        AnschlussEntfernung = sqrt(sqr(AnschlussPosition[1]-AnschlussBefestigung[1])+sqr(AnschlussPosition[0]-AnschlussBefestigung[0]));
        translate([AnschlussBefestigung[0],AnschlussBefestigung[1],0])
            rotate([0,0,AnschlussWinkel])
            {
                translate([-(ath)*abs(tan(90-AnschlussWinkel)),-(ath/2),NozzleThreadLen+Nozzle_ThreadPitch-tol])
                {
                    cube([AnschlussEntfernung+(ath/2)*abs(cos(AnschlussWinkel)),ath,KlammerBreite-NozzleThreadLen-Nozzle_ThreadPitch]);
                }
                if (support_bridges)
                {
                    translate([0,(ath/2),0])
                    {
                        for (x=[support_abstand+(ath/2)*abs(tan(90-AnschlussWinkel)):support_abstand:AnschlussEntfernung-Nozzle_MajorDiameter/2-Nozzle_ThreadPitch/2])
                            translate([x,-ath,0])
                        cube([support_thickness,ath,NozzleThreadLen+Nozzle_ThreadPitch-support_objdistance]);
                    }
                }
            }
    }
}

module Body()
{
    Befestigung(
        bd=BackenDicke, 
        ba=BackenAbstand, 
        bl=BackenLaenge, 
        kao=KlammerAbstandOben, 
        kau=KlammerAbstandUnten, 
        kl=KlammernLaenge, 
        vl=VerbinderLaenge, 
        l=KlammerBreite);

    translate([AnschlussPosition[0],AnschlussPosition[1],0])
    {
        rotate([0,0,-AnschlussRotation])
            difference()
            {
                union()
                {
                    Anschluss();
                }
                if (view_sectioned)
                    translate([0,0,-500])
                    cube([1000,1000,1000]);
            }
            if (!print_layout)
            {
                if (0)
                translate([0, 0, AnschlussLaenge+ThreadPitch*0.75])
                    color([0,0,255,0.25])
                        cylinder(r=33/2, h=GewindeLaenge+ThreadPitch*0.75);
            }
    }
    difference()
    {
        Bruecke();
        translate([AnschlussPosition[0],AnschlussPosition[1],0])
            AnschlussKern(xen=tol);
        BefestigungKern(
            bd=BackenDicke, 
            ba=BackenAbstand, 
            bl=BackenLaenge, 
            kao=KlammerAbstandOben, 
            kau=KlammerAbstandUnten, 
            kl=KlammernLaenge, 
            vl=VerbinderLaenge, 
            l=KlammerBreite,
            xyen=tol);
    }
}        



module Duese()
{
    difference()
    {
        union()
        {
            translate([0,0,-(NozzleThreadLen)])
            {
                translate([0,0,Nozzle_ThreadPitch/2])
                {
                    xs=Nozzle_ThreadPitch/8;
                    screw_extrude(
                        P=InternalThreadSection(pitch=Nozzle_ThreadPitch),
                        r=Nozzle_MajorDiameter/2+xsin+tol, 
                        p=Nozzle_ThreadPitch, 
                        d=(NozzleThreadLen/Nozzle_ThreadPitch)*360+360, 
                        sr=90, 
                        er=45, 
                        fn=fn, 
                        rf="sin");
                }
                rotate_extrude($fn=fn, convexity=4)
                {
                    polygon(
                    [
                        [Nozzle_MajorDiameter/2+xsin, 0],
                        [Nozzle_MajorDiameter/2+xsin+wt, 0],
                        [Nozzle_MajorDiameter/2+xsin+wt, NozzleThreadLen+Nozzle_ThreadPitch+wt],
                        [Nozzle_MajorDiameter/2+xsin, NozzleThreadLen+Nozzle_ThreadPitch+wt]
                    ]
                    );
                }
            }
            RoundtangleToRoundtangleTube(
                dx1=Duesenanschluss_Dia,
                dy1=Duesenanschluss_Dia,
                r1=Duesenanschluss_Dia/2,
                dx2=Duesenradius*2+2*Duesenspitzenwanddicke,
                dy2=Duesenradius*2+2*Duesenspitzenwanddicke,
                r2=Duesenradius+Duesenspitzenwanddicke,
                dz=NozzleAdditionalLength,
                rr=Duesenrundungsradius,
                wt1=wt,
                wt2=Duesenspitzenwanddicke,
                w=Nozzle_Angle,
                steps=45,
                solid=false);
            
       }
        if (view_sectioned)
            rotate([0,0,180])
                translate([0,0,-500])
                    cube([1000,1000,1000]);
    }
}

function ExternalThreadXshift(pitch) =  -(7 * pitch / 8);
function ExternalThreadSection(pitch)
=
    let
    (
        P8=pitch/8,
        H8=pitch/8,
        M=4*P8
    )
[
    [0,0*P8-M],
    [7*H8,3.5*P8-M],
    [7*H8,4.5*P8-M],
    [0,8*P8-M]
]
;

function InternalThreadXshift(pitch) =  pitch / 8;
function InternalThreadSection(pitch)
=
    let
    (
        P8=pitch/8,
        H8=pitch/8,
        M=4*P8
    )
[
    [0,0*P8-M],
    [-6*H8,3*P8-M],
    [-6*H8,5*P8-M],
    [0,8*P8-M]
]
;

xs=ExternalThreadXshift(ThreadPitch);
xsn=ExternalThreadXshift(Nozzle_ThreadPitch);
xsin=InternalThreadXshift(Nozzle_ThreadPitch)+ws;

OuterAnschlussProfil=
[
   // outside, from bottom up
        // nozzle-cylinder:
    [Nozzle_MajorDiameter/2+xsn-ws,0],
    [Nozzle_MajorDiameter/2+xsn-ws,NozzleThreadLen],
        // base for hose-thread:
    [MajorDiameter/2,NozzleThreadLen+AnschlussLaenge],
    [MajorDiameter/2,NozzleThreadLen+AnschlussLaenge+ThreadPitch*1],
    [MajorDiameter/2+xs-ws+tol,NozzleThreadLen+AnschlussLaenge+ThreadPitch*1],
        // rim
    [MajorDiameter/2+xs-ws+tol,NozzleThreadLen+AnschlussLaenge+GewindeLaenge+ThreadPitch*0.5],
    [MajorDiameter/2+xs-wt/2,NozzleThreadLen+AnschlussLaenge+GewindeLaenge+ThreadPitch*1],
];

InnerAnschlussProfil=
[
             // inside, from top down:
            [MajorDiameter/2+xs-ws-wt,NozzleThreadLen+AnschlussLaenge+GewindeLaenge+ThreadPitch*1],
            [MajorDiameter/2+xs-ws-wt,NozzleThreadLen+AnschlussLaenge+ThreadPitch*0],
               // nozzle-cylinder (inside)
            [Nozzle_MajorDiameter/2+xsn-wt,NozzleThreadLen],
            [Nozzle_MajorDiameter/2+xsn-wt,0]
];

module AnschlussKern(xen=0)
{
    rotate_extrude(height=GewindeLaenge, convexity=4*GewindeLaenge/ThreadPitch, $fn=fn)
    {
        polygon
        (
            concat
            (
                [
                    [0,0],
                    [0,NozzleThreadLen+AnschlussLaenge+GewindeLaenge+ThreadPitch*1]
                ],
                verschiebe2D(InnerAnschlussProfil,[xen,0])
            )
        );
    }
}

module Anschluss()
{
    translate([0,0,NozzleThreadLen+AnschlussLaenge+ThreadPitch*0.5])
    {
        echo ("Schlauchanschluss: xs=",xs);
        screw_extrude(
            P=ExternalThreadSection(ThreadPitch),
            r=MajorDiameter/2+xs-ws, 
            p=ThreadPitch, 
            d=(GewindeLaenge/ThreadPitch)*360-180, 
            sr=0, 
            er=90, 
            fn=fn, 
            rf="sin"
        );
    }
    rotate_extrude(height=GewindeLaenge, convexity=4*GewindeLaenge/ThreadPitch, $fn=fn)
    {
        polygon(concat(OuterAnschlussProfil,InnerAnschlussProfil));
    }
    translate([0,0,Nozzle_ThreadPitch/2])
    {
        echo ("Düsenanschluss: xsn=",xsn);
        screw_extrude(
            P=ExternalThreadSection(
                pitch=Nozzle_ThreadPitch,
                xshift=xsn),
            r=Nozzle_MajorDiameter/2+xsn-ws-tol, 
            p=Nozzle_ThreadPitch, 
            d=(NozzleThreadLen/Nozzle_ThreadPitch)*360, 
            sr=90, er=90, fn=fn, rf="sin");
    }
}


/*
            _______________
           /              /|
          /              l |
        --bl-       -vl-/  |
    bd  ################   |
    |   #####//|kao ####   |
     ba|/    //     ####  /
        #####/|kau  #### /
        ################/
             ---kl--
*/



module BefestigungKern(bd, ba, bl, kao, kau, kl, vl, l, xyen=0)
{
    gh=bd*2+ba;
    gl=bl+kl+vl;
    mytol = tol+xyen;

    translate([0,gh,0])
    {
        rotate([90,0,0])
        {
            translate([-mytol,-mytol,0])
            {
                translate([0,0,bd])
                    cube([bl+2*mytol,l+2*mytol,ba+2*mytol]);
                translate([bl,0,bd-kau])
                    cube([kl+2*mytol,l+2*mytol,kau+ba+kao+2*mytol]);
            }
        }
    }
}

module Befestigung(bd, ba, bl, kao, kau, kl, vl, l)
{
   gh=bd*2+ba;
   gl=bl+kl+vl;

   difference()
    {
        translate([0,gh,0])
        {
            rotate([90,0,0])
            {
                cube([gl,l,gh]);
            }
        }
        BefestigungKern(bd, ba, bl, kao, kau, kl, vl, l);
    }
}

/*
function ThreadSection(madia,midia,pitch)
=
    let
    (
        p8=pitch/8,
        rmaj=madia/2-midia/2,
        rmin=0
    )
    [
        [rmin,0],
        [rmaj, 2*p8],
        [rmaj, 3*p8],
        [rmin, 5*p8]
    ]
;
*/

function OuterThreadSection(madia,midia,pitch)
=
    let
    (
        p8=pitch/8,
        rmaj=madia/2-midia/2,
        rmin=2*p8,
        mitte=pitch/2
    )
    [
        [rmin-2*p8,0*p8-mitte],
        [rmaj, 3*p8-mitte],
        [rmaj, 4*p8-mitte],
        [rmin-2*p8, 6*p8-mitte]
    ]
;

function InnerThreadSection(madia,midia,pitch)
=
    let
    (
        p8=pitch/8,
        rmaj=madia/2-midia/2,
        rmin=rmaj-p8,
        mitte=0
    )
    [
        [rmin,0*p8-mitte],
        [rmaj, 3*p8-mitte],
        [rmaj, 4*p8-mitte],
        [rmin-2*p8, 6*p8-mitte]
    ]
;


////////////////////////
// Helpers

/**
 * module screw_extrude(P, r, p, d, sr, er, fn)
	by Philipp Klostermann
	
	screw_rotate rotates polygon P 
	with the radius r 
	with increasing height by p mm per turn 
	with a rotation angle of d degrees
	with a starting-ramp of sr degrees length
	with an ending-ramp of er degrees length
	in fn steps per turn.
	
	the points of P must be defined in clockwise direction looking from the outside.
	r must be bigger than the smallest negative X-coordinate in P.
	sr+er <= d
**/

module screw_extrude(P, r, p, d, sr, er, fn, rf)
{
	anz_pt = len(P);
	steps = round(d * fn / 360);
	mm_per_deg = p / 360;
	points_per_side = len(P);
	echo ("steps: ", steps, " mm_per_deg: ", mm_per_deg);
	
	VL = [ [ r, 0, 0] ];
	PL = [ for (i=[0:1:anz_pt-1]) [ 0, 1+i,1+((i+1)%anz_pt)] ];
	V = [
		for(n=[1:1:steps-1])
			let 
			(
				w1 = n * d / steps,
				h1 = mm_per_deg * w1,
				s1 = sin(w1),
				c1 = cos(w1),
				faktor = (w1 < sr)
				?
					(w1 / sr)
				:
					(
						(w1 > (d - er))
						?
							1 - ((w1-(d-er)) / er)
						:
							1
					),
				f = (rf == "" || rf == "lin") ? faktor
					: (rf == "sin") ? sin(faktor*90)
					: (rf == "sin2") ? (sin(faktor*180-90)+1)/2 : faktor
				
			)
			for (pt=P)
			[
				r * c1 + pt[0] * c1 * f, 
				r * s1 + pt[0] * s1 * f, 
				h1 + pt[1] * f 
			]
	];
	P1 = [
		for(n=[0:1:steps-3])
			for (i=[0:1:anz_pt-1]) 
			[
				1+(n*anz_pt)+i,
				1+(n*anz_pt)+anz_pt+i,
				1+(n*anz_pt)+anz_pt+(i+1)%anz_pt
			] 
			
		
	];
	P2 = 
	[
		for(n=[0:1:steps-3])
			 for (i=[0:1:anz_pt-1]) 
				[
					1+(n*anz_pt)+i,
					1+(n*anz_pt)+anz_pt+(i+1)%anz_pt,
					1+(n*anz_pt)+(i+1)%anz_pt,
				] 
			
		
	];

	VR = [ [ r * cos(d), r * sin(d), mm_per_deg * d ] ];
	PR = 
	[
		for (i=[0:1:anz_pt-1]) 
		[
			1+(steps-1)*anz_pt,
			1+(steps-2)*anz_pt+((i+1)%anz_pt),
			1+(steps-2)*anz_pt+i
		]
	];
			
	VG=concat(VL,V,VR);
	PG=concat(PL,P1,P2,PR);
	convex = round(d/45)+6;
	echo ("convexity = round(d/180)+4 = ", convex);
	polyhedron(VG,PG,convexity = convex);
}

function verschiebe2D(V,D) = [ for (v=V) v+D ];

function sqr(x) = x*x;

/* flatten is found in th OpenSCAD documentation;
	https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/List_Comprehensions#Flattening_a_nested_vector
*/
function flatten(l) = [ for (a = l) for (b = a) b ] ;

/* rotateY() & vrotateY() by Philipp Klostermann
	return the given position(s) rotated around an y-axis, that is xs mm away in -x direction from v
*/
function rotateY(v,w,xs) =
	let 
	(
		x = v[0] + xs, z = v[2],
		wy = atan2(z,x),
		r = sqrt(x*x+z*z),
		xd = r * cos(wy+w) - xs,
		zd = r * sin(wy+w)
	)
	concat
	(
		xd,
		v[1],
		zd
	);
function vrotateY(V,w,xs) =	(w != 0) ? [ for (v =V)	rotateY(v,w,xs)	] :	V;


/* RoundedRectangleVec() by Philipp Klostermann
	returns a vector of 3d positions representing a rounded rectangle
	with the witdh dx and height dy an the corner-radius r at height z
*/
stepa=360/fn;
function RoundedRectangleVec(dx, dy, r, z) =
concat(
	// front side:
	[[-(dx/2 - r), -dy/2, z]], [[dx/2 - r, -dy/2, z]],
	// front right corner:
	[ for (w=[270+stepa:stepa:360-stepa]) [cos(w)*r+(dx/2-r),sin(w)*r-(dy/2-r),z] ],
	// right side:
	[[dx/2, -(dy/2 - r), z]], [[dx/2, dy/2 - r, z]],
	// back right corner:
	[ for (w=[stepa:stepa:90-stepa]) [cos(w)*r+(dx/2-r),sin(w)*r+(dy/2-r),z] ],
	// back side:
	[[dx/2 - r, dy/2, z]], [[-(dx/2 - r), dy/2, z]],
	// back left corner:
	[ for (w=[90+stepa:stepa:180-stepa]) [cos(w)*r-(dx/2-r),sin(w)*r+(dy/2-r),z] ],
	// left side:
	[[-dx/2, dy/2 - r, z]], [[-dx/2, -(dy/2 - r), z]],
	// front left corner:
	[ for (w=[180+stepa:stepa:270]) [cos(w)*r-(dx/2-r),sin(w)*r-(dy/2-r),z] ],
	// the middle:
	[ [0, 0, z ] ]
);
	
/* RoundtangleToRoundtangleTube() by Philipp Klostermann
	creates a bended tube with transition beween two rounded rectangular cross sections
	dx1: outer x-size bottom side
	dy1: outer y-size bottom side
	r1: radius of the roundig of the edges bottom side
	dx2: outer x-size upper side
	dy2: outer y-size upper side
	r2: radius of the roundig of the edges upper side
	dz: additional height (normally left 0, positive value necessary if rr=0)
	rr: radius of the bending of the tube
	wt1: wall-thickness of lower side
	wt2: wall-thickness of upper side
	w: bending angle of tube
	steps: how many intervals (resolution of bending)
	solid=false: if true, wt1 & wt2 are ignored and a solid object will be created.
	*/
module RoundtangleToRoundtangleTube(dx1,dy1,r1,dx2,dy2,r2,dz,rr,wt1,wt2,w,steps,solid=false)
{
	echo ("RoundtangleToRoundtangleTube(",dx1,dy1,r1,dx2,dy2,r2,dz,rr,wt1,wt2,w,steps);
	wstep=w/steps;
	VP = flatten(	
	[ 
		for (i=[0:1:steps])
			let(
				dx = dx1 + i*((dx2-dx1)/steps),
				dy = dy1 + i*((dy2-dy1)/steps),
				r = r1 + i*((r2-r1)/steps),
				wt = wt1 + i*((wt2-wt1)/steps)
			)
			vrotateY(
				concat(
					RoundedRectangleVec(dx, dy, r, (dz/steps)*i),
					RoundedRectangleVec(dx-2*wt, dy-2*wt, max(r-wt,0), (dz/steps)*i)
					),
					(w/steps)*i,
					rr
			    )
	]);
	V = VP; // concat(VP, [rotateY([0,0,0], w, rr)]);
	n=(len(V))/(steps+1)/2;
	echo("len(V)", len(V));
	echo("n", n);
	//echo(V);
	FOU = solid
		? 
			concat 
			(
				// bottom side:
				[ for (i=[0:1:n-3]) [i, i+1, n] ],
				// top side;
				[ for (i=[0:1:n-3]) [steps*n*2+i+1, steps*n*2+i, steps*n*2+n] ]
			)
		:
			concat 
			(
				// bottom side:
				[ for (i=[0:1:n-3]) [i,n+i+1,n+i] ],
				[ for (i=[0:1:n-3]) [i,i+1,n+i+1] ],
				// top side;
				[ for (i=[0:1:n-3]) [steps*n*2+n+i, steps*n*2+i+1, steps*n*2+i] ],
				[ for (i=[0:1:n-3]) [steps*n*2+n+i, steps*n*2+n+i+1, steps*n*2+i+1] ]
			);
	FAI = solid
		?
			flatten(
			[ 
				for (j=[0:1:steps-1])
					concat(
						[ for (i=[0:1:n-3]) [j*n*2+i, j*n*2+n+n+i, j*n*2+n+n+i+1] ] ,
						[ for (i=[0:1:n-3]) [j*n*2+i, j*n*2+n+n+i+1, j*n*2+i+1] ]
						)
			]
			)
		:
			flatten(
			[ 
				for (j=[0:1:steps-1])
					concat(
						[ for (i=[0:1:n-3]) [j*n*2+i, j*n*2+n+n+i, j*n*2+n+n+i+1] ] ,
						[ for (i=[0:1:n-3]) [j*n*2+i, j*n*2+n+n+i+1, j*n*2+i+1] ],
						[ for (i=[0:1:n-3]) [j*n*2+n+i, j*n*2+3*n+i+1, j*n*2+3*n+i] ],
						[ for (i=[0:1:n-3]) [j*n*2+n+i, j*n*2+n+i+1, j*n*2+3*n+i+1]]
						)
			]
		);
	F = concat(FOU,FAI);
	// F = concat(FOU);
	// echo (F);
	polyhedron(V,F,10);
}
