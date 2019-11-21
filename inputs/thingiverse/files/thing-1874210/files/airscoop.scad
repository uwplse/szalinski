//
//  fresh air scoop for race car
//
//  design by egil kvaleberg, 1 august 2016
//

// outer diameter
dia = 58.0;
wall = 1.5;
fn=60;
// length of scoop part
scoop = 20.0;
scooptract = 1.3;
outlet = 20.0;
mnthole = 6.5;

// should support be added
has_support = 0; // [0, 1]
supwall = 0.7;

d = 1*0.1;

module bend(len1,len2,dia,cdia) {
    rotate([90,0,0]) cylinder(d1=dia, d2=dia*scooptract, h=len1, $fn=fn);
    intersection() {
        translate([cdia, 0, 0]) rotate_extrude(convexity=2,$fn=fn) translate([cdia, 0, 0]) circle(d=dia,$fn=fn);
        translate([-cdia/2-d,-d,-cdia/2]) cube([cdia*1.5+2*d,cdia*1.5+2*d,cdia]);
    }
    translate([cdia,cdia,0]) rotate([90,0,90]) cylinder(d=dia, h=len2, $fn=fn);
}

module m(dy) {
    translate([0,dy,0]) rotate([0,90,0]) {
        cylinder(d=mnthole, h=dia*0.8, $fn=15);
        cylinder(d=2*mnthole, h=dia*0.56, $fn=15);
    }
}


difference () {
    union() {
        bend(scoop, outlet, dia, dia);
        translate([dia*0.4,-scoop,-dia*0.3/2]) cube([dia*0.22,scoop+dia*0.6,dia*0.3]);
        
        // support
        if (has_support) {
            for (dz = [-dia*0.32:5:dia*0.32]) 
    translate([dia*0.8,-scoop,dz]) cube([dia*0.2+outlet,scoop+dia*0.8,supwall]);
            translate([dia*0.9+outlet/2,-scoop,-dia*0.32]) cube([supwall,dia*0.45+outlet,2*dia*0.32]);
            translate([dia*0.7,-scoop,-dia*0.32]) cube([dia*0.3+outlet,supwall,2*dia*0.32]);
        }
    }
    union() {
        color("red") bend(scoop+d, outlet+d, dia-2*wall, dia);
        m(-scoop/2);
        m(dia*0.1);
    }
}
