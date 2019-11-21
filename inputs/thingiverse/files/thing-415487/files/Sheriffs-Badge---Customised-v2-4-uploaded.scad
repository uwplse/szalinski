// Sherriff's Protest Badge
// http://www.thingiverse.com/apps/customizer/run?thing_id=415487

// preview[view:south, tilt:top]

/* [Hidden] */
Letter_height=0; // workaround to t=Letter_height issue with include<>
kh=0;
//
OS_Y=floor(version_num()/10000);
OS_MMDD=version_num()-OS_Y*10000;
OS_String=str("OS V=",OS_Y,OS_MMDD<1000 ? "0" : "",OS_MMDD);
echo(OS_String);
include <write/Write.scad>

/* [Global] */


/* [Text] */
//1_Top_rim="Aa16!GgjipqMy.?";

// Use spaces to help align
1_Top_rim="Orbiton";
// Center Text cut to fit if too long
2_Upper_center="Letters";
// See Font size tab to adjust gap in center
3_Lower_center="KneWave"; 
// Use Spacing tab to squeeze text if needed
4_Bottom_rim="BlackRose";

//for debugging
//1_Top_rim=OS_String;
//4_Bottom_rim="gjpqy why is this showing?";
//4_Bottom_rim="abcdef";


/* [Font Size] */

// Also see text Spacing tab:
1_Top_rim_size=55;				//[35:90]
// :
2_Upper_center_size=70;			//[35:120]
// :
3_Lower_center_size=70;			//[35:120]
// :
4_Bottom_rim_size=60;			//[35:90]
// Gap between the two central lines:
5_Center_gap=40;				//[0:90]

/* [Fonts] */

// 
1_Top_rim_font = "write/orbitron.dxf"; //["write/Letters.dxf":Letters,"write/orbitron.dxf":Orbitron,"write/BlackRose.dxf":BlackRose,"write/braille.dxf":Braille,"write/knewave.dxf":KneWave]
// 
2_Upper_center_font ="write/Letters.dxf"; //["write/Letters.dxf":Letters,"write/orbitron.dxf":Orbitron,"write/BlackRose.dxf":BlackRose,"write/braille.dxf":Braille,"write/knewave.dxf":KneWave]
//
3_Lower_center_font ="write/knewave.dxf"; //["write/Letters.dxf":Letters,"write/orbitron.dxf":Orbitron,"write/BlackRose.dxf":BlackRose,"write/braille.dxf":Braille,"write/knewave.dxf":KneWave]
//
4_Bottom_rim_font = "write/BlackRose.dxf"; //["write/Letters.dxf":Letters,"write/orbitron.dxf":Orbitron,"write/BlackRose.dxf":BlackRose,"write/braille.dxf":Braille,"write/knewave.dxf":KneWave]
//4_Bottom_rim_font = "write/knewave.dxf"; //["write/Letters.dxf":Letters,"write/orbitron.dxf":Orbitron,"write/BlackRose.dxf":BlackRose,"write/braille.dxf":Braille,"write/knewave.dxf":KneWave]


/* [Spacing] */
// Together < 10 > Apart:
1_Top_rim_spacing = 10;				//[5:15]
// :
2_Upper_center_spacing = 10;		//[5:15]
// :
3_Lower_center_spacing = 10;		//[5:15]
// :
4_Bottom_rim_spacing = 10;			//[5:15]

/* [Options] */

// on star
Number_of_points=5;				//[3,4,5,6,7]
// - raised height in mm
Letter_height=1.5;		//[0.5,1.0,1.5,2.0,2.5]
// select none if you don't want one
Mounting_hole=1.5; 		//[0:None,1.0:Small,1.5:Medium,2.0:Large]

module dummy() {}		// stop customiser processing variables

function decent(text,font) = (font == "write/BlackRose.dxf")
								? decentBlackRose(text)
								: decentOther(text);
		
function decentOther(text) = 
					(search(text,[ ["g"],["j"],["p"],["q"],["y"] ]) == [])
					? 0
					: 1;
function decentBlackRose(text) = 
			(search(text,[ ["A"],["G"],["g"],["j"],["K"],["p"],["q"],["R"],["X"],["y"] ]) == [])
			? 0
			: 0.5;

// translate to less typing variables
t1=str(1_Top_rim);			// workaround in case only digits are entered.
t2=str(2_Upper_center);
t3=str(3_Lower_center);
t4=str(4_Bottom_rim);

th1=1_Top_rim_size/10;
th2=2_Upper_center_size/10;
th3=3_Lower_center_size/10;
th4=4_Bottom_rim_size/10;

tco=5_Center_gap/10;

f1=1_Top_rim_font;
f2=2_Upper_center_font;
f3=3_Lower_center_font;
f4=4_Bottom_rim_font;

s1=1_Top_rim_spacing/10;
s2=2_Upper_center_spacing/10;
s3=3_Lower_center_spacing/10;
s4=4_Bottom_rim_spacing/10;

np=Number_of_points;
mhr=Mounting_hole;

// radius top - will need to check text size if you change this
rt=26; 		
// radius bottom circle
rb=26.5; 
// height 
kh=5; 			//

t=Letter_height+kh-0.1;				// " (letter thickness)

union() {
	color("gold") 
		render() 
			difference() {
				cylinder(r1=rb,r2=rt,h=kh,$fn=46);			// base of badge
				// -
				translate([0,0,kh])
					cylinder_chamfer(rt-1,3,$fn=46);		// round top edge
			} // d	
	//
	color("gold") bourbles($fn=33);
	//
	if (str(t1,t2,t3,t4) != "")
		intersection() {
			cylinder(r=rt-2.5,h=kh+t,$fn=46);
			color("darkslategrey") dotext();
		} // i
} // u

module bourbles() {
	// bourbles & points
	for ( i = [1 : np] ) {
		rotate( i * 360 / (np), [0, 0, 1]) {
			// point at triangle
			linear_extrude(height = kh*0.6 ) 
				polygon([[-rt/(np<4?2:1.25),0],[0,rt*2*sin(45)],[rt/(np<4?2:1.25),0]]);
			// bourbles
			translate([0, rt*1.5, 0]) 
				difference() {
					scale([1,1,0.8])
						sphere(r = rt/5);
					translate([0,0,-(rt/5)]) 
						cylinder(r=rt/5+1,h=rt/5);
					// mounting hole
					if (i==np && mhr>0)
						cylinder(h =rt/2,r=mhr,center = true,$fs=1);
				} // d
		} // r
	} // f
} // bourbles

module dotext() {
	// text top edge
	writecylinder(t1,[0,0,0],rt-1.5,t/2+0.1,
		h=th1,face="top",font=f1,center=false,space=s1);
	// text in middle
	translate([0,tco,t/2+0.1]) // slightly top of center
		write(t2,h=th2,face="top",font=f2,center=true,space=s2);
	translate([0,-tco,t/2+0.1]) // slightly bottom of center
		write(t3,h=th3,face="top",font=f3,center=true,space=s3);
	// text lower edge
	offset= ((th4*0.3) * (decent(t4,f4)) );  // low hanging chars like j
	//echo(th4=th4,offset=offset,decent(t4));
	writecylinder(t4,[0,0,0], rt-3.75-offset+th4*0.5 , t/2+0.1,
		h=th4,face="top",font=f4,ccw=true,center=false,space=s4);
}


module cylinder_chamfer(r1,r2)
{ 
/*  Derived (derivative aspects public domain) from
 *  OpenSCAD Metric Fastners Library (www.openscad.org)
 *  Copyright (C) 2010-2011  Giles Bathgate
 *  From MCAD/metric_fasteners.scad - see library for licencing
 */

	t=r1-r2;
	p=r2*2;
	rotate_extrude()
	difference()
	{
		translate([t,-r2])square([p,p]);
		translate([t,-r2])circle(r2);
	}
} // cylinder_chamfer

