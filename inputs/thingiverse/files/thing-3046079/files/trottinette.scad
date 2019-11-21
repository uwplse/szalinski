

difference() {

    union() {
// Manchon
        difference() {
            translate([0,0,-7]) cylinder(r=35/2,h=25,center=true,$fn=50);
            cylinder(r=26/2,h=50,center=true,$fn=50);
        };

// Renfort vis
        translate([0,16,0]) cube([13,5,15], center=true);
    }

// Trou vis
    translate([0,16,0]) rotate([90,0,0]) cylinder(r=5/2,h=10,center=true,$fn=20);
    translate([0,17,0]) rotate([90,0,0]) intersection() {
       cylinder(r2=5/2,r1=8/2,h=4,center=true,$fn=20);
       cylinder(r=7/2,h=4,center=true,$fn=20);
    }
    
}

// Accroche sangle
difference() {
    translate([0,-23,-4.5]) cube([17,20,20], center=true);
    
// Percement vertical
    translate([0,-24,-7.5]) cube([10,13,30], center=true);

// Arrondi supérieur
    translate([0,-32,20]) rotate([0,90,0]) cylinder(r=20,h=20,center=true,$fn=100);

// Arrondi inférieur
    translate([0,-32,-25]) rotate([0,90,0]) cylinder(r=20,h=20,center=true,$fn=100);
    
}
