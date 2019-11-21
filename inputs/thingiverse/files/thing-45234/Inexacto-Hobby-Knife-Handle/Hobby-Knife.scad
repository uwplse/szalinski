/*
 * Hobby Knife.scad:  A 3D printable hobby knife handle
 * 
 * Written by Steven Morlock, smorloc@gmail.com
 *
 * This script is licensed under the Creative Commons Attribution - Share Alike license:
 *     http://creativecommons.org/licenses/by-sa/3.0/
 *
 * This work is derived from the following existing projects found on Thingiverse:
 *
 *     Knurled Surface Library v2, by aubenc:
 *         http://www.thingiverse.com/thing:32122
 *
 *     Poor man's openscad screw library, by aubenc:
 *         http://www.thingiverse.com/thing:8796
 *
 *     Write.scad, by HarlanDMii:
 *         http://www.thingiverse.com/thing:16193
 *
 */
  
use <polyScrewThread.scad>
use <knurledFinishLib_v2.scad>
use <write/Write.scad>

PI = 3.141592;

// Uncomment what you are working on:
//knife_holder();
//knife_handle();
//knife_sleeve();
knife_exploded_view();

//
// Handle parameters
//
screw_diameter = 7.3;
screw_step = 2;
screw_degrees = 55;
screw_length = 10.3;
screw_countersink = -1;     // -1 - Bottom (countersink'd and top flat)

handle_diameter = 11.3;
handle_length = 100;
handle_thread_length = screw_length * 1.5;

//
// Sleeve parameters
//
sleeve_height = 20;
sleeve_inside_diameter = 9.2;
sleeve_flange_height = 2;
sleeve_flange_diameter = screw_diameter + 0.75;

//
// Holder parameters
//
slit_width = 0.8;
slit_height = 21.0;
total_height = 22.0;
shank_height = 12.0;		// distance from bottom to start of flare
dia_bottom = 7.3;
dia_flare = 10.7;

module knife_sleeve()
{
    difference()
    {
        knurl(k_cyl_hg = sleeve_height,
                k_cyl_od = handle_diameter,
                knurl_wd =  2.0,
                knurl_hg =  3.0,
                knurl_dp = 1.0,                
                s_smooth = 50);
        translate([0,0,sleeve_flange_height])
        cylinder(h=sleeve_height, 
                r1=sleeve_inside_diameter / 2, 
                r2=sleeve_inside_diameter / 2,
                $fn=200, 
                center=false);
        cylinder(h=sleeve_height, 
                r1=sleeve_flange_diameter / 2, 
                r2=sleeve_flange_diameter / 2,
                $fn=200, 
                center=false);
    }
}
module knife_handle()
{
    // The sloppier your print, the more fudge you may need 
    // in order to get the holder to screw into the handle.
    thread_fudge = 0.5;
    
    difference()
    {
        // Body
        cylinder(h=handle_length, 
                r1=handle_diameter / 2, 
                r2=handle_diameter / 2,
                $fn=200, 
                center=false);

        // Countersink
        translate([0,0,handle_length - screw_step / 2 + 0.1])
        cylinder(h=screw_step / 2 + 0.01, 
                r1=screw_diameter / 2 - screw_step / 2,
                r2=screw_diameter / 2, 
                $fn=200, 
                center=false);

        // Thread
        translate([0, 0, handle_length-handle_thread_length])
        screw_thread(screw_diameter + thread_fudge,
                screw_step,
                screw_degrees,
                handle_thread_length,
                PI/2,
                -2);

        writecylinder("Inexacto",
            [0,0,0],
            radius = handle_diameter / 2,
            height = handle_length,
            rotate = -90,
            font = "orbitron.dxf",
            space =1.2,
            h = 4.5,
            t = 2);
        writecylinder("Inexacto",
            [0,0,0],
            radius = handle_diameter / 2,
            height = handle_length,
            east = 180,
            rotate = -90,
            font = "orbitron.dxf",
            space =1.2,
            h = 4.5,
            t = 2);
    }
}

module knife_holder()
{
    relief = 0.3;

    union()
    {
        screw_thread(screw_diameter,
                screw_step,
                screw_degrees,
                screw_length,
                PI / 2,
                screw_countersink);

        translate([0, 0, screw_length])
        intersection()
        {
            difference()
            {
                knife_holder_body();
                knife_holder_slit();
            }
            
            // Knock off the sharp edge on the top of the holder
            union()
            {
                cylinder(h = total_height - relief,
                        r = dia_flare / 2 - relief,
                        $fn = dia_flare * PI,
                        center = false);
                translate([0, 0, total_height - relief])
                cylinder(h = relief,
                        r1 = dia_flare / 2 - relief,
                        r2 = dia_flare / 2 - relief * 2,
                        $fn = dia_flare * PI,
                        center = false);
            }
        }
    }
}

module knife_holder_body()
{
    union()
    {
        // Bottom
        cylinder(h = total_height, 
                r = dia_bottom / 2,
                $fn = dia_bottom * PI,
                center = false);

        // Bottom of flare to top
        translate([0, 0, shank_height])
        cylinder(h = total_height - shank_height,
                r1 = dia_bottom / 2,
                r2 = dia_flare / 2,
                $fn = dia_bottom * PI,
                center = false);
    }
}

module knife_holder_slit()
{
    margin = 2;
    
    dia = dia_flare + margin;

    translate([-dia/2, -slit_width/2, total_height - slit_height])
    cube(size=[dia, slit_width, slit_height + margin], center=false);
}

module knife_exploded_view()
{
    // Good for Thingiverse generated 3D view...
    space = 5;
    rotate([60, 60, 0])
    {
        rotate([0, 0, -45])
        knife_handle();
        translate([0, 0, handle_length + space])
        knife_sleeve();
        translate([0, 0, handle_length + space + sleeve_height + space])
        rotate([0, 0, 45])
        knife_holder();
    }
}
