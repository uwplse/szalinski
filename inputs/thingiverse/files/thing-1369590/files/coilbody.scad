// Diameter
D=10;
// length of coil
h=15;
// number of windings
n=3;
// width of indent for wire
wirewidth=1.5;
// elasticity measure for winding
elastic=0.2;
// number of spiral Segments per rotation
segs=32;

/* [Hidden] */

D_el=D/(1+elastic);
n_el=n*(1+elastic);

$fn=32;

alpha=atan(h/(n_el*PI*D_el));

difference() {
    
    cylinder(d=D_el, h=h);

    for(i = [1:(n_el*segs)-1])
    {
        hull(){
            rotate(360*(i/segs)) translate([D_el/2,0,h*(i/(n_el*segs))]) rotate([90+alpha,0,0])linear_extrude(.01)circle(d=wirewidth);
            rotate(360*((i+1)/segs)) translate([D_el/2,0,h*((i+1)/(n_el*segs))]) rotate([90+alpha,0,0])linear_extrude(.01)circle(d=wirewidth);
        }
 
    }
}