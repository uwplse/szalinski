$fn=120;

lochabstand=81;
fussdm=92+.5;
fussh=10;

schraubendm=3.8;
schraubenl=25;

staerke=3;
boden=3;

camdm=70+.5;
camh=8;
camsab=56;
camwinkel=15;

module sub() {
translate([0,0,schraubenl]) cylinder(d=fussdm,h=fussh);
for(i=[0:2]) rotate([0,0,i*120]) {
    translate([lochabstand/2,0,0]) cylinder(d=schraubendm,h=schraubenl);
    translate([(fussdm-2*staerke-20)/2-5,0,0]) cylinder(d1=5,d2=10,h=5);
}
  translate([10,0,0]) cylinder(d=20,h=boden);
}

module add() {
    difference() {
        translate([0,0,0]) cylinder(d=fussdm,h=schraubenl);
        translate([0,0,boden]) cylinder(d=fussdm-2*staerke,h=schraubenl-boden-10);
        translate([0,0,schraubenl-10]) cylinder(d1=fussdm-2*staerke,d2=fussdm-2*staerke-20,h=10);
    }
    for(i=[0:2]) rotate([0,0,i*120]) translate([lochabstand/2,0,0]) {
        hull() {
            cylinder(d=schraubendm+2*staerke,h=schraubenl);
            translate([schraubendm/2+staerke-.1,-schraubendm/2-staerke,0]) cube([.1,schraubendm+2*staerke,schraubenl]);
        }
        translate([(fussdm-2*staerke-20)/2-5-lochabstand/2,0,0]) cylinder(d1=20,d2=15,h=5);

    }
}


module dose() {
difference() {
add();
sub();
}
}

module deckel() {
difference() {
hull() {
translate([0,0,schraubenl+sin(camwinkel)*camdm/2+staerke]) rotate([0,camwinkel,0]) cylinder(d=camdm,h=camh);
translate([0,0,schraubenl]) cylinder(d=fussdm,h=staerke);
}

translate([0,0,schraubenl+sin(camwinkel)*camdm/2+staerke]) rotate([0,camwinkel,0]) {
        for(i=[0:2]) rotate([0,0,i*120]) translate([camsab/2,0,-11+camh]) cylinder(d=3.4,h=11+1);
         translate([0,0,-20]) cylinder(d=20,h=camh+20+1);   
        }
translate([0,0,schraubenl+staerke]) difference() {
    cylinder(d=fussdm,h=20); 
    cylinder(d=lochabstand-5-4,h=20);
}
translate([0,0,schraubenl]) difference() {
    cylinder(d=fussdm,h=20); 
    cylinder(d=lochabstand-4,h=20);
}
}
translate([0,0,schraubenl+sin(camwinkel)*camdm/2+staerke]) rotate([0,camwinkel,0]) translate([-camdm/2+2,-4,camh]) cube([15,8,6]);
}

module ring() {
difference() { union() {
translate([0,0,schraubenl+staerke]) difference() {
    cylinder(d=fussdm,h=5); 
    cylinder(d=lochabstand-5-4+.5,h=5);
}
translate([0,0,schraubenl+1]) difference() {
    cylinder(d=fussdm,h=4); 
    cylinder(d=lochabstand-4+.5,h=4);
}
}
for(i=[0:2]) rotate([0,0,i*120]) {
    translate([lochabstand/2,0,0]) cylinder(d=schraubendm,h=schraubenl+50);
}
}
}


translate([90,0,-schraubenl]) deckel();
dose();
translate([55,78,schraubenl+1+5+1+1]) rotate([180,0,0]) ring();
