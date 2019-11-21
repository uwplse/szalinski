/*  Russell Salerno 2018-01-12
    * Snap-on cap for upcycling the measuring cup found on every jug of laundry detergent
    * Fits Tide cups perfectly (may fit other brands too)
    * With holes, can be used for desiccant, potpourri, animal repellant, salt shaker etc. 
    * Without holes, can be used to store small items, thumbtacks etc.
*/

// Cap diameter
capd=69.0;

// Hole diameter
holed=1.4;

// Holes or no holes?
holes = "holes";    // ["holes":Holes, "no_holes":No holes ]

module null() {}

capz=5.5;
grooveh=3.5;
groovew=2.5;
grooveapex=0.5;
groovek=1.2;

$fn=60;


module hole(num, diam) {
    for (i=[0:num-1]) rotate([0,0,i*360/num]) translate([diam,0,0]) cylinder(d=holed, h=capz);
}

module holes() {
    hole(1, 0);
    hole(5, 3);
    hole(11, 6);
    hole(17, 9);
    hole(23, 12);
    hole(32, 15);
    hole(38, 18);
    hole(43, 21);
    hole(51, 24);
    hole(57, 27);
}

module polyg() {
    polygon([[0, -grooveh], [-groovew, -grooveh], [-groovew*.65, -grooveapex], [-groovew, groovek], [0, groovek]]);
}

module groove() {
    rotate_extrude() translate([capd/2-1, 0, 0]) polyg();
}

module cap() {
    difference() {
        difference() {
            cylinder(d=capd, h=capz);
            translate([0,0,capz-1]) groove();
            translate([0,0,1.5]) cylinder(d=capd-8, h=capz-1);
        }
        if ( holes == "holes" ) holes();
    }
}

cap();
