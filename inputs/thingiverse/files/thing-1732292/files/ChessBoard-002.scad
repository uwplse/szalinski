side=30;
//thickness of the board
thick=2.2;
edge_thick=3;
//coefficient of the thickness of the board
edge_height_coef=1.5;//[1:0.1:3]

//printer tolerance (only affect "color 02" parts)
tolerance=0.2;//[0:0.05:0.7]
//definition (only affect corners)
$fn=60;
render="Test part";//[Corner color 01,Corner color 02,Edge color 01,Edge color 02,Center color 01,Center color 02,Test part]

////////
module slot() {
translate([-side/2,0,-thick/2-0.2]) rotate([0,0,180]) translate([0.2,0,0]) hull() {for(i=[-1,1]) translate([-0.5-2*tolerance/1.75,i*(0.866+2*tolerance),0]) cylinder(d=8,h=thick/2+0.5,$fn=3);}
}
module couleur01(a) {
    cube([side,side,thick],center=true);
    for(i=[0,90]) rotate([0,0,i])
    translate([-side/2,0,-thick/2]) cylinder(d=10,h=thick/2,$fn=3);
    if (a==2) {
        for(i=[0,-90]) rotate([0,0,i])
        translate([-side/2,side/2,-thick/2]) cube([side,edge_thick,edge_height_coef*thick]);
        difference() {
            translate([side/2,side/2,-thick/2]) cylinder(r=edge_thick,h=edge_height_coef*thick);
            cube([side,side,2*edge_height_coef*thick],center=true);
        }
    }
    if (a==3) {
        rotate([0,0,180])
        translate([-side/2,0,-thick/2]) cylinder(d=10,h=thick/2,$fn=3);
        translate([-side/2,side/2,-thick/2]) cube([side,edge_thick,edge_height_coef*thick]);
    }
    else if (a==4) {
        for(i=[180,-90]) rotate([0,0,i])
        translate([-side/2,0,-thick/2]) cylinder(d=10,h=thick/2,$fn=3);
    }
    else {};
}

module couleur02(a) {
    difference() {
        cube([side,side,thick],center=true);
        for(i=[0,90]) rotate([0,0,i])
        slot();
        if (a==3) {
            rotate([0,0,180]) slot();
        }
        else if (a==4) {
            for(i=[180,-90]) rotate([0,0,i]) slot();
        }
        else {};
    }
    if (a==2) {
        for(i=[0,-90]) rotate([0,0,i])
        translate([-side/2,side/2,-thick/2]) cube([side,edge_thick,edge_height_coef*thick]);
        difference() {
            translate([side/2,side/2,-thick/2]) cylinder(r=edge_thick,h=edge_height_coef*thick);
            cube([side,side,2*edge_height_coef*thick],center=true);
        }
    }
    if (a==3) {
        translate([-side/2,side/2,-thick/2]) cube([side,edge_thick,edge_height_coef*thick]);
    }
}

if (render=="Corner color 01") {
    couleur01(2);
}
else if (render=="Corner color 02") {
    couleur02(2);
}
else if (render=="Edge color 01") {
    couleur01(3);
}
else if (render=="Edge color 02") {
    couleur02(3);
}
else if (render=="Center color 01") {
    couleur01(4);
}
else if (render=="Center color 02") {
    couleur02(4);
}
else if (render=="Test part") {
    rotate([0,0,180]) translate([-1.5,0,0]) difference() {
        translate([-7.5,0,0]) cube([15,15,thick],center=true);
        translate([-30/2,0,-thick/2-0.2]) rotate([0,0,180]) translate([0.2,0,0]) hull() {for(i=[-1,1]) translate([-0.5-2*tolerance/1.75,i*(0.866+2*tolerance),0]) cylinder(d=8,h=thick/2+0.5,$fn=3);}
    }
    translate([-1.5,0,0]) union() {
        translate([-7.5,0,0]) cube([15,15,thick],center=true);
        translate([-30/2,0,-thick/2]) cylinder(d=10,h=thick/2,$fn=3);
    }
}
