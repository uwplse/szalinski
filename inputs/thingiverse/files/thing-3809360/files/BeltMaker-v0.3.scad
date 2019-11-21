//BeltMaker - Copyright (c) 2019 Alexander Tanchoco
//Feel free to use for non-commercial applications
//This code is intended for the educational use of OpenScad and techniques in coding.
//WARNING: This design has NOT been tested in actual use or intended for any specific purpose. You assume all the responsibility and risk associated with its actual use. Please use common sense with any mechanical component, improper use or application could cause considerable damage or even death.

diameter = 100;
width = 7;
thickness = 3;
//ribs = 3;
rib_start = 0;
rib_width = 1;
rib_gap = 1;
rib_thickness = 1;
preview_cleanup = 0.01;

belt();

//can also provide parameters like 
//belt(50); //overrides the first parameter


module belt(dm=diameter,w=width,t=thickness,
        rs=rib_start, rw=rib_width,rt=rib_thickness,rg=rib_gap) {
    difference() {
        cylinder(h=w, d=dm, $fn=dm*2 );
        translate( [0,0,-preview_cleanup] )
            cylinder(h=w+preview_cleanup*2, d=dm-(t*2), $fn=dm*2 );
    
        if( rw>0 ) {
            for( z=[rw:rg+rw:w-preview_cleanup] ) {
                translate( [0,0,z-preview_cleanup] )
                    cylinder(h=rw+preview_cleanup*2, d=dm-(t-rt)*2, $fn=dm*2 );
            }
        }
    }
}

