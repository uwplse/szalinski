// Preassembled Harmonic Drive by Emmett Lalish
// License: CC-BY-SA, January 5th, 2014

use <../write/Write.scad>

// outer diameter of ring
D=70;
// gear thickness
T=15;
// clearance
tol=0.15;
// width of extrusion thread
wt=0.4;
number_of_teeth_on_planets=15;
number_of_teeth_on_sun=12;
// pressure angle
P=45;//[30:60]
// number of teeth to twist across
nTwist=1.4;
// width of hexagonal hole
w=6.7;

m=2*1;
DR=0.7*1;// maximum depth ratio of teeth

np=round(number_of_teeth_on_planets);
ns=round(number_of_teeth_on_sun);
nr=ns+2*np;
delta=2*1;
nf=nr-delta;
pitchD=0.8*D/(1+min(PI/(2*nr*tan(P)),PI*DR/nr));
pitch=pitchD*PI/nr;
echo(pitch);
helix_angle=atan(2*nTwist*pitch/T);
echo(helix_angle);

phi=$t*360/m;
R1=(ns+np)*2/ns;
R2=nr/delta;
R=R1*R2;
echo(R);

//flex();
assembly();
//herringbone(ns,pitch,P,DR,tol,helix_angle,T);

module assembly()
translate([0,0,T/2]){
	difference(){// fixed ring
		cylinder(r=D/2,h=T,center=true,$fn=100);
		herringbone(nr,pitch,P,DR,-5*tol-2*wt,helix_angle,T+0.02);
		difference(){
			union(){
				rotate([0,0,180])translate([0,-D/2,0])rotate([90,0,0])monogram(h=10);
				writecylinder(text=str(R),radius=D/2,h=5,t=2,
					font="../write/Letters.dxf");
			}
			cylinder(r=D/2-0.25,h=T+2,center=true,$fn=100);
		}
	}

	flex();// flexible output

	rotate([0,0,(np+1)*180/ns+phi*R1])// sun gear
	difference(){
		mirror([0,1,0])
			herringbone(ns,pitch,P,DR,0,helix_angle,T);
		cylinder(r=w/sqrt(3),h=T+1,center=true,$fn=6);
	}

	for(i=[1:m])rotate([0,0,i*360/m+phi])translate([pitchD/2*(ns+np)/nr,0,0])// planets
		rotate([0,0,i*ns/m*360/np-phi*(ns+np)/np-phi])
			herringbone(np,pitch,P,DR,tol,helix_angle,T);
}

module monogram(h=1)
linear_extrude(height=h,center=true)
translate(-[3,2.5])union(){
	difference(){
		square([4,5]);
		translate([1,1])square([2,3]);
	}
	square([6,1]);
	translate([0,2])square([2,1]);
}

module flex(){
difference(){
	union(){
		flexbase(w=2*wt);
		translate([0,0,2.5*T-0.01])cylinder(r=pitch*nf/(2*PI)+tol/2+wt,h=T/2,$fn=2*nf);
	}
	translate([0,0,-0.01])scale([1,1,(3*T+0.02)/(3*T)])flexbase(w=0);
	translate([0,0,2.5*T-0.02])cylinder(r1=pitch*nf/(2*PI)+tol/2,r2=pitch*nf/(2*PI)+tol/2-1,h=1);
	translate([0,0,3*T])cylinder(r=w/sqrt(3),h=T-4,center=true,$fn=6);
}}

module flexbase(w)
union(){
	scale([nr/nf,nf/nr,1])herringbone(nf,pitch,P,DR,-tol-w,helix_angle,T);
	translate([0,0,2.5*T])rotate([180,0,0])linear_extrude(height=2*T+0.01,scale=[nr/nf,nf/nr])
		circle(r=pitch*nf/(2*PI)+(tol+w)/2,$fn=2*nf);
}

module herringbone(
	number_of_teeth=15,
	circular_pitch=10,
	pressure_angle=20,
	depth_ratio=2/PI,
	clearance=0,
	helix_angle=0,
	gear_thickness=5){
union(){
	half(number_of_teeth,
		circular_pitch,
		pressure_angle,
		depth_ratio,
		clearance,
		helix_angle,
		gear_thickness/2);
	mirror([0,0,1])
		half(number_of_teeth,
			circular_pitch,
			pressure_angle,
			depth_ratio,
			clearance,
			helix_angle,
			gear_thickness/2);
	
}}

module half(
	number_of_teeth=15,
	circular_pitch=10,
	pressure_angle=20,
	depth_ratio=2/PI,
	clearance=0,
	helix_angle=0,
	gear_thickness=5){
radius=circular_pitch*number_of_teeth/(2*PI)-clearance/2;
intersection(){
	union(){
		gear(number_of_teeth,
			circular_pitch,
			pressure_angle,
			depth_ratio,
			clearance,
			helix_angle,
			gear_thickness);
		cylinder(r1=radius-gear_thickness/2,r2=radius,h=gear_thickness,$fn=2*number_of_teeth);
	}
	cylinder(r1=radius+gear_thickness/2,r2=radius,h=gear_thickness,$fn=2*number_of_teeth);
}} 

module gear (
	number_of_teeth=15,
	circular_pitch=10,
	pressure_angle=20,
	depth_ratio=2/PI,
	clearance=0,
	helix_angle=0,
	gear_thickness=5,
	flat=false){
twist=turn(number_of_teeth,circular_pitch,helix_angle,gear_thickness);

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
		linear_extrude(height=h,twist=twist,slices=twist/6)child(0);
	else
		child(0);
}

module gear2D (
	number_of_teeth,
	circular_pitch,
	pressure_angle,
	depth_ratio,
	clearance){
pitch_radius = pitchR(number_of_teeth,circular_pitch);
base_radius = pitch_radius*cos(pressure_angle);
depth = rackDepth(circular_pitch,pressure_angle);
max_radius = pitch_radius+depth/2+max(-clearance,0);
outer_radius = outerR(number_of_teeth, circular_pitch, pressure_angle, clearance, depth_ratio);
inner_radius = innerR(number_of_teeth, circular_pitch, pressure_angle, clearance, depth_ratio);
min_radius = max(base_radius,inner_radius);
backlash_angle = clearance/(pitch_radius*cos(pressure_angle)) * 180 / PI;
pitch_point = involute (base_radius, involute_intersect_angle (base_radius, pitch_radius));
tip_angle = atan2(pitch_point[1], pitch_point[0]) + 90/number_of_teeth - backlash_angle/2;

intersection(){
	circle($fn=number_of_teeth*2,r=outer_radius);
	union(){
		rotate(90/number_of_teeth)
			circle($fn=number_of_teeth*2,r=inner_radius);
		for (i = [1:number_of_teeth])rotate(i*360/number_of_teeth){
			halftooth (
				base_radius,
				min_radius,
				max_radius,
				tip_angle);		
			mirror([0,1])halftooth (
				base_radius,
				min_radius,
				max_radius,
				tip_angle);
		}
	}
}}

module halftooth (
	base_radius,
	min_radius,
	max_radius,
	tip_angle){
index=[0,1,2,3,4,5];
start_angle = max(involute_intersect_angle (base_radius, min_radius)-5,0);
stop_angle = involute_intersect_angle (base_radius, max_radius);
angle=index*(stop_angle-start_angle)/index[len(index)-1];
p=[[0,0],
	involute(base_radius,angle[0]+start_angle),
	involute(base_radius,angle[1]+start_angle),
	involute(base_radius,angle[2]+start_angle),
	involute(base_radius,angle[3]+start_angle),
	involute(base_radius,angle[4]+start_angle),
	involute(base_radius,angle[5]+start_angle)];

difference(){
	rotate(-tip_angle)polygon(points=p);
	square(2*max_radius);
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

function pitchR(Nteeth=15, pitch=10) = Nteeth*pitch/(2*PI);

function turn(Nteeth=15, pitch=10, helix_angle=0, h=5) = tan(helix_angle)*h/pitchR(Nteeth, pitch)*180/PI;

function rackDepth(pitch=10, pressure_angle=20) = pitch/(2*tan(pressure_angle));

function baseR(Nteeth=15, pitch=10, pressure_angle=20) = pitchR(Nteeth, pitch)*cos(pressure_angle);

function innerR(Nteeth=15, pitch=10, pressure_angle=20, clearance=0, depth_ratio=2/PI) = 
	max(max(pitchR(Nteeth, pitch)-rackDepth(pitch, pressure_angle)/2-clearance/2,
		baseR(Nteeth, pitch, pressure_angle)*sign(-clearance)),
		pitchR(Nteeth, pitch)-depth_ratio*pitch/2-clearance/2);

function outerR(Nteeth=15, pitch=10, pressure_angle=20, clearance=0, depth_ratio=2/PI) = 
	pitchR(Nteeth, pitch) + min(depth_ratio*pitch/2-clearance/2,
		rackDepth(pitch, pressure_angle)/2+max(-clearance,0));

function depth_diameter(Nteeth=15, pressure_angle=20, depth_ratio=2/PI) = 
	min(PI/(2*Nteeth*tan(pressure_angle)),PI*depth_ratio/Nteeth);