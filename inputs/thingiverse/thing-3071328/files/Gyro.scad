// - Outer diameter of the gyro
MaxOD = 45;

// - Wall thickness of the segments
T = 2.1;

// - Clearance between segments
C = 1.5;

// - Minimum overlap between segments
MinOL = 0.25;

// - Maximum print angle
MaxAng = 40;

// - Print quality
$fn=50;


/* [Hidden] */

H = 2*sqrt(pow(MaxOD/2-T,2)-pow(MaxOD/2-T-C-MinOL,2));
echo(H);

intersection() {
    Anulus(MaxOD);
    cylinder(d=MaxOD,H,center=true);
}

module Anulus(OD) {
    ang = atan((H/2)/(OD/2-T));
    echo(OD, ang);
    if(ang<MaxAng) {
        difference() {
            sphere(d=OD);
            sphere(d=OD-T);
        }
        Anulus(OD-T-C);
    }
}