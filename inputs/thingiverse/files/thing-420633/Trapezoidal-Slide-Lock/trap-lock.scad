h = 30;
off = 15;
folga = 1;

trap_dif = 3;
trap_h = 10;
trap_l = 30;

paraf_r= 2;
paraf_h= 5;

translate([off, off*.8, 0]){


difference(){
translate([-off, -off,0])cube([trap_l + 2*off,trap_h + off,h]);
translate([0,0,5]
)linear_extrude(height = h + 5, center = false, convexity = 10) polygon(points=[[0,0],[trap_dif,trap_h + 1],[trap_l-trap_dif,trap_h + 1],[trap_l,0]]);

translate([-off/2,50,h/2]) rotate([90,0,0]) cylinder(r=paraf_r, h=200, $fn=30);
translate([trap_l + off/2,50,h/2]) rotate([90,0,0]) cylinder(r=paraf_r, h=200, $fn=30);

translate([-off/2,trap_h + 1,h/2]) rotate([90,0,0]) cylinder(r=paraf_r*2, h=paraf_h, $fn=30);
translate([trap_l + off/2,trap_h + 1,h/2]) rotate([90,0,0]) cylinder(r=paraf_r*2, h=paraf_h, $fn=30);

}
/*

difference(){
union(){
translate([-off, trap_h + folga,0])cube([trap_l + 2*off,trap_h + off*.5,h]);
translate([0,0,5]
)linear_extrude(height = h - 5, center = false, convexity = 10) polygon(points=[[folga,folga],[trap_dif + folga,trap_h + 1],[trap_l-trap_dif - folga,trap_h + 1],[trap_l - folga, + folga]]);
}

translate([-off/2,50,h/2]) rotate([90,0,0]) cylinder(r=paraf_r, h=200, $fn=30);
translate([trap_l + off/2,50,h/2]) rotate([90,0,0]) cylinder(r=paraf_r, h=200, $fn=30);

translate([-off/2, trap_h + folga + paraf_h-1,h/2]) rotate([90,0,0]) cylinder(r=paraf_r*2,  h=paraf_h, $fn=30);
translate([trap_l + off/2,trap_h + folga + paraf_h-1,h/2]) rotate([90,0,0]) cylinder(r=paraf_r*2, h=paraf_h, $fn=30);

}
*/
}
