X=14-.1;
fingerWidth=3;
small=0.01;

module Lshape()
{
    cube([3*X,X,X]);
    translate([0,0,X-small]) 
    cube([X,X,X]);
    
    translate([1.5,X/2,X/4])
    sphere(r=2.5,$fn=12);
}

module Tshape()
{
    cube([3*X,X,X]);
    translate([X,0,X-small]) 
    cube([X,X,X]);    
    
    translate([1.5,X/2,X/4])
    sphere(r=2.5,$fn=12);
}

module Zshape()
{
    cube([2*X,X,X]);
    translate([X,X-small,0]) 
    cube([X,X,2*X]);
    
    translate([1.5,X/2,X/4])
    sphere(r=2.5,$fn=12);
}

module Qshape()
{
    union()
    {
        difference()
        {
            cube([2*X,2*X,X]);
            translate([X,X,0])
            sphere(d=1.5*X);
        }
        translate([0,0,X-small]) 
        cube([X,X,2*X]);
        difference()
        {
            translate([0,X-fingerWidth/2,0]) 
            cube([2*X-small,fingerWidth,1*X]);
            translate([X, X-fingerWidth, fingerWidth])
            rotate([-90,0,0])
            cylinder(d=fingerWidth, h=2*fingerWidth,$fn=10);
        }
        translate([1.5,X,X/4])
        sphere(r=2.5,$fn=12);
        /*
        translate([X, 1.5,X/4])
        sphere(r=2.5,$fn=12);
        
        translate([2*X-1.5,X,X/4])
        sphere(r=2.5,$fn=12);
        
        translate([X,2*X-1.5,X/4])
        sphere(r=2.5,$fn=12);
        */
    }
}
//!Qshape();

Lshape();
translate([0,1.5*X,0]) Lshape();
translate([0,3.0*X,0]) Tshape();
translate([0,4.5*X,0]) Zshape();
translate([0,7.0*X,0]) Qshape();