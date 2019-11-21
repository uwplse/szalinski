
// OFP cage gap (mm)
cageG = 42; // [40,40.5,41,41.5,42,42.5,43]

// Groove diameter, minor to minor distance (mm)
grooveD = 8.5; // [7.5:0.1:9.5]

// Wheel to collar tolerance for press fit
shaftT = 0;

// Overhang Angle
overA = 30; // // [25:5:90]


/* [Hidden] */
shellT = 2;
majorD = 36.75;
coppOffR = 7;
coppOffH = 5;
shellTopT = 1.5;
wheelH = 14.3;
copperD = 8;

// STL quality, i.e. polygon count (polygons per revolution)
$fn = 200; // [100:10:200]



difference() {
translate([0,0,wheelH+coppOffH])
rotate([180,0,0])
difference() {
    union() {
        difference() {
            cylinder(h=wheelH+coppOffH,d=majorD,center=false);
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
    cylinder(h=50,d=4,center=true);   
}
rotate_extrude() polygon( points=[[majorD/2 - sqrt(pow(coppOffH/sin(overA),2) - pow(coppOffH,2)),0],[majorD/2 - sqrt(pow(coppOffH/sin(overA),2) - pow(coppOffH,2)),-1],[majorD/2+1,-1],[majorD/2+1,coppOffH],[majorD/2,coppOffH]]);
}


