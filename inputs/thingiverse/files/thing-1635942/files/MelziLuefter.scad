// MelziLuefter.scad by Philipp Klostermann (pk-scad at pkmx dot de) 
// Use and modify as you whish, but mention me.

/* [Geometry] */
// angle of bending
Knickwinkel=45; // [0:90]
// radius of bending
Knickradius=50;
// additional height
Zusatzhoehe=0;
// thickness of walls
Wanddicke = 2;

/* [Resolution] */
// resolution of roundings in steps/360°
fn = 128; // [8,16,32,64,128,256]
// resolution of small roundings
fns = 32; // [8,16,32,64]
// how many steps for the bending?
steps = 32;

/* [Printing] */
// turn object with fan-opening down
print_layout=0; // [0:no, 1:yes]
// enable print support
print_support=0; // [0:no, 1:yes]
// distance between support and object
support_dist=0.3;
// thickness of support
supTh=0.4;

/* [Parts Positions & sizes] */
// positions of screw-holes on board
SchrPos = [[4, 4], [46, 4]];
// diameter of screw-holes on board
PcbLochdurchmesser = 3;

// positions of polarized caps 
ElkoPositionen = [ [33, 19], [33, 41], [33, 62], [33, 84] ];
// diameter of polarized caps 
ElkoDurchmesser = 7;
// height of polarized caps 
ElkoHoehe = 8;
// additional space for polarized caps 
ElkoPlatz = 0.5;

// positions of heat-sinks
KuehlkoerperPositionen = [ [20, 9], [20, 30], [20, 52], [20, 73] ];
// y-size of heat-sinks
KuelkoerperBreite = 10;
// x-size of heat-sinks 
KuehlkoerperTiefe = 9;
// height of heat-sinks
KuelkoerperHoehe = 6;
// additional space for heat-sinks
KuehlkoerperPlatz = 0.5;

// positions of trim-pots
PotiPositionen = [ [18, 19], [18, 41], [18, 63], [18, 83] ];
// edge length of trim-pots
PotiKantenlaenge = 6;
// height of trim-pots
PotiHoehe = 2;

// positions of SMD-parts in 0603 case
SMD0603Positionen = [ [24, 5], [19, 6.5] ];
// edge length of 0603 SMD-parts
SMD0603Kantenlaenge = 3.6;
// height of 0603 SMD-parts
SMD0603Hoehe = 1.5;

// positions of terminals
AnschlussklemmenPositionen = [ [36, 6] ];
// y-size of terminals
AnschlussklemmenBreite = 16;
// x-size of terminals
AnschlussklemmenTiefe = 8;
// height of terminals
AnschlussklemmenHoehe = 10;

/* [Fan Dimensions] */
// edge-to-edge of fan-case
FanAussenkante=40;
// radius of corners
FanEckenradius=4;
// diameter of fan
FanDurchmesser=38;
// distance between two screw-holes on one edge
FanSchraubenabstand=32;
// thickness of platfom holding the fan
FanHalterdicke=4;
// diameter of screw-holes
FanSchraubendurchmesser = 3;

/* [Hidden] */

FanhalterWT = (FanAussenkante-(FanDurchmesser))/2;
DiaNut = PcbLochdurchmesser*2;
Basisposition = KuehlkoerperPositionen[0];
Basislaenge = KuehlkoerperPositionen[len(KuehlkoerperPositionen)-1][1] + KuelkoerperBreite - KuehlkoerperPositionen[0][1]; // 75;
Basisbreite = KuelkoerperBreite;
Basishoehe = 15;
// distance between support walls
support_interval=DiaNut-supTh/2;

wt1 = Wanddicke;
dx1 = KuelkoerperBreite;
dy1 = Basislaenge + 2 * KuehlkoerperPlatz + 2 * wt1;
r1 = Wanddicke;
dx2 = FanDurchmesser + 2 * FanhalterWT;
dy2 = FanDurchmesser + 2 * FanhalterWT;
r2 = FanDurchmesser/2;
wt2 = Wanddicke;
dz = Zusatzhoehe;
rr = Knickradius;
tol = 2;
sa = (SchrPos[1][0]-SchrPos[0][0])+DiaNut;
Schraubenmitte = SchrPos[0][0]+sa/2-DiaNut/2;
vBasis = [Basisposition[0]+Basisbreite/2, -(Basisposition[1]+Basislaenge/2), 0];
stepa=360/fn;

rotate([0,(print_layout!=0)?-Knickwinkel-90:0,0])
{
	Befestigung();
	Luftduese();
}

module Befestigung()
{
	difference()
	{
		union()
		{
			for (p=SchrPos)
			{
				translate([p[0],-p[1],0])
				{
					cylinder(r=DiaNut/2, h=Basishoehe, $fn=fns);
				}
			}
			translate([SchrPos[0][0],-SchrPos[0][1]-DiaNut/2,Basishoehe/2])
			{
				cube(
				[ 
					max(SchrPos[1][0]-SchrPos[0][0], DiaNut),
					max(SchrPos[1][1]-SchrPos[1][1], DiaNut),
					Basishoehe/2
				]);
			}
			translate([Basisposition[0], -(Basisposition[1]-KuehlkoerperPlatz), Basishoehe/2])
			{
				cube([Basisbreite, Basisposition[1]-SchrPos[0][1], Basishoehe/2]);
			}
		}
		for (p=SchrPos)
		{
			translate([p[0],-p[1],-tol])
			{
				cylinder(r=PcbLochdurchmesser/2, h=Basishoehe+2*tol, $fn=fns);
			}
		}
	}
	if (print_support != 0)
	{
		O = [ rotateY(
				// [-sa/2, 0, 0], // lo
				[-dy2/2, 0, dz], // lo
				Knickwinkel,
				rr
				),
			rotateY(
				// [sa/2, 0, 0], // ro
				[dy2/2, 0, dz], // ro
				Knickwinkel,
				rr
				) ];
		S=[
			[sa/2, 0, support_dist], // ru
			[-sa/2, 0, support_dist], // lu
			[	
				O[0][0]-FanHalterdicke*sin(Knickwinkel)	/* - support_dist * sin(Knickwinkel) */ + vBasis[0]-Schraubenmitte, 
				O[0][1], 
				O[0][2]+FanHalterdicke*cos(Knickwinkel)	/* - support_dist * cos(Knickwinkel) */
			], // lo
			[
				O[1][0]-FanHalterdicke*sin(Knickwinkel)	/* - support_dist * sin(Knickwinkel) */ + vBasis[0]-Schraubenmitte, 
				O[1][1], 
				O[1][2]+FanHalterdicke*cos(Knickwinkel) /* - support_dist * cos(Knickwinkel) */
			] // ro
			
		];
		translate([ SchrPos[0][0]+sa/2-DiaNut/2, 
					-(SchrPos[0][1]-DiaNut/2), 
					Basishoehe])
		{
			// translate([0,-100,0]) #cube([0.1,200,0.1]);
			for (sy=[0:support_interval:DiaNut])
			{
				translate([0,-(sy+supTh),0])
				{
					V=concat(S,	[ for (s=S) [s[0], s[1]+supTh, s[2]] ]);
					Octohedron(V);
				}
			}
			for	(V=[[ 
					[ S[1][0]+supTh, S[1][1]-DiaNut, S[1][2] ],
					[ S[1][0], S[1][1]-DiaNut, S[1][2] ],
					[ S[2][0], S[2][1]-DiaNut*2, S[2][2] ],
					[ S[2][0]+supTh*cos(Knickwinkel), S[2][1]-DiaNut*2, S[2][2]+supTh*sin(Knickwinkel) ],
					[ S[1][0]+supTh, S[1][1], S[1][2] ],
					[ S[1][0], S[1][1], S[1][2] ],
					[ S[2][0], S[2][1]+DiaNut, S[2][2] ],
					[ S[2][0]+supTh*cos(Knickwinkel), S[2][1]+DiaNut, S[2][2]+supTh*sin(Knickwinkel) ]
				],
				[
					[ S[0][0]+supTh, S[0][1]-DiaNut, S[0][2] ],
					[ S[0][0], S[0][1]-DiaNut, S[0][2] ],
					[ S[3][0], S[3][1]-DiaNut*2, S[3][2] ],
					[ S[3][0]+supTh*cos(Knickwinkel), S[3][1]-DiaNut*2, S[3][2]+supTh*sin(Knickwinkel) ],
					[ S[0][0]+supTh, S[0][1], S[0][2] ],
					[ S[0][0], S[0][1], S[0][2] ],
					[ S[3][0], S[3][1]+DiaNut, S[3][2] ],
					[ S[3][0]+supTh*cos(Knickwinkel), S[3][1]+DiaNut, S[3][2]+supTh*sin(Knickwinkel) ]
				]])
			{
				Octohedron(V);
			}
		}
	}
}

module Luftduese()
{
	difference()
	{
		union()
		{
			translate(vBasis)
			{
				RoundtangleToRoundtangleTube(
					dx1=dx1,dy1=dy1,r1=r1,wt1=wt1,
					dx2=dx1,dy2=dy1,r2=r1,wt2=wt1,
					dz=Basishoehe,rr=0,w=0,steps=1);
				translate([0,0,Basishoehe])
				{
					RoundtangleToRoundtangleTube(
						dx1=dx1,dy1=dy1,r1=r1,wt1=wt1,
						dx2=dx2,dy2=dy2,r2=r2,wt2=FanhalterWT,
						dz=dz,rr=rr,w=Knickwinkel,steps=steps);
					translate(rotateY([0,0,dz],Knickwinkel,rr))
					{
						rotate([0,-Knickwinkel,0])
						{
							translate([0,0,0])
							{
								// translate([0,-100,0]) cube([0.1,200,0.1]);
								difference()
								{
									RoundtangleToRoundtangleTube(
									dx1=FanAussenkante,
									dy1=FanAussenkante,
									r1=FanEckenradius,
									wt1=FanhalterWT,
									dx2=FanAussenkante,
									dy2=FanAussenkante,
									r2=FanEckenradius,
									wt2=FanhalterWT,
									dz=FanHalterdicke,
									rr=FanEckenradius,
									w=0,
									steps=1,
									solid=true);
									translate([0,0,-2*tol])
									{
										cylinder(r=FanDurchmesser/2, h=FanHalterdicke+4*tol, $fn=fn);
										for (lx=[-FanSchraubenabstand/2:
													FanSchraubenabstand:
													FanSchraubenabstand/2])
										{
											for (ly=[-FanSchraubenabstand/2:
														FanSchraubenabstand:
														FanSchraubenabstand/2])
											{
												translate([lx,ly,0])
												{
													cylinder(r=FanSchraubendurchmesser/2, 
															h=FanHalterdicke+4*tol, $fn=fns);
												}
											}
										}
									}
								}
							}
						}
					}
				}
			};
		}
		for (P=ElkoPositionen)
		{
			translate([P[0],-(P[1]+ElkoDurchmesser/2),-tol])
			{
				cylinder(r = ElkoDurchmesser / 2 + ElkoPlatz, h=ElkoHoehe+tol, $fn=fn);
			}
		}
		for (P=KuehlkoerperPositionen)
		{
			translate([P[0]-Wanddicke,-(P[1]+KuelkoerperBreite+KuehlkoerperPlatz),-tol])
			{
				cube([KuehlkoerperTiefe+2*Wanddicke+2*tol, KuelkoerperBreite+KuehlkoerperPlatz*2, KuelkoerperHoehe+tol]);
			}
		}
		for (P=PotiPositionen)
		{
			translate([P[0],-(P[1]+PotiKantenlaenge),-tol])
			{
				cube([PotiKantenlaenge, PotiKantenlaenge, PotiHoehe+tol]);
			}
		}
		for (P=SMD0603Positionen)
		{
			translate([P[0],-(P[1]+SMD0603Kantenlaenge),-tol])
			{
				cube([SMD0603Kantenlaenge, SMD0603Kantenlaenge, SMD0603Hoehe+tol]);
			}
		}
		for (P=AnschlussklemmenPositionen)
		{
			translate([P[0],(-P[1])-AnschlussklemmenBreite,-tol])
			{
				cube([AnschlussklemmenTiefe, AnschlussklemmenBreite, AnschlussklemmenHoehe+tol]);
			}
		}
	}
}

////////////////////////
// Helpers

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
	echo(V);
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

/* Octohedron() by Philipp Klostermann
	Takes an array of 8 points describing an octohedron in the following order:
		0..3: front face seen from lower y side with the lower 
			right point first, the rest in clockwise direction,
		4..7: back face seen from the same direction with the same order
	Octohedron([ [10,0,0], [0,0,0], [0,30,0], [10,30,0],
				[10,0,20], [0,0,20], [0,30,20], [10,30,20]]
	creates a cuboid with a size of 10*20*30 mm.
*/ 
module Octohedron(P)
{
	echo("Octohedron(",P, ")");
	aru = 0; alu = 1; alo = 2; aro = 3; 
	iru = 4; ilu = 5; ilo = 6; iro = 7; 
	b_au = P[aru][0]-P[alu][0];
	b_ao = P[aro][0]-P[alo][0]; 
	b_iu = P[iru][0]-P[ilu][0];
	b_io = P[iro][0]-P[ilo][0]; 
	echo(" b_au: ", b_au," b_ao: ", b_ao," b_iu: ", b_iu," b_io: ", b_io);
	if (b_au || b_iu || b_ao || b_io)
	{
		PI = (b_iu > 0 && b_io > 0) ? 
				[[iru, ilu, ilo], [ilo, iro, iru]] : // Innenseite (vorne)
				(b_iu == 0)	? 
				(
					(b_io == 0) ? [] // keine Fläche
					: // (b_io != 0)
					[[ilo, iro, ilu]]  //  Innenseite = Dreieck Spitze unten
				)
				: 
					[[ilu, ilo, iru]]; // Innenseite = Dreieck Spitze oben
		PA = (b_au > 0 && b_ao > 0) ?
				[[alu, aru, aro], [aro, alo, alu]] : // Außenseite (hinten)
				(b_au == 0)	?
				(
					(b_ao == 0) ? [] // keine Fläche
					:
					[[aro, alo, aru]]  //  Außenseite = Dreieck Spitze unten
				)
				:
					[[aru, aro, alu]]; // Außenseite = Dreieck Spitze oben
		PL = [[ilu, alu, alo], [alo, ilo, ilu]]; // linke Seite
		PR = [[aru, iru, iro], [aru, iro, aro]]; // rechte Seite
		PO = (b_io > 0 && b_ao > 0) ? 
				// [[ilo, alo, aro], [iro, ilo, aro]]: //  Oberseite
				[[ilo, alo, iro],[alo, aro, iro]]: //  Oberseite
				[];
		PU = (b_iu > 0 && b_au > 0) ? 
				[[alu, ilu, aru], [aru, ilu, iru]] : // Unterseite
				[];
		
		echo(" PI: ", PI," PA: ", PA," PL: ", PL," PR: ", PR," PO: ", PO," PU: ", PU);
		F = concat(PI,PR,PA,PL,PO,PU);
			
		// echo ("polyhedron(",P,F,")");
		polyhedron(P,F,10);
	}
}

