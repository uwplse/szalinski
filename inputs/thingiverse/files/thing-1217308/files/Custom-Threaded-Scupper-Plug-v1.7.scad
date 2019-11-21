//////////////////////////////////////////////////////////////////////
// Project: Custom Threaded scupper plugs for Pelican kayak         //
// Purpose: Stop me from getting a wet butt.                        //
// Add attachements in the future.                                  //
// Author: infinigrove Squirrel Master                              //
// Date: 23 December 2015    v1.3                                   //
//////////////////////////////////////////////////////////////////////

// Printing:
// Set to 10% to 20% infill with minimal material so they float!

// ---------------------------------------------------------------- //
// ------------------ BEGIN USER SERVICABLE CODE ------------------ //
// ---------------------------------------------------------------- //

//   !!!! NOTE: DIMENSIONS ARE METRIC AND IN MILIMETERS !!!!   //

// Length of scupper plug
plug_length = 32;

plug_detail = 40; //[40:360]

thread_detail = 2; //[2:8]

// Diameter of the top of plug
top_diameter = 26;

top_style = "bolt"; //[bolt,nut,hook,flat,pole_holder]

top_base_bevel = "no"; //[yes,no]

top_thread_length = 15;
top_thread_diameter = 22;
top_thread_pitch = 4; //[2:6]

// Diameter of bottom of plug
bottom_diameter = 38;

// Which end would you like? (bottom)
bottom_style = "slot"; //[slot,bolt,nut,hook,gopro,flat,scoop]

bottom_base_bevel = "no"; //[yes,no]

/* [bottom slot] */

slot_size = 2; // [1:10]

/* [bottom bolt nut] */

bottom_thread_length = 47;
bottom_thread_diameter = 18;
bottom_thread_pitch = 4; //[2:6]

/* [Top Pole Holder EXPERIMENTAL] */

pole_holder_length = 115;
pole_holder_outer_diameter = 40;
pole_holder_inner_diameter = 28;
pole_holder_base_diameter = 80;

/* [GoPro Connector EXPERIMENTAL] */

gopro_style="triple_nut"; // [triple_nut,triple,double]
gopro_base_height = 48;


/* [Hidden] */

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

gopro_connector_wall_tol=1.1+0;
gopro_tol=0.04+0;

// Can be queried from the outside
gopro_connector_z= 2*gopro_connector_th3_side+gopro_connector_th3_middle+2*gopro_connector_gap;
gopro_connector_x= gopro_connector_z;
gopro_connector_y= gopro_connector_z/2+gopro_wall_th;
// ---------------------------------------------------------------- //
// ------------------- END USER SERVICABLE CODE ------------------- //
module plug_torus(r,rnd)
{
	translate([0,0,rnd/2])
		rotate_extrude(convexity= 10, $fn=plug_detail)
			translate([r-rnd/2, 0, 0])
				circle(r= rnd/2, $fs=0.2);
}
// ---------------------------------------------------------------- //
// --- screw thread modules --------------------------------------- //
/*    Minimal thread modules hacked from
 *    polyScrewThread.scad    by aubenc @ Thingiverse
 *
 * This script contains the library modules that can be used to 
 * generate screw and nut threads.
 *
 * http://www.thingiverse.com/thing:8796
 *
 * CC Public Domain
 */
// --- modules added for use with thingverse cusomizer ------------ //
// ---------------------------------------------------------------- //
module screw_thread(od,st,lf0,lt,rs,cs)
{
    or=od/2;
    ir=or-st/2*cos(lf0)/sin(lf0);
    pf=2*PI*or;
    sn=floor(pf/rs);
    lfxy=360/sn;
    ttn=round(lt/st)+1;
    zt=st/sn;

    intersection()
    {
        if (cs >= -1)
        {
           # thread_shape(cs,lt,or,ir,sn,st);
        }

        full_thread(ttn,st,sn,zt,lfxy,or,ir);
    }
}

module thread_shape(cs,lt,or,ir,sn,st)
{
    if ( cs == 0 )
    {
        cylinder(h=lt, r=or, $fn=sn, center=false);
    }
    else
    {
        union()
        {
            translate([0,0,st/2])
              cylinder(h=lt-st+0.005, r=or, $fn=sn, center=false);

            if ( cs == -1 || cs == 2 )
            {
                cylinder(h=st/2, r1=ir, r2=or, $fn=sn, center=false);
            }
            else
            {
                cylinder(h=st/2, r=or, $fn=sn, center=false);
            }

            translate([0,0,lt-st/2])
            if ( cs == 1 || cs == 2 )
            {
                  cylinder(h=st/2, r1=or, r2=ir, $fn=sn, center=false);
            }
            else
            {
                cylinder(h=st/2, r=or, $fn=sn, center=false);
            }
        }
    }
}

module full_thread(ttn,st,sn,zt,lfxy,or,ir)
{
    for(i=[0:ttn-1])
    {
        for(j=[0:sn-1])
        {
            polyhedron(
                  points=[
                          [0,                  0,                  i*st-st            ],
                          [ir*cos((j+1)*lfxy), ir*sin((j+1)*lfxy), i*st+(j+1)*zt-st   ],
                          [ir*cos(j*lfxy),     ir*sin(j*lfxy),     i*st+j*zt-st       ],
                          [or*cos((j+1)*lfxy), or*sin((j+1)*lfxy), i*st+(j+1)*zt-st/2 ],
                          [or*cos(j*lfxy),     or*sin(j*lfxy),     i*st+j*zt-st/2     ],
                          [0,                  0,                  i*st+st            ],
                          [ir*cos((j+1)*lfxy), ir*sin((j+1)*lfxy), i*st+(j+1)*zt      ],
                          [ir*cos(j*lfxy),     ir*sin(j*lfxy),     i*st+j*zt          ]
                         ],
               triangles=[
                          [0,1,2],
                          [5,6,3],[5,3,0],[0,3,1],
                          [3,4,1],[1,4,2],
                          [3,6,4],[4,6,7],
                          [0,2,4],[0,4,5],[5,4,7],
                          [5,7,6]
                         ],
               convexity=5);
        }
    }
}
//GoPro connector module hacked from
// gopro_mounts_mooncactus.scad by MoonCactus
// http://www.thingiverse.com/thing:62800
module gopro_torus(r,rnd)
{
	translate([0,0,rnd/2])
		rotate_extrude(convexity= 10, $fn=plug_detail/2)
			translate([r-rnd/2, 0, 0])
				circle(r= rnd/2, $fs=0.2);
}


module gopro_connector(version="double", withnut=true, captive_nut_th=0, captive_nut_od=0, captive_rod_id=0, captive_nut_angle=0)
{
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
			if(version=="double")
			{
				for(mz=[-1:2:+1]) scale([1,1,mz])
						translate([0,0,gopro_connector_th3_middle/2 + (gopro_connector_gap-gopro_connector_th2)/2]) gopro_profile(gopro_connector_th2);
			}
			if(version=="triple")
			{
				translate([0,0,-gopro_connector_th3_middle/2]) gopro_profile(gopro_connector_th3_middle);
				for(mz=[-1:2:+1]) scale([1,1,mz])
					translate([0,0,gopro_connector_th3_middle/2 + gopro_connector_gap]) gopro_profile(gopro_connector_th3_side);
			}

			// add the common wall
			//translate([0,gopro_connector_z/2+gopro_wall_th/2+gopro_connector_wall_tol,0])
				//cube([gopro_connector_z,gopro_wall_th,gopro_connector_z], center=true);
            translate([0,(gopro_connector_z/2+gopro_wall_th/2+gopro_connector_wall_tol)+gopro_base_height,0]) rotate([90,0,0]) cylinder(h=gopro_base_height,d1=bottom_diameter,d2=gopro_connector_z*1.5,$fn=plug_detail);

			// add the optional nut emboss
			if(version=="triple" && withnut)
			{
				translate([0,0,gopro_connector_z/2-gopro_tol])
				difference()
				{
					cylinder(r1=gopro_connector_z/2-gopro_connector_roundness/2, r2=11.5/2, h=gopro_nut_h+gopro_tol, $fn=plug_detail /2);
					cylinder(r=gopro_nut_d/2, h=gopro_connector_z/2+3.5+gopro_tol, $fn=6);
				}
			}
		}
		// remove the axis
		translate([0,0,-gopro_tol])
			cylinder(r=(version=="double" ? gopro_holed_two : gopro_holed_three)/2, h=gopro_connector_z+4*gopro_tol, center=true, $fn=plug_detail /2);
	}
}

// ---------------------------------------------------------------- //
// --- render a custom threaded scupper plug ---------------------- //
// ---             MAIN CODE                 ---------------------- //
// ---------------------------------------------------------------- //
/*    Partially hacked and major additions from
 *    Glide_Kayak_Scuppers_-_Mahi_rev2.scad    by Max Bainrot 
 *
 * http://www.thingiverse.com/thing:951903
 *
 */
// ---------------------------------------------------------------- //
// ------- can be thanked for hook scupper end -------------------- //
// ---------------------------------------------------------------- //
PI=3.141592;
translate([0,0,plug_length])
rotate([0,180,0])
difference()
{
    union()
    {
        cylinder(h=(plug_length), r1=(top_diameter/2), r2=(bottom_diameter /2),$fn=plug_detail);
        
        // GoPro connector
        if (bottom_style == "gopro") 
        {
            if (gopro_style == "double") translate([0,0,plug_length+10+gopro_base_height])  rotate([270,0,0]) gopro_connector("double");
            if (gopro_style == "triple") translate([0,0,plug_length+10+gopro_base_height])  rotate([270,0,0]) gopro_connector("triple", withnut=false);
            if (gopro_style == "triple_nut") translate([0,0,plug_length+10+gopro_base_height])  rotate([270,0,0]) gopro_connector("triple", withnut=true);
        }  
        // scoop connector
        if (bottom_style == "scoop") translate([0,0,plug_length]) sphere(d=bottom_diameter, $fn=plug_detail);;
        
        // pole holder base
        if (top_style == "pole_holder") translate([0,0,-(pole_holder_outer_diameter /3)]) cylinder( h=pole_holder_outer_diameter /3,   d1=pole_holder_outer_diameter,    d2=pole_holder_base_diameter, $fn=plug_detail);
        
        if (top_style == "bolt") translate([0,0,-(top_thread_length)]) screw_thread(top_thread_diameter,top_thread_pitch,55,top_thread_length,PI/thread_detail,2);
            
        if (bottom_style == "bolt") translate([0,0,plug_length]) screw_thread(bottom_thread_diameter,bottom_thread_pitch,55,bottom_thread_length,PI/thread_detail,2);
            
        if (top_style == "hook") translate([0,(top_diameter /8),0]) rotate([90,0,0]) cylinder(d=top_diameter - 3,h=top_diameter /4,$fn=plug_detail);
        
        if (bottom_style == "hook") translate([0,(bottom_diameter /8),plug_length]) rotate([90,0,0]) cylinder(d=bottom_diameter - 3,h=bottom_diameter /4,$fn=plug_detail);
            
        if (bottom_base_bevel == "yes") translate([0,0,plug_length-(gopro_connector_roundness/1.4)]) plug_torus(r=bottom_diameter/2, rnd=gopro_connector_roundness);
            
        if (top_base_bevel == "yes") translate([0,0,-(gopro_connector_roundness/1.4)]) plug_torus(r=top_diameter/2, rnd=gopro_connector_roundness);
            
    }
    if (top_style == "hook") translate([0,0,0]) sphere(d=top_diameter /1.5, $fn=plug_detail);
        
    if (bottom_style == "hook") translate([0,0,plug_length]) sphere(d=bottom_diameter /1.5, $fn=plug_detail);
    
    if (top_style == "nut") screw_thread(top_thread_diameter,top_thread_pitch,55,top_thread_length,PI/thread_detail,0);
        
    if (bottom_style == "nut") translate([0,0,(plug_length - bottom_thread_length)]) screw_thread(bottom_thread_diameter,bottom_thread_pitch,55,bottom_thread_length,PI/thread_detail,0);
    
    if (bottom_style == "slot") translate([-(bottom_diameter /2),-(slot_size /2),(plug_length - slot_size)]) cube([bottom_diameter,slot_size,slot_size+gopro_connector_roundness]);
        
    
        
    if (bottom_style == "scoop") translate([0,0,plug_length]) 
    {
        //remove half with block and scoop out whats left
        translate([-(bottom_diameter /2), 0, 0])cube([bottom_diameter,bottom_diameter,bottom_diameter]);
        sphere(d=bottom_diameter - 4, $fn=plug_detail);
        //remove cylinder in plug
        translate([0,0,-plug_length]) cylinder(h=plug_length, d1=(top_diameter - 4), d2=(bottom_diameter - 4), $fn=plug_detail);
        
        //remove cylinder in top_bolt
        translate([0,0,-(plug_length + top_thread_length)]) cylinder(h=top_thread_length, d1=(top_thread_diameter - top_thread_pitch), d2=(top_thread_diameter - top_thread_pitch), $fn=plug_detail);
        
        //translate([0,0,-(plug_length + top_thread_length)]) cylinder(h=(plug_length + top_thread_length), d1=(bottom_thread_diameter - bottom_thread_pitch), d2=(bottom_diameter - 4), $fn=plug_detail);
        
    }
}

// pole holder main cylinder
if (top_style == "pole_holder") 
{
    // you may need to tweek this traslate depending on size of pole holder
    translate([(pole_holder_outer_diameter/1.1),0,(plug_length + pole_holder_length)*.98]) 
    rotate([0,200,0])
    difference()
    {
        union()
        {
            // pole holder outer
            cylinder(h=pole_holder_length, d=pole_holder_outer_diameter,$fn=plug_detail);
    
        }
        
        // pole holder inner
        cylinder(h=(pole_holder_length - (pole_holder_outer_diameter - pole_holder_inner_diameter)), d=pole_holder_inner_diameter,$fn=plug_detail);
    }
}
