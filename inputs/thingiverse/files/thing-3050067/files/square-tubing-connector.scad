// Square tubing corner connector
// David O'Connor  david@lizardstation.com
// 14 August 2018

// Inside dimension
insideDim = 9.5; // [6:0.1:30]
// Outside dimension
outsideDim = 12.7;// [6:0.1:30]
// Protrusion length
protrusionLength = 15;// [6:0.2:60]
// Roundoff radius
roundoffRadius = 1;// [1.0:0.1:4.0]

bracket(id=insideDim, od=outsideDim, l=protrusionLength, r=roundoffRadius, fa=5, $fs=0.5);

module bracket(id=6, od=8, l=8, r=1) {
    union() { 
        cube([od, od, od], center=true);
        m = l/2+od/2;
        translate([0, 0, m])
            protrusion(id, l, r);

        translate([m, 0, 0])
            rotate([0, 90, 0])
                protrusion(id, l, r);

        translate([0, m, 0])
            rotate([90, 0, 0])
                protrusion(id, l, r);
    }
}

module protrusion(t, l, r) {
    minkowski() {
    cube([t-2*r, t-2*r, l], center=true);  
        sphere(r=r);
    }
}  

