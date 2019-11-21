// OpenSCAD Compound Planetary System
// (c) 2019, tmackay
//
// Licensed under a Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0) license, http://creativecommons.org/licenses/by-sa/4.0.
//include <MCAD/involute_gears.scad> 

// Modules, planetary layers
modules = 3; //[2:1:3]
// Height of planetary layers (drive stage)
gear_h = 7.5; //[5:0.5:100]
// Height of planetary layers (output stage)
gear_h2 = 15; //[5:0.5:200]
// Number of teeth in inner planet gears
planet_t = 10; //[10:1:20]
planet_t2 = 14; //[10:1:20]
// Number of teeth in ring gears
ring_t1 = 30; //[30:1:90]
ring_t2 = 41; //[30:1:90]
// Sun gear multiplier
sgm = 1; //[1:1:5]
// Shaft diameter
shaft_d = 8; //[0:0.1:25]
// secondary shafts (for larger sun gears)
shafts = 6; //[0:1:12]
// Outer diameter
outer_d = 60; //[30:300]
// Outer teeth
outer_t = 0; //[0:1:24]
// Width of outer teeth
outer_w=3; //[0:0.1:10]
// Ring wall thickness (relative pitch radius)
wall = 5; //[0:0.1:20]
// Number of planet gears in inner circle
planets = 5; //[3:1:21]
// number of teeth to twist across
nTwist=1; //[0:0.5:5]
// Gear depth ratio
depth_ratio=0.5; //[0:0.05:1]
// Gear clearance
tol=0.2; //[0:0.01:0.5]
// pressure angle
P=30; //[30:60]
// Layer height (for ring horizontal split)
layer_h = 0.2; //[0:0.01:1]
// Chamfer exposed gears, top - watch fingers
ChamferGearsTop = 0;				// [1:No, 0.5:Yes, 0:Half]
// Chamfer exposed gears, bottom - help with elephant's foot/tolerance
ChamferGearsBottom = 0;				// [1:No, 0.5:Yes, 0:Half]
// Number of sets of jaws
jaws = 1; //[0:1:6]
// Jaw Initial Rotation (from closed)
jaw_rot = 180; //[0:180]
// Jaw Size
jaw_size = 20; //[0:100]
// Jaw Offset
jaw_offset = 0; //[0:0.1:100]
// Jaw Taper Angle (outside edge)
jaw_angle = 30; //[0:60]
// Dimple radius
dim_r = 1.1; //[0:0.1:2]
// Dimple depth ratio
dim_d = 0.5; //[0:0.1:1]
//Diameter of the knob, in mm
KnobDiameter		= 30.0;			//[10:0.5:100]
//Thickness of knob, including the stem, in mm:
KnobTotalHeight 	= 15;			//[10:thin,15:normal,30:thick, 40:very thick]
//Number of points on the knob
FingerPoints		= 8;   			//[3,4,5,6,7,8,9,10]
//Diameter of finger holes
FingerHoleDiameter	= 10; //[5:0.5:50]
TaperFingerPoints	= true;			// true

//
// Include Nut Captures at base of stem and/or on top of part
// If using a hex-head bolt for knob, include Top Nut Capture only.
// including both top and bottom captures allows creation of a knob 
// with nuts top and bottom for strength/stability when using all-thread rod
//

//Include a nut capture at the top
TopNutCapture = 0;				//[1:Yes , 0:No]
//Include a nut capture at the base
BaseNutCapture = 0/1;				// [1:Yes , 0:No]

// Curve resolution settings, minimum angle
$fa = 5/1;
// Curve resolution settings, minimum size
$fs = 1/1;

// For fused sun gears, we require them to be a multiple of the planet teeth
drive_t = planet_t*sgm;
drive_t2 = planet_t2*sgm;

// Calculate cp based on desired ring wall thickness
cp=(outer_d/2-wall)*360/(drive_t+2*planet_t);

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

// Jaws
dim_n = floor(((modules-1)*gear_h+gear_h2)/dim_r/3);
dim_s = ((modules-1)*gear_h+gear_h2)/(dim_n+1);
if(jaws>0)for(k=[0:jaws-1])rotate([0,0,k*360/jaws]){
    for(i=[dim_s/2:dim_s:jaw_size-dim_s/2+AT]){
        for(j=[dim_s/2:dim_s:(modules-1)*gear_h+gear_h2-dim_s/2+AT]){
            translate([outer_d/2+jaw_size-i,jaw_offset,j])
                scale([1,dim_d,1])rotate([90,0,0])sphere(r=dim_r,$fn=6);
        }
    }
    difference(){
        intersection(){
            translate([0,jaw_offset,0])
                cube([outer_d/2+jaw_size,outer_d/2-jaw_offset,(modules-1)*gear_h+gear_h2-AT]);
            rotate([0,0,-jaw_angle])
                cube([outer_d/2+jaw_size,outer_d/2,(modules-1)*gear_h+gear_h2-AT]);
        }
        translate([0,0,-AT])
            cylinder(r=outer_d/2-0.5,h=gear_h+ST);
        translate([0,0,gear_h])
            cylinder(r=outer_d/2+0.5,h=gear_h2+layer_h-TT);
        translate([0,0,gear_h+gear_h2+layer_h-AT])
            cylinder(r=outer_d/2-0.5,h=gear_h+ST);
        for(i=[dim_s:dim_s:jaw_size-dim_s]){
            for(j=[dim_s:dim_s:(modules-1)*gear_h+gear_h2-dim_s+AT]){
                translate([outer_d/2+jaw_size-i,jaw_offset,j])
                    scale([1,dim_d,1])rotate([90,0,0])sphere(r=dim_r,$fn=6);
            }
        }
    }
    
    rotate([0,0,-jaw_rot])mirror([0,1,0]){
        for(i=[dim_s:dim_s:jaw_size-dim_s]){
            for(j=[dim_s:dim_s:(modules-1)*gear_h+gear_h2-dim_s+AT]){
                translate([outer_d/2+jaw_size-i,jaw_offset,j])
                    scale([1,dim_d,1])rotate([90,0,0])sphere(r=dim_r,$fn=6);
            }
        }
        difference(){
        intersection(){
            translate([0,jaw_offset,0])
                cube([outer_d/2+jaw_size,outer_d/2-jaw_offset,2*gear_h+gear_h2-AT]);
            rotate([0,0,-jaw_angle])
                cube([outer_d/2+jaw_size,outer_d/2,(modules-1)*gear_h+gear_h2-AT]);
            }
            translate([0,0,-AT])
                cylinder(r=outer_d/2+0.5,h=gear_h+layer_h+AT);
            translate([0,0,gear_h])
                cylinder(r=outer_d/2-0.5,h=gear_h2+layer_h-TT);
            translate([0,0,gear_h+gear_h2-TT])
                cylinder(r=outer_d/2+0.5,h=gear_h+ST);
            for(i=[dim_s/2:dim_s:jaw_size-dim_s/2+AT]){
                for(j=[dim_s/2:dim_s:(modules-1)*gear_h+gear_h2-dim_s/2+AT]){
                    translate([outer_d/2+jaw_size-i,jaw_offset,j])
                        scale([1,dim_d,1])rotate([90,0,0])sphere(r=dim_r,$fn=6);
                }
            }
        }
    }
}

// Knob
// by Hank Cowdog
// 2 Feb 2015
//
// based on FastRyan's
// Tension knob 
// Thingiverse Thing http://www.thingiverse.com/thing:27502/ 
// which was downloaded on 2 Feb 2015 
//
// GNU General Public License, version 2
// http://www.gnu.org/licenses/gpl-2.0.html
//
//This program is free software; you can redistribute it and/or
//modify it under the terms of the GNU General Public License
//as published by the Free Software Foundation; either version 2
//of the License, or (at your option) any later version.
//
//This program is distributed in the hope that it will be useful,
//but WITHOUT ANY WARRANTY; without even the implied warranty of
//MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//GNU General Public License for more details.
//
//
// 
//
//
//
// Finger points are the points on a star knob.
// Finger holes are the notches between each point.
// Larger values make for deeper holes.
// Too many/too deep and you may reduce knob size too much.
// If $TaperFingerPoints is true, the edges will be eased a little, making 
// for a nicer knob to hold/use. 
//

//Ratio of stem to total height smaller makes for less of a stem under the knob:
//StemHeightPercent =30.0/100.0;			// [0.3:0.8]

// The shaft is for a thru-hole.  Easing the shaft by a small percentage makes for
// easier insertion and makes allowance for ooze on 3D filament printers 

//Diameter of the shaft thru-bolt, in mm 
ShaftDiameter = shaft_d;

ShaftEasingPercentage = 0/100.0;  // 10% is plenty

NutFlatWidth = 1.75 * ShaftDiameter;
NutHeight =     0.87 * ShaftDiameter;
SineOfSixtyDegrees = 0.86602540378/1.0;

NutPointWidth = NutFlatWidth /SineOfSixtyDegrees;

//StemDiameter= KnobDiameter/2.0;
//StemHeight = KnobTotalHeight  * StemHeightPercent;

EasedShaftDiameter = ShaftDiameter * (1.0+ShaftEasingPercentage);

translate([0,0,(modules-1)*gear_h+gear_h2-ST]){
intersection(){
translate([0,0,KnobTotalHeight])mirror([0,0,1])difference() {
// The whole knob
	cylinder(h=KnobTotalHeight, r=KnobDiameter/2, $fn=50);
	
// each finger point
	for ( i = [0 : FingerPoints-1] )
	{
    		rotate( i * 360 / FingerPoints, [0, 0, 1])
    		translate([0, (KnobDiameter *.6), -1])
		union() {

// remove the vertical part of the finger hole 
    			cylinder(h=KnobTotalHeight+2, r=FingerHoleDiameter/2, $fn=60);

// taper the sides of the finger points 
			if(TaperFingerPoints) {
				rotate_extrude(convexity = 10, $fn = 60)
					translate([FingerHoleDiameter/2.0, 0, 0])
					polygon( points=[[2,-3],[-1,6],[-1,-3]] );

			}
		}
	}


// Drill the shaft and nut captures
	translate([0, 0, KnobTotalHeight+1]) scale([1, 1, -1])
	union() {
//The thru-shaft
		cylinder(h=KnobTotalHeight+2, r=EasedShaftDiameter/2., $fn=50);
	
// Drill the nut capture
		if (1 == BaseNutCapture) {
			cylinder(h=NutHeight + 1, r=NutPointWidth/2.0, $fn=6);
		}
	}
	
// Drill the 2nd nut capture      
	if (1 == TopNutCapture) { 
		translate([0, 0, -1])
			cylinder(h=NutHeight + 1, r=NutPointWidth/2.0, $fn=6);
	}

// Torus removal to transition knob into stem
//	translate([0, 0, KnobTotalHeight])
//	rotate_extrude(convexity = 10, $fn = 50)
//		translate([StemDiameter, 0, 0])
//		circle(r = StemHeight, $fn = 50);

// taper the ends of the points
	if(TaperFingerPoints) {
		rotate_extrude(convexity = 10, $fn = 50)
		translate([KnobDiameter/2, 0, 0])
		polygon( points=[[-2,-3],[1,6],[1,-3]] );
	}
}	

        
        if(modules==3)rotate([0,0,180/drive_t*(1-planet_t%2)]){
            linear_extrude(height=KnobTotalHeight,scale=1+KnobTotalHeight/(drive_t*cp/360)*sqrt(3),slices=1)
                gear2D(drive_t,cp*PI/180,P,depth_ratio,tol);
        }
        if(modules==3)rotate([0,0,180/drive_t*(1-planet_t%2)]){
            linear_extrude(height=KnobTotalHeight,scale=1+KnobTotalHeight/(drive_t*cp/360)/1.25,slices=1)
                hull()gear2D(drive_t,cp*PI/180,P,depth_ratio,tol);
    
        }
        if(modules==2)rotate([0,0,180/drive_t2*(1-planet_t2%2)]){
            linear_extrude(height=KnobTotalHeight,scale=1+KnobTotalHeight/(drive_t2*cp2/360)*sqrt(3),slices=1)
                gear2D(drive_t2,cp2*PI/180,P,depth_ratio,tol);
        }
        if(modules==2)rotate([0,0,180/drive_t2*(1-planet_t2%2)]){
            linear_extrude(height=KnobTotalHeight,scale=1+KnobTotalHeight/(drive_t2*cp2/360)/1.25,slices=1)
                hull()gear2D(drive_t2,cp2*PI/180,P,depth_ratio,tol);
    
        }
    }
}

// center gears
rotate([0,0,180/drive_t*(1-planet_t%2)])intersection(){
    drivegear(t1=drive_t,bore=shaft_d,rot=180/drive_t*(1-planet_t%2));
    if(ChamferGearsBottom<1)rotate(90/planet_t)
        linear_extrude(height=gear_h,scale=1+gear_h/(drive_t*cp/360)*sqrt(3),slices=1)
            circle($fn=drive_t*2,r=drive_t*cp/360-ChamferGearsBottom*min(cp/(2*tan(P))+tol,depth_ratio*cp*PI/180+tol));
}
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
    intersection(){
        planetgear(t1 = planet_t, bore=shaft_d);
        if(ChamferGearsBottom<1)rotate(90/planet_t)
            linear_extrude(height=gear_h,scale=1+gear_h/(planet_t*cp/360)*sqrt(3),slices=1)
                circle($fn=planet_t*2,r=planet_t*cp/360-ChamferGearsBottom*min(cp/(2*tan(P))+tol,depth_ratio*cp*PI/180+tol));                
    }

translate([0,0,gear_h-TT])
    planets(t1=planet_t2, t2=drive_t2,offset=(drive_t2+planet_t2)*cp2/360,n=planets,t=ring_t2+drive_t2)
        intersection(){
            planetgear(t1 = planet_t2, bore=shaft_d,cp=cp2,helix_angle=helix_angle2,gear_h=gear_h2);
            linear_extrude(height=gear_h2,scale=1+gear_h2/(planet_t*cp/360)*sqrt(3),slices=1)
                gear2D(planet_t,cp*PI/180,P,depth_ratio,tol);
            if(ChamferGearsTop<1&&modules==2)translate([0,0,gear_h2])rotate(90/planet_t2)mirror([0,0,1])
                linear_extrude(height=gear_h2,scale=1+gear_h2/(planet_t2*cp2/360)*sqrt(3),slices=1)
                    circle($fn=planet_t2*2,r=planet_t2*cp2/360-ChamferGearsBottom*min(cp2/(2*tan(P))+tol,depth_ratio*cp2*PI/180+tol));
        }
if(modules==3)translate([0,0,gear_h+gear_h2-AT])
    planets(t1=planet_t, t2=drive_t,offset=(drive_t+planet_t)*cp/360,n=planets,t=ring_t1+drive_t)
        intersection(){
            planetgear(t1 = planet_t, bore=shaft_d);
            linear_extrude(height=gear_h,scale=1+gear_h/(planet_t2*cp2/360)*sqrt(3),slices=1)
                    gear2D(planet_t2,cp2*PI/180,P,depth_ratio,tol);
            if(ChamferGearsTop<1)translate([0,0,gear_h])rotate(90/planet_t)mirror([0,0,1])
                linear_extrude(height=gear_h,scale=1+gear_h/(planet_t*cp/360)*sqrt(3),slices=1)
                    circle($fn=planet_t*2,r=planet_t*cp/360-ChamferGearsBottom*min(cp/(2*tan(P))+tol,depth_ratio*cp*PI/180+tol));
        }

// rings
s1=ring_t1_n/ring_t1;
s2=ring_t2_n/ring_t2;
ha1=atan(PI*nTwist*s1*cp/90/gear_h); // not sure about this, seems close enough.
ha2=atan(PI*nTwist*s2*cp2/90/gear_h);
difference(){
    gearcase(t1=ring_t1,bore=outer_d/2,cp=s1*cp,helix_angle=ha1);
    if(ChamferGearsBottom<1)translate([0,0,-TT])
        linear_extrude(height=(ring_t1*s1*cp/360)/sqrt(3),scale=0,slices=1)
            if(ChamferGearsTop>0)
                hull()gear2D(ring_t1,s1*cp*PI/180,P,depth_ratio,-tol);
            else
                circle($fn=ring_t1*2,r=ring_t1*s1*cp/360);
}
translate([0,0,gear_h-TT])difference(){
    gearcase(t1=ring_t2,bore=outer_d/2,cp=s2*cp2,helix_angle=ha2,gear_h=gear_h2);
    linear_extrude(height=(ring_t1*s1*cp/360)/sqrt(3),scale=0,slices=1)
        hull()gear2D(ring_t1,s1*cp*PI/180,P,depth_ratio,-tol);
    translate([-outer_d,-outer_d,-TT])cube([2*outer_d,2*outer_d,layer_h+AT]);
    if(ChamferGearsTop<1&&modules==2)translate([0,0,gear_h2+AT])mirror([0,0,1])
        linear_extrude(height=(ring_t2*s2*cp2/360)/sqrt(3),scale=0,slices=1)
            if(ChamferGearsTop>0)
                hull()gear2D(ring_t2,s2*cp2*PI/180,P,depth_ratio,-tol);
            else
                circle($fn=ring_t2*2,r=ring_t2*s2*cp2/360);
}
if(modules==3)translate([0,0,gear_h+gear_h2-AT])
    difference(){
        gearcase(t1=ring_t1,bore=outer_d/2,cp=s1*cp,helix_angle=ha1);
        linear_extrude(height=(ring_t2*s2*cp2/360)/sqrt(3),scale=0,slices=1)
            hull()gear2D(ring_t2,s2*cp2*PI/180,P,depth_ratio,-tol);
        translate([-outer_d,-outer_d,-TT])cube([2*outer_d,2*outer_d,layer_h+AT]);
        if(ChamferGearsTop<1)translate([0,0,gear_h+AT])mirror([0,0,1])
            linear_extrude(height=(ring_t1*s1*cp/360)/sqrt(3),scale=0,slices=1)
                if(ChamferGearsTop>0)
                    hull()gear2D(ring_t1,s1*cp*PI/180,P,depth_ratio,-tol);
                else
                    circle($fn=ring_t1*2,r=ring_t1*s1*cp/360);
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