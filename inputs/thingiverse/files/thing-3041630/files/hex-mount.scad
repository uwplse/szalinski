// This is an insert for mounting hex tools in wood or other material.
//
// Warning -- some sanding and fitting may be required.
//
// This is licensed under the creative commons+attribution license
//
// To fulfill the attribution requirement, please link to:
// http://www.thingiverse.com/thing:3041630

/* [Main] */

// Define number of facets (large numbers provide better smoothing)
$fn=100;

shape=0;//[0:Without Knurling,1:With Knurling]

// in mm
insert_height = 19.0;

// in mm
hole_depth = 16.0;

// (without knurling) in mm
outside_diameter = 10.0;

// in mm
inside_diameter = 7.3;

module knurl1()
{
        for(i=[0:1:5])
        {
                translate([outside_diameter/2+insert_height/24,0,i*insert_height/6+insert_height/12])
        rotate([0,90,0]) cylinder(h=insert_height/12,r1=insert_height/12,r2=0,center=true,$fn=4);
        }
}
 
module knurl2()
{
    for(i=[0:1:4])
    {
     
        translate([outside_diameter/2+insert_height/24,0,i*insert_height/6+insert_height/6])
        rotate([0,90,0]) cylinder(h=insert_height/12,r1=insert_height/12,r2=0,center=true,$fn=4);
    }
}

rotate([180,0,0]) difference()
{
    if(shape==0)
    {
        // Draw outer shape
        translate([0,0,0]) cylinder(h=insert_height,r=outside_diameter/2,center=false);
    }
    if(shape==1)
    {
        union()
        {
                // Draw outer shape
                translate([0,0,0]) cylinder(h=insert_height,r=outside_diameter/2,center=false);

                // Draw small pyramids
                for(angle=[0:30:330]) 
                {
                        rotate([0,0,angle])    knurl1();
            rotate([0,0,angle+15]) knurl2();
                }

        }
    }
        
    #translate([0,0,hole_depth/2]) cylinder($fn=6,r=inside_diameter/2,h=hole_depth+1.0,center=true);
}
