//$fn=100;
/*
    default values
*/
function maxx(x) = max(xmin,min(xmax,x));
function maxy(y) = max(ymin,min(ymax,y));
/* [Global] */
// Roof height
roof=25; // [25:38]
// Number of helixes
nhelixes=8; // [6:32]
// Helix thickness
thick=2;
// Helix turns
turns=.5;

/* [Hidden] */
xmax=roof;
fn=60;
xmin=0;
ymax=999;
ymin=-999;
radius=36;
height=77;

$fn=fn;
step = 360/fn;
div =  (360*turns) / height;
rev = height/(360 / div);

module helix(start=0,step=5,rev=.75,r=20,div=3,thick=4) {
	translate([-thick/2,-thick/2,0])  {
    for(a=[step:step:(360*rev) + step]) {
        x = maxx(sin(a+start)*r);
        x2 = maxx(sin((a+start)-step)*r);
        y = maxy(cos(a+start)*r);
        y2 = maxy(cos((a+start)-step)*r);
		hull() {
			translate([x,y,a/div]) 
                cube(thick);
			translate([x2,y2,(a-step)/div]) 
				cube(thick);
		}
	}
}
}
module helixc(start=0,step=5,rev=.75,r=20,div=3,thick=4) {
    translate([-thick/2,-thick/2,0]) union() {
        for(a=[0:-step:-(360-step)*rev]) {
            x = maxx(sin(a+start)*r);
            x2 = maxx(sin((a+start)-step)*r);
            y = maxy(cos(a+start)*r);
            y2 = maxy(cos((a+start)-step)*r);
            hull() {
                translate([x,y,-a/div]) 
                    cube(thick);
                translate([x2,y2,-(a-step)/div]) 
                    cube(thick);
            }
        }
    }
}

module helixgrid(n=7,rev=1,r=20,div=3,thick=2) {
    for(v=[0:360/n:360]) {
        helix(v,step=step,rev=rev,r=r,div=div,thick=thick);
        helixc(v,step=step,rev=rev,r=r,div=div,thick=thick);
    }

}
module topcut(r=57.5) {
    difference() {
        cylinder(r=r,h=20);
        translate([-r-xmin+1.5,-r,-1]) cube([r,r*2,20]);
        translate([xmax-1.5,-r,-1]) cube([r,r*2,20]);
    }
}

module top(r=60) {
    difference() {
        cylinder(r=r,h=10);
        translate([0,0,-1]) topcut(r-2.5);
        translate([-r-xmin-1,-r,-1]) cube([r,r*2,20]);
        translate([xmax+1,-r,-1]) cube([r,r*2,20]);
    }
}

module bottom(r=60) {
    difference() {
        cylinder(r=r,h=10);
        translate([0,0,2.5]) cylinder(r=r-2.5,h=10);
        translate([-r-xmin-1,-r,-1]) cube([r,r*2,20]);
        translate([xmax+1,-r,-1]) cube([r,r*2,20]);
        translate([3.5,-28,1]) cube([2,56,10]);
        translate([2.5,-7.5,-1]) cube([2,15,10]);
    }
    translate([-1,-35,0]) cube([1.5,70,10]);
    translate([0,-33,0]) cube([3.5,20,10]);
    translate([0,13,0]) cube([3.5,20,10]);
    translate([0,28,0]) cube([6,7,10]);
    translate([0,-35,0]) cube([6,7,10]);

    translate([6,24,0]) cube([2.5,11,7]);
    translate([6,-35,0]) cube([2.5,11,7]);
}
module slot() {
    translate([5.5,15,5.5]) rotate([90,0,0]) hull() {
        cylinder(r=6,h=20);
        translate([0,54,0]) cylinder(r=6,h=20);
    }
}
module conn_holes(l=5.5) {
    translate([3,25,5]) slot();    
}
module connectors() {
    difference() {
        cylinder(r=37,h=80);
        translate([0,0,-1]) cylinder(r=34.5,h=82);
        translate([-51,-40,-1]) cube([50,80,82]);
        translate([19,-35,-1]) cube([50,70,82]);
        translate([-10,-70,-1]) cube([50,70,82]);
    }
}
module lid_base(r=37) {
    difference() {
        cylinder(r=r,h=2.5);
        translate([-r-xmin-1,-r,-1]) cube([r,r*2,20]);
        translate([xmax+1,-r,-1]) cube([r,r*2,20]);
    }
    difference() {
        translate([0,0,2.5]) cylinder(r=r-4,h=7);
        translate([-r-xmin+3,-r,-1]) cube([r,r*2,20]);
        translate([xmax-2.6,-r,-1]) cube([r,r*2,20]);
    }
    
}
module netusb(h=20) {
    translate([2.5,-28,-1]) linear_extrude(height = h, center = false, convexity = 10, slices = 1, scale = 1.0) {
        polygon(points=[[0,0.7],[17,0.7],[17,18],[20,18],[20,53.5],[0,53.5]]);
    }
    translate([2.5,-30,1]) cube([3,10,20]);
    translate([2.5,18,1]) cube([3,10,20]);
}
module lid() {
    difference() {
        lid_base();
        netusb();
    }
}
module hanger() {
    difference() {
        union() {
            connectors();
            bottom(37);
            helixgrid(nhelixes,rev,radius,div,thick);
            translate([0,0,76]) top(37);
        }
        conn_holes();
    }
}

//bottom(37);
hanger();
translate([xmax+10,0,0])
lid();

