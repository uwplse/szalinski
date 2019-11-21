lipdiameter=37.5; //[22:52]
neckdiameter=30.8; //[20:50]
bottlewidth=128; //[80:200]
thickness=5; //1
beveled_handle=true; //comment

difference(){
    union(){
        cube([lipdiameter,bottlewidth,thickness],center=true);
        for (i = [0:1]) {
            rotate([i*180,0,0])
            hull(){
                translate([0,bottlewidth/2,0]) cylinder(d=lipdiameter+5,h=thickness, center=true);
                translate([0,bottlewidth/2-lipdiameter/2-1,0]) cylinder(d=lipdiameter+10,h=thickness, center=true);
            }
        }
    }

    for (i = [0:1]) {
        rotate([i*180,0,0]) union() {
        translate([0,bottlewidth/2,0]) cylinder(d=neckdiameter,h=thickness+1, center=true);
        translate([0,bottlewidth/2-lipdiameter/2-1,0]) cylinder(d=lipdiameter,h=thickness+1, center=true);
        }
    }
    if(beveled_handle){
        hull(){
            translate([0,bottlewidth/2-lipdiameter/2,0]) rotate ([0,0,135]) translate([0,lipdiameter+3,0]) cylinder(d=lipdiameter-5,h=thickness+1, center=true);
            translate([0,-(bottlewidth/2-lipdiameter/2),0]) rotate ([0,0,45]) translate([0,lipdiameter+3,0]) cylinder(d=lipdiameter-5,h=thickness+1, center=true);
        }
        
        hull(){
            translate([0,bottlewidth/2-lipdiameter/2,0]) rotate ([0,0,-135]) translate([0,lipdiameter+3,0]) cylinder(d=lipdiameter-5,h=thickness+1, center=true);
            translate([0,-(bottlewidth/2-lipdiameter/2),0]) rotate ([0,0,-45]) translate([0,lipdiameter+3,0]) cylinder(d=lipdiameter-5,h=thickness+1, center=true);
        }
    }
}

