/* [Global] */

// Base Polygon Scale
PolyScale = 1; // [1:30]

// Midpoint Polygon Scale
PolyScale2 = 1; // [1:30]

// Total Height
Height = 1; // [1:30]

// Midpoints' Height  
Height2 = 1; // [1:30]

/* [Hidden] */

s 	= PolyScale;
h 	= Height;
s2 = PolyScale2;
h2 = Height2;

polyhedron
    (points = [[0, 0, 18.5*h], [0, 6*s, 0], [5.7063*s, 1.8541*s, 0], [3.5267*s, -4.8541*s, 0], [-3.5267*s, -4.8541*s, 0], [-5.7063*s, 1.8541*s, 0], [0, 7.2*s2, 14*h2], [6.8476*s2, 2.2249*s2, 14*h2], [4.2320*s2, -5.8249*s2, 14*h2], [-4.2320*s2, -5.8249*s2, 14*h2], [-6.8476*s2, 2.2249*s2, 14*h2]],faces = [[5,4,3,2,1], [1,2,7,6], [2,3,8,7], [3,4,9,8], [4,5,10,9], [5,1,6,10], [6,7,0], [7,8,0], [8,9,0], [9,10,0], [10,6,0]]);
