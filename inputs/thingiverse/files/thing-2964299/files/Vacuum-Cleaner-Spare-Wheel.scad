
// vacuum cleaner / spare wheel

// --- axle left
// diameter (axle left)
a = 6.6;

// min. diameter (axle left)
amin = 5.26;

// length (axle left)
b = 9.5;

// length till min diameter (axle left)
b1=1.82;

// length with min diameter (axle left)
b2=2.56;

// length till max diameter (axle left)
b3=1;

// --- wheel
// diameter (wheel) middle
ci = 25.63;


// diameter (wheel) outside
co = 24.7;

// width (wheel)
d = 12;

// part of width (wheel) with middle diameter
di = 5;

// --- axle right
// diameter (axle right)
e = 6.6;

// min. diameter (axle right)
emin = 5.26;

// length (axle right)
f = 9.5;


// length till min diameter (axle right)
f1=1.82;

// length with min diameter (axle right)
f2=2.56;

// length till max diameter (axle right)
f3=1;


// quality 
$fn=100;


//rotate([90,0,0]) {
    wheel();
    axleLeft();
    axleRight();
//}    
    
// wheel
module wheel() {
    translate([0,0,(d/2+di/2) / 2])
    cylinder(d1=ci, d2=co, h=d/2-di/2, center=true);

    cylinder(d=ci, h=di, center=true);

    translate([0,0,-(d/2+di/2)/2])
    cylinder(d1=co, d2=ci, h=d/2-di/2, center=true);
}


// axle left
module axleLeft() {
    // in wheel
    translate([0,0, -d/2])
    cylinder(d=a, h=d/2);
    
    translate([0,0, -d/2-b1])
    cylinder(d1=amin, d2=a, h=b1);
    
    translate([0,0, -d/2-b1-b2])
    cylinder(d=amin, h=b2);
    
    translate([0,0, -d/2-b1-b2-b3])
    cylinder(d1=a, d2=amin, h=b3);
    
    translate([0,0, -d/2-b1-b2-b3-(b-b1-b2-b3)])
    cylinder(d=a, h=b-b1-b2-b3);
}

// axle right
module axleRight() {
        // in wheel
    translate([0,0, 0])
    cylinder(d=a, h=d/2);
    
    translate([0,0, d/2])
    cylinder(d1=a, d2=emin, h=f1);
    
    translate([0,0, d/2+f1])
    cylinder(d=emin, h=f2);
    
    translate([0,0, d/2+f1+f2])
    cylinder(d1=emin, d2=a, h=f3);
    
    translate([0,0, d/2+f1+f2+f3])
    cylinder(d=a, h=f-f1-f2-f3);

}
