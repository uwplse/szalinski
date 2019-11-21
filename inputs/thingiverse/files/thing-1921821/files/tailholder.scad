/* [Global] */

// How to build the holder?
part = "solid"; // [solid:one solild holder,pieces:two pieces to be connected]

// dia of the seatpost we made the thing for
dseat = 32.6; //[15:0.1:60]

// thickness of the outside wall
wall=2; // [1:5]

// total height of the holder
total_height=12; // [10:20]

/* [Head] */

// nut which holds seatpost
seatpostnut = 7; // [3:10]

// bolt dia which holds seatpost
seatpostbolt = 4; // [2:8]

// nut which holds the light
lightnut = 8; // [4:12]

// bolt dia which holds the light
lightbolt = 5; // [3:10]

// length of the holder
holderlength = 29; // [20:100]

// height of the holder
holderheight = 14; // [10:20]

/* [Hidden] */

$fn=100;
d=0.01;
d2=d+d;
d3=d2+d;
sqrt32=1.732050808/2;

module gaika(m, h)
{
    cylinder (r=(m*1.01)/sqrt32/2, $fn=6, h=h );
}

module up(h)
{
    translate([0,0,h]) children();
}

module dh()
{
    up(-d) children();
}

module pie (r,h,angle)
{
    translate ([0,0,-d]) rotate([0,0,-angle/2]) rotate_extrude(angle=angle, convexity = 10) square([r+d,h+d2]); 
}

module rcut (r,h,angle1,angle2,dl=0.2)
{
    rotate([0,0,-angle2]) rotate_extrude(angle=angle, convexity = 10) translate ([r-dl/2,0,-d]) square([dl,h+d2]); 
}

module outercylpieces(r, h)
{
    ir=3;
    dl=0.2;
    difference() {
        hull() {
            cylinder (r=r, h=h);
            translate([-r-ir+wall,0,0]) cylinder (r=ir,h=h);
        }
        translate([-r-ir+wall,0,0]) {
            dh() rcut(r=ir+d,h=h/4-dl/2,angle=180,angle2=180,dl=dl);
            up(h/4-dl/2) cylinder (r=ir+dl/2, h=dl);
            up(h/4+dl/2) rcut(r=ir+d,h=h/2-dl/2,angle=180,angle2=0,dl=dl);
            up(h*3/4-dl/2) cylinder (r=ir+dl/2, h=dl);
            up(h*3/4+dl/2) rcut(r=ir+d,h=h/4,angle=180,angle2=180,dl=dl);
            dh() cylinder (r=1,h=h+d2);
        }
    }
}

module outercylsolid(r, h)
{
    cylinder (r=r, h=h);
}

module outercyl(r, h)
{
    if ( part == "solid" ) {
        outercylsolid (r, h);
    } else if ( part == "pieces" ) {
        outercylpieces (r, h);
    }
}

module holder(h)
{
    hull() {
        cube([holderlength-holderheight,h,holderheight]);
        translate([holderlength-h+h/2,h/2,0])
        cylinder (r=h/2,h=holderheight);
    }
}

// hole for bolt + nut + cutoff which holds the light
module hhole()
{
    dh() cylinder (d=lightbolt+.5, h=holderheight+d2);
    dh() rotate([0,0,30]) gaika(m=lightnut, h=4);
    up(4+3) cylinder (r=9.7/2, h=holderheight-4-3-2+d);
    up(10) cylinder (r=9, h=holderheight-10+d2);
    up(6) rcut(r=9,h=6, angle=180,angle2=-90,dl=.2);
    cu = 4.75;
    ch=2.6;
    ct = 2;
    up(cu) rcut(r=9+ct/2,h=ch, angle=180,angle2=-90,dl=ct);
}

// hole for bolt + nut which holds the piece on the seatpost
module hole()
{
    dh() cylinder (d=seatpostbolt+0.6, h=holderheight+d2);
    dh() rotate([0,0,30]) gaika(m=seatpostnut, h=2);
    up(10) cylinder (d=9.7, h=holderheight-4-3-2+d);
}

module fullholder(h)
{
    difference() {
        holder(h);
        translate([holderlength-h/2,h/2,0]) hhole();
        translate([h/2,h/2,0]) hole();
    }
}

module base()
{
    bar = dseat/2;
    difference() {
        union() {
            outercyl(bar+wall, total_height);
            translate([dseat/2,holderheight/2,0]) rotate([90,0,0]) fullholder(total_height);
        }
        dh() cylinder (r=bar, h=total_height+d2);
        dh() pie (bar+wall+12+d,total_height+d2,5);
    }
}


base();



