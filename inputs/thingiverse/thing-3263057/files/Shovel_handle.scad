$fn=250;
//shaft diameter in mm
sd=30.5;
//handle length; Changes the length of the grip, value must be half of desired length in mm
lg=65;

module arm(){
    translate([0,0,-15])
    cylinder(38.1,d1=sd,d2=sd,false);
    translate([0,0,38.1-15])
    sphere(d=sd);
    translate([0,0,38.1-15])
    rotate([0,75,0])
    cylinder((lg-38.1)/sin(15),d1=sd,d2=sd);
    translate([(lg-38.1)/tan(15),0,lg-15])
    sphere(d=sd);
    translate([(lg-38.1)/tan(15),0,-15])
    cylinder(lg,d1=sd,d2=sd,false);
};
module arms(){
translate([-30/2,0,0])
rotate([0,-90,0])
arm();
translate([30/2,0,0])
rotate([180,-90,0])
arm();

};
module shaft(){
    cylinder(63.5+5, d1=sd+5,d2=sd+5,false);
};
module bottom(){
    union(){
        translate([0,0,48])
        arms();
        shaft();
    }
};
module bottom_cut(){
    difference(){
        bottom();
        cylinder(63.5, d1=sd, d2=sd,false);
    }
};
;
module screw_holes(){
    difference(){
    bottom_cut();
    translate([0,100,15.875])
    rotate([90,90,0])
    cylinder(200,d1=6,d2=6,false);
    translate([0,100,47.625])
    rotate([90,90,0])
    cylinder(200,d1=6,d2=6,false);
    }
};
;
screw_holes();
