
/* [Support] */
// Length of the mount arm. Longer arms will produce more vibrations.
armLenght = 135; // [120:170]

// Mount direction
mountDir = 1; // [1:To the right, -1:To the left]
// Angle between arms. Best suit for me was 30º
armsAngle = 30; // [0:90]

// Include cable holder
cableHolder = 1; // [0:No, 1:Yes]

// Cable diameter
cableDiameter = 4; // [1:10]

// Separation between cable holder and mount support
holderSeparation = 90; //[10:150]

/* [Mount] */

// Phone width
phoneW = 80;

// Phone depth
phoneD = 10;

// Mount height
mountH = 30;

// USB plug width
usbW = 10;

// USB plug depth
usbD = 5;

/* [Hidden] */
width=30;
height=4;
corner=10;
len1=armLenght;
len2=95;


mountH1 = 5;

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
$fn=60;

ang=armsAngle*mountDir;

cR=1.5;
cabRad=cableDiameter/2;
cabLen=5;

rotate(a=[0, 0, (mountDir == 1 ? 0 : 180) + mountDir*30]) carMount();
translate([mountDir*cos(60-armsAngle)*(len1-phoneW/4), sin(60-armsAngle)*(len1-mountH*3/2), height+phoneD+2]) rotate(a=[-90, 0, 0]) mount();
module carMount() {
difference() {
union() {
sideA();
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
    wT = 1.2;
    difference() {
        translate([-phoneW/2-wT, 0, 0]) cube([phoneW+2*wT, phoneD+2*wT, mountH]);
        translate([-phoneW/2+mountH1, -phoneD, mountH1]) cube([phoneW-mountH1*2, phoneD*2, mountH]); 
        translate([-phoneW/2, wT, wT]) cube([phoneW, phoneD, mountH+1]);
        translate([0, phoneD/2+wT, 0]) cube([usbW, usbD, wT*3], center=true);
        translate([-phoneW/2, phoneD/2+wT, mountH-usbW/2+1]) cube([wT*3, usbD, usbW], center=true);
    }
}