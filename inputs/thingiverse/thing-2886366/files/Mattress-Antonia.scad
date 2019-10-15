// "Mattress"
// Based on an original idea of Antonia (7yo)
// (c) 2018 Harald Mühlhoff, 58300 Wetter, Germany

// Mattress Width
a = 62;

// Mattress Height
e = 8;

// Outer diameter joint
b = e*0.6;

// Inner diameter joint
c= b-1;

// Segment Length
d = 20;



// Distance between segments
f = 3;

// Height joint
g = 2;

// Height "stopper"
h = 2;


// Number of segments
i = 4;

$fn=50;




for(it=[0: i-1]) {

    translate([0, it*e*1.4, a])
    rotate([0,180, 0]) {

        // Joint
        translate([-d-f,0,0])
        cylinder(d=c, h=a-h);

        // Connection Joint to Cube
        translate([-d-c/2, -g/2, 0])
        cube([c/2+f, g, a-h]);


        difference() {
            // Cube
            translate([-d+c/2, -e/2, 0])
            cube([d, e, a]);

            // place for joint
            cylinder(d=b, h=a-h);
        }

}
}