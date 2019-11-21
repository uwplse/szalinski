// Wheel or Jig
whichOne = "wheel"; // [wheel,jig]
// OFP cage gap (mm)
cageG = 42; // [40,40.5,41,41.5,42,42.5,43]
// Wheel major diameter (mm), OFP well size is about 38.5
majorD = 36.75; // [36.5:0.05:37]
// Groove diameter, minor to minor distance (mm)
grooveD = 8.5; // [7.5:0.1:9.5]
// Side-wall thickness (mm) - Do not change unless you absolutely need to to get the rim diameter up to fit around the OFP motor well (25.4 mm)
shellT = 2; // [1.5:0.05:2]
// Wheel to collar tolerance i.e. printed to true, SLIDING FIT (mm)
shaftT = 0.25;
// Wheel to jig tolerance i.e. printed to printed, SLIDING FIT (mm)
rimT = 0.15;


/* [Hidden] */
coppOffR = 7;
coppOffH = 5;
shellTopT = 1.5;
wheelH = 14.3;
copperD = 8;
// STL quality, i.e. polygon count (polygons per revolution)
$fn = 200; // [100:10:200]


if (whichOne == "wheel" && (cageG-grooveD-2*shellT) > 26) {
translate([0,0,wheelH+coppOffH])
rotate([180,0,0])
difference() {
union() {
    difference() {
    cylinder(h=wheelH,d=majorD,center=false);
    cylinder(h=2*(wheelH-shellTopT),d=(cageG-grooveD-2*shellT),center=true);
    rotate_extrude()
    translate([cageG/2,wheelH/2,0])
    circle(d = grooveD);
    }
    translate([0,0,wheelH])
    cylinder(h=coppOffH,r=(copperD/2+coppOffR  ),center = false);
    }
 cylinder(h=(wheelH+6),r=(copperD/2+shaftT),center=false);
 translate([0,0,wheelH+coppOffH/2])
    rotate([90,0,0])
 cylinder(h=50,d=4,center=false);   
}
}

if (whichOne == "jig") {
    difference() {
        cylinder(h=(wheelH-shellTopT+.5),d=(cageG-2*shellT-rimT),center=false);
        cylinder(h=100,d=(2+shaftT-0.05),center=false);
    }
}