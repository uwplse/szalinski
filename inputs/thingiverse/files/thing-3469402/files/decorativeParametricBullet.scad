/* [Global] */
// Base Diameter
diam = 38; // [1:0.5:100]

// Total length
length = 140; // [1:260]

// Polygon resolution
$fn=64; // [24:512]

// Hollow on the inside
hollow = "YES"; // [YES, NO]

// Notch at the base
notch = "YES"; // [YES, NO]

/* [Fine Tune Shape] */
// General flattening coefficient
a = 0.2; // [0:0.01:2]

// Exponent
d = 2.3; // [0.1:0.1:4]

// Exponent coefficient
c = 0.2; // [0:0.01:2]

// Asymptote coefficient
b = 20; // [0:0.1:100]

module mathExperiment(r=35,l=160,a=0.2,b=7,c=0.3,d=2.3) {
    N = min([max([12,2* $fn]), 513]);
    function curveY(x) = l-min([(c*pow(x,d) + b*abs(x/(r-x)))*a, l]);
    polyArray = [for(i = [0:N+1]) [(i>N?0:i*r/N), (i>N?0:curveY(i*r/N))] ];
    rotate_extrude()
        polygon(polyArray);
}

module torus(diam, radius) {
    rotate_extrude()
        translate([diam/2,3*radius])
            circle(radius);
}

module deluxeBullet(diam, length) {
    insideDiam = 0.6 * diam;
    keepout = 10;
    runout = length * 0.2;
    insideLength = length - (runout+keepout);
    difference() {
        mathExperiment(diam/2, length, a, b, c, d);
        union() {
            if (notch == "YES")
                torus(diam, 1.7);
            if (hollow == "YES") {
                translate([0,0,-0.01])
                    cylinder(d=insideDiam, h=0.1+insideLength);
                translate([0,0,insideLength])
                    cylinder(d1=insideDiam, d2=0, h=runout);
            }
        }
    }
}

deluxeBullet(diam, length);