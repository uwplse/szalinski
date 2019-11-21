
color("blue")difference(){
union(){
hull(){
cylinder(d1=18, d2 =14,h = 2, $fn = 90);
translate([0,11,0])cylinder(d=1, h = 2, $fn = 90);}
cylinder(d1=18, d2 = 10, h = 16, $fn = 90);

}


translate([0,0,-2])cylinder(d=3.1 ,h = 16, $fn = 90);
translate([0,0,-2])cylinder(d1=21, d2=3,h = 7, $fn = 90);
//болт крепления
//translate([0,0,8])rotate([90,0,0])cylinder(d=2.5, h = 55, $fn = 90);
}

