// GoPro Mount for Binoculars
// https://www.thingiverse.com/thing:3028620
// Created by https://www.thingiverse.com/Bikecyclist
//
// V1.0 First Version on Thingiverse
//
// Remixed from
// ...
// https://www.thingiverse.com/thing:3027974 - V1.0
// Created by https://www.thingiverse.com/Bikecyclist
// ... and ...
// GoPro Hero mount and joint (gopro_mounts_mooncactus.scad) - Rev 1.03
// CC-BY-NC 2013 jeremie.francois@gmail.com
// http://www.thingiverse.com/thing:62800
// http://betterprinter.blogspot.com


// Diameter of Connection Piece
d_connect = 21.5;

//Height of GoPro Connector Bottom above Connection Piece Circumference
h_connect = 0;

// Diameter of Screw Head
d_head = 15;

// Diameter of Screw Body
d_screw = 6;

// Thickness of Wall between Screw Head and Binocular
wall = 5;

// Number of Facets in a Circle
$fn = 64;

th_connect = 5 + wall;

// Parameter to ensure proper meshing (no need to change this, normally)
epsilon = 0.01;

/*[hidden]*/
// The gopro connector itself (you most probably do not want to change this but for the first two)

// The locking nut on the gopro mount triple arm mount (keep it tight)
gopro_nut_d= 9.2;
// How deep is this nut embossing (keep it small to avoid over-overhangs)
gopro_nut_h= 2;
// Hole diameter for the two-arm mount part
gopro_holed_two= 5;
// Hole diameter for the three-arm mount part
gopro_holed_three= 5.5;
// Thickness of the internal arm in the 3-arm mount part
gopro_connector_th3_middle= 3.1;
// Thickness of the side arms in the 3-arm mount part
gopro_connector_th3_side= 2.7;
// Thickness of the arms in the 2-arm mount part
gopro_connector_th2= 3.04;
// The gap in the 3-arm mount part for the two-arm
gopro_connector_gap= 3.1;
// How round are the 2 and 3-arm parts
gopro_connector_roundness= 1;
// How thick are the mount walls
gopro_wall_th= 3;

gopro_connector_wall_tol=0.5+0;
gopro_tol=0.04+0;

// Can be queried from the outside
gopro_connector_z= 2*gopro_connector_th3_side+gopro_connector_th3_middle+2*gopro_connector_gap;
gopro_connector_x= gopro_connector_z;
gopro_connector_y= gopro_connector_z/2+gopro_wall_th;

// Bottom Width of GoPro Connector
w1 = gopro_connector_z;

rotate ([90, 0, 0])
    union ()
    {
        rotate ([0, 0, 90])
            translate ([-(h_connect + d_connect), 0, 0])
                difference ()
                {
                    hull ()
                    {
                        cylinder (d = d_connect, h = th_connect);
                        
                        translate ([h_connect + d_connect/2, 0, th_connect/2])
                            cube ([epsilon, w1, th_connect], center = true);
                    }
                    
                    translate ([0, 0, -epsilon])
                        cylinder (d = d_screw, h = th_connect + 2 * epsilon);
                    
                    translate ([0, 0, wall + epsilon])
                        cylinder (d = d_head, h = th_connect - wall + epsilon);
                }


        translate ([0, 0, gopro_connector_z/2])
            rotate ([0, -90, 180])
                gopro_connector();
    }



///////////////////////////////////////////////////////////////////////
//
// GoPro Hero mount and joint (gopro_mounts_mooncactus.scad) - Rev 1.03
//
///////////////////////////////////////////////////////////////////////
//
// CC-BY-NC 2013 jeremie.francois@gmail.com
// http://www.thingiverse.com/thing:62800
// http://betterprinter.blogspot.com
//




module gopro_connector()
{
    

    module gopro_torus(r,rnd)
    {
        translate([0,0,rnd/2])
            rotate_extrude(convexity= 10)
                translate([r-rnd/2, 0, 0])
                    circle(r= rnd/2, $fs=0.2);
    }

    module gopro_profile(th)
    {
        hull()
        {
            gopro_torus(r=gopro_connector_z/2, rnd=gopro_connector_roundness);
            translate([0,0,th-gopro_connector_roundness])
                gopro_torus(r=gopro_connector_z/2, rnd=gopro_connector_roundness);
            translate([-gopro_connector_z/2,gopro_connector_z/2,0])
                cube([gopro_connector_z,gopro_wall_th,th]);
        }
    }

    difference()
    {
        union()
        {
            {
                translate([0,0,-gopro_connector_th3_middle/2]) gopro_profile(gopro_connector_th3_middle);
                for(mz=[-1:2:+1]) scale([1,1,mz])
                    translate([0,0,gopro_connector_th3_middle/2 + gopro_connector_gap]) gopro_profile(gopro_connector_th3_side);
            }

            // add the common wall
            translate([0,gopro_connector_z/2+gopro_wall_th/2+gopro_connector_wall_tol,0])
                cube([gopro_connector_z,gopro_wall_th,gopro_connector_z], center=true);

            // add the optional nut emboss
            {
                translate([0,0,gopro_connector_z/2-gopro_tol])
                difference()
                {
                    cylinder(r1=gopro_connector_z/2-gopro_connector_roundness/2, r2=11.5/2, h=gopro_nut_h+gopro_tol);
                    cylinder(r=gopro_nut_d/2, h=gopro_connector_z/2+3.5+gopro_tol, $fn=6);
                }
            }
        }
        // remove the axis
        translate([0,0,-gopro_tol])
            cylinder(r=(gopro_holed_three)/2, h=gopro_connector_z+4*gopro_tol, center=true, $fs=1);
    }
}