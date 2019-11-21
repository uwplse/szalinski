
// giesskanne sieb
// watering can sprinkler
//
// Title:        watering can diffusor
// Version:      1.007
// Release Date: 20170425 (ISO)
// Author:       David Larsson
//
// to be fit on can tip

// length of can tip slip_on
laenge_spitze=30; // [10:40]

// diameter of can tip end
diam_spitze=25; // [10:40]

// diameter of can connect tube [laenge_spitze] mm from tip
diam_spitze_innen=28; // [10:40]

// diameter of syphon ball
diam_boll=40; // [30:60]

// offset angle for sprinkler holes
voffs=0; // [0:30]

// thickness of walls
dik=2; // [1:3]

// foot rim for easier printing
foot=1; // {0:"no",1:"yes"]

module tip() {
difference() {
    union() {
        if( foot==1 ) {
// print foot
            color("blue")
            cylinder(dik,2*dik+diam_spitze_innen/2,2*dik+diam_spitze_innen/2);
        }
        
// can fit tube
        cylinder(laenge_spitze,dik+diam_spitze_innen/2,dik+diam_spitze/2,$fn=60);

// connect to syphon ball
        color("red")
        translate([0,0,laenge_spitze-.1]) {
            cylinder(10,dik+diam_spitze/2,dik+diam_spitze/2);
            if( voffs>0) 
            translate([dik/2,0,0])
              rotate([0,0,90])
                cube([diam_spitze/dik+4,2*dik,2*dik]);
    }
    }

// inner hollow space
    union() {
        translate([0,0,-.1])
        color("blue")
            cylinder(laenge_spitze+14,diam_spitze_innen/2,diam_spitze/2,$fn=60);

        translate([0,0,laenge_spitze+diam_boll/2]) 
            sphere(diam_boll/2);
    }
}

difference() {
// syphon ball
        translate([0,0,laenge_spitze+(dik+diam_boll)/2])
            sphere(dik+diam_boll/2,$fn=60);

// inner hollow space
    union() {
        translate([0,0,laenge_spitze])
            cylinder(+8,diam_spitze/2-1,diam_spitze/2-1,$fn=60);
        color("red")
        translate([0,0,laenge_spitze-3.2])
            cylinder(6,diam_spitze/2,diam_spitze/2);

        translate([0,0,laenge_spitze+(dik+diam_boll)/2]) {
            sphere(diam_boll/2);

            rotate([voffs,0,0]) {
// syphon ball sprinkler holes
        cylinder(diam_boll,1,1);

        for(v=[0:60:360])
            rotate([15,0,v])
                cylinder(diam_boll,1,1);

        for(v=[18:30:360])
            rotate([26,0,v])
                cylinder(diam_boll,1,1);

        for(v=[8:20:360])
            rotate([40,0,v])
                cylinder(diam_boll,1,1);
    }
    }
    }
}
}
difference() {
tip();
// cut out to check
//    translate([0,0,-.10]) cube([180,180,180]);
}
