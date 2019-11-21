
// *************************************************************
// (C) 2013 Dipl.Ing. Rolf-Dieter Klein, Munich Germany
// OpenSource -- would be great to keep my name as reference
// HORN ANTENNA for Microwaves -- use copper to metallize
// or use for metal casting !!
// www.rdklein.de
// report error, problems to rdklein@rdklein.de
// *************************************************************
// WR Flange Code 
wrcode = 8; // [1:WR112,2:WR90,3:WR75,4:WR62,5:WR51,6:WR42,7:WR34,8:WR28]
//
// overall wall thickness in mm
wall = 2.58; // 
// flange thickness
flanged = 5; // flange thickness
//
// Antennalenght multiplier R0 = Lambda * n
multin = 2; // default 2Lambda

// addon in lamba/2 units flanged is subtracted ! !
waveadd = 1;  

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
//

// faces for precision
$fn=36; // faces for precision
//
// *********** FLANGE ****************
// Draw A Flange with mounting holes
// now with separate thickness.
difference() {
 difference() {
 	intersection() {

		cube([sizea,sizea,flanged],center=true);
		rotate([0,0,45]) cube([sizea*1.4142*0.9,sizea*1.4142*0.9,flanged],center=true);
	}
	cube([lquat,lquat*2,wall*2],center=true);
 } 
 translate([-sizee,sizef,0]) cylinder(h=flanged*2,r=drill,center=true);
 translate([sizee,sizef,0]) cylinder(h=flanged*2,r=drill,center=true);
 translate([-sizee,-sizef,0]) cylinder(h=flanged*2,r=drill,center=true);
 translate([sizee,-sizef,0]) cylinder(h=flanged*2,r=drill,center=true);
}
//
// ***** HORN ANTENNA *****
// Pyramidal Horn
// r0 = length to pyramidal joint point
//
r0 = multin * lquat * 4; // lambda * 4 * multiplier for r0
Asize = sqrt(3*lquat*4*r0); // Size in H plane direction
//
// *** if preferred Bsize = sqrt(2*lquat*4*r0); // Size in E plane direction
//
a = lquat*2; // simpler for calc below
b = lquat;
// ********* rh and re now the base... one can be choosen
// optimal horn is for re=rh
// 
Bsize = 1/2*(b + sqrt(b*b+(8*Asize*(Asize-a)/3) ));
//
echo(r0);
echo(Asize);
//
lh = sqrt(r0*r0+(Asize*Asize)/4);
rh = Asize*( (Asize- a)/(3*lquat*4));

// rh = (Asize- a)*sqrt((lh/Asize)-1/4);
// le = sqrt(r0*r0+(Bsize*Bsize)/4);
// re = (Bsize- b)*sqrt((le/Bsize)-1/4);
// 
 
rh1 = rh * 1.00001; // for boolean problems to be solved
offset1 = -0.001+0.0;

// 
wa1= wall;
// wall thickness not alongside, but if needed:
// alpha = atan(Asize/(2*r0));
// wa1 = wall/cos(alpha);
// echo("alpha",alpha,"walpha=",wa1);
//
// Outer Polygon
 difference() {
translate([0,0,-flanged/2+lquat*2*waveadd]) polyhedron(
  points=[ [Bsize/2+wa1,Asize/2+wa1,rh],[Bsize/2+wa1,-Asize/2-wa1,rh],[-Bsize/2-wa1,-Asize/2-wa1,rh],[-Bsize/2-wa1,Asize/2+wa1,rh], /// the four points at base
           [b/2+wa1,wa1+a/2,0],[b/2+wa1,-wa1-a/2,0],[-wa1-b/2,-wa1-a/2,0],[-wa1-b/2,wa1+a/2,0]  ],                                 // the apex point 
  triangles=[ [0,1,4],[1,2,5],[2,3,6],[3,0,7],          // each triangle side
				   [1,5,4],[2,6,5],[3,7,6],[0,4,7],
              [1,0,3],[2,1,3],[4,5,7],[5,6,7]  ]                         // two triangles for square base
 );
// b in x a in y
// inner polygon for subtration...

translate([0,0,-flanged/2+lquat*2*waveadd]) polyhedron(
  points=[ [Bsize/2,Asize/2,rh1],[Bsize/2,-Asize/2,rh1],[-Bsize/2,-Asize/2,rh1],[-Bsize/2,Asize/2,rh1], /// the four points at base
           [b/2,a/2,offset1],[b/2,-a/2,offset1],[-b/2,-a/2,offset1],[-b/2,a/2,offset1]  ],                                 // the apex point 
  triangles=[ [0,1,4],[1,2,5],[2,3,6],[3,0,7],          // each triangle side
				   [1,5,4],[2,6,5],[3,7,6],[0,4,7],
              [1,0,3],[2,1,3],[4,5,7],[5,6,7]  ]                         // two triangles for square
);
}
// Additional wavequide 
difference() {
 translate([0,0,-flanged/2+lquat*waveadd]) cube([lquat+wall*2,lquat*2+wall*2,lquat*2*waveadd],center=true);
 translate([0,0,-flanged/2+lquat*waveadd]) cube([lquat,lquat*2,lquat*2*waveadd+wall*3],center=true);
}
//


 