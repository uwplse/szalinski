echo(version=version());

// Parameters for RJMP-01-0x (shaft size x, all dimensions in [mm])
// Designation  d1  d2  B   B1      s   dn
//-----------------------------------------
// RJMP-01-08   8   16  25  16.2    1.1 14.3
shrinkage = 1.0;     // Allow for shrinkage of the material
d1 = 8 * shrinkage;    // Inner diameter
d2 = 16 * shrinkage;   // Outer Diameter
B  = 25 * shrinkage;   // Bearing total length
B1 = 16.2 * shrinkage; // Distance between outer ring flanges
s  = 1.1 * shrinkage;  // Ring width
dn = 15.2 * shrinkage; // Ring diameter
cd = 1.5 * shrinkage;  // Chamfer distance
ca = 30 * shrinkage;   // Chamfer angle
tol= 0.3 * shrinkage;  // Tolerance
da = 30;               // Delta angle for glide surfaces
gw = 1.1 * shrinkage;  // Gap width for glide surfaces

// Create sketch of bearing block
difference() {
    union(){
        cylinder(h=B-(2*cd),d=d2,$fn=360,center=true);
        for (i=[-1,1]) {
            translate ([0,0,i*(B-cd)/2]) {
                ar1 = d2/2;
                ar2 = ar1 - cd*tan(30);
                cylinder(h=cd,r2=(i*((ar2-ar1)/2)+(ar1+ar2)/2),r1=(i*((ar1-ar2)/2)+(ar1+ar2)/2),$fn=360,center=true);
            }
        }
    }
    // Center shaft subtraction
    // NOTE: Tolerance is added to inner diameter
    cylinder(h=B,d=d1+tol,$fn=360,center=true);
    // fastener ring gaps subtraction
    for (i=[-1,1]) {
        translate ([0,0,i*(B1/2+s/2)]) {
            // Ring gaps
            difference() {
                cylinder(h=s,d=d2,$fn=360,center=true);
                cylinder(h=s,d=dn,$fn=360,center=true);
            }
        }
    }
    // Glide surface lobe creation
    for (i=[0:da:(180-da)]) {
        rotate ([0,0,i]) {
            cube ([gw,(d1+d2)/2,B], center=true);
        }
    }
}


