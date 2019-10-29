
/* [Support] */
// Length of the mount arm. Longer arms will produce more vibrations.
armLenght = 145; // [120:170]

// Mount direction
mountDir = 1; // [1:To the right, -1:To the left]
// Angle between arms. Best suit for me was 30º
armsAngle = 30; // [0:90]

// Include cable holder
cableHolder = 1; // [0:No, 1:Yes]

// Cable diameter
cableDiameter = 4; // [1:10]

// Separation between cable holder and mount support
holderSeparation = 60; //[10:150]

/* [Mount] */

// Mount base diameter
mountBaseDiam = 8; // [2:10]

// Mount base height
mountBaseHeight = 20; // [0:60]

// Mount sphere diameter
mountSphereDiam = 18; // [10:50]

/* [Hidden] */
width=30;
height=4;
corner=10;
len1=armLenght;
len2=95;


rad1=6;
rad2=7;
rad3=2;
h1=6;
h2=2;

// Separation between drills
dist1=75;

// Distance to end from mount base
dist2=10;
dist3=holderSeparation;
$fn=50;

radSupport=mountBaseDiam/2;
heightSupport=mountBaseHeight;
sphereRadius=mountSphereDiam/2;

ang=armsAngle*mountDir;

cR=1.5;
cabRad=cableDiameter/2;
cabLen=5;

rotate(a=[0, 0, (mountDir == 1 ? 0 : 180) + mountDir*30]) carMount();

module carMount() {
difference() {
union() {
sideA();
translate([len1-dist2, 0, height]) mount();
rotate(a=[0, 0, ang]) translate([-len2+width/2, 0, 0]) sideB();
    if (cableHolder==1) translate([len1-dist3, 0, height]) cableHolder();
}
rotate(a=[0, 0, ang]) translate([-len2+width/2, 0, 0]) drills();
}
}

module cableHolder() {
    translate([0, 0, cabRad+cR]) rotate(a=[90, -180, -mountDir*90])
    difference() {
        union() {
    cylinder(r=cabRad+cR, h=cabLen);
    translate([-cabRad-cR, 0, 0]) cube([cabRad+cR, cabRad+cR, cabLen]);
        }
    translate([0, 0, -1]){ cylinder(r=cabRad, h=cabLen+2);
    translate([0.5, 0.5, 0]) cube([cabRad+cR, cabRad+cR, cabLen+2]);}}
}

module sideA() {
hull() {
    cylinder(r=width/2, h=height);
    translate([len1-width/2, 0, 0]) cylinder(r=width/2, h=height);
}    
}

module sideB() {
    hull() {
    cylinder(r=width/2, h=height);
    translate([(len2-width/2), 0, 0]) cylinder(r=width/2, h=height);
    }
    translate([-(width/2-10), 0, height]) cylinder(r=rad2, h=h1);
    translate([-(width/2-10)+dist1, 0, height]) cylinder(r=rad2, h=h1);
}

module drills() {
    translate([-(width/2-10), 0, -1]) cylinder(r=rad1, h=height+h1-h2+1);
    translate([-(width/2-10)+dist1, 0, -1]) cylinder(r=rad1, h=height+h1-h2+1);
    translate([-(width/2-10), 0, 0]) cylinder(r=rad3, h=height+h1+1);
    translate([-(width/2-10)+dist1, 0, 0]) cylinder(r=rad3, h=height+h1+1);
}

module mount() {
cylinder(r=radSupport, h=heightSupport);
translate([0, 0, heightSupport]) sphere(r=sphereRadius);
}