/* [resolution & printing} */
// Resolution of roundings (steps/360°)
fn=128; // [32,64,128,256]
// Print distance
pd=2; 
// print support thickness (set to 0 fo no support)
ps=0.4; 
// print support vertival distance
psvd=0.2; 
// print support horizontal distance
pshd=0.2; 
// print support vertival thickness of bridges
psvth=0.5; 
// view sectioned
vs=0; 

/* [dimensions} */
// inner radius screw-part
uri=2.3; 
// radius of tread
ura=3.3; 
// height of thread
h1=8; 
// cone radius
ara=6; 
// tread pitch
p=0.794; 
// thread height
thrh=0.558;
// total height
h2=36; 
// first inner nozzle radius
dri1=1; 
// wall-thickness nozzle
dwd=1; 
// mm per step
stufe=1; 
// number of nozzles
anz=4; 

/* [attachment} */
// distance of attachment
befe=2; 
// width of connection of attachment
befs=10; 
// inner radius of attachment
befr=6; 
// wall-thickness of attachment
befd=2; 
// height of attachment
befh=3; 
// opening angle attachment
owb=90; 


/* [Hidden} */

tol=0.01;
if(1)
for (i=[0:anz-1])
translate([i*max(ara*2+pd,(befr+befd)*2+pd,pd+(dri1+anz*stufe+dwd)*2),0,0])
    difference()
    {
        Duese(dri1+i*stufe,dri1+i*stufe+dwd); 
        if (vs) cube([1000,1000,1000]);
    }

    
module Duese(dri,dra)
{
    rotate_extrude($fn=fn)
        polygon([[uri,0],[uri,h1],[dri,h2],[dra,h2],[ara,h1],[ura,h1],[ura,0]]);
    translate([0,0,p/2])
        screw_extrude(P=[[0,p/2-tol],[thrh,0],[0,-p/2+tol]], r=ura-tol, p=p, d=h1/p*360, sr=90, er=90, fn=fn, rf="sin");
    befar=befr+befd;
    te=ara+befr+befe;
    wb=90-acos(befs/befar/2);
    wbi=90-acos((befs-2*ps)/befar/2);
    ara2=ara-(ara-dra)*(befh/(h2-h1));
    w2=90-acos(befs/ara2/2);
    w2i=90-acos((befs-2*ps)/ara/2); // ara2 ?
    // echo(str("w2:",w2));
    p_v=P(owb,wb,befr,befd,w2,te,ara2,fn);
    p_vi=P(owb,wbi,befr+ps,befd-2*ps,w2i,te,ara,fn);
    // echo(p_v);
    translate([0,te,h1])
        linear_extrude(height=befh)
            polygon(p_v);
    if (ps)
    {
        translate([0,0,h1-psvth-psvd])
            linear_extrude(height=psvth)
            {
                translate([0,te,0])
                    polygon(p_v);
                difference()
                {
                    circle(r=ara, $fn=fn);
                    circle(r=pshd+ura+thrh+ps, $fn=fn);
                }
            }
        linear_extrude(height=h1-psvd-psvth)
        {
            translate([0,te,0])
                difference()
                {
                    polygon(p_v);
                    polygon(p_vi);
                }
            difference()
            {
                circle(r=ara, $fn=fn);
                circle(r=ara-ps, $fn=fn);
            }
            difference()
            {
                circle(r=pshd+ura+thrh+ps, $fn=fn);
                circle(r=pshd+ura+thrh, $fn=fn);
            }
        }
    }
}
function w4fn(w) = round(w/(360/fn))*(360/fn);
function P(owb,wb,befr,befd,w2,te,ara2,fn) = concat(
        [for(w=[w4fn(450-owb/2):-(360/fn):w4fn(270+wb)]) [cos(w)*(befr+befd),sin(w)*(befr+befd)]],
        [for(w=[w4fn(90-w2):(360/fn):w4fn(90+w2)]) [cos(w)*(ara2),-te+sin(w)*(ara2)]],
        [for(w=[w4fn(270-wb):-(360/fn):w4fn(90+owb/2)]) [cos(w)*(befr+befd),sin(w)*(befr+befd)]],
        [for(w=[w4fn(90+owb/2):360/fn:w4fn(450-owb/2)]) [cos(w)*(befr),sin(w)*(befr)]]
    );

// use-statement uncommented and replaced by part of contents of file for customizer:
// use <inc/screw_extrude_v.scad> // https://www.thingiverse.com/thing:2002982

/**
 * module screw_extrude(P, r, p, d, sr, er, fn)
	by Philipp Klostermann
	
	screw_extrude rotates polygon P 
	with the radi[us|i] r or r1 to r2 
	with increasing height by p mm per turn 
	with a rotation angle of d degrees
	with a starting-ramp of sr degrees length
	with an ending-ramp of er degrees length
	in fn steps per turn.
	
	the points of P must be defined in clockwise direction looking from the outside.
	r must be bigger than the smallest negative X-coordinate in P.
	sr+er <= d
**/
module screw_extrude(P, r, r1, r2, p, d, sr, er, fn, rf)
{
    v = screw_extrude_v(P, r, r1, r2, p, d, sr, er, fn, rf);
	echo ("convexity = round(d/180)+4 = ", v[2]);
	polyhedron(v[0], v[1], convexity = v[2]);
}

function screw_extrude_v(P, r, r1, r2, p, d, sr, er, fn, rf) 
=
    let (
    R1 = (r1 == undef) ? r : r1,
    R2 = (r2 == undef) ? r : r2,
    DR = R2-R1,
    laenge = p*d/360,
    steigung = DR/laenge,
	anz_pt = len(P),
	steps = round(d * fn / 360),
	mm_per_deg = p / 360,
	points_per_side = len(P),
	VL = [ [ R1, 0, 0] ],
	PL = [ for (i=[0:1:anz_pt-1]) [ 0, 1+i,1+((i+1)%anz_pt)] ],
	V = [
		for(n=[1:1:steps-1])
			let 
			(
				w1 = n * d / steps,
                R = R1 + n*(R2 - R1)/steps,
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
                R1 * c1 
                + h1 * steigung * c1 
                + pt[1] * steigung * c1
                + pt[0] * c1 * f 
                , 
            
				R1 * s1 
                + h1 * steigung * s1 
                + pt[1]  *steigung * s1
                + pt[0] * s1 * f
                , 
				h1 + pt[1] * f 
			]
	],
	P1 = [
		for(n=[0:1:steps-3])
			for (i=[0:1:anz_pt-1]) 
			[
				1+(n*anz_pt)+i,
				1+(n*anz_pt)+anz_pt+i,
				1+(n*anz_pt)+anz_pt+(i+1)%anz_pt
			] 
			
		
	],
	P2 = 
	[
		for(n=[0:1:steps-3])
			 for (i=[0:1:anz_pt-1]) 
				[
					1+(n*anz_pt)+i,
					1+(n*anz_pt)+anz_pt+(i+1)%anz_pt,
					1+(n*anz_pt)+(i+1)%anz_pt,
				] 
			
		
	],
	VR = [ [ R2 * cos(d), R2 * sin(d), mm_per_deg * d ] ],
	PR = 
	[
		for (i=[0:1:anz_pt-1]) 
		[
			1+(steps-1)*anz_pt,
			1+(steps-2)*anz_pt+((i+1)%anz_pt),
			1+(steps-2)*anz_pt+i
		]
	]
    )
    [concat(VL,V,VR), concat(PL,P1,P2,PR), round(d/45)+4]
;
 
