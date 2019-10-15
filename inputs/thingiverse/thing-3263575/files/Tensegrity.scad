// Select strut or cap / Strebe oder Kappe auswaehlen
part = 0; // [0:Strut / Strebe, 1:Cap / Kappe]
// Number of sides / Anzahl der Seitenflaechen
fn = 6; // [3:60]
// Radius of part / Radius des Teils
r = 3.0;
// Width of slot / Weite des Schlitzes
sw = 2.0;
// Distance of parts / Abstand der Teile
dist = 10;
// Length of strut / Laenge einer Strebe
l = 100.0;
// Length of slot (in strut) / Laenge des Schlitzes (in der Strebe)
sl = 5.0;
// Index of bottom side / Index der Auflageflaeche
side = 0;
// Number of struts / Anzahl der Streben
ns = 6;
// Height of cap / Hoehe einer Kappe
h = 10.0;
// Height of bottom or 0 for a hood / Hoehe des Bodens oder 0 fuer eine Haube
b = 2.0;
// Thickness of wall of cap / Dicke der Wand einer Kappe
w = 1.0;
// Number of rows of caps / Anzahl der Reihen von Kappen
ncr = 3;
// Number of columns of caps / Anzahl der Spalten von Kappen
ncc = 2;

//  Struts for tensegrity models. Just rods with slots on both ends.
//  Streben fuer Tensegrity Modelle. Einfache Staebe mit Schlitzen an beiden Enden.
//  
//  Appropriate caps. Eventually use slightly larger radius.
//  Geeignete Kappen. Eventuell etwas groesseren Radius benutzen!
//

module strut(r, sw, l, sl, side) {
    rotate([0, -90, 0])
    rotate([0, 0, side*360/$fn])
    difference() {
        rotate([0, 0, 180 + 180/$fn]) cylinder(r=r, h=l);
        for (z = ([0:l:l])) translate([0, 0, z]) cube([2*r+1, sw, 2*sl], center=true);
    }
}

module cap(r, sw, h, b, w) {
    difference() {
        rotate([0, 0, 180/$fn]) difference() {
            union(){ 
            if (b == 0) { sphere(r=r+w); };
            cylinder(r=r+w, h=h);};
            translate([0, 0, b]) cylinder(r=r, h=h+0.1);
        }
        translate([-r-sw-1, -sw/2, b]) cube([2*(r+w+1), sw, h+0.1]);
    }
}

module struts(ns, dist, fn, r, sw, l, sl, side) {
    $fn=fn;
    for (y = ([0:1:ns-1])) translate([0, y*dist, 0]) 
        strut(r, sw, l, sl, side);
}

module caps(ncr, ncc, dist, fn, r, sw, h, b, w) {
    $fn = fn;
    for (x = ([0:1:ncr-1])) for (y = ([0:1:ncc-1])) translate([x*dist, y*dist, 0])
       cap(r, sw, h, b, w);
}

if (part == 0) {
    struts(ns, dist, fn, r, sw, l, sl, side);
} else {
    caps(ncr, ncc, dist, fn, r, sw, h, b, w);
}
