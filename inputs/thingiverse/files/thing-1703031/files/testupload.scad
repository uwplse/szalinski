 difference(){
//translate([0,0,-2])linear_extrude(17)circle(20, $fn = 100);
//translate([0,0,-2])linear_extrude(1)circle(19, $fn = 100);
        translate([0,0,998])cylinder(h=17, r=20, $fn = 100);
        translate([0,0,998])cylinder(h=1, r=19, $fn = 100);
    }