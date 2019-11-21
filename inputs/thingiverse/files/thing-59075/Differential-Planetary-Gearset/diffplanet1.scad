// Differential planetary drive (customizable)

use <write/Write.scad>

//assembly();
choose(export);

// choose the object to render
export=0;// [0:Input,1:Output]
// outer diameter of ring
D=70;
// thickness
T=15;
// clearance between gear teeth
tol=0.15;
// vertical clearance
vtol=0.5;
number_of_planets=4;
number_of_teeth_on_planets=14;
approximate_number_of_teeth_on_sun=12;
// difference in teeth on ring gears
delta=-1;
// number of teeth to twist across
nTwist=1;
// pressure angle
P=30;
// width of hexagonal hole
w=6.7;

DR=2/PI;// maximum depth ratio of teeth

m=round(number_of_planets);
np=round(number_of_teeth_on_planets);
nsa=approximate_number_of_teeth_on_sun;
ka=round(2/m*(nsa+np));
k= ka*m%2!=0 ? ka+1 : ka;
ns=k*m/2-np;
echo(ns);
nr=ns+2*np;
nr2=nr+delta;
np2=np+delta;
pitchD=0.9*D/(1+depth_diameter(nr,P,DR));
pitch=pitchD*PI/nr;
echo(pitch);
helix_angle=atan(2*nTwist*pitch/T);
echo(helix_angle);

phi=$t*360;
R1=(1+nr/ns);// sun to planet-carrier ratio
R2=-nr2*np/(ns+np)/delta;// planet-carrier to ring ratio
R=R1*R2;
echo(R);

module choose(i){
if(i==0) planetary();
else ring();
}

module plate(){
translate([D+1,0,0])planetary();
translate([-D-1,0,0])ring();
}

module assembly(){
planetary();
translate([0,0,3*T/2+1+3*vtol])rotate([180,0,phi/R2-turn(nr2,pitch,helix_angle,vtol)])render()ring();
}

module ring()
difference(){
	union(){
		difference(){
			cylinder(r=D/2*nr2/nr,h=T/2+1,$fn=100);
			translate([0,0,1])gear(nr2,pitch,P,DR,-tol,helix_angle,T/2+0.2);
		}
		cylinder(r=0.9*innerR(ns,pitch,P,tol,DR),h=T/2+1);
		cylinder(r=w/3,h=T/2+1+3*vtol);
	}
	translate([0,0,-1])cylinder(r=w/sqrt(3),h=T,center=true,$fn=6);
	for(i=[1:3])rotate([0,0,i*120])translate([pitchD/2*(ns+np)/nr,0,0])
		cylinder(r=innerR(np2,pitch,P,tol,DR),h=3,center=true);
}

module planetary()
translate([0,0,T/2]){
	difference(){
		cylinder(r=D/2,h=T,center=true,$fn=100);
		herringbone(nr,pitch,P,DR,-tol,helix_angle,T+0.2);
		difference(){
			union(){
				rotate([0,0,180])translate([0,-D/2,0])rotate([90,0,0])monogram(h=10);
				writecylinder(text=str(R),radius=D/2,h=5,t=2,
					font="write/Letters.dxf");
			}
			cylinder(r=D/2-0.25,h=T+2,center=true,$fn=100);
		}
	}
	rotate([0,0,(np+1)*180/ns+phi*R1])
	difference(){
		mirror([0,1,0])
			herringbone(ns,pitch,P,DR,tol,helix_angle,T);
		translate([0,0,-1])cylinder(r=w/sqrt(3),h=T,center=true,$fn=6);
	}
	for(i=[1:m])rotate([0,0,i*360/m+phi])translate([pitchD/2*(ns+np)/nr,0,0])
		rotate([0,0,-phi*(ns+np)/np-phi]){
			difference(){
				rotate([0,0,i*ns/m*360/np])herringbone(np,pitch,P,DR,tol,helix_angle,T+3*vtol);
				translate([0,0,-D/2-T/2])cube(D,center=true);
			}
			rotate([0,0,i*ns/m*360/np-turn(np,pitch,helix_angle,vtol)])translate([0,0,T/2+vtol-0.01])
				cylinder(r=outerR(np,pitch,P,tol,DR)-tol,h=vtol+0.02,$fn=np);
			rotate([0,0,-i*nr2/m*360/np2])translate([0,0,T/2+2*vtol])
				gear(np2,pitch,P,DR,tol,helix_angle,T/2);
		}
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

module herringbone(
	number_of_teeth=15,
	circular_pitch=10,
	pressure_angle=20,
	depth_ratio=2/PI,
	clearance=0,
	helix_angle=0,
	gear_thickness=5){
union(){
	gear(number_of_teeth,
		circular_pitch,
		pressure_angle,
		depth_ratio,
		clearance,
		helix_angle,
		gear_thickness/2);
	mirror([0,0,1])
		gear(number_of_teeth,
			circular_pitch,
			pressure_angle,
			depth_ratio,
			clearance,
			helix_angle,
			gear_thickness/2);
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
//outer_radius = pitch_radius+depth_ratio*circular_pitch/2-clearance/2;
outer_radius = outerR(number_of_teeth, circular_pitch, pressure_angle, clearance, depth_ratio);
//root_radius1 = pitch_radius-depth/2-clearance/2;
//root_radius = (clearance<0 && root_radius1<base_radius) ? base_radius : root_radius1;
//inner_radius = max(root_radius,pitch_radius-depth_ratio*circular_pitch/2-clearance/2);
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