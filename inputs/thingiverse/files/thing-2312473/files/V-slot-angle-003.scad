d1=150;//[20:1:300]
d2=150;//[30:1:300]
mw=20;//[15:1:50]
profil=2;//[1:20x20,2:20x40,3:20x60,4:20x80]

render(profil);

$fn=40;
function x1()=(d1<=d2)? mw:d1-d1*((d2-mw)/d2);
function x2()=(d1>=d2)? mw:d2-d2*((d1-mw)/d1);
echo("x1=",x1());
echo("x2=",x2());      


module pre_hull(a,b) {
    intersection() {
        cube([a,4,b*20],center=true);
        rotate([0,90,0]) hull() {for(i=[-1,1],j=[-0.5,5]) translate([i*8.5+i*(b-1)*10,j,0]) cylinder(d=3,h=a,center=true);}
    }
}
module slot(a) {
    translate([-a/2,-2,0]) hull() {
        translate([0,0,-4.5]) cube([a,4,9]);
        translate([1.7,-1.7,-2.8]) cube([a-2*1.7,5.7,5.6]);
    }
}
module V_slot_angle(b) {
    difference() {
        union() {
            hull() {
                translate([d1-x1()/2,2,0]) pre_hull(x1(),b);
                translate([2,d2-x2()/2,0]) rotate([0,0,-90]) pre_hull(x2(),b);
            }
            for(i=[1:1:b]) translate([0,0,(i-1)*20-(b-1)*10]) {
                translate([d1-x1()/2,2,0]) slot(x1());
                translate([2,d2-x2()/2,0]) rotate([0,0,-90]) slot(x2());
            }
        }
        for(i=[1:1:b]) translate([0,0,(i-1)*20-(b-1)*10]) {
            translate([2,d2-x2()/2,0]) rotate([0,90,0]) {
                cylinder(d=5.2,h=40,center=true);
                translate([0,0,2]) cylinder(d=8.8,h=50);
            }
            translate([d1-x1()/2,2,0]) rotate([-90,0,0]) {
                cylinder(d=5.2,h=40,center=true);
                translate([0,0,2]) cylinder(d=8.8,h=50);
            }
        }
        linear_extrude(height = b*22, center = true, convexity = 10, twist = 0)polygon(points=[[d1,0],[0,d2],[0,d2+40],[d1+40,0]]);

    }
}

module render(a) {
    rotate([-90,0,0]) rotate([0,0,atan(d2/d1)]) V_slot_angle(a);
}

