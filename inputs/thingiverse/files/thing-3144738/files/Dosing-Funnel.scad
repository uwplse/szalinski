$fn = 180*1;

// Base Outer diameter
OD = 76;

// Base Inner diameter
ID = 60.5;

// Funnel Diameter
// FD = 85;
FD = 76;

// Funnel Height
// FH = 18;
FH = 28;

// Overhang
OH = 2;

// thickness of walls
WALL = 2.8;

// thickness of lip
LIP = 1;

// LUG length
// LUGL = 27;
LUGL = 19.7;

// LUG height
LUGH = 5;
// LUGH = 10;

// LUG TYPE: 1 == Normal, 2 == Inverted, 3 == Single inverted
// LUGT = 1;
LUGT = 2;

module body () {
    cylinder(d=OD, h=FH+LUGH);
    translate([0,0,LUGH]) cylinder(d1=FD*.75, d2=FD, h=FH);        
}

module lugholes () {
    if (LUGT == 1) { // Normal LUGs
        cube([LUGL, OD*1.1, LUGH*2], center=true);
    } else if (LUGT == 2) { // Inverted LUG
        translate([-OD/2-LUGL/2, 0, 0])
            cube([OD, OD*1.1, LUGH*2], center=true);
        translate([OD/2+LUGL/2, 0, 0])
            cube([OD, OD*1.1, LUGH*2], center=true);
    } else if (LUGT == 3) { // Single Inverted LUG
        translate([-OD/2-LUGL/2, 0, 0])
            cube([OD, OD*1.1, LUGH*2], center=true);
        translate([OD/2+LUGL/2, 0, 0])
            cube([OD, OD*1.1, LUGH*2], center=true);
        translate([0,OD/2,0])
            cube([OD, OD, LUGH*2], center=true);
    }
}



difference () {
    
    // main body of dosing funnel
    body();
    
    // cone hole
    translate([0,0,LUGH+OH+LIP]) cylinder(d1=ID, d2=FD-WALL/2, h=FH);

    // inner hole    
    translate([0,0,-FH*0.05]) cylinder(d=ID, h=LUGH+FH*1.1);
    
    // outer lip hole
    translate([0,0,-OH*0.05]) cylinder(d=OD-2*WALL, h=LUGH+OH*1.05);
    
    // LUG holes
    lugholes();
}

