// height chimney (mm)
h=70; 

// width chimney (mm)
b=80; 

// depth chimney (mm)
t=60; 

// thickness chimney wall (mm)
d=5; 

// inclination of roof (in degrees)
a=40; // [0:89]


/* [Hidden] */
// sin a = h / c
// c = sqrt((b/2)^2+h^2)
// solve h=sin(a)*sqrt(b^2/4+h^2) for h
hroof = b * sin(a)/(2 *sqrt(1 - sin(a)*sin(a)));


difference() {
    // chimney
    cube([b, t, h]);

    union() {
        // inner cube to remove
        translate([d, d, 0])
        cube([b-2*d, t-2*d, h]);

        roof(b, t, hroof);
    }
}

module roof(b, t, h){
   polyhedron(
       points=[[0,0,0], [0,t,0], [b,t,0], [b,0,0], [b/2,0,h], [b/2,t,h]],
       faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[1,5,2],[0,3,4]]
   );
}
