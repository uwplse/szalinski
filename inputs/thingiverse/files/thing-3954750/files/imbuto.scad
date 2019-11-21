// imbuto.scad

// Just a simple parametric funnel
// modify child modules regardless of how the child geometry
// is created.

$fn = 90;

// funnel entrance diameter 
d_ext=20.0;

// funnel output diameter
d_small = 6.7; 

// heigt of the nail
h_fun_1=6.0;

// height of the cylinder
h_fun_2=6.0;

// height of border
h_fun_3=20.0;

// thickness (used for empty funnel)
th_alu=1.0; 

// empty funnel
empty = true;

module funnel(d1, d2,h1,h2,h3,th,empty=true){
    union(){
        difference(){
            cylinder(h=h1, d=d1);
            if (empty) translate([0,0,-1])
                cylinder(h=h1+2,d=d1-2*th);
        }
        difference(){
            translate([0,0,h1])
                cylinder(h=h2,d1=d1, d2=d2);
            if (empty) translate([0,0,h1-1])
                cylinder(h=h2+2,d1=d1-2*th, d2=d2-2*th);
        };
        difference(){
            translate([0,0,h1+h2])
                cylinder(h=h3,d=d2);
            if (empty) translate([0,0,h1+h2-1])
                cylinder(h=h3+2,d=d2-2*th);
        };
    }
}

funnel(d_ext,d_small,h_fun_1,h_fun_2,h_fun_3,th_alu,empty);
/*
translate([1.5*d_ext,0,0])funnel(d_ext-2*th_alu,d_small-2*th_alu,
        h_fun_1/2,h_fun_2,1.5*h_fun_3,th_alu);

*/

