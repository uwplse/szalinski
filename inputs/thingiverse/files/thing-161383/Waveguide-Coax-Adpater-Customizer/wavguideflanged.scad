
// *************************************************************
// (C) 2013 Dipl.Ing. Rolf-Dieter Klein, Munich Germany
// OpenSource -- would be great to keep my name as reference
// www.rdklein.de
// report error, problems to rdklein@rdklein.de
// *************************************************************
// WR Flange Code 
wrcode = 6; // [1:WR112,2:WR90,3:WR75,4:WR62,5:WR51,6:WR42,7:WR34,8:WR28]
//
// Diameter of Coax Adapter (in mm)
coaxsize = 4.05;  // SMA Adapter dielectric diameter
//
// overall wall thickness in mm
wall = 2.58; // also thickness of SMA Adapter dielectric to contact
// flange thickness
flanged = 5; // flange thickness
// add length *lambda/2
addlen = 1;
// standard dimension tables
// WR cannot be entered directly due to openscad variable restrictions
// a case of if for assignment cannot be used, index is easier for this.
// WR 112 7.05-10.00 GHz
// WR 90  8.20-12.40 GHz
// WR 75  10.00-15.00 GHz
// WR 62  12.49-18.00 GHz
// WR 51  15.00-22.00 GHz
// WR 42  18.00-26.50 GHz
// WR 34  22.00-33.00 GHz
// WR 28  26.50-40.00 GHz
//
// do not change:
wrtab = [0,112,90,75,62,51,42,34,28]*1.0;
// do not change:
atab = [0,47.9,41.4,38.3,33.3,31.0,22.41,22.1,19.05]*1.0;
// do not change:
etab = [0,18.72,16.26,14.25,12.14,11.25,8.51,7.9,6.73]*1.0;
// do not change:
ftab = [0,17.17,15.49,13.21,12.63,10.29,8.13,7.5,6.34]*1.0;
// do not change:
drilltab=[0,4.3,4.3,4.1,4.1,4.1,3.1,3.1,3.0]*1.0;
// dann werte zuweisen
// ueber index
sizea = atab[wrcode]; // square size of flange
sizee = etab[wrcode]; // holes from smaller 
sizef = ftab[wrcode]; // holes from larger 
drill = drilltab[wrcode]/2.0; // drill for flange mounting
wr = wrtab[wrcode];
lquat = wr/20.0*2.54; // lamba 4 in mm
// faces for precision
$fn=36; // faces for precision
//
// *********** FLANGE ****************
// Draw A Flange with mounting holes
//
difference() {
 difference() {
 	intersection() {

		cube([sizea,sizea,flanged],center=true);
		rotate([0,0,45]) cube([sizea*1.4142*0.9,sizea*1.4142*0.9,flanged],center=true);
	}
	cube([lquat,lquat*2,flanged*2],center=true);
 } 
 translate([-sizee,sizef,0]) cylinder(h=flanged*2,r=drill,center=true);
 translate([sizee,sizef,0]) cylinder(h=flanged*2,r=drill,center=true);
 translate([-sizee,-sizef,0]) cylinder(h=flanged*2,r=drill,center=true);
 translate([sizee,-sizef,0]) cylinder(h=flanged*2,r=drill,center=true);
}
//
// ***** Transisition adapater *****
// designed for simple hole using a coax cable; Sma etc.
// with no mounting holes 
// tuning screws also omitted (due to inperfection of 3d prints anyway...)
offsetbool = 0.001;
translate([0,0,lquat*3/2+wall/2-offsetbool-flanged/2+addlen*lquat]) difference() {
 difference() {
	translate([0,0,0]) cube([lquat+wall*2,lquat*2+wall*2,lquat*3+addlen*lquat*2+wall*1],center=true);
	translate([0,0,-wall/2-offsetbool]) cube([lquat,lquat*2,lquat*(3+offsetbool)+addlen*lquat*2],center=true);
 }

 // drill hole for coax, position lamba/4 of waveguide from end size
 // waveguide here 3*l/4
 translate([lquat/2+wall/2,0,lquat/2+addlen*lquat-wall]) rotate ([0,90,0]) cylinder(h=wall*2,r=coaxsize/2,center=true);
}
//

 