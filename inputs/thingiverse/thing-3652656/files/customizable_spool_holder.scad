// Diameter of the spool hole in mm (where the spool holder will fit)
spool_hole_diameter=57; 

// Height of the spool holder in mm
height=10; 

// Diameter of the inner hold of the spool holder in mm (where the bearing is placed)
bearing_diameter=22;

// Spool holder inner ring thickness in mm
inner_ring_thickness=4; 


number_of_arms=6;

// Arms thickness in mm
arms_thickness=4; 

// Which side do you want to print?
side=1; // [0:Left, 1:Right]


module ring(r0, r1, h=5, center=false, $fn=32) {
    difference()
    {
        cylinder(r=r1, h=h, center=center);
        translate([0, 0, -h/2]) {
            cylinder(r=r0, h=h*4, center=center);
        }
    }
}

module half_moon(r0=10, r1=10, r2=0, offset=10, h=10, center=false, $fn=32) {
    difference() {
        cylinder(r=r0, h=h, center=center);
        translate([offset,0,-h/2])
        cylinder(r=r1, h=h*4, center=center);
        translate([0,r2,-h/2])
        cylinder(r=r2, h=h*4, center=center);
    }
}

module arms(h=10, ath=3, n=6, $fn=32) {
    rotate([0,0,15]) {
        difference() {
            for (i=[0:n]) {
                rotate([0,0,360/n*i])
                translate([11,0,0]) 
                rotate([0,0,80]) {
                    half_moon(r0=20.5,r1=20.5, r2=0, h=h, offset=ath);
                }
            }
            translate([0,0,-3])
            ring(r0=30, r1=50, h=h*2);
        }
        difference() {
            for (i=[0:n]) {
                rotate([0,0,360/n*i-22 ])
                translate([30,0,0])
                scale([1,1.1,1])
                cylinder(r=4, h=h);
            }
            translate([0,0,1])
            ring(r0=30, r1=50, h=h, $fn=50);
        }
    }

}

module spool_holder(d=60,h=10, ir=11+0.2, rth=5, ath, $fn=32) {
    difference() {
        union() {
            cylinder(r=ir+rth,h=h);
            scale([(d+4)/64,(d+4)/64,1]) arms(h=h, ath=ath, n=number_of_arms);
        }
        translate([0,0,-h/2])
        cylinder(r=ir,h=h*2, $fn=50);

    }
}



mirror([side,0,0]) {
    spool_holder(d=spool_hole_diameter, h=height, ir=bearing_diameter/2, rth=inner_ring_thickness, ath=arms_thickness);
}