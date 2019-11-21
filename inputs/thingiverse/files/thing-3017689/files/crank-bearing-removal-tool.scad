thickness=8;
spacing=3;
minDiam=28;
maxDiam=34;
totalHeight=120;
coneHeight=40;

difference() {
    union() {
        translate([0, 0, totalHeight/2]) cylinder(h=totalHeight, d=minDiam, center=true);
        translate([0, 0, coneHeight/2]) cylinder(h=coneHeight, d1=maxDiam, d2=minDiam, center=true);
    }
    translate([0, 0, totalHeight/2]) cylinder(h=totalHeight, d=minDiam-thickness, center=true);         
    translate([0, 0, coneHeight/2]) cylinder(h=coneHeight, d1=maxDiam-thickness, d2=minDiam-thickness, center=true);     
    for(a = [0:360/3:359]){
        translate([0, 0, coneHeight/2]) rotate([0, 0, a]) cube([maxDiam, spacing, coneHeight], center=true);
    }
}
