inside_dia = 20;
inside_height = 4;

strap_width = 3;
strap_thick = 0.8;
strap_slack = 1;

// additional diameter of snap ring
snap_od = 1;

fillet_radius = 1;
wall = 1.5;
lip_height = 2;

/* [extra] */
// tolerance between parts
tol = 0.1;

/* [hidden] */
eps = 0.01;

neckh = inside_height + wall- lip_height;

$fn = 60;

module torus(d1,d2) {
    rotate_extrude() translate([d1/2, 0,0]) circle(d=d2);
}

module tfillet(d1, dy, ds,fr=fillet_radius) {
    translate([0,0,-fr*dy])difference() {
        translate([0,0,dy*fr/2-fr/2]) difference() {
            cylinder(h=fr, d=d1+fr+fr*ds);
            translate([0,0,-eps])cylinder(h=fr+eps*2, d=d1-fr+fr*ds);
        }
        torus(d1+fr*ds*2, fr*2);
    }
}

union() {
    // bottom cavity
    union() {
        difference() {
            union() {
                // body
                cylinder(h=wall+inside_height, d=inside_dia+wall*2);
                // lip
                cylinder(h=lip_height, d = inside_dia+wall*2+snap_od*2+wall*2);
                // snap ring
                translate([0,0,lip_height+neckh/2]) torus(d1=inside_dia+wall*2, d2=snap_od);
            }
            // main cavity
            translate([0,0,wall]) cylinder(d=inside_dia, h=inside_height+tol);
            // fillet top lip
            translate([0,0,wall+inside_height+tol]) tfillet(inside_dia+wall*2+tol, 1, -1);
        }
        // cavity fillet
        translate([0,0,wall]) tfillet(inside_dia, -1,-1);  
    }
    // strap
    bottom_radius = inside_dia/2+wall+snap_od+wall;
    straplen = wall + inside_height + strap_slack + tol + wall;
    translate([bottom_radius-tol, -strap_width/2, 0]) 
        cube([straplen+tol*2, strap_width, strap_thick]);
    // top lid
    translate([bottom_radius + straplen+ bottom_radius, 0, 0]) union(){
        difference(){
            // body
            cylinder(h=wall+neckh-tol, r=bottom_radius);
            // inside cavity
            translate([0,0,wall]) cylinder(h=neckh, d=inside_dia+wall*2);
            // snap ring
            translate([0,0,neckh/2+wall+tol*2]) torus(d1=inside_dia+wall*2, d2=snap_od+tol*2);
        }
        // fillet lid inside
        translate([0,0,wall]) tfillet(inside_dia+wall*2, -1, -1, fillet_radius+tol*2);
    }
}