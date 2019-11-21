$fn=64;

thickness = 3;

outer_diam = 45;
outer_height = 20;

inner_diam_top = 17;
inner_diam_bottom = 15;
inner_height = 30;

diff = 0.1;

module net(x= 50, y= 50, d=0.6, period = 1){
    
    for (i = [0:round(x/period)])
        translate([-x/2 + i*period, -y/2, 0]) rotate([-90,0,0]) cylinder(r = d/2, h = y, $fn=8);
    
    for (i = [0:round(y/period)])
        translate([-x/2, -y/2 + i*period, 0]) rotate([0,90,0]) cylinder(r = d/2, h = x, $fn=8);
    
}


module rost(x= 50, y= 50, d=0.5, period = 1){
    
    for (i = [0:round(x/period)])
        translate([-x/2 + i*period, -y/2, 0]) rotate([-90,0,0]) cylinder(r = d/2, h = y, $fn=8);
}

difference(){
    union(){
        cylinder(r1= outer_diam/2, r2= inner_diam_top/2, h= outer_height);
        translate([0,0,outer_height ]) cylinder(r1= inner_diam_top/2, r2= inner_diam_bottom/2, h= inner_height);
    }
    translate([0,0,-diff]) cylinder(r1= (outer_diam-thickness)/2, r2= (inner_diam_top-thickness)/2, h= outer_height+ 2*diff);
    translate([0,0,outer_height -diff]) cylinder(r1= (inner_diam_top-thickness)/2, r2= (inner_diam_bottom-thickness)/2, h= inner_height + 2*diff);
}

difference(){
    union(){
        translate([0,0,outer_height-0.4]) rost(x = 30, y=30);
        translate([0,0,outer_height-0.7]) rotate([0,0,90]) rost(x = 30, y=30);
    }
    difference(){
        translate([-30,-30,0]) cube([60,60,outer_height]);
        translate([0,0,-diff]) cylinder(r1= (outer_diam-thickness)/2, r2= (inner_diam_top-thickness)/2, h= outer_height+ 2*diff);
    }
}