$fn=50*1;

// PF Stand Height
H=55;

// PF Stand Outer Diameter
OD=79;

// PF Stand Inner Diameter
ID=71;

// PF Stand Bottom Thickness;
BH=5;

// PF Handle Width;
HANDLEW=20;

// PF Handle Height (from bottom of stand)
HANDLEH=18.5;

// Lug Thickness
LUGTH=6.5;

// Lug Length
LUGL=27;

// Bottom Hole Diameter
HOLED=10;

// Bottom Hole Height
HOLEH=9.1;

// Bottom Hole Offset
HOLEOFF=-0;
// HOLEOFF=-5;

// Hole Cap Diameter
CAPD=17.6;

// Hole Cap Height
CAPH=13.5;

// Channel Width
CHANNELW=8;

// Channel Length
CHANNELL=OD/2;

// Channel Height
CHANNELH=4;

// Channel Wall Thickness
CHANNELTH=4;


// Model Selection, 1 = stand, 2 = channel guide
SELECT=1;


module base() {
    difference () {
        cylinder(d=OD, h=H);
        translate([0,0,BH])
            cylinder(d=ID, h=H);
    }
    
    // Center cap
    translate([HOLEOFF,0,0]) cylinder(d=CAPD, h=CAPH);
    
    // Channel Cap
    translate([-OD/2 + CHANNELW/2 + CHANNELTH ,0,0]) 
        cylinder(d=CHANNELW+CHANNELTH*2, h=CHANNELH+CHANNELTH);
    translate([-OD/2 - 1 + CHANNELW/2, -CHANNELW/2 - CHANNELTH, 0])
        cube(size=[OD/2, CHANNELW+CHANNELTH*2, CHANNELH+CHANNELTH]);
}


if ( SELECT == 1) {
difference () {
    base();
    
    // Center hole
    translate([HOLEOFF,0,-1]) cylinder(d=HOLED, h=HOLEH+1);
    
    // Lug holes
    translate([0,0,H-LUGTH*0.5])
        cube(size=[LUGL, OD, LUGTH*1.01], center=true);
    
    // PF handle hole
    translate([0,0,HANDLEH+HANDLEW/2])
        rotate([0,90,0])
        cylinder(d=HANDLEW, h=H);
    rotate([0,0,-90])
        translate([-HANDLEW/2,0,HANDLEH+HANDLEW/2])
        cube([HANDLEW,H,H]);
    
    // Opposite Funnel Hole
    translate([-OD/2,0,H-5])
        rotate([0,0,-90])
        cube([HANDLEW,OD,10.01], center=true);
        
    // Channel Hole
    translate([-OD/2, -CHANNELW/2-0.2, -0.01])
        cube(size=[OD/2, CHANNELW+0.4, CHANNELH]);     
}
} else if ( SELECT == 2 ) {
    translate([-CHANNELL/2, -0.2, 0])
        cylinder(d=CHANNELW-0.4, h=CHANNELH-1);
    difference () {
        translate([-CHANNELL/2, -CHANNELW/2, 0])
            cube(size=[CHANNELL/2, CHANNELW-0.4, CHANNELH-1]);     
        translate([HOLEOFF,0,-0.01]) cylinder(d=HOLED-0.4, h=HOLEH);
    }
    difference () {
        translate([HOLEOFF,0,0]) cylinder(d=HOLED-0.4, h=1);
        translate([0,0,-1]) cylinder(d=5, h=3);
        translate([-CHANNELL/2,CHANNELW/2-0.4,-0.01])
            cube([CHANNELL,CHANNELW,CHANNELH]);
        translate([-CHANNELL/2,-CHANNELW*1.5,-0.01])
            cube([CHANNELL,CHANNELW,CHANNELH]);
    }
}
