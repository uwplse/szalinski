// I found magnets of these sizes in my magnet collection:
// 12.6 x 1.6
// 9.6 1.5

// Diameter of magnet disk
magnet = 12.6; 
// thickness of magnet disk
magneth = 1.6;
// handle height
h = 5;
// layer thickness of bottom
layer = 0.2;

/* [extras] */
// fit tolerance for the magnet
tol = 0.2;
// diameter change bottom to top
taper = 2;
dia = magnet+0.4*3;;

/* [hidden] */
$fn = 60;
difference() {
    cylinder(h=h, d1=dia, d2=dia+taper);
    translate([0,0,layer])cylinder(h=magneth+layer*2, d1=magnet, d2=magnet+tol);
    translate([0,0,magneth+layer*2]) cylinder(h=h, d1=magnet+tol, d2=magnet-tol);
}

// plug
translate([dia*3,0,0]) cylinder(h=h-magneth-layer*2, d1=magnet, d2=magnet-tol*2);
