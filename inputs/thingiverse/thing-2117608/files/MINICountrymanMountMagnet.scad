
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
// Magnet shape
magnetShape = 0; // [0:Circular, 1:Rectangular]);

// Mount base height
mountBaseHeight = 20; // [0:60]

// Magnet X dimension for rectangular shape
magnetX = 35;  // [0:50]

// Magnet Y dimension for rectangular shape
magnetY = 25; // [0:50]

// Magnet diameter for circular shape
magnetDiam = 15; // [0:50]

// Magnet height
magnetHeight = 1.5;

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
$fn=60;

heightSupport=mountBaseHeight;


magR = magnetDiam/2;
magSup = magnetShape==0 ? magnetDiam : sqrt(magnetX*magnetX+magnetY*magnetY);
m = max(magSup+2, width);
ang=armsAngle*mountDir;

cR=1.5;
cabRad=cableDiameter/2;
cabLen=5;



rotate(a=[0, 0, (mountDir == 1 ? 0 : 180) + mountDir*30]) carMount();
translate([mountDir*cos(60-armsAngle)*(len1-m/2), sin(60-armsAngle)*(len1-m/2), height]) mount();

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
difference() {
    supportD = max(magSup+2, width);
cylinder(r=supportD/2, h=heightSupport);
if (magnetShape==0) { 
    translate([0, 0, heightSupport-magnetHeight]) cylinder(r=magR, h=magnetHeight+1);
}
else {
    translate([-magnetX/2, -magnetY/2, heightSupport-magnetHeight]) cube([magnetX, magnetY, magnetHeight+1]);
}
}
}