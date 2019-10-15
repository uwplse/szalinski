include <MCAD/involute_gears.scad>

/* [General] */
// Which part to print
part="all"; // [large:Large gear,small:Small gear,all:Both gears]
// Outer diameter of large gear - used to calculate diametral pitch
Ldiam1=140;
// Twist angle - (positive angle=helical gear,negative value=double helical)
twist=-270;
// Clearance
eps=0.1;
// Number of faces for curves
$fn=36;
// Pressure angle
PA=20;

/* [Large gear] */
// Large gear thickness
Lth1=5;
// Inner rim thickness of large gear
Lth2=5;
// Hub thickness of large gear
Lth3=5;
// Number of teeth on large gear
Lnteeth=68;
// Inner diameter of large gear
Ldiam2=124;
// Hub diameter of large gear
Ldiam3=104;
// Bore diameter of large gear
Ldiam4=75;
// Number of holes in large gear
Lholes=4;

/* [Small gear] */
// Small gear thickness
Sth1=5;
// Inner rim thickness of small gear
Sth2=2.5;
// Hub thickness of small gear
Sth3=5;
// Number of teeth on small gear
Snteeth=20;
// Inner diameter of small gear
Sdiam2=40;
// Hub diameter of small gear
Sdiam3=10;
// Bore diameter of small gear
Sdiam4=5;
// Number of holes in small gear
Sholes=8;

// [* Hidden *]
// Diametral pitch
diam_pitch=(Lnteeth+2)/Ldiam1;

module my_gear(th1,th2,th3,nteeth,diam2,diam3,diam4,holes) {
    diam1=(nteeth+2)/diam_pitch;
    gear(
        number_of_teeth=nteeth,
        diametral_pitch=diam_pitch,
        pressure_angle=PA,
        rim_thickness=th1,rim_width=(diam1-diam2)/2,
        gear_thickness=th2,
        hub_thickness=th3,hub_diameter=diam3,
        bore_diameter=diam4,
        circles=holes,
        twist=twist/nteeth,
        clearance=eps
    );
    if (twist<0)
        mirror([0,0,1]) gear(
            number_of_teeth=nteeth,
            diametral_pitch=diam_pitch,
            pressure_angle=PA,
            rim_thickness=th1,rim_width=(diam1-diam2)/2,
            gear_thickness=th1,
            hub_thickness=th1,hub_diameter=diam3,
            bore_diameter=diam4,
            circles=holes,
            twist=twist/nteeth,
            clearance=eps
        );
}

if (part=="large")
    mirror() my_gear(Lth1,Lth2,Lth3,Lnteeth,Ldiam2,Ldiam3,Ldiam4,Lholes);
else if (part=="small")
    my_gear(Sth1,Sth2,Sth3,Snteeth,Sdiam2,Sdiam3,Sdiam4,Sholes);
else if (part=="all") {
    mirror() translate([(Lnteeth/diam_pitch-eps)/2,0,0]) rotate(360/Lnteeth*$t)
    my_gear(Lth1,Lth2,Lth3,Lnteeth,Ldiam2,Ldiam3,Ldiam4,Lholes);
    translate([(Snteeth/diam_pitch-eps)/2,0,0]) rotate(360/Snteeth*$t+180/Snteeth)
    my_gear(Sth1,Sth2,Sth3,Snteeth,Sdiam2,Sdiam3,Sdiam4,Sholes);
}
