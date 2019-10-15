/*
Seven cristalline structures
by Jérémie Grisolia a.k.a MiDuino from AirDuino(2013)
CC BY-NC-SA 3.0

Based on the P Moews algorythm 
that creates a model of a molecule from a set
of orthogonal coordinates(here part of diamond lattice)
*/

// Which crystalline structure would you like to make?
cristal = "Cubic"; // [Cubic,Tetragonal,Orthorombic,Monoclinic,Triclinic,Rhomboedral,Hexagonal,Cristal_fcc, Cristal_Hexagonal]

//number of atoms in the x direction
nx = 2;//[1:5]
//number of atoms in the y direction
ny = 2;//[1:5]
//number of atoms in the z direction
nz = 2;//[1:5]

//atom radius
ra=2; //[1:5]
//bond radius
rb=1; //[1:5]

//atom facet number
f_ra = 10;//[2:20]
//bond facet number
f_rb = 4;//[2:10]

//Vecteurs unitaires
Oxx = 1; Oxy = 0; Oxz = 0; //Ox->
Oyx = 0; Oyy = 1; Oyz = 0; //Oy->
Ozx = 0; Ozy = 0; Ozz = 1; //Oz->

//IMPRESSION DES SYSTEMES CRISTALLOGRAPHIQUES
module print_cristal(ra, rb) {

// 7 primitive crystalline structure
	if (cristal == "Cubic") {
reseau_cubique(ra/10, nx, ny, nz);//atome size radius
	} else if (cristal == "Tetragonal") {
reseau_quadratique(ra/10, nx, ny, nz);//atome size radius
	} else if (cristal == "Orthorombic") {
reseau_orthorombique(ra/10, nx, ny, nz);//atome size radius
	} else if (cristal == "Monoclinic") {
reseau_monoclinique(ra/10, nx, ny, nz);//atome size radius
	} else if (cristal == "Triclinic") {
reseau_triclinique(ra/10, nx, ny, nz);//atome size radius
	} else if (cristal == "Rhomboedral") {
reseau_rhomboedrique(ra/10, nx, ny, nz);//atome size radius
	} else if (cristal == "Hexagonal") {
reseau_hexagonal(ra/10, nx, ny, nz);//atome size radius
	} else if (cristal == "Cristal_fcc") {
cristal_fcc(ra/10, 1, 1, 1);//atome size radius
	} else if (cristal == "Cristal_Hexagonal") {
cristal_hexagonal(ra/10, nx, ny, nz);//atome size radius
	}
}

////////////MODULE ATOM/////////////
//spheres of radius rx are placed at the atomic positions - x0,y0,z0 */
module atom(rx,x0,y0,z0)
{
  translate(v=[x0,y0,z0])
  sphere(r=rx,$fn=f_ra);
}
//////////////////////////////////

////////////MODULE BOND/////////////
/*Module bond represents a bond between two atoms -
as a cylinder - the orthogonal coordinates of the two
atoms are passed

tx,ty,and tz are the coordinates of the midpoint of the line
connecting the atoms
ax,ay,and az is the vector between the atoms

A cylinder whose height is equal to the bond length
is placed at the origin and rotated to align with the
bond.  The cylinder is then translated to the proper
position
*/

module bond(x2,y2,z2,x1,y1,z1)
{
tx = (x2 + x1)/2;
ty = (y2 + y1)/2;
tz = (z2 + z1)/2;
ax = x2 - x1 ;
ay = y2 - y1;
az = z2 - z1;
translate(v=[tx,ty,tz])
rotate(a = [-acos(az/sqrt(ax*ax+ay*ay+az*az)), 0, -atan2(ax, ay)])
cylinder(r=rb/10,h=sqrt(ax*ax+ay*ay+az*az),center=true,$fn=f_rb);
}
//////////////////////////////////


/////////////////////MONOCLINIQUE////////////////////
module reseau_monoclinique(ra, nx, ny, nz) 
{
//Norme des vecteurs
//a=2, b=3, c=4
//alpha=90, beta=60, gamma=90
//Coordonnées des vecteurs
//a->  (atome c1)
ax=2;ay=0;az=0;
//b->  (atome c6)
bx=0;by=3;bz=0;
//c-> (atome c7)
cx=2;cy=0;cz=3.464;

//Norme des vecteurs
a=round(sqrt(ax*ax+ay*ay+az*az)); 
b=round(sqrt(bx*bx+by*by+bz*bz)); 
c=round(sqrt(cx*cx+cy*cy+cz*cz)); 
echo("a, b, c=", a, b, c); 
//Angles
alpha = round(acos((bx*cx+by*cy+bz*cz)/(b*c))); 
beta  = round(acos((cx*ax+cy*ay+cz*az)/(c*a))); 
gamma = round(acos((bx*ax+by*ay+bz*az)/(b*a))); 
echo("alpha,beta,gamma=", alpha,beta,gamma);

//Orientation de x selon le vecteur a->
//Orientation de z selon le vecteur c->
Oxa = acos((Oxx*ax+Oxy*ay+Oxz*az)/a);
Oya = acos((Oyx*ax+Oyy*ay+Oyz*az)/a);
Oza = acos((Ozx*ax+Ozy*ay+Ozz*az)/a);
echo("Oxa, Oya, Oza=", Oxa, Oya, Oza);

Oxb = acos((Oxx*bx+Oxy*by+Oxz*bz)/b);
Oyb = acos((Oyx*bx+Oyy*by+Oyz*bz)/b);
Ozb = acos((Ozx*bx+Ozy*by+Ozz*bz)/b);
echo("Oxb, Oyb, Ozb=", Oxb, Oyb, Ozb); 

Oxc = acos((Oxx*cx+Oxy*cy+Oxz*cz)/c);
Oyc = acos((Oyx*cx+Oyy*cy+Oyz*cz)/c);
Ozc = round(acos((Ozx*cx+Ozy*cy+Ozz*cz)/c));
echo("Oxc, Oyc, Ozc=", Oxc, Oyc, Ozc); 

for (i = [0:nx-1]) {
	for (j = [0:ny-1]) {
		for (k = [0:nz-1]) {
echo("i,j,k=", i, j, k); 

echo("tx,ty,tz=", a*i*cos(Oxa) + b*j*cos(Oxb)+ c*k*cos(beta), a*i*cos(Oya) + b*j*cos(Oyb), c*k*sin(beta)); 

translate([a*i*cos(Oxa) + b*j*cos(Oxb)+ c*k*cos(beta),a*i*cos(Oya) + b*j*cos(Oyb),c*k*sin(beta)])
primitif_monoclinique(ra);
		}//fin de k
	}//fin de j
}//fin de i
}//reseau_monoclinique

module primitif_monoclinique(ra) {
atom(ra, 0, 0, 0);          //  c0
atom(ra, 2, 0, 0);        //  c2
atom(ra, 2, 3, 0);      //  c3
atom(ra, 4, 0, 3.464);  //  c4
atom(ra, 4, 3, 3.464);//  c5
atom(ra, 0, 3, 0);        //  c6
atom(ra, 2, 0, 3.464);  //  c7
atom(ra, 2, 3, 3.464);//  c8

//BASE
bond(0, 0, 0, 2, 0, 0);  //  c0-c2
bond(2, 3, 0, 2, 0, 0);  //  c3-c2
bond(2, 3, 0, 0, 3, 0);  //  c3-c6
bond(0, 0, 0, 0, 3, 0);  //  c0-c6

bond(0, 0, 0, 2, 0, 3.464);  //  c0-c7
bond(4, 0, 3.464, 2, 0, 3.464);  //  c4-c7
bond(4, 0, 3.464, 4, 3, 3.464);  //  c4-c5
bond(2, 3, 3.464, 4, 3, 3.464);  //  c8-c5
bond(2, 3, 3.464, 2, 0, 3.464);  //  c8-c7
bond(4, 3, 3.464, 2, 3, 0);  //  c5-c3
bond(2, 0, 0, 4, 0, 3.464);  //  c2-c4
bond(2, 3, 3.464, 0, 3, 0);  //  c8-c6
}

/////////////////////MONOCLINIQUE////////////////////

/////////////////////HEXAGONAL////////////////////

module cristal_hexagonal(ra, nx, ny, nz)
{
reseau_hexagonal(ra, nx, ny, nz);
rotate([0,0,120])
reseau_hexagonal(ra, nx, ny, nz);
rotate([0,0,-120])
reseau_hexagonal(ra, nx, ny, nz);
}//fin module

module reseau_hexagonal(ra, nx, ny, nz) 
{
//Coordonnées des vecteurs
//a->  (atome c1)
ax=2;ay=0;az=0;
//b->  (atome c5)
bx=-1;by=1.732;bz=0;
//c-> (atome c6)
cx=0;cy=0;cz=4;

//Norme des vecteurs
a=round(sqrt(ax*ax+ay*ay+az*az)); 
b=round(sqrt(bx*bx+by*by+bz*bz)); 
c=round(sqrt(cx*cx+cy*cy+cz*cz)); 
echo("a,b,c=", a, b, c); 
//Angles
alpha = round(acos((bx*cx+by*cy+bz*cz)/(b*c))); 
beta  = round(acos((cx*ax+cy*ay+cz*az)/(c*a))); 
gamma = round(acos((bx*ax+by*ay+bz*az)/(b*a))); 
echo("alpha,beta,gamma=", alpha,beta,gamma);

//Orientation de x selon le vecteur a->
Oxa = acos((Oxx*ax+Oxy*ay+Oxz*az)/a);
Oya = acos((Oyx*ax+Oyy*ay+Oyz*az)/a);
Oza = acos((Ozx*ax+Ozy*ay+Ozz*az)/a);
echo("Oxa, Oya, Oza=", Oxa, Oya, Oza);

Oxb = acos((Oxx*bx+Oxy*by+Oxz*bz)/b);
Oyb = acos((Oyx*bx+Oyy*by+Oyz*bz)/b);
Ozb = acos((Ozx*bx+Ozy*by+Ozz*bz)/b);
echo("Oxb, Oyb, Ozb=", Oxb, Oyb, Ozb); 
/*
Oxc= atan(cy/cx);
Oyc= atan(cx/cy);
Ozc= asin(cz/c);
*/
Oxc = acos((Oxx*cx+Oxy*cy+Oxz*cz)/c);
Oyc = acos((Oyx*cx+Oyy*cy+Oyz*cz)/c);
Ozc = acos((Ozx*cx+Ozy*cy+Ozz*cz)/c);
echo("Oxc, Oyc, Ozc=", Oxc, Oyc, Ozc); 

for (i = [0:nx-1]) {
	for (j = [0:ny-1]) {
		for (k = [0:nz-1]) {
echo("i,j,k=", i, j, k); 

echo("tx,ty,tz=", a*i*cos(Oxa) + b*j*cos(Oxb)+ c*k*cos(Oxc)*cos(Ozc), a*i*cos(Oya) + b*j*cos(Oyb)+ c*k*sin(Oxc)*sin(Ozc), c*k*cos(Ozc)); 

translate([a*i*cos(Oxa) + b*j*cos(Oxb)+ c*k*cos(Oxc)*cos(Ozc),a*i*cos(Oya) + b*j*cos(Oyb)+ c*k*sin(Oxc)*sin(Ozc),c*k*cos(Ozc)])
primitif_hexagonal(ra);
		}//fin de k
	}//fin de j
}//fin de i
}

module primitif_hexagonal(ra) {
atom(ra, 0, 0, 0);  //   c0
atom(ra, 2, 0, 0);  //   c1
atom(ra, 1, 1.732, 0);  //   c2
atom(ra, 2, 0, 4);  //   c3
atom(ra, 1, 1.732, 4);  //   c4
atom(ra, -1, 1.732, 0);  //  c5
atom(ra, 0, 0, 4);  //   c6
atom(ra, -1 ,1.732, 4);  //   c7

bond(0, 0, 0, 2, 0, 0);  //  c0-c1
bond(1, 1.732, 0, -1, 1.732, 0);  //  c2-c5
bond(0, 0, 0, -1, 1.732, 0);  //  c0-c5
bond(1, 1.732, 0, 2, 0, 0);  //  c2-c1
bond(2, 0, 4, 1, 1.732, 4);  //  c3-c4
bond(1, 1.732, 4, -1 ,1.732, 4);  //  c4-c7
bond(-1 ,1.732, 4, 0, 0, 4);  //  c7-c6
bond(0, 0, 4, 2, 0, 4);  //  c6-c3
bond(0, 0, 0, 0, 0, 4);  //  c0-c6
bond(2, 0, 0, 2, 0, 4);  //  c1-c3
bond(1, 1.732, 0, 1, 1.732, 4);  //  c2-c4
bond(-1, 1.732, 0, -1 ,1.732, 4);  //  c5-c7

//OPTIONNEL
bond(0, 0, 0, 1, 1.732, 0);  //  c0-c2
bond(1, 1.732, 4, 0, 0, 4);  //  c4-c6
}


/////////////////////HEXAGONAL////////////////////




/////////////////////RHOMBOEDRIQUE////////////////////
module reseau_rhomboedrique(ra, nx, ny, nz) 
{

//Coordonnées des vecteurs
//a->  (atome c1)
ax=3;ay=0;az=0;
//b->  (atome c5)
bx=1.5;by=2.598;bz=0;
//c-> (atome c6)
cx=1.5;cy=0.867;cz=2.448;
//Norme des vecteurs
a=round(sqrt(ax*ax+ay*ay+az*az)); 
b=round(sqrt(bx*bx+by*by+bz*bz)); 
c=round(sqrt(cx*cx+cy*cy+cz*cz)); 
echo("a,b,c=", a, b, c); 
//Angles
alpha = round(acos((bx*cx+by*cy+bz*cz)/(b*c))); 
beta  = round(acos((cx*ax+cy*ay+cz*az)/(c*a))); 
gamma = round(acos((bx*ax+by*ay+bz*az)/(b*a))); 
echo("alpha,beta,gamma=", alpha,beta,gamma);

//Orientation de x selon le vecteur a->
Oxa = 0;
Oya = 90;
Oza = 0;

Oxb = gamma;
Oyb = 90-gamma;
Ozb = 0;
echo("Oxb,Oyb,Ozb=", Oxb, Oyb, Ozb); 

Oxc= atan(cy/cx);
Oyc= atan(cx/cy);
Ozc= asin(cz/c);
echo("Oxc,Oyc,Ozc=", Oxc, Oyc, Ozc); 

for (i = [0:nx-1]) {
	for (j = [0:ny-1]) {
		for (k = [0:nz-1]) {
echo("i,j,k=", i, j, k); 

echo("tx,ty,tz=", a*i*cos(Oxa) + b*j*cos(Oxb)+ c*k*cos(Oxc)*cos(Ozc),a*i*cos(Oya) + b*j*cos(Oyb)+ c*k*cos(Oyc)*cos(Ozc),c*k*sin(Ozc)); 

translate([a*i*cos(Oxa) + b*j*cos(Oxb)+ c*k*cos(Oxc)*cos(Ozc),a*i*cos(Oya) + b*j*cos(Oyb)+ c*k*sin(Oxc)*cos(Ozc),c*k*sin(Ozc)])
primitif_rhomboedrique(ra);
		}//fin de k
	}//fin de j
}//fin de i
}

module primitif_rhomboedrique(ra) {
atom(ra, 0, 0, 0);  //   c0
atom(ra, 3, 0, 0);  //   c1
atom(ra, 4.5, 2.598, 0);  //   c2
atom(ra, 4.5, 0.867, 2.448);  //   c3
atom(ra, 6, 3.465, 2.448);  //   c4
atom(ra, 1.5, 2.598, 0);  //  c5
atom(ra, 1.5, 0.867, 2.448);  //   c6
atom(ra, 3, 3.465, 2.448);  //   c7

bond(0, 0, 0, 3, 0, 0);  //  c0-c1
bond(0, 0, 0, 1.5, 2.598, 0);  //  c0-c5
bond(0, 0, 0, 1.5, 0.867, 2.448);  //  c0-c6
bond(4.5, 2.598, 0, 1.5, 2.598, 0);  //  c2-c5
bond(4.5, 2.598, 0, 3, 0, 0);  //  c2-c1
bond(4.5, 0.867, 2.448, 6, 3.465, 2.448);  //  c3-c4
bond(6, 3.465, 2.448, 3, 3.465, 2.448);  //  c4-c7
bond(3, 3.465, 2.448, 1.5, 0.867, 2.448);  //  c7-c6
bond(1.5, 0.867, 2.448, 4.5, 0.867, 2.448);  //  c6-c3
bond(3, 0, 0, 4.5, 0.867, 2.448);  //  c1-c3
bond(4.5, 2.598, 0, 6, 3.465, 2.448);  //  c2-c4
bond(1.5, 2.598, 0, 3, 3.465, 2.448);  //  c5-c7
}


/////////////////////RHOMBOEDRIQUE////////////////////


/////////////////////TRICLINIQUE////////////////////
module reseau_triclinique(ra, nx, ny, nz) 
{
//Coordonnées des vecteurs
//a->  (atome c1)
ax=2;ay=0;az=0;
//b->  (atome c5)
bx=0.521;by=2.954;bz=0;
//c-> (atome c6)
cx=2;cy=-1.058;cz=3.299;
//Norme des vecteurs
a=round(sqrt(ax*ax+ay*ay+az*az)); 
b=round(sqrt(bx*bx+by*by+bz*bz)); 
c=round(sqrt(cx*cx+cy*cy+cz*cz)); 
echo("a,b,c=", a, b, c); 
//Angles
alpha = round(acos((bx*cx+by*cy+bz*cz)/(b*c))); 
beta  = round(acos((cx*ax+cy*ay+cz*az)/(c*a))); 
gamma = round(acos((bx*ax+by*ay+bz*az)/(b*a))); 
echo("alpha,beta,gamma=", alpha,beta,gamma);

//Orientation de x selon le vecteur a->
Oxa = 0;
Oya = 90;
Oza = 0;

Oxb = gamma;
Oyb = 90-gamma;
Ozb = 0;
echo("Oxb,Oyb,Ozb=", Oxb, Oyb, Ozb); 

Oxc= atan(cy/cx);
Oyc= atan(cx/cy);
Ozc= asin(cz/c);
echo("Oxc,Oyc,Ozc=", Oxc, Oyc, Ozc); 

for (i = [0:nx-1]) {
	for (j = [0:ny-1]) {
		for (k = [0:nz-1]) {
echo("i,j,k=", i, j, k); 

echo("tx,ty,tz=", a*i*cos(Oxa) + b*j*cos(Oxb)+ c*k*cos(Oxc)*cos(Ozc),a*i*cos(Oya) + b*j*cos(Oyb)+ c*k*cos(Oyc)*cos(Ozc),c*k*sin(Ozc)); 

translate([a*i*cos(Oxa) + b*j*cos(Oxb)+ c*k*cos(Oxc)*cos(Ozc),a*i*cos(Oya) + b*j*cos(Oyb)+ c*k*sin(Oxc)*cos(Ozc),c*k*sin(Ozc)])
primitif_triclinique(ra);
		}//fin de k
	}//fin de j
}//fin de i
}

module primitif_triclinique(ra) {
atom(ra, 0, 0, 0);  //   c0
atom(ra, 2, 0, 0);  //   c1
atom(ra, 2.521, 2.954, 0);  //   c2
atom(ra, 4, -1.058, 3.299);  //   c3
atom(ra, 4.521, 1.896, 3.299);  //   c4
atom(ra, 0.521, 2.954, 0);  //  c5
atom(ra, 2, -1.058, 3.299);  //   c6
atom(ra, 2.521, 1.896, 3.299);  //   c7

bond(0, 0, 0, 2, 0, 0);  //  c0-c1
bond(2.521, 2.954, 0, 2, 0, 0);  //  c2-c1
bond(2.521, 2.954, 0, 0.521, 2.954, 0);  //  c2-c5
bond(0, 0, 0, 0.521, 2.954, 0);  //  c0-c5
bond(2, 0, 0, 4, -1.058, 3.299);  //  c1-c3
bond(0, 0, 0, 2, -1.058, 3.299);  //  c0-c6
bond(2.521, 2.954, 0, 4.521, 1.896, 3.299);  //  c2-c4
bond(0.521, 2.954, 0, 2.521, 1.896, 3.299);  //  c5-c7
bond(4.521, 1.896, 3.299, 2.521, 1.896, 3.299);  //  c4-c7
bond(4.521, 1.896, 3.299, 4, -1.058, 3.299);  //  c4-c3
bond(2, -1.058, 3.299, 4, -1.058, 3.299);  //  c6-c3
bond(2, -1.058, 3.299, 2.521, 1.896, 3.299);  //  c6-c7
}

/////////////////////TRICLINIQUE////////////////////

/////////////////////ORTHOROMBIQUE////////////////////
module reseau_orthorombique(ra, nx, ny, nz) 
{
//translation en x
tx = 3;
//translation en y
ty = 4;
//translation en z
tz = 2;

for (i = [0:nx-1]) {
	for (j = [0:ny-1]) {
		for (k = [0:nz-1]) {
translate([i*tx,j*ty,k*tz])
primitif_orthorombique(ra, tx, ty, tz); 
		}//fin de k
	}//fin de j
}//fin de i
}

module primitif_orthorombique(ra, tx, ty, tz) {

atom(ra, 0, 0, 0);  //   c0
atom(ra, 0, 0, tz);  //   c5
atom(ra, tx, 0, tz);  //   c6
atom(ra, 0, ty, tz);  //   c7
atom(ra, tx, ty, tz);  //   c8
atom(ra, tx, 0, 0);  //   c9
atom(ra, 0, ty, 0);  //   c10
atom(ra, tx, ty, 0);  //   c11

bond(0, 0, 0, 0, 0, tz);  //  c0-c5
bond(0, 0, 0, tx, 0, 0);  //  c0-c9
bond(0, 0, tz, tx, 0, tz);  //  c5-c6
bond(tx, 0, tz, tx, 0, 0);  //  c6-c9
bond(0, 0, 0, 0, ty, 0);  //  c0-c10
bond(0, 0, tz, 0, ty, tz);  //  c5-c7
bond(tx, 0, 0, tx, ty, 0);  //  c9-c11
bond(tx, 0, tz, tx, ty, tz);  //  c6-c8
bond(0, ty, tz, 0, ty, 0);  //  c7-c10
bond(0, ty, 0, tx, ty, 0);  //  c10-c11
bond(tx, ty, 0, tx, ty, tz);  //  c11-c8
bond(tx, ty, tz, 0, ty, tz);  //  c8-c7

}
/////////////////////ORTHOROMBIQUE////////////////////


/////////////////////QUADRATIQUE////////////////////
module reseau_quadratique(ra, nx, ny, nz) 
{
//translation en x
tx = 1;
//translation en y
ty = 1;
//translation en z
tz = 2;

for (i = [0:nx-1]) {
	for (j = [0:ny-1]) {
		for (k = [0:nz-1]) {
translate([i*tx,j*ty,k*tz])
primitif_quadratique(ra, tx, ty, tz); 
		}//fin de k
	}//fin de j
}//fin de i
}

module primitif_quadratique(ra, tx, ty, tz) {
atom(ra, 0, 0, 0);  //   1
atom(ra, tx, 0, 0);  //   2
atom(ra, tx, ty, 0);  //   3
atom(ra, 0, ty, 0);  //   4
atom(ra, 0, 0, tz);  //   5
atom(ra, tx, 0, tz);  //   6
atom(ra, tx, ty, tz);  //   7
atom(ra, 0, ty, tz);  //   8

bond(0, 0, 0, tx, 0, 0);  //  1-2
bond(tx, 0, 0, tx, ty, 0);  //  2-3
bond(tx, ty, 0, 0, ty, 0);  //  3-4
bond(0, ty, 0, 0, 0, 0);  //  4-1

bond(0, 0, 0, 0, 0, tz);  //  1-5
bond(tx, 0, 0, tx, 0, tz);  //  2-6
bond(tx, ty, 0, tx, ty, tz);  //  3-7
bond(0, ty, 0, 0, ty, tz);  //  4-8

bond(0, 0, tz, tx, 0, tz);  //  5-6
bond(tx, 0, tz, tx, ty, tz);  //  6-7
bond(tx, ty, tz, 0, ty, tz);  //  7-8
bond(0, ty, tz, 0, 0, tz);  //  8-5
}
/////////////////////QUADRATIQUE////////////////////

/////////////////////CUBIC////////////////////
module reseau_cubique(ra, nx, ny, nz) 
{
//translation en x
tx = 1;
//translation en y
ty = 1;
//translation en z
tz = 1;
for (i = [0:nx-1]) {
	for (j = [0:ny-1]) {
		for (k = [0:nz-1]) {
translate([i*tx,j*ty,k*tz])
primitif_cubique(ra);
		}//fin de k
	}//fin de j
}//fin de i
}

module primitif_cubique(ra) 
{
atom(ra, 0, 0, 0);  //   1
atom(ra, 1, 0, 0);  //   2
atom(ra, 1, 1, 0);  //   3
atom(ra, 0, 1, 0);  //   4
atom(ra, 0, 0, 1);  //   5
atom(ra, 1, 0, 1);  //   6
atom(ra, 1, 1, 1);  //   7
atom(ra, 0, 1, 1);  //   8

bond(0, 0, 0, 1, 0, 0);  //  1-2
bond(1, 0, 0, 1, 1, 0);  //  2-3
bond(1, 1, 0, 0, 1, 0);  //  3-4
bond(0, 1, 0, 0, 0, 0);  //  4-1

bond(0, 0, 0, 0, 0, 1);  //  1-5
bond(1, 0, 0, 1, 0, 1);  //  2-6
bond(1, 1, 0, 1, 1, 1);  //  3-7
bond(0, 1, 0, 0, 1, 1);  //  4-8

bond(0, 0, 1, 1, 0, 1);  //  5-6
bond(1, 0, 1, 1, 1, 1);  //  6-7
bond(1, 1, 1, 0, 1, 1);  //  7-8
bond(0, 1, 1, 0, 0, 1);  //  8-5
}
////////////////////////////////////////////////////////////CUBIC



/////////////////// FCC /////////////////////////////////////////
module reseau_cubique_face_centre(ra, nx, ny, nz) 
{
atom(ra, 0, 0, 0);  //   1
for (i = [1:nx]) {
	for (j = [1:ny]) {
		for (k = [1:nz]) {
//cube simple 
atom(ra, i*1, 0, 0);  //   2
atom(ra, i*1, j*1, 0);  //   3
atom(ra, 0, j*1, 0);  //   4
atom(ra, 0, 0, k*1);  //   5
atom(ra, i*1, 0, k*1);  //   6
atom(ra, i*1, j*1, k*1);  //   7
atom(ra, 0, j*1, k*1);  //   8

bond(0, 0, 0, i*1, 0, 0);  //  1-2
bond(i*1, 0, 0, i*1, j*1, 0);  //  2-3
bond(i*1, j*1, 0, 0, j*1, 0);  //  3-4
bond(0, j*1, 0, 0, 0, 0);  //  4-1

bond(0, 0, 0, 0, 0, k*1);  //  1-5
bond(i*1, 0, 0, i*1, 0, k*1);  //  2-6
bond(i*1, j*1, 0, i*1, j*1, k*1);  //  3-7
bond(0, j*1, 0, 0, j*1, k*1);  //  4-8

bond(0, 0, k*1, i*1, 0, k*1);  //  5-6
bond(i*1, 0, k*1, i*1, j*1, k*1);  //  6-7
bond(i*1, j*1, k*1, 0, j*1, k*1);  //  7-8
bond(0, j*1, k*1, 0, 0, k*1);  //  8-5

//cube face centree
atom(ra, i*0.5, j*0.5, 0);  //   9
atom(ra, i*0.5, j*0.5, k*1);  //   10
atom(ra, 0, j*0.5, k*0.5);  //   11
atom(ra, i*1, j*0.5, k*0.5);  //   12
atom(ra, i*0.5, 0, k*0.5);  //   13
atom(ra, i*0.5, j*1, k*0.5);  //   14
atom(ra, i*0.5, j*0.5, k*0.5);// 15

bond(i*0.5, j*0.5, k*0.5, i*0.5, j*0.5, 0);  //  15-9
bond(i*0.5, j*0.5, k*0.5, i*0.5, j*0.5, k*1);  //  15-10
bond(i*0.5, j*0.5, k*0.5, 0, j*0.5, k*0.5);  //  15-11
bond(i*0.5, j*0.5, k*0.5, i*1, j*0.5, k*0.5);  //  15-12
bond(i*0.5, j*0.5, k*0.5, i*0.5, 0, k*0.5);  //  15-13
bond(i*0.5, j*0.5, k*0.5, i*0.5, j*1, k*0.5);  //  15-14
		}//fin k
	}//fin j
}//fin i
}//fin module
/////////////////// FCC /////////////////////////////////////////



//////////////////////////////////////////////////////////////

module cristal_fcc()
{

reseau_cubique_face_centre(ra/10, 1,1,1);
mirror([1,0,0])
reseau_cubique_face_centre(ra/10, 1,1,1);

mirror([0,-1,0])
union()
{
reseau_cubique_face_centre(ra/10, 1,1,1);
mirror([1,0,0])
reseau_cubique_face_centre(ra/10, 1,1,1);
}

mirror([0,0,-1])
union()
{
reseau_cubique_face_centre(ra/10, 1,1,1);
mirror([1,0,0])
reseau_cubique_face_centre(ra/10, 1,1,1);

mirror([0,-1,0])
union()
{
reseau_cubique_face_centre(ra/10, 1,1,1);
mirror([1,0,0])
reseau_cubique_face_centre(ra/10, 1,1,1);
}

}//fin union
}//fin module

//cristal();



/////////////////// PRINT CRISTAL /////////////////////////////////////////
print_cristal(ra, rb);






