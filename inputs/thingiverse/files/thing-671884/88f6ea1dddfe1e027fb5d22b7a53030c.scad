// 'Epcot Style Container' by wstein 
// is licensed under the Attribution - Non-Commercial - Share Alike license. 
// (c) February 2015
// please refer the complete license here: http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
//
// Version 1.1: 
// - workaround for current customizer global parameter bug

/* [Dimensions] */

//top hole diameter
size=50;

//ignores the X / Y density settings
use_default_density = 1; // [0:false, 1:true]

// basicly the X Density should be about 3.25 * Y Density. For the default values please refer the thing instructions.
x_density=26; // [15:100]
y_density=8;  // [1:50]
function get_x_density() = (use_default_density ? round(get_y_density() * 3.25 - 0.2) : x_density);
function get_y_density() = (use_default_density ? round(sqrt(size * 50) / 6.25 - 0.2) : y_density);
echo(str("X density = ", get_x_density()));
echo(str("Y density = ", get_y_density()));

/* [Appearance] */

shaping_1=50; // [-100:100]
shaping_2=50; // [-100:100]

/* [Expert] */

// default 80, use lower values for faster preview (no need to use more than 100!) 
quality=80;

// ratio of top hole and sphere diameter, you may also adjust the density setting, after changing this value
sphere_lid_ratio=70; // [40:90]

//Believe me, you don't want to change this setting! This is only to be compatible with the base thing http://www.thingiverse.com/thing:634383. Value -1 means 2mm up to size 60, 2.5mm from 61 - 100. 3mm for larger. default = -1
wall_thickness=-1;
function get_wall_thickness() = ( 
	wall_thickness!=-1 ? wall_thickness : (
	size <= 60 ? 2.0 : (
	size <= 100 ? 2.5 : 
   3.0 )));
echo(str("get_wall_thickness() = ", get_wall_thickness()));

/* [Hidden] */

// some basic calculations

ratio = sphere_lid_ratio / 100;

shaping1=1+shaping_1/1000;
shaping2=1+shaping_2/1000;

r4=size/2;
r3=r4+get_wall_thickness()/2;
r2=r3/sqrt(1-ratio*ratio);
r1=r2/20;
r=r2;
thread_height=(r4*2>20?r4*2/6:20/6);
height=r2*2*ratio;

b0=-asin(ratio);
bn=asin(ratio);

ad=360/get_x_density();
bd=(bn-b0)/get_y_density()*2;

a_step=360/quality;
z_step=height/quality*2;
ta_step=250/quality;
tz_step=thread_height/quality;

thread_thickness=min(get_wall_thickness(),thread_height/2.5);

// build container with thread

build_container();

module build_container()
union()
{
	body();
	thread();
}

module body()
union()
{
	// build rotation
	for(n=[0:get_x_density()-1],m=[0:get_y_density()-1])
	triangle(ad*(n+m/2),b0+bd*m/2);

	// build top and buttom
	for(n=[0:get_x_density()-1],m=[b0,bn])
	assign(shift=((m-b0)/bd%1))
	assign(p1=[r*cos((n+shift)*ad-ad/2)*cos(m), r*sin((n+shift)*ad-ad/2)*cos(m), r*sin(m)])
	assign(p2=[0, 0, r*sin(m)])
	assign(p3=[r*cos((n+shift)*ad+ad/2)*cos(m), r*sin((n+shift)*ad+ad/2)*cos(m), r*sin(m)])
	{
		if(m != b0)
		polyhedron(points = [p1,p2,p3],faces = [[1,2,0]]);
		else
		polyhedron(points = [p1,p2,p3],faces = [[0,2,1]]);
	}
}

module triangle(a,b)
assign(p1=[r*cos(a-ad/2)*cos(b), r*sin(a-ad/2)*cos(b), r*sin(b)])
assign(p2=[r*cos(a)*cos(b+bd/2), r*sin(a)*cos(b+bd/2), r*sin(b+bd/2)])
assign(p3=[r*cos(a+ad/2)*cos(b), r*sin(a+ad/2)*cos(b), r*sin(b)])
assign(p4=[r*cos(a+ad)*cos(b+bd/2), r*sin(a+ad)*cos(b+bd/2), r*sin(b+bd/2)])
assign(pm0=(p1+p2+p3)/3*shaping1)
assign(pm1=(p2+p3+p4)/3*shaping2)
polyhedron(points = [pm0,p1,p2,p3,p4,pm1], 
     faces = [
				[1,2,0],
				[0,2,3],
				[1,0,3],
				[2,5,3],
				[2,4,5],
				[5,4,3],
			]);

module thread()
translate([0,0,height/2])
union()
{
	translate([0,0,0.001])
	cylinder(r=r3,h=thread_height+r1+get_wall_thickness(),$fn=quality);

	translate([0,0,r1+get_wall_thickness()/2])
	for(m=[0:180:359])
	rotate([0,0,m])
	for(n=[0:quality-1])
	thread_part(n,a_step,z_step);
}

module thread_part(n)
hull()
{
	for(m=[n,n+1])
	assign(a=m*ta_step)
	assign(z=m*tz_step)
	rotate([0,0,40+a])
	translate([r3,0,z])
	resize([0,0,thread_thickness])
	rotate([90,0,0])
	sphere(r=get_wall_thickness()/2,$fn=12);
}


