// Subtractive implementation of Sierpinski pyramid by DrLex, 2017/10
// Based on Thing:2573402 by aeropic
// Released under Creative Commons - Attribution license

// Order of sierpinski fractal. Customizer is limited to 4, because 5 would timeout anyway. Use OpenSCAD for higher order numbers.
order = 3; //[0,1,2,3,4]
// Size (half diagonal) of smallest pyramid.
size = 1.5; //[.5:.1:20]
// Vertical scale factor
zscale = 1.0; //[.5:.1:2]

/* [Advanced] */
// Layer height you will be printing at; entering the right value here will ensure perfect alignment of the structure.
layers = 0.2;
// Shift the whole print up by this distance; use this to add a solid bottom layer, and/or nudge the layers to avoid that your slicer breaks the spiral vase in case of bad alignment.
shift = 0.0;
// Gap width, must be at least 0.1 to make spiral vase mode work in Slic3r.
gap = 0.10; //[.01:.01:.5]

/* [Hidden] */
sq2 = sqrt(2);
// align each 'floor' with layer height, such that connections between floors are at least 0.42mm wide
estimate = zscale*(size-sq2*0.21);
eps = (size-layers*floor(estimate/layers)/zscale)/sq2;
conn = 0.46;
rtop = 0.04;
// All lines marked with 'MF' include some fudge factor to avoid exactly overlapping geometries, which usually lead to non-manifold results when combined in a Boolean fashion
epsh = 1.01*zscale*sq2*(eps+gap/2)+0.01; //MF

totalsize = pow(2,order) * (size*sq2 - 2*eps) + 2*eps;


translate([0,0,shift]) {
    difference() {
        rotate([0,0,45]) cylinder(r1=totalsize/sq2, r2=rtop, h=zscale*(totalsize/sq2-rtop), $fn=4);
        ss(order-1);
    }
}
if(shift > 0) {
    translate([-totalsize/2, -totalsize/2, 0]) cube([totalsize, totalsize, shift+0.01]); //MF
}


// Construct a tetrahedron that slightly extends beyond the pyramid surface so we're not doing booleans at perfectly matching surfaces, which never ends well
module tetrahole(r) {
    h = zscale*sq2*r/2*.999; //MF
    r2 = r/2*.999; //MF
    rx = 1.01*r;
    r2x = 1.025*r2;
    polyhedron(
        points=[ [0,0,0], [rx,0,0], [r2,-r2,h], [r2,r2,h], [r2x,-r2,h], [r2x,r2,h] ],
        faces=[ [0,2,4,1],[0,1,5,3],[0,3,2],[2,3,5,4],[1,4,5] ]
    );
}


// sierpinsky recursive code 
module ss(ord){
    k = pow(2,ord);
    w = size *k;
    w2 = k * (size*sq2 - 2*eps) - 2*eps;

    if(ord > -1) {
        // recursion for the 6 subparts
        translate([-k*eps+w/sq2, -k*eps+w/sq2, 0]) ss(ord-1);
        translate([k*eps-w/sq2, k*eps-w/sq2, 0]) ss(ord-1);
        translate([k*eps-w/sq2, -k*eps+w/sq2, 0]) ss(ord-1);
        translate([-k*eps+w/sq2, k*eps-w/sq2, 0]) ss(ord-1);
        translate([0, 0, zscale*(w-sq2*k*eps)]) rotate([180,0,0]) ss(ord-1);
        translate([0, 0, zscale*(w-sq2*k*eps)]) ss(ord-1);
        
        // create both the holes and the gaps to ensure a single outline curve
        translate([conn, -gap/2, -0.01])  cube([sq2*w, gap, epsh]);
        translate([2*eps, 0, zscale*sq2*eps]) tetrahole(w2);
        rotate([0,0,90]) {
            translate([conn, -gap/2, -0.01])  cube([sq2*w, gap, epsh]);
            translate([2*eps, 0, zscale*sq2*eps]) tetrahole(w2);
        }
        rotate([0,0,180]) {
            translate([conn, -gap/2, -0.01]) cube([sq2*w, gap, epsh]);
            translate([2*eps, 0, zscale*sq2*eps]) tetrahole(w2);
        }
        rotate([0,0,270]) {
            translate([conn, -gap/2, -0.01])  cube([sq2*w, gap, epsh]);
            translate([2*eps, 0, zscale*sq2*eps]) tetrahole(w2);
        }
    }
 } // end module ss
