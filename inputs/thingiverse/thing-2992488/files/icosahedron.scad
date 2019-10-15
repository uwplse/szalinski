////////////////////////////
// icosahedron
// by skitcher
////////////////////////////

/* [Customizer Parameters] */

// Edge length
Edge_length=40;

// Resolution
Resolution=45;

// Corner radius
Corner_radius=5;



/* [Hidden] */
phi=(1 + sqrt(5)) / 2;
$fn=Resolution;
s=Edge_length/2-Corner_radius/1.5;
r=Corner_radius;
s2=s*phi;



//translate([0,0,25]) cube(20 ,true);

    hull(){
        
        translate([s,0,s2]) sphere(r);
        translate([s,0,-s2]) sphere(r);
        
        translate([-s,0,s2]) sphere(r);
        translate([-s,0,-s2]) sphere(r);
        
        translate([s2,s,0]) sphere(r);
        translate([-s2,s,0]) sphere(r);
        
        translate([s2,-s,0]) sphere(r);
        translate([-s2,-s,0]) sphere(r);
        
        translate([0,s2,s]) sphere(r);
        translate([0,s2,-s]) sphere(r);
        
        translate([0,-s2,s]) sphere(r);
        translate([0,-s2,-s]) sphere(r);
        
        
    }