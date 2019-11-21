// PocketBook 626 flip cover

/*
This is cover for PocketBook 626 ebook reader, inspired by original flip cover. It is 
slightly more thick (3mm vs. 2.5mm) to allow reliable printed hinges.

It features space for optional magnets -- they has to be inserted during the print though, 
either by manually pausing the print or using tool like Prusa's color print. When inseting 
magnets, it is strongly recommended to use glue, as most print heads contain ferromagnetic 
parts, which would cause magnets to pop out of print and stick to print head.
Also note, that most magnets when exposed to high temperatures will loose its magnetism, 
so try to minimize contact with hot filament or print head.

Because of printed tiny hinges in upper part, I don't recommend using nozzle diameter larger 
than 0.4 mm and vertical resolution more than 0.15 mm. I also strongly recommend using some 
high quality PLA for print (Fillamentum filaments are great) as I had big trouble with poorly 
printed hinges when I used some cheap PLA.

Print settings:
resolution: 0.1 mm 
nozzle diameter: 0.4 mm
*/

// Customizer variables

// Create space for magnets (10 magnets total, 5 on each side)?
use_magnets = "yes";    // [yes,no]
// Magnet dimension (shorter side)
magnet_xsize = 5;   // [1:8]

// Magnet dimension (longer side)
magnet_ysize = 10;  // [2:20]

// Magnet thickness
magnet_zsize = 1.2; // [.2:2]


// [HIDDEN]
$fn = $preview ? 36 : 72;

// tolerances
tol = .2;   // tolerance for tight fit (for magnets)
tolf = .4;  // tolerance to allow free movement
htol = .5;  // Hinge tolerance

t = 3;          // thickness; original cover was 2.5mm
w = 115;        // width
h = 135+38+1;   // height
cr_top = 5;     // top corner radius
cr_bottom = 14; // bottom corner radius

// Top holder dimensions
hld_l = 83;
hld_dist = 59.4;
hld_t = 1.5 - tolf;
hld_w = 4.4 - tolf;
hld_lock = 2.2;
hld_lock_h = 1.5;
hld_lock_l = .8;
hld_lock_base = t+.6;

// Hinge dimensions
hinge_seg = 6;
hinge_w1 = 10;
hinge_w2 = 5.5;

// Magnet positions and size
mag_y = [20, 58, 88, 128, 152];
mag_x = 5;      // distance from side edge to magnet center
mag_z = .4;
mag = [magnet_xsize, magnet_ysize, magnet_zsize];


cover();


module cover() {
    difference() {
        _plate();
        translate([-hld_l/2-tolf, -hinge_w1, -1]) cube([hld_l+2*tolf, hinge_w1+t+1, t+2]);
        if (use_magnets == "yes") {
            for (x = [-w/2+mag_x, w/2-mag_x])
                for (y = mag_y)
                    translate([x, -y, mag_z]) _mag();
        }
    }
    translate([0, -hinge_w1+hld_lock_base, 0]) _hinge(wa = hld_lock_base, wb = hinge_w1/2, wae=2*tolf+.1);
    translate([0, hld_lock_base, 0]) _hinge(wa = hinge_w1/2, wb = hinge_w2/2);
    translate([0, hld_lock_base+hinge_w2, 0]) _hinge(wa = hinge_w2/2, wb = hld_lock_base);
    translate([-hld_dist/2, hinge_w2+2*hld_lock_base, 0]) _lock();
    mirror([1,0,0]) translate([-hld_dist/2, hinge_w2+2*hld_lock_base, 0]) _lock();
}

module _mag() {
    magt = [mag[0]+tol, mag[1]+tol, mag[2]+tol];
    echo(magt);
    translate([0, 0, magt[2]/2]) cube(magt, center=true);
}

module _lock() {
    lw = hld_w/2+hld_lock_l;
    difference() {
        hull() {
            translate([-lw/2+hld_lock_l, hld_lock, 0]) cylinder(d = lw, h = hld_t);
            translate([-hld_w, 0, 0]) cube([hld_w, .01, hld_t]);
        }
        translate([0, -.1, -.1]) cube([hld_w, hld_lock+.1, hld_t+.2]);
    }
}

module _hinge(l = hld_l, wa = 10, wb = 10, wae = 0) {
    th = (t - 2*htol)/4;
    hdo = t;
    hdi = hdo - 2*th;
    hdt = hdo + 2*th;
    pd = 2*th;
    hi = hinge_seg - htol;
    ho = hinge_seg + htol;
    
    translate([0, 0, hdo/2]) rotate([0, 90, 0])
    union() {
        difference() {
            union() {
                translate([0, -wa/2, 0]) cube([hdo, wa, l+wae], center=true);
                for (z = [0 : hinge_seg*2 : l/2]) 
                    for (d = [-1,1])
                        translate([0, 0, d*z-hi/2]) cylinder(d = hdo, h = hi);
            }
            translate([0, 0, -l/2-1]) cylinder(d = hdi, h = l + 2);
            for (z = [hinge_seg : hinge_seg*2 : (l+hinge_seg)/2]) 
                for (d = [-1,1])
                    translate([0, 0, d*z]) cube([hdt, hdt, ho], center=true);
        }
        difference() {
            union() {
                translate([0, wb/2, 0]) cube([hdo, wb, l], center=true);
                for (d = [-1,1]) {
                    he = ((l % hinge_seg) - htol) / 2;
                    translate([0, 0, d*(l/2-he/2)-he/2]) cylinder(d = hdo, h = he);
                    for (z = [hinge_seg : hinge_seg*2 : l/2]) 
                        translate([0, 0, d*z-hi/2]) cylinder(d = hdo, h = hi);
                }
            }
            for (z = [0 : hinge_seg*2 : l/2]) 
                for (d = [-1,1])
                    translate([0, 0, d*z]) cube([hdt, hdt, ho], center=true);
        }
        translate([0, 0, -l/2]) cylinder(d = pd, h = l);
    }
}

module _plate() {
    dxt = w - 2*cr_top;
    dxb = w - 2*cr_bottom;
    hull() {
        for (x = [-dxt/2, dxt/2])
            translate([x, -cr_top, 0]) _rcylinder(r = cr_top, h = t);
        for (x = [-dxb/2, dxb/2]) {
            translate([x, cr_bottom-h+1, 0]) _rcylinder(r = cr_bottom, h = t);
            translate([x/2, cr_bottom*2-h, 0]) _rcylinder(r = cr_bottom*2, h = t);
        }
    }
}


module _rcylinder(r = 1, h = 1) {
    if (r > h) {
        translate([0, 0, h/2]) rotate_extrude() translate([r-h/2, 0, 0]) circle(d=h);
        cylinder(r = r-h/2, h = h);
    } else {
        cylinder(r = r, h = h);
    }
}
