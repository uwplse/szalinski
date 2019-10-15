// OpenSCAD Dual Planetary System
// (c) 2018, tmackay
//
// Licensed under a Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0) license, http://creativecommons.org/licenses/by-sa/4.0.
include <MCAD/involute_gears.scad> 

// Overall height
gear_h = 10;
// Circular pitch: Length of the arc from one tooth to the next
cp = 360;
// Number of teeth in central drive gear
drive_t = 7;
// Number of teeth in inner planet gears
planet_t = 7;
// Number of teeth in outer planet gears
planet_t2 = 6;
// Extra teeth in ring, determines thickness of inner ring
ring_t = 5;
// Scale the planet gears for clearance if printed too close
gear_scale = 1;
// Shaft diameter
shaft_d = 3;
// Number of planet gears in inner circle
inner_planets = 4;
// Number of planet gears in outer circle
outer_planets = 8;
// Clearance
clearance = 0.2;
// Backlash applied to planet and drive gears for rotational clearance
backlash = 0.2;
// Backlash applied to ring gear for rotational clearance
backlash_r = 1;
// Backlash applied to negative ring gears for rotational clearance
backlash_n = 1;

// Curve resolution settings, minimum angle
$fa = 5;
// Curve resolution settings, minimum size
$fs = 1;

ring_t1 = drive_t+2*planet_t;
ring_t2 = ring_t1 + ring_t;
case_t = ring_t2 + 2*planet_t2;

// Tolerances for geometry connections.
AT=0.02;
ST=AT*2;
TT=AT/2;

module planetgear(t1=13,teethtwist=1,b=0,s=1,cl=clearance,bl=backlash)
{
	g1twist = 360 * teethtwist / t1;
	union()
	{
		translate([0,0,(gear_h/2) - TT])
			gear(twist = -g1twist, 
				number_of_teeth=t1, 
				circular_pitch=cp*s, 
				gear_thickness = (gear_h/2)+AT, 
				rim_thickness = (gear_h/2)+AT, 
				rim_width = 0,
				hub_thickness = (gear_h/2)+AT, 
				hub_width = 0,
				bore_diameter=b,
                clearance=cl,
                backlash=bl); 
		translate([0,0,(gear_h/2) + TT]) rotate([180,0,0]) 
			gear(twist = g1twist, 
				number_of_teeth=t1, 
				circular_pitch=cp*s, 
				gear_thickness = (gear_h/2)+AT, 
				rim_thickness = (gear_h/2)+AT, 
				hub_thickness = (gear_h/2)+AT, 
				bore_diameter=b,
                clearance=cl,
                backlash=bl); 
	}
}

module planets()
{
    for(i = [0:n-1])
    rotate([0,0,round(i*t/n)*360/t])
        translate([offset,0,0]) rotate([0,0,round(i*t/n)*360/t*t2/t1])
            children();
}

module drivegear(t1=13,teethtwist=1)
{
    difference()
    {
        planetgear(t1,teethtwist);
        translate([-1,-3,-AT])
            cube([2,6,gear_h+ST]);
    }
}

module gearring(t1=13,t2=51,teethtwist=1)
{
    difference() {
        rotate([0,0,180/ring_t2*(1-planet_t2%2)])
            planetgear(t1=t2,teethtwist=-teethtwist,b=0,bl=backlash_r);
        planetgear(t1=t1,b=0,TT=AT,AT=ST, bl=-backlash_n, cl=0, s=1+360*clearance/t1/cp);
	}
}

module gearcase(t1=13,teethtwist=1)
{
    difference() {
        union()
        {
            cylinder(r=t1*cp/360+gear_h/2, h=gear_h);
            //shaft supports
            planets(t1=planet_t, t2=ring_t2, offset=t1*cp/360+gear_h/2,n=outer_planets,t=case_t+ring_t2)
                cylinder(d=3*shaft_d, h=gear_h);
        }
  		union()
		{
            planetgear(t1=t1,b=0,TT=AT,AT=ST,bl=-backlash_n,cl=0,s=1+360*clearance/t1/cp);
            //shaftholes
            planets(t1=planet_t, t2=ring_t2, offset=t1*cp/360+gear_h/2,n=outer_planets,t=case_t+ring_t2)
                translate([0,0,-TT])
                    cylinder(d=shaft_d, h=gear_h+ST);
		}
	}
}

// center gear
rotate([0,0,180/drive_t*(1-planet_t%2)])
    drivegear(t1 = drive_t, teethtwist=-1);

// inner planets
planets(t1=planet_t, t2=drive_t,offset=(drive_t+planet_t)*cp/360,n=inner_planets,t=ring_t1+drive_t)
    planetgear(t1 = planet_t, b=shaft_d, s=gear_scale);

// inner ring
gearring(t1=ring_t1, t2=ring_t2);

// outer planets
planets(t1=planet_t2, t2=ring_t2, offset=(ring_t2+planet_t2)*cp/360,n=outer_planets,t=case_t+ring_t2)
    planetgear(t1 = planet_t2, b=shaft_d, s=gear_scale);

// outer ring
gearcase(t1=case_t);

if ((drive_t+ring_t1)%inner_planets)
{
    echo(str("For even spacing, inner_planets must divide ", drive_t+ring_t1));
}
if ((ring_t2+case_t)%outer_planets)
{
    echo(str("For even spacing, outer_planets must divide ", ring_t2+case_t));
}
