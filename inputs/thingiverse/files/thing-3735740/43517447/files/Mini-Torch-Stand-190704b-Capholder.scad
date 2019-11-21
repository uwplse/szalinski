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
    cylinder(d=dc+2*16.2+1*wr,h=16.2,$fn=fn);

    rotate_extrude($fn=fn)
    translate([dc+1*wr+4,dc/2+2*wr+2,0])
    circle(d=dc+wr+4,$fn=fn);
    
    translate([0,0,dc/2+wr])
    cylinder(d=dc+dn, h=hc-dc, $fn=fn);

    translate([0,0,dc/2+wr])
    sphere(d=dc+dn, $fn=fn);
};

color("Fuchsia")
translate([2*dc+2*wr,0,0])
union()
{
    difference()
    {
        cylinder(d=2*16-2*dn,h=16/2+2*wr,$fn=fn);

        rotate_extrude($fn=fn)
        translate([16-dn,16/2+wr+dn/2+0.1,0])
        circle(d=16-dn,$fn=fn);
        
        

        *translate([0,0,dc/2+wr])
        sphere(d=dc+dn, $fn=fn);
    };

    //translate([2*dc+2*wr,0,wr])
    cylinder(d=16-dn, h=16/2+wr+25, $fn=fn);
};

color("Orange")
difference()
{
    translate([dc/2,-wi/2-wr,0])
    cube([dc+12,wi+2*wr,wi+wr]);
    translate([dc/2-wr,-wi/2,wr+dn+0.1])
    cube([dc+12+2*wr,wi,wi+2*wr]);
};