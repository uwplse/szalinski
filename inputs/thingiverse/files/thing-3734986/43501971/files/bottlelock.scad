/* [Bottle] */
// (1) Diameter of the bottleneck
bottleneck=26;

// (2) diameter of the ring around the bottles neck
collarDia=33;

// (3) height of the ring around the bottles neck
collarHeight=3;

// (4) Diameter of the bottle cap
bottleCapDia=30;

// (5) Height of the bottle cap
bottleCapHeight=22;

/* [lock related] */
// hole size for the lock
lockhole=8;

// wall thickness
wall=5;

/* [Hidden] */
// to avoid flickering, add a little overlap
overlap=.1;

module bottle(wide=0) {
    translate([wall+collarDia/2,wall+collarDia/2,0]) union() {
        hull() {
            cylinder(wall+overlap,bottleneck/2,bottleneck/2);
            translate([0,collarDia*wide,0]) cylinder(wall+overlap,bottleneck/2,bottleneck/2);
        }
        hull() {
            translate([0,0,wall]) cylinder(collarHeight,collarDia/2,collarDia/2);
            translate([0,collarDia*wide,wall]) cylinder(collarHeight,collarDia/2,collarDia/2);
        }
        hull() {
            translate([0,0,collarHeight+wall-overlap]) cylinder(bottleCapHeight+overlap,bottleCapDia/2,bottleCapDia/2);
            translate([0,collarDia*wide,collarHeight+wall-overlap]) cylinder(bottleCapHeight+overlap,bottleCapDia/2,bottleCapDia/2);
        }
    }
}


module bolt(cutout=0) {
    difference() {
        translate([-wall-lockhole-wall,0,0]) cube([wall+collarDia+wall*2+wall+lockhole+wall,wall+cutout,wall+lockhole+wall+cutout]);
        translate([-wall-lockhole/2,-overlap,wall+lockhole/2]) rotate([-90,0,0]) cylinder(wall+overlap*2,lockhole/2,lockhole/2);
    }
    translate([wall+collarDia+wall,-wall,0]) cube([wall,wall*3,wall+lockhole+wall]);
}
module lock() {
    difference() {
        translate([0,0,overlap]) cube([collarDia+wall*2,collarDia+wall*3,wall+collarHeight+bottleCapHeight+wall]);
        bottle(wide=1);
        translate([overlap,wall+collarDia,wall+collarHeight+2]) #bolt(cutout=1);
    }
    //#bottle(wide=0);
}
rotate([90,0,0]) lock();
translate([0,20,0]) bolt();
//bottle();