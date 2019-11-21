// Pneumatic manifold base
// Vincent Groenhuis
// Nov 20, 2018

// Min 22, max 50
PatternSpacing = 23;

// Number of ports per side
Positions = 3;

// 1 = ports on both sides, 0 = ports on single side only
DoubleSided = 1;

// Circular segments detailing
$fn=100;

difference(){
    body();
    holes();
}

module body() {
    for (i=[0:Positions-1]) {
        translate([PatternSpacing*i,0,0])cylinder(h=4,d=22); 
    }

    if (Positions>1) {
        for (i=[0:Positions-2]) {
            translate([PatternSpacing*i,0,0]) {
                arc();
                mirror([0,1,0])arc();
            }
        }
    }
}

module holes(){
    for (i=[0:Positions-1]) {
        translate([PatternSpacing*i,0,0]){
            translate([0,0,DoubleSided?-1:-3])cylinder(h=6,d=4);
            for (j=[0:5]){
                rotate([0,0,30+60*j])
                translate([9,0,-1])
                cylinder(h=6,d=2.15);            
            }
        }
    }
    translate([0,-1.5,1])cube([PatternSpacing*(Positions-1),3,2]);
}

module arc(){
    difference(){
        cube([PatternSpacing,1/2*sqrt(3)*22/2,4]);
        translate([PatternSpacing/2,1/2*sqrt(3)*PatternSpacing,-1])
          cylinder(h=6,d=22+(PatternSpacing-22)*2);
    }
}
