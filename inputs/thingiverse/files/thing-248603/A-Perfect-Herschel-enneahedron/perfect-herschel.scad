// A Perfect Herschel enneahedron
//
// Bill Owens, Feb 2014
//   released into the public domain
//
// This is an OpenSCAD model of the Herschel enneahedron created by Christian Perfect <http://checkmyworking.com/>
// Full description and a paper model at <http://aperiodical.com/2013/10/an-enneahedron-for-herschel/>
//
// Setting size=70 and stretch=1 produces a model the same size and proportion as the paper model in the original article.

// parameters for Thingiverse Customizer
//

// tip-to-tip length (mm)
size = 70;	

// shape of the polyhedron
stretch = 1;

/* [Hidden] */
h1 = stretch/2;
h2 = stretch*2/3;

scale(size) rotate([90,0,0]) polyhedron(
    points = [
    [1/2,0,-h1],    		//v0
    [0,0,0],					//v1
    [1/2,0,h1],				//v2
    [1,0,0],					//v3
    [1/2,sqrt(3)/6,-h2],		//v4
    [3/4,sqrt(3)/4,-h1],		//v5
    [3/4,sqrt(3)/4,h1],		//v6
    [1/2,sqrt(3)/6,h2],		//v7
    [1/4,sqrt(3)/4,h1],		//v8
    [1/4,sqrt(3)/4,-h1],		//v9
    [1/2,sqrt(3)/2,0]],		//v10
    triangles = [
    [1,2,3],
    [1,3,0],
    [2,7,3],
    [3,7,6],
    [0,3,4],
    [3,5,4],
    [3,6,10],
    [3,10,5],
    [6,7,10],
    [7,8,10],
    [4,5,10],
    [4,10,9],
    [1,10,8],
    [1,9,10],
    [1,8,7],
    [1,7,2],
    [1,4,9],
    [1,0,4]]);
