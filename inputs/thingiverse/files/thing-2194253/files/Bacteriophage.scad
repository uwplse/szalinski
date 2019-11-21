// Bacteriophage by Erik Wrenholt 2017-02-12
// License: Creative Commons - Attribution

$fn = 12;

leg_count = 6;
leg_width = 1.75;

printable_phage();

module printable_phage() {
    // chop off the bottom of the legs so they are flat on the bottom.
    difference() {
        bacteriophage();
        translate([0,0,-5]) cube([100,100,10], center=true);
    }
}

module bacteriophage() {
    body();
    for(i=[0:leg_count]) {
        rotate((360 / leg_count) * i, [0,0,1])
            leg();
    }
 }

module body() {
    
    // Icosahedral head
    translate([0,0,30]) 
    scale([1,1,1.3])
        rotate(30, [0,1,0]) 
                icosahedron(5);
    
    // Base-Plate
    translate([0,0,1.5])
        scale([1,1,0.4])
            rotate(30, [0,0,1])
                sphere(6, $fn=12);

    // Helical Sheath
    for(i=[2:10]) {
        translate([0,0,i*2])
            scale([1,1,0.5])
                sphere(4);
    }

}

module leg() {
    union() {
        hull() {
            translate([2,0,0]) sphere(leg_width);
            translate([15,0,12]) sphere(leg_width);
        }
        hull() {
            translate([15,0,12]) sphere(leg_width);
            translate([25,0,-2]) sphere(leg_width);
        }
    }
}


// https://www.thingiverse.com/thing:1343285

/*****************************************************************
* Icosahedron   By Adam Anderson
* 
* This module allows for the creation of an icosahedron scaled up 
* by a factor determined by the module parameter. 
* The coordinates for the vertices were taken from
* http://www.sacred-geometry.es/?q=en/content/phi-sacred-solids
*************************************************************/

module icosahedron(a = 2) {
    phi = a * ((1 + sqrt(5)) / 2);
    polyhedron(
        points = [
            [0,-phi, a], [0, phi, a], [0, phi, -a], [0, -phi, -a], [a, 0, phi], [-a, 0, phi], [-a, 0, -phi], 
            [a, 0, -phi], [phi, a, 0], [-phi, a, 0], [-phi, -a, 0], [phi, -a, 0]    
        ],
        faces = [
            [0,5,4], [0,4,11], [11,4,8], [11,8,7], [4,5,1], [4,1,8], [8,1,2], [8,2,7], [1,5,9], [1,9,2], [2,9,6], [2,6,7], [9,5,10], [9,10,6], [6,10,3], [6,3,7], [10,5,0], [10,0,3], [3,0,11], [3,11,7]
        ]
    
    );
}