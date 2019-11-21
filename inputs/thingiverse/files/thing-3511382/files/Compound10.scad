// OpenSCAD Compound Planetary System
// (c) 2019, tmackay
//
// Licensed under a Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0) license, http://creativecommons.org/licenses/by-sa/4.0.
//include <MCAD/involute_gears.scad> 

// Modules, planetary layers
modules = 2; //[2:1:3]
// Height of planetary layers (drive stage)
gear_h = 7.5;
// Height of planetary layers (output stage)
gear_h2 = 7.5;
// Circular pitch: Length of the arc from one tooth to the next
cp = 245;
// Number of teeth in inner planet gears
planet_t = 13; //[10:1:20]
planet_t2 = 15; //[10:1:20]
// Number of teeth in ring gears
ring_t1 = 38; //[30:1:90]
ring_t2 = 45; //[30:1:90]
// Sun gear multiplier
sgm = 1; //[1:1:5]
// Shaft diameter
shaft_d = 10;
// secondary shafts (for larger sun gears)
shafts = 6;
// Outer diameter
outer_d = 60;
// Outer teeth
outer_t = 0;
// Width of outer teeth
outer_w=3;
// Wall thickness
wall = 0;
// Slot width
slot_w = 0;
// Slot length
slot_l = 0;
// Number of planet gears in inner circle
planets = 3; //[3:1:21]
// number of teeth to twist across
nTwist=1;
// Gear depth ratio
depth_ratio=1;
// Gear clearance
tol=0.2;
// pressure angle
P=45; //[30:60]
// Curve resolution settings, minimum angle
$fa = 5;
// Curve resolution settings, minimum size
$fs = 1;
// Layer height (for ring horizontal split)
layer_h = 0.2;

// For fused sun gears, we require them to be a multiple of the planet teeth
drive_t = planet_t*sgm;
drive_t2 = planet_t2*sgm;

if ((drive_t+ring_t1)%planets)
{
    echo(str("Warning: For even spacing, planets must divide ", drive_t+ring_t1));
}
if ((drive_t2+ring_t2)%planets)
{
    echo(str("Warning: For even spacing (2), planets must divide ", drive_t2+ring_t2));
}

if (drive_t + 2*planet_t != ring_t1) {
    echo(str("Teeth fewer than ideal (ring1): ", drive_t+2*planet_t-ring_t1));
}
if (drive_t2 + 2*planet_t2 != ring_t2) {
    echo(str("Teeth fewer than ideal (ring2): ", drive_t2+2*planet_t2-ring_t2));
}

// Planetary gear ratio for fixed ring: 1:1+R/S
echo(str("Gear ratio of first planetary stage: 1:", 1+ring_t1/drive_t)); // eg. 1:3.1818...

// (Planet/Ring interaction: Nr*wr-Np*wp=(Nr-Np)*wc)
// one revolution of carrier (wc=1) turns planets on their axis
// wp = (Np-Nr)/Np = eg. (10-31)/10=-2.1 turns
// Secondary Planet/Ring interaction
// wr = ((Nr-Np)+Np*wp)/Nr = eg. ((34-11)-11*2.1)/34 = 1/340
// or Nr2/((Nr2-Np2)+Np2*(Np1-Nr1)/Np1)
echo(str("Gear ratio of planet/ring stage: 1:", abs(ring_t2/((ring_t2-planet_t2)+planet_t2*(planet_t-ring_t1)/planet_t)))); // eg. 3.8181..

// Final gear ratio is product of above, eg. 1:1298.18..
echo(str("Input/Output gear ratio: 1:",abs((1+ring_t1/drive_t)*ring_t2/((ring_t2-planet_t2)+planet_t2*(planet_t-ring_t1)/planet_t))));

// what ring should be for teeth to mesh without additional scaling
ring_t1_n = drive_t+2*planet_t; 
ring_t2_n = drive_t2+2*planet_t2;

// Coincident planet offsets
cp2=(drive_t+planet_t)*cp/(drive_t2+planet_t2);

// Tolerances for geometry connections.
AT=0.02;
ST=AT*2;
TT=AT/2;

helix_angle=atan(PI*nTwist*cp/90/gear_h);
helix_angle2=atan(PI*nTwist*cp2/90/gear_h);

// center gears
rotate([0,0,180/drive_t*(1-planet_t%2)])
    drivegear(t1=drive_t,bore=shaft_d,rot=180/drive_t*(1-planet_t%2));
translate([0,0,gear_h-TT])intersection(){
    rotate([0,0,180/drive_t2*(1-planet_t2%2)])
        drivegear(t1=drive_t2,bore=shaft_d,cp=cp2,helix_angle=helix_angle2,gear_h=gear_h2,rot=180/drive_t2*(1-planet_t2%2));
    rotate([0,0,180/drive_t*(1-planet_t%2)])
        linear_extrude(height=gear_h2,scale=1+gear_h2/(drive_t*cp/360)*sqrt(3),slices=1)
            gear2D(drive_t,cp*PI/180,P,depth_ratio,tol);
}
if(modules==3)translate([0,0,gear_h+gear_h2-AT])intersection(){
    rotate([0,0,180/drive_t*(1-planet_t%2)])
        drivegear(t1=drive_t,bore=shaft_d,rot=180/drive_t*(1-planet_t%2));
    rotate([0,0,180/drive_t2*(1-planet_t2%2)])
        linear_extrude(height=gear_h,scale=1+gear_h/(drive_t2*cp2/360)*sqrt(3),slices=1)
            gear2D(drive_t2,cp2*PI/180,P,depth_ratio,tol);
}

// planets
planets(t1=planet_t, t2=drive_t,offset=(drive_t+planet_t)*cp/360,n=planets,t=ring_t1+drive_t)
    planetgear(t1 = planet_t, bore=shaft_d);

translate([0,0,gear_h-TT])
    planets(t1=planet_t2, t2=drive_t2,offset=(drive_t2+planet_t2)*cp2/360,n=planets,t=ring_t2+drive_t2)
        intersection(){
            planetgear(t1 = planet_t2, bore=shaft_d,cp=cp2,helix_angle=helix_angle2,gear_h=gear_h2);
            linear_extrude(height=gear_h2,scale=1+gear_h2/(planet_t*cp/360)*sqrt(3),slices=1)
                    gear2D(planet_t,cp*PI/180,P,depth_ratio,tol);
        }
if(modules==3)translate([0,0,gear_h+gear_h2-AT])
    planets(t1=planet_t, t2=drive_t,offset=(drive_t+planet_t)*cp/360,n=planets,t=ring_t1+drive_t)
        intersection(){
            planetgear(t1 = planet_t, bore=shaft_d);
            linear_extrude(height=gear_h,scale=1+gear_h/(planet_t2*cp2/360)*sqrt(3),slices=1)
                    gear2D(planet_t2,cp2*PI/180,P,depth_ratio,tol);
        }

// rings
s1=ring_t1_n/ring_t1;
s2=ring_t2_n/ring_t2;
ha1=atan(PI*nTwist*s1*cp/90/gear_h); // not sure about this, seems close enough.
ha2=atan(PI*nTwist*s2*cp2/90/gear_h);
gearcase(t1=ring_t1,bore=outer_d/2,cp=s1*cp,helix_angle=ha1);
translate([0,0,gear_h-TT])
    difference(){
        gearcase(t1=ring_t2,bore=outer_d/2,cp=s2*cp2,helix_angle=ha2,gear_h=gear_h2);
        linear_extrude(height=(ring_t1*s1*cp/360)/sqrt(3),scale=0,slices=1)
            hull()gear2D(ring_t1,s1*cp*PI/180,P,depth_ratio,-tol);
        translate([-outer_d,-outer_d,-TT])cube([2*outer_d,2*outer_d,layer_h+AT]);
    }
if(modules==3)translate([0,0,gear_h+gear_h2-AT])
    difference(){
        gearcase(t1=ring_t1,bore=outer_d/2,cp=s1*cp,helix_angle=ha1);
        linear_extrude(height=(ring_t2*s2*cp2/360)/sqrt(3),scale=0,slices=1)
            hull()gear2D(ring_t2,s2*cp2*PI/180,P,depth_ratio,-tol);
        translate([-outer_d,-outer_d,-TT])cube([2*outer_d,2*outer_d,layer_h+AT]);
    }

// Drive gear with slot
module drivegear(t1=13,reverse=false,bore=2*cos(P)*13*cp/360-wall,rot=0)
{
    planetgear(t1,!reverse,bore,cp=cp,helix_angle=helix_angle,gear_h=gear_h,rot=rot);
}

// reversible herringbone gear with bore hole
module planetgear(t1=13,reverse=false,bore=0,rot=0)
{
    difference()
    {
        translate([0,0,gear_h/2])
        if (reverse) {
            mirror([0,1,0])
                herringbone(t1,PI*cp/180,P,depth_ratio,tol,helix_angle,gear_h);
        } else {
            herringbone(t1,PI*cp/180,P,depth_ratio,tol,helix_angle,gear_h);
        }
        
        translate([0,0,-TT]){
            rotate([0,0,-rot])
                cylinder(d=bore, h=2*gear_h+AT);
            // Extra speed holes, for strength
            if(bore>0 && bore/4+(t1-2*tan(P))*cp/720>bore)
                for(i = [0:360/shafts:360-360/shafts])rotate([0,0,i-rot])
                    translate([bore/4+(t1-2*tan(P))*cp/720,0,-AT])
                        cylinder(d=bore,h=2*gear_h+AT);
        }
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

module gearcase(t1=13,teethtwist=1,bore=18*cp/360)
{
    difference() {
        cylinder(r=bore,h=gear_h);
        translate([0,0,-TT])planetgear(t1=t1,gear_h=gear_h+AT,tol=-tol,helix_angle=helix_angle,cp=cp,depth_ratio=depth_ratio,P=P);
	}
            // outer notches
        if(outer_t>0)for(i = [0:360/outer_t:360-360/outer_t])rotate([0,0,i])
            translate([outer_d/2,0,-AT])rotate([0,0,45])
                cylinder(d=outer_w,h=gear_h+AT,$fn=4);

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
		linear_extrude(height=h,twist=twist,slices=6)children(0);
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