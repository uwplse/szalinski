// Print the pot or the partition
p = "pot"; //  [pot, partition]
// Flat back (0-->Complete circle, 1--> Semi-circle)
f = 0.15; // [0.0:1.0]

// Radius of reservoir at bottom
rb = 30; 

// Reservoir height
rh = 35;

// Radius of pot at the top 
pt = 30;

// Pot height (excluding the reservoir)
ph = 30;

// Spout radius
sr = 10;

// Spout height
sh = 15;

// Tube/Wick radius 
tb = 20;

// Clearence for fitting partition into tube 
tol = 0.3;

// Thickness of the reservoir wall 
t1 = 2;

// Thickness of the pot around the gro medium
t2 = 1;

// Thickness of the floor and partition
fh = 2;

// Diameter of grating holes
gdia = 3;

// Pitch at which grating holes are placed in x and y directions
gpitch = 6;

$fn = 60;

function r_at(z) = ((pt*z + rb*(rh+ph-z))/(rh+ph));
rt = r_at(rh);
pb = rt;

module back_cut (offset) {
    translate([(1-f)*(rt+pb)/2-offset, -rb, 0])
        cube([2*pt,2*pt,rh+ph]);
}
module resbase_s (offset)  {
    difference () {
        cylinder(r1=rb-offset, r2=rt-offset, h=rh);
        back_cut(offset);
    }
}

module reservoir_s (offset) {
    hull () {
        resbase_s(offset);
        translate([-r_at(rh-sh), 0, rh-sh]) 
            cylinder(r1 = 2*sr/3-offset, r2 = sr-offset, h = sh); 
    }
}

module reservoir () {
    difference () {
        reservoir_s(0);
        reservoir_s(t1);
    }
}

module pot_s(offset) {
    translate([0,0,rh]) 
        difference() {
            cylinder(r1=r_at(rh)-offset, r2=pt-offset, h=ph);
            back_cut(offset);
        }
}
module pot() {
    difference() {
        pot_s(0);
        pot_s(t2);
    }
}
module body() {
    union() {
        translate([0,0,fh]) union () {
            reservoir();
            wick(); 
            pot();
        }
        difference () {
            cylinder(r=rb, h=fh);
            back_cut(0);
        }
    }
}

module floor_grating() {
    d = r_at(rh);
    for (x = [-d:gpitch:d]) {
        for (y = [-d:gpitch:d]) {
            translate([x,y,0]) cylinder(r=gdia/2, h=fh,$fn=6);
        }
    }
}
module partition_p() {
    difference() {
        cylinder(r1=r_at(rh), r2 = r_at(rh+fh), h=fh);
        floor_grating();
    }
}
module side_grating() {
    n = floor(PI*tb/2/gpitch);
    angle = 180/n;
    nh = floor(rh/gpitch);
    for (j = [1:nh]) {
        translate([0,0,(j-1)*gpitch])
        for (i = [1:n]) {
            rotate([0,0,(i-1)*angle + (j%2)*angle/2]) 
                rotate([90,0,0]) translate([0,0,-tb]) 
                cylinder(r=gdia/2, h=2*tb, $fn=6);
        }
    }
}
module wick() {
    difference () {
        cylinder(r=tb/2, h=rh);
        cylinder(r=tb/2-t2, h=rh);
        side_grating();
    }
}

module partition() {
    difference () {
        union () {
            translate([0,0,fh]) rotate([180,0,0]) partition_p();
            cylinder(r=tb/2-t2-tol, h=rh/3);
        }
        translate([0,0,-rh/3]) cylinder(r=tb/2-t2-tol-t2, h=rh);
        translate([-t2, 0,0]) back_cut(0);
    }
}
if (p == "pot")
    body();
else
    partition();

