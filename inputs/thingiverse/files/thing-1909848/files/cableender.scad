/* [Global] */

// Width of the flat wire
wirex = 5; //[3:0.25:10]

// Height of the flat wire
wirey = 2; //[3:0.25:10]

/* [Body] */

// Length of the ender
height = 30; //[10:80]

// How thicker is the ender's base then the ender's end (mm)
delta = 5; //[2:0.5:10]

/* [Hole] */

// Lenght of the part which will be pulled inside a box
intlen = 2;

// Width of the hole in the boxe's wall
holex = 6.5;

// Height of the hole in the boxe's wall
holey = 3.5;

// Thickness of the boxe's wall
holeh = 3;

/* [Hidden] */

$fn=100;
d=0.01;
d2=d+d;
dd=d2;
d3=d2+d;
ddd=d3;

baseheight = intlen+holeh+3;
wireheight = height+baseheight;
naked=50;
wirenakeheight = wireheight+naked;

module up(h)
{
    translate([0,0,h]) children();
}

module dh()
{
    up(-d) children();
}

module body() {
    hull() {
        translate([0,0,baseheight/2]) up(dd) minkowski()
        {
            cube([wirex+delta,wirey+delta,baseheight],center=true);
            cylinder(r=1,h=d,$fn=50);
        }
       translate([0,0,wireheight]) minkowski() {
            cube([wirex,wirey,ddd],center=true);
            cylinder(r=1,h=d,$fn=50);
        };
    }
}

module wirebody() {
    translate([0,0,wireheight/2]) minkowski() {
        cube([wirex,wirey,wireheight],center=true);
        cylinder(r=.5,h=d,$fn=50);
    };
}

module nakedwire() {
    translate([0,0,wireheight/2]) cube([wirex,wirey,wirenakeheight],center=true);
}

module rebro()
{
    width=wirex+delta+2+dd;
    height = wirey+delta+2+dd;
    translate([-width/2,1,3])
    cube([width,height/2-1,2]);
    translate([-width/2,-height/2,3])
    cube([width,height/2-1,2]);
}

module rebra()
{
    rebroh=4;
    nrebr=height/rebroh;
    translate([0,0,baseheight-rebroh-rebroh/2])
    for (a=[1:nrebr]) {
        translate([0,0,a*rebroh]) rebro();
    }
}

module hole()
{
    width=wirex+delta+3;
    height = wirey+delta+3;
    
    translate([0,0,intlen+holeh/2])
    difference() {
        cube([width,height,holeh],center=true);
        dh() cube([holex,holey,holeh+ddd],center=true);
    };
}

module bodyminus()
{
    rebra();
    hole();
}

module enderbody()
{
    difference() {
        body();
        bodyminus();
    }
    dh() wirebody();
    nakedwire();
}

wall=2;
enterbodyx = wirex + delta + 2;
enterbodyy = wirey + delta + 2;
enterbodyz = wireheight;

module halfbox()
{
    wall2=wall+wall;
    top=enterbodyy/2+wall;
    difference() {
        union() {
            cube([enterbodyx+wall2+10,enterbodyz+wall2+10,enterbodyy/2+wall]);
            translate([enterbodyx+wall2+5,5,top-1]) sphere(r=2.4);
            translate([enterbodyx+wall2+5,enterbodyz+wall2+6,top-1]) sphere(r=2.4);
        }
        translate([enterbodyx/2+wall+5,enterbodyz+wall+5,enterbodyy/2+wall]) rotate([90,0,0])enderbody();
        translate([5,5,top+1]) sphere(r=2.6);
        translate([5,enterbodyz+wall2+6,top+1]) sphere(r=2.6);
    }
}

halfbox();