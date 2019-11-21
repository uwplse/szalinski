// Diameter of your magnet
Magnet_Diameter = 12.5;

// Thickness of your magnet
Magnet_Thickness = 3;

// Diameter of your cable
Cable_Diameter = 7;

// Thickness of the bottom layer holding the magnet. The default should be fine.
Bottom_Thickness = 0.4;

// Thickness of top cover. The default should be fine.
Cover_Thickness = 2;

// Increase clearance if the two parts can't fit, reduce if it's too loose.
Top_Clearance = 0.5;

/* [Hidden] */
$fs = 1;
$fa = 6;

Magnet_Radius = Magnet_Diameter / 2;
Cable_Radius = Cable_Diameter / 2;



module copy_mirror(vec=[0,1,0]) {
 union() {
  children();
  mirror(vec) children();
 }
};

difference() {
    union() {
        cylinder(r=Magnet_Radius+1, h=Magnet_Thickness+Bottom_Thickness);
        difference() {
            cylinder(r=Magnet_Radius+2, h=Magnet_Thickness+Bottom_Thickness+Cover_Thickness+1+Top_Clearance);
            copy_mirror([1,0,0]) translate([3,-(Magnet_Diameter+6)/2,0]) cube([Magnet_Radius+3, Magnet_Diameter+6, Magnet_Thickness+Bottom_Thickness+Cover_Thickness+1+Top_Clearance]);
        }
    }
    translate([0,0,Bottom_Thickness]) cylinder(r=Magnet_Radius, h=Magnet_Thickness+Cover_Thickness+1+Top_Clearance);
    translate([0,0,Magnet_Thickness+Bottom_Thickness]) cylinder(r=Magnet_Radius+1, h=Cover_Thickness+Top_Clearance);
}

//color("green") translate([0,0,Magnet_Thickness+Bottom_Thickness]) {
color("green") translate([Magnet_Diameter+5,0,0]) {
    difference() {
        intersection() {
            union() {
                cylinder(r=Magnet_Radius+1, h=Cover_Thickness);
                translate([-(Magnet_Diameter+2)/2, -(Cable_Diameter+2)/2, 0]) cube([Magnet_Diameter+2, Cable_Diameter+2, (Cable_Diameter+1)/2]);
                translate([0,0,Cable_Radius]) rotate([0,90,0])cylinder(r=Cable_Radius+1, h=Magnet_Diameter+2, center=true);
            }
            cylinder(r=Magnet_Radius+1, h=Cable_Diameter+1);
        }
        translate([-(Magnet_Diameter+2)/2, -Cable_Radius, 0]) cube([Magnet_Diameter+2, Cable_Diameter, (Cable_Diameter+1)/2]);
        translate([0,0,Cable_Radius]) rotate([0,90,0])cylinder(r=Cable_Radius, h=Magnet_Diameter+2, center=true);
        translate([0,0,-1]) cylinder(r=Magnet_Radius+1, h=1);
    }
}