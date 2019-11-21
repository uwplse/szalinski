// Diameter of the router bit
rdia =8;
// Safety distance between router bit and bushing
distance = 3;
// Material thickness of the bushing
material = 4;

// Diameter of the plate of the router
routerplatediameter = 73.9;
// Distance of the screwholes
routerplatescrewdistance = 65;
// Thickness of the router plate
routerplatethickness = 2;
// Thickness of the guide bushing
guidebushingheight = 5;
// Diameter of the screwholes
screwdiameter = 4.5;
// Diameter of the screwheads
screwheaddiameter = 7.6;
// Height of the screwheads
screwheadheight = 1.2;


rradius = rdia / 2;
innerradius1 = rradius + distance;
outerradius1 = innerradius1 + material;
outerradius2 = rdia + distance + material;
innerradius2 = rdia + distance;

translate([0.51*routerplatediameter,0,0])
    Bushing(innerradius1*2, outerradius1*2);
translate([-0.51*routerplatediameter,0,0])
    Bushing(innerradius2*2, outerradius2*2);

module Bushing(inner, outer) {
    lift = routerplatethickness - screwheadheight;
    difference() {
        union() {
            cylinder(d=routerplatediameter, h=routerplatethickness);
            cylinder(d=outer, h=routerplatethickness+guidebushingheight);

        }
        cylinder(d=inner, h=routerplatethickness+guidebushingheight);

        translate([routerplatescrewdistance/2,0,0]) cylinder(d=screwdiameter, h=routerplatethickness);
        translate([-routerplatescrewdistance/2,0,0]) cylinder(d=screwdiameter, h=routerplatethickness);
        translate([routerplatescrewdistance/2,0,lift]) cylinder(d=screwheaddiameter, h=screwheadheight);
        translate([-routerplatescrewdistance/2,0,lift]) cylinder(d=screwheaddiameter, h=screwheadheight);
    }
}
