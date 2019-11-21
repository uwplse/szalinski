// Symmetric Spheroform Tetrahedron
// Solid of Constant Width
// script improvements July 2014

// ----------
// VARIABLES:
// ----------

// For the level of detail in faces of the tetrahedron
// I recommend a number between 50 and 100
FACE_DETAIL=100;

// For the level of detail in the rounded edges
// I recommend a number between 10 and 50
ROUNDNESS_DETAIL=50;

// Number of segments to edges
segs = round(ROUNDNESS_DETAIL/3)+1;
width = 20/1; // width of the object to be printed
AT = 0.001/1; // Epsilon
// vertices and edge length of Reuleaux Tetrahedron from Wikipedia
v1 = [sqrt(8/9), 0, -1/3]/1;
v2 = [-sqrt(2/9), sqrt(2/3), -1/3]/1;
v3 = [-sqrt(2/9), -sqrt(2/3), -1/3]/1;
v4 = [0, 0, 1]/1;
a = sqrt(8/3); // edge length given by above vertices
k = width / a; // scaling constant to generate desired width from standard vertices

// ----------
// INDIVIDUAL COMPONENTS:
// ----------

//box to remove Reuleaux edges
module chop(){
	rotate([41.02515,0,0]) translate([-20,0,0]) cube(size=40);
}

//One face with three edges removed
module face(){difference(){
	translate([0,-16.33,0])sphere(r=20,$fn=FACE_DETAIL);
	translate ([-25,-56.7,-25])cube(size=50);
	translate([0,-6.6358,0]) chop();
	translate([0,-6.6358,0]) rotate([0,120,0])chop();
	translate([0,-6.6358,0]) rotate([0,240,0])chop();
}}

//Two faces positioned
module face2(){union(){
	translate([0,4.0825,0]) face();
	rotate([250.529,180,0]) translate([0,4.0825,0]) face();
}}

//All four faces positioned
module face4(){union(){
	rotate ([-54.736,0,0]) face2();
	rotate ([-54.736,90,180]) face2();
}}

// Helper functions. Plenty of room for simplification (mostly constant calculations, and redundant vector operations).
// reverse an array
function rev(a,i=0)=i<len(a)?concat([a[len(a)-i-1]],rev(a,i+1)):[];
// cumulative index preserving nested structure - for referring to points
function indx(v,i=0,t=0,r=[])=i<len(v)?indx(v,i+1,t+len(v[i]),concat(r,[[for(j=[0:len(v[i])-1])j+t]])):r;
// Envelope sphere radius and offset
function env(x) = width*(((4*sqrt(2)-8)*x*x+2-sqrt(2))/8);
// vector to sphere sweep center
function vec(v1,v2,i) = k*((0.5+i)*v1+(0.5-i)*v2) + env(i)*(v1+v2)/mod(v1+v2);
// reduce number of vertexes near pointy end, in whole numbers
function rj(i) = round(segs*env(i/segs)/env(0)/4);
// vector modulus
function mod(v) = (sqrt(v[0]*v[0]+v[1]*v[1]+v[2]*v[2]));

// generate the points for a single edge
function edge(v1,v2,v3,v4) = [for(i=[-segs/2:1:segs/2])[for(j=[-rj(i):1:rj(i)])
    vec(v2,v3,i/segs)+(vec(v2,v3,i/segs)
    -vec(v4,v1,j==0?0:j/2/rj(i)))/mod(vec(v4,v1,j==0?0:j/2/rj(i))
    -vec(v2,v3,i/segs))*env(i/segs)]];

//complete sphere sweep envelope positioned
module frame(){
    // generate envelope points using list comprehension
    ip=concat(
        edge(v1,v2,v3,v4),
        edge(v4,v1,v2,v3),
        edge(v3,v4,v1,v2),
        edge(v2,v3,v4,v1),
        edge(v1,v4,v2,v3),
        edge(v2,v3,v1,v4)
    );
    ipi=indx(ip); // structured index list
    tp=[for(i=ip)for(j=i)j]; // flattened list of points
    tf=concat( // faces
        [for(i=[1:len(ipi)-2])if(len(ipi[i])>1)for(j=[0:len(ipi[i])-2])
            [ipi[i][j+1],ipi[i][j],ipi[i+1][round((j+0.5-AT)*(len(ipi[i+1])-1)/(len(ipi[i])-1))]]],
        [for(i=[1:len(ipi)-2])if(len(ipi[i])>1)for(j=[0:len(ipi[i])-2])
            [ipi[i][j],ipi[i][j+1],ipi[i-1][round((j+0.5+AT)*(len(ipi[i-1])-1)/(len(ipi[i])-1))]]]        
    );
    rotate([0,35.2644,-90])polyhedron(points=tp,faces=tf,convexity=2);
}

// ----------
// FINAL CONSTRUCTION:
// ----------

//Combine the edges with the Reuleaux tetrahedron
module Tetra(){hull(){
	face4();
	frame();
}}

rotate([-35.264,0,0])Tetra();
