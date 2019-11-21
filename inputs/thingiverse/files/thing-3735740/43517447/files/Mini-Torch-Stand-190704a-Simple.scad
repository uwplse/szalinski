dn=0.40;    // nozzle diameter
dt=21.32;   // torch cylinder diameter net
dc=dn+dt;   // cylinder diameter

wi=12.20+dn;// igniter width
hc=30+16.2; // cylinder height total

wr=1;       // rim width

fn=120;      // rendering fineness

// torch model

color("Grey")
union()
{
    
    translate([0,0,hc-dc/2])
    sphere(d=dc, $fn=fn);

    translate([0,0,dc/2])
    cylinder(d=dc, h=hc-dc, $fn=fn);

    translate([0,0,dc/2])
    sphere(d=dc, $fn=fn);

    translate([dc/2-(21.32+12.2-31.63),-wi/2,16.2])
    cube([wi,wi,30]);
};

color("Lightgreen")
difference()
{
    cylinder(d=2*dc+2*wr,h=16.2-wr,$fn=fn);

    rotate_extrude($fn=fn)
    translate([dc+2*wr,dc/2+2*wr,0])
    circle(d=dc+wr,$fn=fn);
    
    translate([0,0,dc/2+wr])
    cylinder(d=dc+dn, h=hc-dc, $fn=fn);

    translate([0,0,dc/2+wr])
    sphere(d=dc+dn, $fn=fn);
};
