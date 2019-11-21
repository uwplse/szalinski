/* Geometry */
// The inner width in mm
Breite_Dose = 84.2;
// The inner height in mm
Hoehe_Dose = 74;
// the tickness oth the cans walls
Wanddicke = 2;
// the thickness of the lids walls
Wanddicke_Deckel = 2;
// the thickness of the floor
Bodendicke = 3;
// the height of an optional rim
Hoehe_Rand = 3;
// the diameter of the optional rim
Durchmesser_Rand = 85.4;
// the height of the thread
Gewindehoehe = 10;
// turns of thread
thread_turns = 4;
// Cut away a bit of the thread to make it blunt and easier going. How much (in percent) shall be cut away?
cut_thread_percent = 10;
// true makes the base for the thread of the can wider to fit the lid
smooth_sides = 1; // [0:no, 1:yes]

/* [Printing] */
// Only set this to no if you want to see both parts together
layout_to_print = 1; // [0:no, 1:yes]
// Only set this to true if you want to have a sectioned view
view_sectioned = 0; // [0:no, 1:yes]
// It is recommended to print the parts seperately. Which part do you want to print
part_to_print = 2; // [0:all, 1:can, 2:cap]
// Distance between parts
print_distance = 5;

/* Resolution and Tolerance */
// resolution of roundings in steps/360°
fn = 128; // [8,16,32,64,128,256]
// space between moving Parts, printer dependent
wackel = 0.5;

/* [Hidden] */
tol = 0.05;
thread_thicknes = ((Gewindehoehe/thread_turns)/2); // *(100-cut_tread_percent)/100;
Windungshoehe = Gewindehoehe / thread_turns;

cut_mittelhoehe = thread_thicknes*cut_thread_percent/100;
cut_breite = thread_thicknes*(100-cut_thread_percent)/100;

difference()
{
	Alles();
	if (view_sectioned!=0)
	{
		rotate([0,0,180])
		translate([-Breite_Dose,0,-tol])
			cube([Breite_Dose*2,Breite_Dose,Hoehe_Dose+Bodendicke+Bodendicke+tol*2+wackel]);
	}
}

module Alles()
{
	if (part_to_print == 0 || part_to_print == 1)
	{
		Dose();	
	}
	if ((part_to_print == 0) || (part_to_print == 2))
	{
		translate([
					0,
					(layout_to_print!=0) && (part_to_print == 0) ?
						-(Breite_Dose+thread_thicknes*2+Wanddicke*2+Wanddicke_Deckel*2+print_distance)
						: 0,
					(layout_to_print!=0) ?
						0
						: Hoehe_Dose + Bodendicke * 2 + wackel/2
					])
			rotate([0,
					(layout_to_print!=0) ? 
						0
						: 180,
					-0])
				Deckel();
	}
}

module Dose()
{
	difference()
	{
		union()
		{
			cylinder(r = Breite_Dose / 2 + Wanddicke, h = Hoehe_Dose + Bodendicke, $fn=fn);
			translate([0,0,Hoehe_Dose + Bodendicke - Gewindehoehe - Windungshoehe/2])
				screw_extrude
				(
					P = (cut_thread_percent > 0) 
					?
						[
							[-tol,thread_thicknes-tol],
							[cut_breite,cut_mittelhoehe],
							[cut_breite,-cut_mittelhoehe],
							[-tol,-(thread_thicknes-tol)]	
						]
					:
						[
							[-tol,thread_thicknes-tol],
							[thread_thicknes,0],
							[-tol,-(thread_thicknes-tol)]	
						],
					r = Breite_Dose / 2 + Wanddicke,
					p = Windungshoehe,
					d = 360 * (thread_turns + 0),
					sr = 0,
					er = 45,
					fn = fn
				);

			translate([0,0,Hoehe_Dose + Bodendicke - Gewindehoehe - Windungshoehe])
			{
				cylinder(r=Breite_Dose/2+thread_thicknes+Wanddicke + ((smooth_sides!=0) ? Wanddicke_Deckel : 0), h=Windungshoehe, $fn=fn);
				translate([0,0,-Wanddicke*2])
					SideSupport(Breite_Dose/2+Wanddicke, 
								thread_thicknes + ((smooth_sides!=0) ? Wanddicke_Deckel : 0), 
								Wanddicke*2 );
			}
		}
		// Innenraum:
		translate([0,0,Bodendicke])
			cylinder(r=Breite_Dose / 2, h=Hoehe_Dose + tol, $fn=fn);
		// Platz für den Dosenrand:
		translate([0,0,Bodendicke + Hoehe_Dose - Hoehe_Rand])
			cylinder(r = Durchmesser_Rand/2, h=Hoehe_Rand + tol, $fn=fn);
		// Überstehendes Gewinde abschneiden:
		translate([0,0,Hoehe_Dose+Bodendicke-tol])
			cylinder(r=Breite_Dose+Wanddicke*2+thread_thicknes*2+tol, h=Windungshoehe*2+tol);
		/*
		*/
	}
}

module Deckel()
{
	difference()
	{
		cylinder(r = Breite_Dose/2 + thread_thicknes + Wanddicke+Wanddicke_Deckel, h = Gewindehoehe + Bodendicke, $fn=fn);
		translate([0,0,Bodendicke])
			cylinder(r=Breite_Dose / 2 + Wanddicke + thread_thicknes + wackel, h= Gewindehoehe + tol, $fn=fn);
	}
	difference()
	{
		translate([0,0, Bodendicke - Windungshoehe/2])
		{	
			screw_extrude
			(
				P = (cut_thread_percent > 0) 
				?
					[
						[tol*2,-(thread_thicknes-tol)],
						[-cut_breite,-cut_mittelhoehe],
						[-cut_breite, cut_mittelhoehe],
						[tol*2,thread_thicknes-tol]
					]
				:
					[
						[tol,-(thread_thicknes-tol)],
						[-thread_thicknes,0],
						[tol,thread_thicknes-tol]
					]
				,
				r = Breite_Dose / 2 + Wanddicke + thread_thicknes + wackel,
				p = Windungshoehe,
				d = 360 * (thread_turns + 0),
				sr = 0,
				er = 45,
				fn = fn
			);
		}
		translate([0,0,Gewindehoehe + Bodendicke])
			cylinder(r=Breite_Dose+Wanddicke*2+thread_thicknes+tol, h=Windungshoehe+tol);
		rotate([180,0,0])
			translate([0,0,-tol])
			cylinder(r=Breite_Dose+Wanddicke*2+thread_thicknes+tol, h=Windungshoehe+tol);
	}
}

module SideSupport(r,w,h)
{
	rotate_extrude($fn=fn)
		translate([r,0,0])
						polygon([[0,0],
							[w,h],
							[0,h]]);
		
}

/**
 * screw_extrude(P, r, p, d, sr, er, fn)
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

module screw_extrude(P, r, p, d, sr, er, fn)
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
					)
			)
			for (pt=P)
			[
				r * c1 + pt[0] * c1 * faktor, 
				r * s1 + pt[0] * s1 * faktor, 
				h1 + pt[1] * faktor 
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
	convex = round(d/45)+4;
	echo ("convexity = round(d/180)+4 = ", convex);
	polyhedron(VG,PG,convexity = convex);
}

