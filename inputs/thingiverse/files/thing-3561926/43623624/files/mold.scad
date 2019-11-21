// [Global]

part = "bottom"; // [top,bottom,both]
whorl_fn = 32;

// [Inlet]
luer_lock = "no"; // [yes,no]
inlet = "yes"; // [yes,no]
inlet_diameter = 2.5;

// [Outlet]
outlet = "yes"; // [yes,no]
outlet_diameter = 1;

rez = "low"; // [low,high]

$fn= (rez == "high") ? 32 : 128;

preview_tab="";

module highlight(this_tab) {
  if (preview_tab == this_tab) {
    color("red") children(0);
  } else {
    children(0);
  }
}

module whorl(){
    difference() {
        union() {
            difference () {
                // main body
                scale([1,1,.3]) sphere(r=40, $fn=whorl_fn);
                translate([0,0,12]) scale([.8,.8,.2])  sphere(r=40, $fn=whorl_fn);
                translate([0,0,-12]) scale([.8,.8,.2])  sphere(r=40, $fn=whorl_fn);
            }

            // Bore reinforcing cylinder
            translate ([0,0,-10]) cylinder (r=8, h=20);

            // adornments
            translate ([35,0,0]) sphere (r=6);
            translate ([-35,0,0]) sphere (r=6);
            translate ([0,35,0]) sphere (r=6);
            translate ([0,-35,0]) sphere (r=6);

            translate ([24.5,24.5,0]) sphere (r=6);
            translate ([-24.5,-24.5,0]) sphere (r=6);
            translate ([24.5,-24.5,0]) sphere (r=6);
            translate ([-24.5,24.5,0]) sphere (r=6);
        }
        // shaft hole
        translate ([0,0,-20]) cylinder (r=4, h=40);
    }    
}

module luer() {
    Rin=0.75;
    Rout=1.25;

    color("orange"){
        // luer connection
        difference(){
            //outside
            union(){
                cylinder(r=Rout,h=10);
                translate([0,0,-5]) cylinder(r1=5.4/2,r2=Rout,h=5);
                translate([0,0,-11]) cylinder(r1=5.6/2,r2=5.4/2,h=6);
                translate([0,0,-11]) cylinder(r=7.5/2,h=1);
            }
            //inside
            translate([0,0,-0.1]) cylinder(r=Rin,h=10.2);
            translate([0,0,-11.1]) cylinder(r1=4.3/2,r2=4.0/2,h=6.1);
            translate([0,0,-5.1]) cylinder(r1=4.0/2,r2=Rin,h=5.2);
            //notches
            translate([5.6/2,-7.5/2,-11.1]) cube([1,7.5,1.2]);
            translate([-5.6/2-1,-7.5/2,-11.1]) cube([1,7.5,1.2]);
        }

    }
}

module shell() {
    difference() {
        union() {
            cylinder(r=45,h=15);
            translate([0,-45,0]) sphere(r=3);
            translate([-45,0,0]) sphere(r=3);
        }
        translate([0,45,0]) sphere(r=3);
        translate([45,0,0]) sphere(r=3);
        difference() {
            cylinder(r=55,h=55,center=true);
            cylinder(r=45,h=56,center=true);
        }
    }
}

module top(){
    difference() {
        union() {
            shell();
            if (luer_lock == "yes") {
                highlight("Inlet") rotate([90,0,-45]) translate([0,0,-45]) luer();
            }
        }
        rotate([0,0,30]) whorl();
        if (inlet == "yes") {
            highlight("Inlet") translate([35,35,0]) rotate([90,0,-45]) cylinder(d=inlet_diameter,h=15);
        }
        if (outlet == "yes") {
            highlight("Outlet") translate([-35,-35,0]) rotate([90,0,135]) cylinder(d=outlet_diameter,h=15);
        }
    }
    if (luer_lock == "yes") {
        difference() {
            highlight("Inlet") rotate([90,0,-45]) translate([0,0,-45]) luer();
            rotate([0,0,30]) whorl();
        }
    }
}

module bottom() {
    difference() {
        rotate([180,0,-90]) shell();
        rotate([0,0,-60]) whorl();
       if (inlet) {
            translate([35,35,0]) rotate([90,0,-45]) cylinder(d=inlet_diameter,h=15);
        }
        if (outlet) {
            translate([-35,-35,0]) rotate([90,0,135]) cylinder(d=outlet_diameter,h=15);
        }
    }
}

if (part == "top") {
    translate([0,0,15]) rotate([180,0,0]) top();
} else if (part == "bottom") {
    translate([0,0,15]) bottom();
} else {
    translate([-50,0,15]) rotate([180,0,0]) top();
    translate([50,0,15]) bottom();
}
