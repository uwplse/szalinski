/* [Size and Shape] */

// Height needed on the inside of the hexagon (mm)
total_interior_height = 60; // [50:200]

// Depth of the hexagon, front to back (mm)
hexagon_depth = 32; // [16:50]

// Recessed LEGO base?
LEGO_base = 1; // [1:Yes,0:No]

// LEGO recess location
LEGO_base_location = 0; // [1:Near Front,0:Center,-1:Near Back]

// Hole for pushing LEGO baseplate out (only with baseplate)?
baseplate_hole = 1; // [1:Yes,0:No]

// Back Type
back_type = 0; // [0:None,1:Full Back]

// Mount Type (only with full back)
mount_type = 1; // [0:None,1:Keyhole Mount]

/* [Rails and Slots] */

// Connector type - top
top_connector = -1; // [-1:Slot,0:None,1:Rail]
// Connector type - top right
top_right_connector = 1; // [-1:Slot,0:None,1:Rail]
// Connector type - bottom right
bottom_right_connector = -1; // [-1:Slot,0:None,1:Rail]
// Connector type - bottom
bottom_connector = 1; // [-1:Slot,0:None,1:Rail]
// Connector type - bottom left
bottom_left_connector = -1; // [-1:Slot,0:None,1:Rail]
// Connector type - top left
top_left_connector = 1; // [-1:Slot,0:None,1:Rail]

// Slot Gap (mm) (0.15 is super tight, 0.3 is recommended)
slot_gap = 0.3; // [0.15:0.5]

/* [Hidden] */

$fn = 30;
legoUnit = 1.6*5;
plateH = 3.2;

totH = total_interior_height;

baseD = hexagon_depth; //4*legoUnit;
t = plateH+1.6;

baseW = totH/cos(30)/2+t;
echo(baseW);
echo(2*(baseW-t)*cos(30));

module hex(h,d) {
    cylinder(h,d1=d,d2=d,$fn=6);
}

module cell() {
    difference() {
        hex(baseD,baseW*2);
        translate([0,0,-1]) hex(baseD+2,baseW*2-2*t);
    }
}

module keyhole() {
    h1 = 5;
    h2 = 9;
    hlen = 10;
    translate([0,0,-1]) hull() {
        cylinder(totH,d1=h1,d2=h1);
        translate([0,hlen,0]) cylinder(totH,d1=h1,d2=h1);
    }
    translate([0,0,-1]) cylinder(totH,d1=h2,d2=h2);
}
    
module partial_back(tt) {
    difference() {
        hex(tt,baseW*2-2*t);
        translate([-baseD-10,-2*baseD-13,-1]) cube([2*baseD+20,2*baseD+20,baseD+2]);
        keyhole();

    }
}

module fullBack(tt) {
    hex(tt,baseW*2-2*t);
}

module slider_old() {
    linear_extrude(baseD*1) {
        translate([-0.8,0,0]) square([1.6,1.6+1.6]);
        translate([-2,1.6,0]) square([4,1.6]);
    }
}

module slider() {
    linear_extrude(baseD*1) {
        translate([-0.8,-0.5,0]) square([1.6,1.6+1.6+0.5]);
        translate([-2,1.6,0]) square([4,1.6]);
    }
}


module slot() {
    // delta of 0.15 = original
    // delta of 0.3 = loose fit
    translate([0,0.2,-1]) linear_extrude(baseD+2) offset(delta=slot_gap) rotate([0,0,180]) {
        translate([-0.8,0,0]) square([1.6,1.6+1.6]);
        translate([-2,1.6,0]) square([4,1.6]);
    }
}

module stud() {
    cylinder(1.6,d1=4.8,d2=4.8,$fn=30);
}

module stud3x4() {
    translate([-legoUnit*1.5,-legoUnit*1,0]) {
        for (i=[0,3]) {
            for (j=[1:1]) {
                translate([i*legoUnit,j*legoUnit,0]) stud();
            }
        }
    }
}


cutoutW = 4*legoUnit+0.3;
cutoutD = 3*legoUnit+0.3;
cutoutH = plateH;

module plateCutout() {
    difference() {
        translate([-cutoutW/2,0,0]) cube([cutoutW,cutoutH+10,cutoutD]);
        // Studs
        if (LEGO_base == 1) translate([0,-0.1,cutoutD/2]) rotate([-90,0,0]) stud3x4();
    }
    // hole for pushing plate out
    if (baseplate_hole == 1) if (LEGO_base == 1) translate([0,5,cutoutD/2]) rotate([90,0,0]) cylinder(20,d1=5,d2=5,$fn=30);
}        

module display() {

    difference() {
        cell();
        
        // cutout for base
        if (LEGO_base == 1) translate([0,-totH/2-plateH,LEGO_base_location*(baseD/2-cutoutD/2-legoUnit/3)+baseD/2-cutoutD/2]) plateCutout();

 
        // slots
        if (top_connector == -1) {
            rotate([0,0,60*0]) {
                translate([baseW/6,baseW*cos(30),-0.15]) slot();
                translate([-baseW/6,baseW*cos(30),-0.15]) slot();
            }
        }
        if (top_right_connector == -1) {
            rotate([0,0,60*1]) {
                translate([baseW/6,baseW*cos(30),-0.15]) slot();
                translate([-baseW/6,baseW*cos(30),-0.15]) slot();
            }
        }
        if (bottom_right_connector == -1) {
            rotate([0,0,60*2]) {
                translate([baseW/6,baseW*cos(30),-0.15]) slot();
                translate([-baseW/6,baseW*cos(30),-0.15]) slot();
            }
        }
        if (bottom_connector == -1) {
            rotate([0,0,60*3]) {
                translate([baseW/6,baseW*cos(30),-0.15]) slot();
                translate([-baseW/6,baseW*cos(30),-0.15]) slot();
            }
        }
        if (bottom_left_connector == -1) {
            rotate([0,0,60*4]) {
                translate([baseW/6,baseW*cos(30),-0.15]) slot();
                translate([-baseW/6,baseW*cos(30),-0.15]) slot();
            }
        }
        if (top_left_connector == -1) {
            rotate([0,0,60*5]) {
                translate([baseW/6,baseW*cos(30),-0.15]) slot();
                translate([-baseW/6,baseW*cos(30),-0.15]) slot();
            }
        }
    }

  
    // rails
    if (top_connector == 1) {
        rotate([0,0,60*0]) {
            translate([baseW/6,baseW*cos(30),0]) slider();
            translate([-baseW/6,baseW*cos(30),0]) slider();
        }
    }
    if (top_right_connector == 1) {
        rotate([0,0,60*1]) {
            translate([baseW/6,baseW*cos(30),0]) slider();
            translate([-baseW/6,baseW*cos(30),0]) slider();
        }
    }
    if (bottom_right_connector == 1) {
        rotate([0,0,60*2]) {
            translate([baseW/6,baseW*cos(30),0]) slider();
            translate([-baseW/6,baseW*cos(30),0]) slider();
        }
    }
    if (bottom_connector == 1) {
        rotate([0,0,60*3]) {
            translate([baseW/6,baseW*cos(30),0]) slider();
            translate([-baseW/6,baseW*cos(30),0]) slider();
        }
    }
    if (bottom_left_connector == 1) {
        rotate([0,0,60*4]) {
            translate([baseW/6,baseW*cos(30),0]) slider();
            translate([-baseW/6,baseW*cos(30),0]) slider();
        }
    }
    if (top_left_connector == 1) {
        rotate([0,0,60*5]) {
            translate([baseW/6,baseW*cos(30),0]) slider();
            translate([-baseW/6,baseW*cos(30),0]) slider();
        }
    }
    
    // full back
    if (back_type == 1) difference() {
        fullBack(2);
        // keyhole mount
        if (mount_type == 1) translate([0,totH*0.4-10,-1]) keyhole();
    }
    
}

/*
difference() {
    display();
    translate([-100,-100,baseD/2]) cube([200,200,100]);
}
*/

/*
difference() {
    display();
    //translate([25,0,0]) rotate([0,0,60]) translate([-100,0,-1]) cube([200,100,100]);
    #translate([-100,0,-1]) cube([200,100,100]);
    #rotate([0,0,60]) translate([-100,0,-1]) cube([200,100,100]);
    #rotate([0,0,-60]) translate([-100,0,-1]) cube([200,100,100]);
}
*/

display();

//plateCutout();