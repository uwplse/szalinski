//
//   jig for drilling extra holes in old Billy shelves and so on
//
//   design by Egil Kvaleberg, 5 December 2016
//

// hole and peg diameter
hdia = 5.0;

// length of peg
hdepth = 6.0;

// jig thickness
wall = 4.0;

// number of pegs
pegs = 3;
// number of holes (for drilling)
holes = 2;

// distance between holes
hdist = 32.0;

width = 4*hdia;

// tolerance
tol = 0.2;
d = 1*0.01;

module peg()
{
    cylinder(d=hdia-2*tol, h=wall+hdepth-hdia/2, $fn=30);
    translate([0,0,wall+hdepth-hdia/2]) sphere(d=hdia-2*tol, $fn=30);
}

difference () {
    union () {
        translate([-hdist/2,-width/2,0]) cube([(pegs+holes)*hdist,width,wall]);
        for (n = [holes:holes+pegs-1]) translate([n*hdist,0,0]) 
            peg();
    }
    union () {
        for (n = [0:holes-1]) translate([n*hdist,0,-d]) 
            cylinder(d=hdia, h=2*wall+2*d, $fn=30);
    }
}