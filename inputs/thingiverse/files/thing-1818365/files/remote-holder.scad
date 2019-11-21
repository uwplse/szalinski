//
//  wall holder for aircond remote control
//
//  design by egil kvaleberg, 5 october 2016
//
//  added support for chamfer
//

// size of compartment
comp_w = 46;
comp_d = 23;
comp_h = 52;
// width of front slot
slot_w = 34;
// width of slot lower lip
slot_lower = 16; 
// corner radius of compartment
corner_r = 4;
// wall thickness of comparement
wall = 2.5;
// chamfer for top entry and bottom (typical value is 0.6)
chamfer = 0.0;
// diameter of mounting screws
mnt_dia = 2.5;

// generic tolerance
tol = 0.25;

d = 1*0.1;

module add() {
    // chamfered bottom section
    if (chamfer > 0) hull() for (sx = [-1,1]) for (sy = [-1,1]) 
        translate([sx*(comp_d/2-corner_r),sy*(comp_w/2-corner_r),-wall]) {
            cylinder(r1=wall+corner_r-chamfer, r2=wall+corner_r, h=chamfer, $fn=30);
        }   
    // main section    
    hull() for (sx = [-1,1]) for (sy = [-1,1]) 
        translate([sx*(comp_d/2-corner_r),sy*(comp_w/2-corner_r),chamfer-wall]) {
            cylinder(r=wall+corner_r, h=wall+comp_h-chamfer, $fn=30);
        }   
}

module sub() {
    // main compartment 
    hull () for (sx = [-1,1]) for (sy = [-1,1]) 
        translate([sx*(comp_d/2-corner_r),sy*(comp_w/2-corner_r),0]) {
            cylinder(r=corner_r, h=comp_h+d, $fn=30);
    }
    // main compartment, chamfered section
    if (chamfer > 0) hull () for (sx = [-1,1]) for (sy = [-1,1]) 
        translate([sx*(comp_d/2-corner_r),sy*(comp_w/2-corner_r),comp_h-chamfer]) {
            translate([0,0,]) cylinder(r1=corner_r, r2=corner_r+chamfer+d, h=chamfer+d, $fn=30);
    }
    // slot in front
    translate ([0,0,slot_lower+comp_h/2]) rotate([0,-90,0]) hull () for (sx = [-1,1]) for (sy = [-1,1]) 
        translate([sx*(comp_h/2-corner_r),sy*(slot_w/2-corner_r),0]) {
            cylinder(r=corner_r, h=comp_h+d, $fn=30);
    }
    // mounting holes
    translate ([comp_d/2-d,0,comp_h/2]) rotate([0,90,0]) for (sy = [-1,1]) 
        translate([0,sy*slot_w/4,0]) {
            cylinder(d1=mnt_dia+2*tol+2*wall*0.6, d2=mnt_dia+2*tol, h=d+wall*0.6, $fn=30);
            cylinder(d=mnt_dia+2*tol, h=d+wall+d, $fn=30);
    }   
}
    // mounting holes
    if (0) color("red") translate ([comp_d/2-d,0,comp_h/2]) rotate([0,90,0]) for (sy = [-1,1]) 
        translate([0,sy*slot_w/4,0]) {
            cylinder(d=mnt_dia+2*tol, h=d+wall+d, $fn=30);
    } 

    // main structure:
    difference () {
        color("red") add();
        difference () {
            sub();
            //
        }
    }
