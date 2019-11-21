// Hook width (mm)
hook_width = 10; //[1:30]

/* [Hidden] */
$fn = 50;

eps = 0.5;
wd = 53.66 + eps;   // width of the cubicle top bar
wliph = 12.6 + eps; // height of the cubicle top bar
inset = 2.8 + eps;  // inset from the top bar to the cube wall

hookw = hook_width;     // width of the hook
r = 1.0;        // fillet radius of the cutout
hookh = 50;     // total height of the hook
hookendl = 12+(hookw-3)/2;  // distance out from hook
t = 5;          // thickness of the hook walls
tt = t+1.5;     // thickness of tip part
ang = 45;       // angle of the tip
hr = tt/2;      // hook fillet radius

module roundbox(bl,bw,bh,br) {
    hull() {
        translate([br,br,0]) cylinder(bh,br,br);
        translate([bl-br,br,0]) cylinder(bh,br,br);
        translate([bl-br,bw-br,0]) cylinder(bh,br,br);
        translate([br,bw-br,0]) cylinder(bh,br,br);
    }
}

module wall() {
    translate([0,hookw,hookh-t-wliph]) rotate([90,0,0]) roundbox(wd,wliph,hookw,r);
    translate([inset,0,0]) cube([wd-inset-1.5,hookw,hookh-t-wliph+1]);
    translate([-t-1,0,0]) cube([t+inset+1,hookw,hookh-wliph-2*t]);
}

module hook() {
    difference() {
        translate([0,hookw,hookh-wliph-2*t]) rotate([90,0,0]) roundbox(wd+2*t,wliph+2*t,hookw,1);
        translate([t,-1,0]) scale([1,2,1]) wall();
    }
    translate([wd+t,0,0]) cube([t,hookw,2]);
    // upward bend
    translate([wd+2*t,hookw,0]) rotate([90,0,0]) linear_extrude(hookw) offset(r=-hr) offset(r=hr) union() {
        translate([-tt,0,0]) square([tt,hookh-t-wliph]);
        rotate([0,0,-ang]) translate([-tt,0,0]) square([tt,hookendl/cos(ang)-t/2]);
    }
}

module hooktip() {
    translate([hookendl/cos(ang)-t/2,hookw,tt/2]) rotate([90,0,0]) cylinder(hookw,d=tt,d=tt);
}

module wholehook() {
    hook();
    translate([wd+2*t,0,0]) rotate([0,-ang,0]) hooktip();
    // inset on backside of hook
    translate([wd+t-inset,0,0]) cube([t,hookw,17.5]);
}

translate([0,0,hookw]) rotate([-90,0,0]) wholehook();

