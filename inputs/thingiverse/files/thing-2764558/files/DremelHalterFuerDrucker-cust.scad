/* [resolution & printing} */

// Resolution of roundings (steps/360°)
fn = 128; // [32,64,128,256]
// Resolution of small roundings (steps/360°)
fns = 32; // [16,32,64,128]
// Space between parts
sbp = 0.15;
// Space for moving
sfm = 0.20;
// show Dremel case
function_view = 0; // [0:no,1:yes]

/* [dimensions} */

// wall thickness
wall = 5;
// length of screws
fixhole_screwlen = 10;
// reserve space for screw-head and screwdriver
fixhole_screwhead = 8;
// width of mounting plate
mountplate_width = 62;
// height of mounting plate
mountplate_height = 52;
// diameter of holes for mounting screws
mounthole_diameter = 3;
// additional distance between Dremel-case and mounting plate
mountplate_distance = 2;
// make holes for screwdriver and screw-head
make_screwdriver_holes = 1; // [0:no,1:yes]
// thickness of wall around Dremel-thread
threadwall = 8;

/* [mounting holes} */

// x-position of first hole (middle is 0)
hole1_x = -21;
// y-position of first hole
hole1_y = 47;
// x-position of second hole (middle is 0)
hole2_x = 22;
// y-position of second hole
hole2_y = 9;
// x-position of third hole (middle is 0)
hole3_x = 22;
// y-position of third hole
hole3_y = 9;
// x-position of fourth hole (middle is 0)
hole4_x = 22;
// y-position of fourth hole
hole4_y = 9;

/* [Dremel holding thread} */

// outer diameter of thread
dremel_gewinde_aussen = 18.6;
// thickness of thread
dremel_gewinde_dicke = 1.2;
// height of thread-section
dremel_gewinde_wh = 1.25;
// height of rim of thread-section
dremel_gewinde_rh = 0.25;
// height of one winding
dremel_gewinde_p = 2;
// height of whole thread
dremel_gewinde_h = 8;
// diameter of ring above thread
dremel_ring_d = 19;
// height of ring above thread
dremel_ring_h = 3;
// angle to turn whole tread (make screwing of dremel stop at the rigth place)
dremel_thread_turning_angle = -80;

/* [Dremel case] */

// height of widening part
dremel_h1 = 36;
// diameter of lower section of widening part
dremel_dia1 = 22.2;
// height of upper part
dremel_h2 = 150;
// diameter of upper part
dremel_dia2 = 47;
// at which height are the ventilation holes?
dremel_airholes_z = 31;
// how high are the ventilation holes?
dremel_airholes_h = 4;
// diameter of finger-hole for fixbutton
dremel_fixbuttonhole_d = 16;
// at which height is the fixbutton
dremel_fixbuttonhole_z = 8;
// where shall the fixbutton-hole be? (angle, 0 = right)
dremel_fixbuttonhole_a = 180;

/* [Hidden] */

tol = 0.01;
Bodendicke = dremel_ring_h+dremel_gewinde_h;
dremel_gewinde_innen = dremel_gewinde_aussen - 2 * dremel_gewinde_dicke;
mountplate_entfernung = dremel_dia2/2+mountplate_distance;
mountholepos = 
[
    [hole1_x,hole1_y],
    [hole2_x,hole2_y],
    [hole3_x,hole3_y],
    [hole4_x,hole4_y]
];
dremel_windungen = dremel_gewinde_h / dremel_gewinde_p;

// main:
if(function_view)
    translate([0,0,Bodendicke])
        dremel_shape(0,0);
All();

module All()
{
    difference()
    {
        union()
        {
            translate([-mountplate_width/2,mountplate_entfernung,0])
                cube([mountplate_width,wall,mountplate_height]);
            hull()
            {
                translate([-mountplate_width/2,mountplate_entfernung,0])
                    cube([mountplate_width,wall,dremel_airholes_z+Bodendicke]);
                //cylinder(r = mountplate_entfernung+wall, h = Bodendicke, $fn = fn);
                cylinder(r = dremel_gewinde_aussen/2+threadwall,
                        h = Bodendicke, 
                        $fn = fn);
            }
        }
        translate([0,0,Bodendicke+dremel_fixbuttonhole_z])
            rotate([0,90,dremel_fixbuttonhole_a])
                cylinder(r = dremel_fixbuttonhole_d/2, h = mountplate_width, $fn = fn);
        for (p = mountholepos)
        {
            translate([p[0],mountplate_entfernung+wall+tol,p[1]])
            {
                rotate([90,0,0])
                {
                    cylinder(r = mounthole_diameter/2+sfm, h = fixhole_screwlen, $fn = fns);
                    translate([0,0,fixhole_screwlen-tol])
                        cylinder(r = fixhole_screwhead/2+sfm, h = dremel_dia2, $fn = fns);
                }
            }
        }
        translate([0,0,-tol])
        {
            cylinder(r = dremel_gewinde_aussen/2+sbp, h = Bodendicke+2*tol, $fn = fn);
        }
        translate([0,0,dremel_gewinde_h])
        {
            cylinder(r = dremel_ring_d/2+sbp, h = dremel_ring_h+tol, $fn = fn);
        }
        translate([0,0,Bodendicke])
            cylinder(r1=dremel_dia1/2+sfm, r2=dremel_dia2/2+sfm, h=dremel_h1, $fn=fn);
            // simple_dremel_shape(sbp,sfm);
    }
    dremel_contergewinde_wh = dremel_gewinde_p - dremel_gewinde_rh - 2 * sbp;
    dremel_contergewinde_rh = dremel_gewinde_p - dremel_gewinde_wh - 1 * sbp;
    rotate([0,0,dremel_thread_turning_angle])
    {
        PnfScrewExtrude
        (
            P  = 
            [
                [tol, dremel_contergewinde_wh/2],
                [tol, -dremel_contergewinde_wh/2],
                [-dremel_gewinde_dicke+sbp, -dremel_contergewinde_rh/2],
                [-dremel_gewinde_dicke+sbp, dremel_contergewinde_rh/2]
            ],
            r = dremel_gewinde_aussen/2+sbp,
            p = dremel_gewinde_p, 
            d = 360 * dremel_windungen, 
            sr = 180, 
            er = 180,
            fn = fn, 
            rf = "sin2"
        );
    }
}

module simple_dremel_shape(sbp,sfm)
{
    rotate_extrude($fn = fn, convexity=4)
    {
        polygon
        (
            [
                [0, -Bodendicke-tol],
                [dremel_gewinde_innen/2+sbp, -Bodendicke-tol],
                [dremel_gewinde_innen/2+sbp, -dremel_ring_h],
                [dremel_ring_d/2+sbp, -dremel_ring_h],
                [dremel_ring_d/2+sbp, tol],
                [dremel_dia1/2+sfm, tol],
                [dremel_dia2/2+sfm, dremel_h1],
                [dremel_dia2/2+sfm, dremel_h1+dremel_h2],
                [0, dremel_h1+dremel_h2]
            ]
        );
    }
}

module dremel_shape(sbp,sfm)
{
    rotate_extrude($fn = fn, convexity=4)
    {
        polygon
        (
            [
                [0, -Bodendicke-tol],
                [dremel_gewinde_innen/2+sbp, -Bodendicke-tol],
                [dremel_gewinde_innen/2+sbp, -dremel_ring_h],
                [dremel_ring_d/2+sbp, -dremel_ring_h],
                [dremel_ring_d/2+sbp, tol],
                [dremel_dia1/2+sfm, tol],
                [dremel_dia2/2+sfm, dremel_h1],
                [dremel_dia2/2+sfm, dremel_h1+dremel_h2],
                [0, dremel_h1+dremel_h2]
            ]
        );
    }
    translate([0,0,-Bodendicke+dremel_gewinde_wh/2+tol])
    rotate([0,0,180])
    PnfScrewExtrude
    (
        P  = 
        [
            [-tol, -dremel_gewinde_wh/2-sbp],
            [-tol, dremel_gewinde_wh/2+sbp],
            [dremel_gewinde_dicke+sbp, dremel_gewinde_rh/2+sbp],
            [dremel_gewinde_dicke+sbp, -dremel_gewinde_rh/2-sbp]
        ],
        r = dremel_gewinde_innen/2,
        p = dremel_gewinde_p, 
        d = 360 * dremel_windungen, 
        sr = 180, 
        er = 10,
        fn = fn, 
        rf = "sin2"
    );
}

///////////////////////////////////
// from pnf-lib:
/*
function pnf_is_tiangle_flat(v_p, v_f, i) = 
    let (P = [for (pi = v_f[i]) v_p[pi]])
    (P[0] == P[1]) || (P[0] == P[2]) || (P[1] == P[2]);
function pnf_flat_triangle_indexes_v(v_p, v_f)  = 
    [ for (i = [0:len(v_f)-1]) if (pnf_is_tiangle_flat(v_p, v_f, i)) i ];
*/
function pnf_flatten_v(l) = [ for (a = l) for (b = a) b ] ;

function pnf_row_of_faces_v(n,basis1,basis2,close1 = -1,close2 = -1,inc1 = 1,inc2 = 1)  = 
concat(
    [ 
        for (b = [0:1:n-1]) 
            [
                // lower left:
                basis1 + b * inc1, 
                // upper left:
                basis2 + b * inc2, 
                // upper right:
                (b < n - 1) ? // closing not necessary:
                    basis2 + (b + 1) * inc2
                :
                    (close2 == -1) ? // don't close
                        basis2 + (b + 1) * inc2
                    : 
                        (close2 == -2) ? // auto
                            basis2
                        :
                            close2
            ] 
    ],
    [ 
        for (b = [0:1:n-1]) 
            [
                // lower left:
                basis1 + b * inc1,
                // upper right:
                (b < n - 1) ? // closing not necessary:
                    basis2 + (b + 1) * inc2
                : 
                    (close2 == -1) ? // don't close:
                        basis2 + (b + 1) * inc2 
                    : // close:
                        (close2 == -2) ? // auto
                            basis2
                        :
                            close2,
                // lower right
                (b < n - 1) ? // closing not necessary:
                    basis1 + (b + 1) * inc1 
                : 
                    (close1 == -1) ? // dont close?
                        basis1 + (b + 1) * inc1
                    :
                        (close1 == -2) ? // close auto
                            basis1
                        :
                            close1
                                
            ] 
    ]
);

function pnf_side_faces_v(nz,nr,basis = 0,close = false) = 
pnf_flatten_v(
    [ 
        for (a = [0:1:nz-1]) 
            pnf_row_of_faces_v(
                n = nr,
                basis1 = basis+a*nr,
                basis2 = basis+(a+1)*nr,
                close1 = close?-2:-1,
                close2 = close?-2:-1,
                inc1 = 1,
                inc2 = 1)
    ]
);

function pnf_concentric_faces_v(n,center,first,close = false,inc = 1) = 
[
    for (i = [0:n-1])
    [
        center, 
        first + i * inc,
        first + (((i < n - 1) || (!close)) ? i * inc + 1 : 0)
    ]
];

function pnf_turn_sides_faces_v(F) = [for (f = F) [f[2], f[1], f[0]] ];


module PnfScrewExtrude(P, r, r1, r2, p, d, sr, er, srxy, erxy, srz, erz, fn, rf, srf, srfxy, srfz, erf, erfxy, erfz)
{
    v = pnf_screw_extrude_pnf_v(P, r, r1, r2, p, d, sr, er, srxy, erxy, srz, erz, fn, rf, srf, srfxy, srfz, erf, erfxy, erfz);
	echo ("convexity = round(d/180)+4 = ", v[2]);
	polyhedron(v[0], v[1], 6);
}

function pnf_screw_extrude_pnf_v(P, r, r1, r2, p, d, sr, er, srxy, erxy, srz, erz, fn, rf, srf, srfxy, srfz, erf, erfxy, erfz) 
 = 
    let (
    SRXY = (srxy == undef) ? sr : srxy,
    SRZ = (srz == undef) ? sr : srz,
    ERXY = (erxy == undef) ? er : erxy,
    ERZ = (erz == undef) ? er : erz,
    R1 = (r1 == undef) ? r : r1,
    R2 = (r2 == undef) ? r : r2,
    DR = R2-R1,
    SRFXY = (srfxy == undef) ? (srf == undef) ? (rf == undef) ? "lin" : rf : srf : srfxy,
    SRFZ = (srfz == undef) ? (srf == undef) ? (rf == undef) ? "lin" : rf : srf : srfz,
    ERFXY = (erfxy == undef) ? (erf == undef) ? (rf == undef) ? "lin" : rf : erf : erfxy,
    ERFZ = (erfz == undef) ? (erf == undef) ? (rf == undef) ? "lin" : rf : erf : erfz,
    // length 
    laenge = p*d/360,
    steigung = DR/laenge,
	anz_pt = len(P),
	steps = round(d * fn / 360 ), // - 0.5),
	mm_per_deg = p / 360,
	points_per_side = len(P),

	PL = [ [ R1, 0, 0] ],
	FL = pnf_concentric_faces_v(
        n = anz_pt,
        center = 0,
        first = 1,
        close = true),
	PR = [ [ R2 * cos(d), R2 * sin(d), mm_per_deg * d ] ],
	FR = pnf_turn_sides_faces_v(pnf_concentric_faces_v(
        n = anz_pt,
        center = 1+(steps-1)*anz_pt,
        first = 1+(steps-2)*anz_pt,
        close = true)),
        
	P = [
		for(n = [1:1:steps-1])
			let 
			(
				w1 = n * (360/fn), // d / steps,
                R = R1 + n*(R2 - R1)/steps,
				h1 = mm_per_deg * w1,
				s1 = sin(w1),
				c1 = cos(w1),
				faktorxy = (w1 < SRXY) 
                    ? (w1 / SRXY) 
                    : ( (w1 > (d - ERXY)) ? 1 - ((w1-(d-ERXY)) / ERXY) : 1 ),
                RFXY = (w1 < SRXY) ? SRFXY : ERFXY,
                RFZ = (w1 < SRZ) ? SRFZ : ERFZ,
				fxy = (RFXY == "" || RFXY == "lin") ? faktorxy
					: (RFXY == "sin") ? sin(faktorxy*90)
					: (RFXY == "sin2") ? (sin(faktorxy*180-90)+1)/2 : faktorxy,
				faktorz = (w1 < SRZ) 
                    ? (w1 / SRZ) 
                    : ( (w1 > (d - ERZ)) ? 1 - ((w1-(d-ERZ)) / ERZ) : 1 ),
				fz = (RFZ == "" || RFZ == "lin") ? faktorz
					: (RFZ == "sin") ? sin(faktorz*90)
					: (RFZ == "sin2") ? (sin(faktorz*180-90)+1)/2 : faktorz
				
			)
			for (pt = P)
			[
                R1 * c1 + h1 * steigung * c1 + pt[1] * fz * steigung * c1 + pt[0] * c1 * fxy, 
				R1 * s1 + h1 * steigung * s1 + pt[1] * fz * steigung * s1 + pt[0] * s1 * fxy, 
				h1 + pt[1] * fz
			]
	],
            
    FS = pnf_side_faces_v(nz = steps-2,nr = anz_pt,basis = 1,close = true)
    )
    [concat(PL,P,PR), concat(FL,FS,FR), round(d/45)+4, steps]
;

