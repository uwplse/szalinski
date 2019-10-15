headHeight = 5;
bodyHeight = 70;

module proBody(){
    difference(){
        hull(){
            cylinder(h=bodyHeight,d=27);
            mirror([0,1,0]) translate([0,-5,0]) cylinder(h=bodyHeight,d=27);
        }
        hull(){
            cylinder(h=bodyHeight,d=24);
            mirror([0,1,0]) translate([0,-5,0]) cylinder(h=bodyHeight,d=24);
        }
        translate([-7,5.5,0]) cube([14,10,bodyHeight]);
    }
}

module proHead(){
    translate([0,0,5]) difference(){
        cylinder(h=headHeight,d=17);
        cylinder(h=headHeight,d=15);
    }
    difference(){
        proHeadBody();
        scale([0.9,0.9,0.85]) proHeadBody();
        cylinder(h=5,d=15);
    }
}

module proHeadBody(){
    hull(){
        cylinder(h=5,d=17);
        difference(){
            hull(){
                cylinder(h=1,d=27);
                mirror([0,1,0]) translate([0,-5,0]) cylinder(h=1,d=27);
            }    
        }
    }
}

proHead();
translate([0,0,-bodyHeight]) proBody();