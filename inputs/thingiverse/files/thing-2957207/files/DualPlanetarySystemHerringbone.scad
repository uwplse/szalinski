// OpenSCAD Dual Planetary System
// (c) 2018, tmackay
//
// Licensed under a Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0) license, http://creativecommons.org/licenses/by-sa/4.0.
//include <MCAD/involute_gears.scad> 

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
// Shaft diameter
shaft_d = 3;
// Slot width
slot_w = 2;
// Slot length
slot_l = 8;
// Number of planet gears in inner circle
inner_planets = 4;
// Number of planet gears in outer circle
outer_planets = 8;
// number of teeth to twist across
nTwist=1;
// Gear clearance
tol=0.15;
// pressure angle
P=45;//[30:60]
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

helix_angle=atan(PI*nTwist*cp/90/gear_h);

// center gear
rotate([0,0,180/drive_t*(1-planet_t%2)])
    drivegear(t1=drive_t);

// inner planets
planets(t1=planet_t, t2=drive_t,offset=(drive_t+planet_t)*cp/360,n=inner_planets,t=ring_t1+drive_t)
    planetgear(t1 = planet_t, bore=shaft_d);

// inner ring
gearring(t1=ring_t1, t2=ring_t2);

// outer planets
planets(t1=planet_t2, t2=ring_t2, offset=(ring_t2+planet_t2)*cp/360,n=outer_planets,t=case_t+ring_t2)
    planetgear(t1 = planet_t2, bore=shaft_d);

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

// Drive gear with slot
module drivegear(t1=13,reverse=false)
{
    difference()
    {
        planetgear(t1,!reverse);
        translate([-slot_w/2,-slot_l/2,-gear_h/2-TT])
            cube([slot_w,slot_l,gear_h+AT]);
        translate([-slot_l/2,-slot_w/2,-gear_h/2-TT])
            cube([slot_l,slot_w,gear_h+AT]);
    }
}

// reversible herringbone gear with bore hole
module planetgear(t1=13,reverse=false,bore=0)
{
    difference()
    {
        if (reverse) {
            mirror([0,1,0])
                herringbone(t1,PI*cp/180,P,1,tol,helix_angle,gear_h);
        } else {
            herringbone(t1,PI*cp/180,P,1,tol,helix_angle,gear_h);
        }
        translate([0,0,-gear_h/2-TT])
            cylinder(d=bore, h=gear_h+AT);
    }
}

// Space out planet gears approximately equally
module planets()
{
    for(i = [0:n-1])
    rotate([0,0,round(i*t/n)*360/t])
        translate([offset,0,0]) rotate([0,0,round(i*t/n)*360/t*t2/t1])
            children();
}

module gearring(t1=13,t2=51,reverse=false)
{
    difference() {
        rotate([0,0,180/ring_t2*(1-planet_t2%2)])
            planetgear(t1=t2,reverse=!reverse,b=0);
        planetgear(t1=t1,b=0,gear_h=gear_h+TT,tol=-tol);
        
	}
}

module gearcase(t1=13,teethtwist=1)
{
    difference() {
        translate([0,0,-gear_h/2])union()
        {
            cylinder(r=t1*cp/360+gear_h/2,h=gear_h);
            //shaft supports
            planets(t1=planet_t,t2=ring_t2,offset=t1*cp/360+gear_h/2,n=outer_planets,t=case_t+ring_t2)
                cylinder(d=3*shaft_d,h=gear_h);
        }
  		union()
		{
            planetgear(t1=t1,gear_h=gear_h+TT,tol=-tol);
            //shaftholes
            planets(t1=planet_t,t2=ring_t2,offset=t1*cp/360+gear_h/2,n=outer_planets,t=case_t+ring_t2)
                translate([0,0,-gear_h/2-TT])
                    cylinder(d=shaft_d,h=gear_h+AT);
		}
	}
}

// Herringbone gear code, taken from:
// Planetary gear bearing (customizable)
// https://www.thingiverse.com/thing:138222
// Captive Planetary Gear Set: parametric. by terrym is licensed under the Creative Commons - Attribution - Share Alike license.
module herringbone(
	number_of_teeth=15,
	circular_pitch=10,
	pressure_angle=28,
	depth_ratio=1,
	clearance=0,
	helix_angle=0,
	gear_thickness=5){
union(){
    translate([0,0,-TT])
	gear(number_of_teeth,
		circular_pitch,
		pressure_angle,
		depth_ratio,
		clearance,
		helix_angle,
		gear_thickness/2+TT);
	mirror([0,0,1]) translate([0,0,-TT])
		gear(number_of_teeth,
			circular_pitch,
			pressure_angle,
			depth_ratio,
			clearance,
			helix_angle,
			gear_thickness/2+TT);
}}

module gear (
	number_of_teeth=15,
	circular_pitch=10,
	pressure_angle=28,
	depth_ratio=1,
	clearance=0,
	helix_angle=0,
	gear_thickness=5,
	flat=false){
pitch_radius = number_of_teeth*circular_pitch/(2*PI);
twist=tan(helix_angle)*gear_thickness/pitch_radius*180/PI;

flat_extrude(h=gear_thickness,twist=twist,flat=flat)
	gear2D (
		number_of_teeth,
		circular_pitch,
		pressure_angle,
		depth_ratio,
		clearance);
}

module flat_extrude(h,twist,flat){
	if(flat==false)
		linear_extrude(height=h,twist=twist,slices=twist/6)children(0);
	else
		children(0);
}

module gear2D (
	number_of_teeth,
	circular_pitch,
	pressure_angle,
	depth_ratio,
	clearance){
pitch_radius = number_of_teeth*circular_pitch/(2*PI);
base_radius = pitch_radius*cos(pressure_angle);
depth=circular_pitch/(2*tan(pressure_angle));
outer_radius = clearance<0 ? pitch_radius+depth/2-clearance : pitch_radius+depth/2;
root_radius1 = pitch_radius-depth/2-clearance/2;
root_radius = (clearance<0 && root_radius1<base_radius) ? base_radius : root_radius1;
backlash_angle = clearance/(pitch_radius*cos(pressure_angle)) * 180 / PI;
half_thick_angle = 90/number_of_teeth - backlash_angle/2;
pitch_point = involute (base_radius, involute_intersect_angle (base_radius, pitch_radius));
pitch_angle = atan2 (pitch_point[1], pitch_point[0]);
min_radius = max (base_radius,root_radius);

intersection(){
	rotate(90/number_of_teeth)
		circle($fn=number_of_teeth*3,r=pitch_radius+depth_ratio*circular_pitch/2-clearance/2);
	union(){
		rotate(90/number_of_teeth)
			circle($fn=number_of_teeth*2,r=max(root_radius,pitch_radius-depth_ratio*circular_pitch/2-clearance/2));
		for (i = [1:number_of_teeth])rotate(i*360/number_of_teeth){
			halftooth (
				pitch_angle,
				base_radius,
				min_radius,
				outer_radius,
				half_thick_angle);		
			mirror([0,1])halftooth (
				pitch_angle,
				base_radius,
				min_radius,
				outer_radius,
				half_thick_angle);
		}
	}
}}

module halftooth (
	pitch_angle,
	base_radius,
	min_radius,
	outer_radius,
	half_thick_angle){
index=[0,1,2,3,4,5];
start_angle = max(involute_intersect_angle (base_radius, min_radius)-5,0);
stop_angle = involute_intersect_angle (base_radius, outer_radius);
angle=index*(stop_angle-start_angle)/index[len(index)-1];
p=[[0,0], // The more of these the smoother the involute shape of the teeth.
	involute(base_radius,angle[0]+start_angle),
	involute(base_radius,angle[1]+start_angle),
	involute(base_radius,angle[2]+start_angle),
	involute(base_radius,angle[3]+start_angle),
	involute(base_radius,angle[4]+start_angle),
	involute(base_radius,angle[5]+start_angle)];

difference(){
	rotate(-pitch_angle-half_thick_angle)polygon(points=p);
	square(2*outer_radius);
}}

// Mathematical Functions
//===============

// Finds the angle of the involute about the base radius at the given distance (radius) from it's center.
//source: http://www.mathhelpforum.com/math-help/geometry/136011-circle-involute-solving-y-any-given-x.html

function involute_intersect_angle (base_radius, radius) = sqrt (pow (radius/base_radius, 2) - 1) * 180 / PI;

// Calculate the involute position for a given base radius and involute angle.

function involute (base_radius, involute_angle) =
[
	base_radius*(cos (involute_angle) + involute_angle*PI/180*sin (involute_angle)),
	base_radius*(sin (involute_angle) - involute_angle*PI/180*cos (involute_angle))
];
