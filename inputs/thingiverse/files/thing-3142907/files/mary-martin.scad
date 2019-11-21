// inspired by Mary Martin's work "Inversions"
// https://www.tate.org.uk/art/artists/mary-martin-1586
// https://en.wikipedia.org/wiki/Mary_Martin_(artist)
//
// by Laura Taalman and Edmund Harriss
// http://mathgrrl.com http://maxwelldemon.com
// Made at the #0things Hackathon at Construct3d 2018
//
// Inspired by British constructivist Artist Mary Martin
// https://www.tate.org.uk/art/artists/mary-martin-1586
// https://en.wikipedia.org/wiki/Mary_Martin_(artist)
// and her artwork Inversions
// https://www.tate.org.uk/art/artworks/martin-inversions-t01198
// Now in the Tate Gallery in London. We use random numbers here, but the original 
// work uses the mathematical idea of permutations. Can you work out the structure hidden
// in her beautiful work?

/////////////////////////////////////////////
// parameters

// random seed
random_seed = 1729; // [1:1:9999]
//random_seed = floor(rands(1,9999,1)[0]);  // use for openscad
//random_seed = 1;                          // use for fixed seed

// Width of the canvas (long side)
width = 100;

// Number of pieces across the long side
cols = 12;

// Number of pieces vertically
rows = 4;

// Height of the pieces (out from the canvas)
height = 20;

// computed
side = width/rows;
length = cols*side;
baseheight = 2*1;

// random turn for each cell of grid
turn = rands(0,3.999,rows*cols,random_seed);

/////////////////////////////////////////////
// render

color("lightgray")
grid(side,height);

/////////////////////////////////////////////
// modules
    
module grid(side,height){
    translate([0,0,baseheight])
    for(j=[0:cols-1])
        for(i=[0:rows-1]){
            translate([j*side,i*side,0])
            translate([side/2,side/2,0])
            rotate(floor(turn[j+i*(cols-1)])*90,[0,0,1])
            translate([-side/2,-side/2,0])
            tile(side,height);
        }
    base(length,width,baseheight);
}

module tile(side,height){
    polyhedron(
        points=[[0,0,0],[0,side,0],[side,side,0],[side,0,0],
                [0,0,height],[0,side,height]],
        faces=[[0,1,2,3],[3,2,5,4],[0,3,4],[2,1,5],[0,4,5,1]]
    );
}

module base(length,width,baseheight){
    cube([length,width,baseheight]);
}
