h1 = 10;
h2 = 4;
r1 = 8;
r2 = 1.8;
rx = 1.5;
$fn = 30;

drilHole = 1;

shell();

if(drilHole == 1) {
    part1();
}

module part1() {
    union() {
        translate([-r1+rx/4,0,h1/2])
        rotate([0,90,0])
            cylinder(r=r2, h=r1*2-rx/2);
        
        translate([-r1/2,-r2,0.5])
            cube([r1,r2*2,h1*2]);
    }
}

module shell() {
    union() {
        difference() {
            cylinder(r=r1,h=h1);
            
            translate([0,0,-1])
                cylinder(r=r1-rx,h=h1+2);
            
            if(drilHole == 1) {
                translate([-r1*2,0,h1/2])
                    rotate([0,90,0])
                        cylinder(r=2, h=r1*4);
                
                translate([-r1,-r2-0.05,h1/2+0.3])
                    cube([r1*2,r2*2+0.1,h1/2-1.5]);
            }
        }
        difference() {
            translate([0,0,-1])
                cylinder(r=r1+2,h=2);

            translate([0,0,-4])
                cylinder(r=r1-rx,h=h1+2);    
        }
    }
}