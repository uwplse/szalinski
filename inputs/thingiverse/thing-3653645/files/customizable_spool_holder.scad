$fn=50;

// Diameter of the spool hole in mm (where the spool holder will fit)
spool_hole_diameter=59; //[25:100]

// Inner diameter of the spool holder
inner_diameter = 16.4; //[1:100]

// Height of the spool holder in mm
height=10; // [5:20]

// Spool holder inner ring thickness in mm
inner_ring_thickness=5; // [3:50]

// Number of Arms
number_arms = 6; //[3:8]

// Arms thickness in mm
arms_thickness=5; // [1:50]
// 
// Which side do you want to print?
side=0; // [0:Left, 1:Right]


module ring(r0, r1, h) {
    difference()
    {
        cylinder(r=r1, h=h, center=true);
        cylinder(r=r0, h=h, center=true);
    }
}

module half_moon(r0, r1, r2, offset, h) {
    difference() {
        cylinder(r=r0, h=h, center=true);
        translate([offset,0,0])
            cylinder(r=r1, h=h*1.2, center=true);
        translate([0,r2,0])
            cylinder(r=r2, h=h*1.4, center=true);
    }
}

module arms(h, ath) {
    difference() {
        for (i=[0:number_arms-1]) {
            rotate([0,0,360/(number_arms)*i])
            translate([spool_hole_diameter/4,0,0]) 
            rotate([0,0,90]) {
                half_moon(
                        r0=spool_hole_diameter/4+.4,
                        r1=spool_hole_diameter/4,
                        r2=0, 
                        offset=ath, 
                        h=h
                        );
            }
        }
    }
    
   for (i=[0:number_arms-1]) {
            rotate([0,0,360/number_arms*i + 360/number_arms])
            translate([spool_hole_diameter/2,0,-height/2])
            cylinder(r=5, h=h);
        }
}

module spool_holder(d, h, rth, ath) {
    difference() {
        union() {
            cylinder(r=(inner_diameter/2)+rth, h=h, center=true);
            arms(h=h, ath=ath);
        }
        cylinder(r=(inner_diameter/2)+0.2, h=h*1.1, center=true);
        translate([0,0,2])
            ring(r0=spool_hole_diameter/2, r1=spool_hole_diameter/2+10, h=h);
    }
}



mirror([side,0,0]) {
    spool_holder(d=spool_hole_diameter, h=height, rth=inner_ring_thickness, ath=arms_thickness);
}