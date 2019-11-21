//
//  parametric soap dish for shower (installed on vertical tube)
//
//  design by egil kvaleberg, 21 july 2016
//
part = "main"; // [ main ]
// set to "test" to examine mount and ribs

// size of soap compartment
soap_w = 60;
soap_l = 90;
soap_h = 13;
// corner radius of soap compartment
corner_r = 5;
// wall thickness of soap comparement
wall = 2.5;
// chamfer for various holes
chamfer = 0.6;
// wall thickness of mounting
mnt_wall = 5.0;
// distance between drain holes
drain_dist = 15.0;
// diameter of drain holes
drain_dia = 4.0;
// height of ribs in bottom
rib_h = 1.0;
// size of tube we are mounting to. need accurate measure
mnt_dia = 25.0;
// fine tune of diameter of friction tabs, smaller number more friction
friction_delta = -0.10;
// number of friction tabs
friction_tabs = 10;
// generic tolerance
tol = 0.25;

d = 1*0.1;

nx = floor((soap_l-2*corner_r)/drain_dist);
ny = floor((soap_w-2*corner_r)/drain_dist);

module add() {
    if (part!="test") hull() for (sx = [-1,1]) for (sy = [-1,1]) 
        translate([sx*(soap_l/2-corner_r),sy*(soap_w/2-corner_r),wall+corner_r]) {
            sphere(r=wall+corner_r, $fn=30);
            translate([0,0,0])
                cylinder(r=wall+corner_r, h=soap_h-corner_r, $fn=30);
        }
    // mount:
    translate([0,soap_w/2+mnt_wall+mnt_dia/2,0]) 
        cylinder(r=mnt_wall+mnt_dia/2+tol, h=wall+soap_h, $fn=60);   
    if (part!="test") translate([-(mnt_dia/2),0,0]) 
        cube([mnt_dia, soap_w/2+mnt_wall+mnt_dia/2, wall+soap_h]);     
}

module sub() {
    if (part!="test") hull () for (sx = [-1,1]) for (sy = [-1,1]) 
        translate([sx*(soap_l/2-corner_r),sy*(soap_w/2-corner_r),wall+corner_r]) {
            sphere(r=corner_r, $fn=30);
            cylinder(r=corner_r, h=d+soap_h-corner_r, $fn=30);
            //translate([0,0,8/*d+soap_h-corner_r-chamfer*/])
            //    cylinder(r1=corner_r, r2=corner_r+chamfer+d+1, h=chamfer+d, $fn=30);
        }
    // drain holes:    
    if (part!="test") for (dx = [0:nx-1]) for (dy = [0:ny-1]) 
        translate([(dx-(nx-1)/2)*drain_dist, (dy-(ny-1)/2)*drain_dist, -d]) {
            cylinder(d1=drain_dia+2*chamfer+2*d, d2=drain_dia, h=d+chamfer, $fn=16);
            cylinder(d=drain_dia, h=d+wall+d, $fn=16);
            translate([0,0,d+wall-chamfer]) cylinder(d1=drain_dia, d2=drain_dia+2*chamfer+2*d, h=d+chamfer, $fn=16);
            
        }
    // mount:
    translate([0,soap_w/2+mnt_wall+mnt_dia/2,-d]) {
        cylinder(r1=mnt_dia/2+tol+chamfer+d, r2=mnt_dia/2+tol, h=d+chamfer, $fn=60);
        cylinder(r=mnt_dia/2+tol, h=d+wall+soap_h+d, $fn=60); 
        translate([0,0,d+wall+soap_h-chamfer]) cylinder(r1=mnt_dia/2+tol, r2=mnt_dia/2+tol+chamfer+d, h=d+chamfer, $fn=60);
        // room for friction tabs:
        for (n = [0:friction_tabs-1]) rotate([0,0,(n+0.5)*360/friction_tabs]) 
        translate([-1.0*mnt_wall/2,-mnt_dia/2-0.7*mnt_wall,0.6*mnt_wall]) 
            cube([1.0*mnt_wall,0.7*mnt_wall,wall+soap_h-0.6*mnt_wall-0.3*mnt_wall]);
    }
    // if test, cut in half
    if (part=="test") translate([0,-d,-d]) 
        cube([mnt_dia, soap_w/2+2*mnt_wall+mnt_dia+2*d, wall+soap_h+2*d]); 
}

module subsub() {
    // internal ribs:    
    if (part!="test") for (dx = [0:nx-2]) hull() for (sy=[-1,1]) 
        translate([(dx-(nx-2)/2)*drain_dist, sy*((ny-1)/2)*drain_dist, (wall+rib_h)/2]) 
            sphere(d=wall+rib_h, $fn=24);
}

    // main structure:
    difference () {
        color("red") add();
        difference () {
            sub();
            subsub();
        }
    }

   // add friction tabs
   translate([0,soap_w/2+mnt_wall+mnt_dia/2,-d]) {
       difference () {
           for (n = [0:friction_tabs-1]) rotate([0,0,(n+0.5)*360/friction_tabs]) 
           translate([-0.8*mnt_wall/2,-mnt_dia/2-0.7*mnt_wall,0.4*mnt_wall]) 
               rotate([-5.0,0,0]) cube([0.8*mnt_wall,0.7*mnt_wall-2.0*tol,wall+soap_h-0.6*mnt_wall-0.3*mnt_wall]);
           cylinder(r=mnt_dia/2+friction_delta, h=d+wall+soap_h+d, $fn=60); 
       }
   }