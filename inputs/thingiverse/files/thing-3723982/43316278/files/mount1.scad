diam = 20.8;
thickness = 6.0;
pin = 4.0;
clearance = 0.12;
radius = 7.5;
ext_thick = 2.9;
middle_thick = 3.2;
mount_lenght = 15.5;
hex_nut_size = 7.9;
hex_nut_depth = 2.5;

module patte(longueur=15, epaisseur=3, trou=5.2) {
    difference() {
        hull() {
            translate([0,diam/2+thickness+longueur-7.5,0]) cylinder(epaisseur,d=15,center=true);
            translate([0,diam/2+0.5,0]) cube([15,1,epaisseur],center=true);
        }
        translate([0,diam/2+thickness+longueur-7.5,0]) cylinder(epaisseur+1, d=trou, center=true);
    }
}

module body() {
    union()
    {
        difference(){
            hull() {
                cylinder(15,r=(diam/2)+thickness,center=true);
                translate([-(diam/2)-thickness+radius,(diam/2)+thickness-radius,0])cylinder(15,r=radius,center=true);
                translate([(diam/2)+thickness-radius,(diam/2)+thickness-radius,0])cylinder(15,r=radius,center=true);
            }
            cylinder(16,d=diam,center=true);
            translate([diam+thickness,0,0]) cube([2*(diam+thickness),2*(diam+thickness),16],center=true);
            
            
            hull() {
                translate([0,-diam/2-thickness/2,15/4+0.5]) cylinder(15/2+1, d=thickness, center=true);
                translate([0,-diam/2-3*thickness,15/4+0.5]) cylinder(15/2+1, d=thickness*2, center=true);
            }
        }
        translate([0,-diam/2-thickness/2,-15/4])
            cylinder(15/2, d=thickness, center=true);
    }
}
module hex(ldiam=7.8, ep=3) {
        for (a =[0:60:120]) rotate([0,0,a]) cube([ldiam,ldiam/sqrt(3),ep], center=true);
}


$fa = 1.0;
$fs = 0.1;

translate([0,diam/2+thickness+mount_lenght-7.5,15/2+hex_nut_depth/2]) difference() {
    hex(hex_nut_size+2,hex_nut_depth);
    hex(hex_nut_size,hex_nut_depth+1);
}
    
/// BODY
difference() {
    union() {
        body();
        translate([0,0,15/2-ext_thick/2+clearance/4]) patte(mount_lenght,ext_thick-(clearance/2),5.2);
        translate([0,0,-15/2+ext_thick/2-clearance/4]) patte(mount_lenght,ext_thick-(clearance/2),5.2);
        //pin
        translate([0,-diam/2-thickness/2,15/4])
            cylinder(15/2, d=pin-clearance/2, center=true);
    }
    translate([0,(diam/2+thickness+1)/2,0]) cube([15,diam/2+thickness+1,middle_thick+clearance], center=true);
    //patte(mount_lenght,middle_thick,5.2);
}

rotate([0,0,180]) translate([0,diam/2+thickness/2,0]) difference() {
    union() {
        body();
        patte(mount_lenght,middle_thick-clearance,5.2);
    }
    //hole
    translate([0,-diam/2-thickness/2,-15/4])
    cylinder(15/2+1, d=pin+clearance/2, center=true);
    //patte
    translate([0,(diam/2+thickness+1)/2,15/2-ext_thick/2+clearance/4+0.5]) cube([15,diam/2+thickness+1,ext_thick-(clearance/2)+1], center=true);
    translate([0,(diam/2+thickness+1)/2,-15/2+ext_thick/2-clearance/4-0.5]) cube([15,diam/2+thickness+1,ext_thick-(clearance/2)+1], center=true);
}
