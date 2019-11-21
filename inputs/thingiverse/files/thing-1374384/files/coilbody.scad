
/////////////////////////
// center cylinder
//
// Diameter
D=80;
// length of coil
h=40;
// number of windings(in center cylinder)
n=0.5;
// width of indent for wire
wirewidth=20;
// elasticity measure for winding
elastic=0.01;
// number of spiral Segments per rotation
segs=20;
/////////////////////////


//////////////
// top cone
//
// diameter of center hole
tc_h = 20;
// extention spiral
// if spiral is extended, you increase tc_s
tc_s = 80;
/////////////////////////

/////////////////////////
// hole for fixing
//
// body hight
hf_h = 10;
//
//dipth of hole(hf_h>hf_dip)
hf_dip = 5;
// diameter of center hole
dfc = 8;
// diameter of out hole
dfo = 2.5;
// diameter of position of out hole
dfod = 8;
/////////////////////////




/* [Hidden] */



D_el=D/(1+elastic);
n_el=n*(1+elastic);

$fn=32;

alpha=atan(h/(n_el*PI*D_el));
alpha2=alpha + 45;

// hole for fixing
difference(){

translate([0,0,-hf_h]) cylinder(h=hf_h, d=D_el);
  
translate([0,0,-hf_h-1]) cylinder(h=hf_dip+1, d=dfc);
translate([0,dfod,-hf_h-1]) cylinder(h=hf_dip+1, d=dfo);
translate([0,-dfod,-hf_h-1]) cylinder(h=hf_dip+1, d=dfo);
translate([dfod,0,-hf_h-1]) cylinder(h=hf_dip+1, d=dfo);
translate([-dfod,0,-hf_h-1]) cylinder(h=hf_dip+1, d=dfo);

}



difference() {
    
    union(){
        cylinder(d=D_el, h=h);
        translate([0,0,h+tc_h/2])
            cylinder(h=tc_h, d1=D_el ,d2=0 , center=true);
    }
    for(i = [1:(n_el*segs)-1+tc_s])
    {
        hull(){
            rotate(360*(i/segs)) translate([D_el/2,0,(h)*(i/(n_el*segs))]) rotate([90+alpha,0,0])linear_extrude(.01)circle(d=wirewidth);
            rotate(360*((i+1)/segs)) translate([D_el/2,0,(h)*((i+1)/(n_el*segs))]) rotate([90+alpha,0,0])linear_extrude(.01)circle(d=wirewidth);
        }

        hull(){
            rotate(360*(i/segs)+120) translate([D_el/2,0,(h)*(i/(n_el*segs))]) rotate([90+alpha,0,0])linear_extrude(.01)circle(d=wirewidth);
            rotate(360*((i+1)/segs)+120) translate([D_el/2,0,(h)*((i+1)/(n_el*segs))]) rotate([90+alpha,0,0])linear_extrude(.01)circle(d=wirewidth);
        }    
        
         hull(){
            rotate(360*(i/segs)+250) translate([D_el/2,0,(h)*(i/(n_el*segs))]) rotate([90+alpha,0,0])linear_extrude(.01)circle(d=wirewidth);
            rotate(360*((i+1)/segs)+250) translate([D_el/2,0,(h)*((i+1)/(n_el*segs))]) rotate([90+alpha,0,0])linear_extrude(.01)circle(d=wirewidth);
        }        
 
        
    }
    
    

}