// Magic box
// Kristine Orten, 2018

// test mot ekte stav, ulike mål


/*Global*/
// name
_n = "Odin";
// name size
_ns = 20;

// define card size
// height (in mm)
_h = 5;  
// width (in mm)
_w = 190;
// depth (in mm)
_d = 50;

/*Hidden*/
error = .01;
$fn = 150;
// wand thickness
_t = 8;
_t2 = 15;
// height of supports
_s = 5*_h;



module name(d,w,h)
{
    translate([.5*d-_t,-.125*w,.5*h-.5+error]) rotate([180,180,-90]) linear_extrude(.5) text(_n, _ns, "Harry P");
}

module supports(d,w,h)
{
    //for(i=[-.375:.75:.375])
    {
        difference()
        {
            translate([0,-.375*w,.5*_s]) cylinder(h=_s,d=_t,center=true);
            translate([0,-.375*w,_s+0*.5*_t]) rotate([90,0,0]) cylinder(h=_t,d=_t+1.6, center=true);
        }
        difference()
        {
            translate([0,.375*w,.5*_s]) cylinder(h=_s,d=_t2,center=true);
            translate([0,.375*w,_s+0*.5*_t]) rotate([90,0,0]) cylinder(h=_t2,d=_t2+1.6, center=true);
        }
    }
}

module lightning_bolts(d,w,h)
{
    translate([.5*d-_t,-.25*w,.5*h-.5+error]) rotate([180,180,-90]) linear_extrude(.5) text("L", _ns, "Lightning Bolt");
    translate([.5*d-_t,.15*w,.5*h-.5+error]) rotate([180,180,-90]) linear_extrude(.5) text("L", _ns, "Lightning Bolt");
    // corner lightning bolts (bl, br, tr, tl)
    translate([.3*d,-.35*w,.5*h-.5+error]) rotate([180,180,45]) linear_extrude(.5) text("E", _ns, "Lightning Bolt");
    translate([.05*d,.425*w,.5*h-.5+error]) rotate([180,180,135]) linear_extrude(.5) text("E", _ns, "Lightning Bolt");
    translate([-.3*d,.35*w,.5*h-.5+error]) rotate([180,180,-135]) linear_extrude(.5) text("E", _ns, "Lightning Bolt");
    translate([-.05*d,-.425*w,.5*h-.5+error]) rotate([180,180,-45]) linear_extrude(.5) text("E", _ns, "Lightning Bolt");
}

module plate(d,w,h)
{
    difference()
    {
        union()
        {
            cube([d,w,h], center=true);
            // edges
            for(i=[-.5:1:.5])
            {
                translate([d*i,0,0]) rotate([90,0,0]) scale([1,1,1]) cylinder(h=w,d=h, center=true);
            }
            supports(d,w,h);
        }
    name(d,w,h);
    lightning_bolts(d,w,h);
    }
}

plate(_d,_w,_h);