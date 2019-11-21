//include <list-comprehension-demos/sweep.scad>
//include <scad-utils/shapes.scad>
use <MCAD/involute_gears.scad>
//CUSTOMIZER VARIABLES
/* [Basic Values] */
number_of_teeth=9;
core_diameter=50;
core_height=25;
//Radius of the torus pieces used to cut the core. Lower numbers result in deeper cuts.
cut_distance=25;

/* [Gear Values] */
circular_pitch=250;
pressure_angle=28;
clearance = 0.2;
rim_width=5;
hub_diameter=15;
bore_diameter=5;
circles=0;
backlash=0;
involute_facets=6;
pressure_angle=28;
/* [Other Values] */
//Teeth engaged/disengaged by the worm gear each rotation. Divide by the number of teeth for the rotation ratio (spur gear:worm gear).
teeth_per_rotation=1;//[1:100]
format=0; //[0=whole, 1=half, 2=split, 3=wheel gear]
//Size of the connector cube used in the split format.
connector_size=20;
core_type=0; //[0=cylinder, 1=chamfered cylinder]
//Side length of the chamfer, if selected.
chamfer_length=5;
//Height of the wheel gear, if selected.
wheel_height=5;
//Number of steps in the resulting cut. Higher numbers result in smoother shapes and longer rendering times.
resolution=50;//[10:5:200]
//CUSTOMIZER VARIABLES END

//Derived Variables
angle=360/number_of_teeth;
twist_angle=teeth_per_rotation*angle;
echo(twist_angle);
res=(involute_facets!=0)?involute_facets:($fn==0)?5:$fn/4;
pitch_diameter  =  number_of_teeth * circular_pitch / 180;
pitch_radius = pitch_diameter/2;
addendum = 1/(number_of_teeth / pitch_diameter);
outer_radius = pitch_radius+addendum;
dedendum = addendum + clearance;
root_radius = pitch_radius-dedendum;
half_thick_angle = (360 / number_of_teeth - backlash / pitch_radius * 180 / PI) / 4;
base_radius = pitch_radius*cos(pressure_angle);
min_radius = max (base_radius,root_radius);
pitch_point = involute (base_radius, involute_intersect_angle (base_radius, pitch_radius));
pitch_angle = atan2 (pitch_point[1], pitch_point[0]);
	centre_angle = pitch_angle + half_thick_angle;
start_angle = involute_intersect_angle (base_radius, min_radius);
stop_angle = involute_intersect_angle (base_radius, outer_radius);

//Helper Functions
function reverseOrder(points)=
    [for(i=[1:len(points)]) points[len(points)-i]];
function mirror_shape(shape)=
    [for (i=[0:len(shape)-1]) mirror_point(shape[i])];
function points()=[for (i=[0:res]) rotate_point(centre_angle,involute(base_radius,start_angle+(stop_angle-start_angle)*i/res))];
function shape()=concat(points(), reverseOrder(mirror_shape(points())));       
function f(t) = [cut_distance*cos(360 * t),cut_distance*sin(360 * t),0];
function flatten(l) = [ for (a = l) for (b = a) b ] ;
function gear_profile()=flatten(reverseOrder([for(i=[0:360/number_of_teeth:360-number_of_teeth]) rotate_shape(i,shape())]));
function rotate_shape(angle, shape)= [for(i=[0:len(shape)-1]) rotate_point(angle, shape[i])];
    
//Modules
module worm() {
    if ($children>0)
    {
        difference(){
            children(0);
            union()
            {
                    rotate([0,0,180]) sweep(gear_profile(), path_transforms1);
                    
                
                
                    sweep(gear_profile(), path_transforms2);
                    
                
            }
            
        }
    }
    else
    {
        union()
            {
                    rotate([0,0,180]) sweep(gear_profile(), path_transforms1);
                    
                
                
                    sweep(gear_profile(), path_transforms2);
                    
                
            }
    }
}
module core(half)
{
    if (core_type==0)
    {
        translate([0,0,-core_height/2]) cylinder(half ? core_height/2:core_height,core_diameter/2,core_diameter/2);
    }
    else if(core_type==1)
    {
        translate([0,0,-core_height/2]) rotate_extrude() trapezoid(core_diameter/2, half ? core_height/2:core_height, chamfer_length);
    }
}
module trapezoid(width, height, length)
{
    polygon([[0,0],[0, height],[width-length, height],[width, height-length],[width, length],[width-length, 0]]);
}
//translate([0,0,-10]) rotate_extrude() trapezoid(25, 20, 5);

//Exectuted code
step = 1/resolution;
path = [for (t=[0:step:0.5+step]) f(t)];

path_transforms1 = [for (t=[0:step:0.5+step]) translation(f(t))*rotation([90,twist_angle*t, 360*t])];
path_transforms2 = [for (t=[0:step:0.5+step]) translation(f(t))*rotation([90,twist_angle*(t+0.5), 360*t])];
if (format==0)
{
    worm() core(false);
}
else if (format==1)
{
    worm() core(true);
}
else if (format==2)
{
    difference()
    {
        worm() core(true);
        cube(connector_size, center=true);
    }
    translate([core_diameter+5,0]) union()
    {
        worm() core(true);
        cube(connector_size, center=true);
    }
}
else
{
    linear_extrude(twist=twist_angle/360*wheel_height, height=wheel_height) gear_shape (
				number_of_teeth,
				pitch_radius = pitch_radius,
				root_radius = root_radius,
				base_radius = base_radius,
				outer_radius = outer_radius,
				half_thick_angle = half_thick_angle,
				involute_facets=involute_facets);
}

/*Libraries*/
//
function rotation_from_axis(x,y,z) = [[x[0],y[0],z[0]],[x[1],y[1],z[1]],[x[2],y[2],z[2]]]; 

function rotate_from_to(a,b,_axis=[]) = 
        len(_axis) == 0 
        ? rotate_from_to(a,b,unit(cross(a,b))) 
        : _axis*_axis >= 0.99 ? rotation_from_axis(unit(b),_axis,cross(_axis,unit(b))) * 
    transpose_3(rotation_from_axis(unit(a),_axis,cross(_axis,unit(a)))) : identity3(); 

function make_orthogonal(u,v) = unit(u - unit(v) * (unit(v) * u)); 

// Prevent creeping nonorthogonality 
function coerce(m) = [unit(m[0]), make_orthogonal(m[1],m[0]), make_orthogonal(make_orthogonal(m[2],m[0]),m[1])]; 

function tangent_path(path, i) =
i == 0 ?
  unit(path[1] - path[0]) :
  (i == len(path)-1 ?
      unit(path[i] - path[i-1]) :
    unit(path[i+1]-path[i-1]));

function construct_rt(r,t) = [concat(r[0],t[0]),concat(r[1],t[1]),concat(r[2],t[2]),[0,0,0,1]]; 

function construct_transform_path(path) =
  [let (l=len(path))
      for (i=[0:l-1])
        construct_rt(rotate_from_to([0,0,1], tangent_path(path, i)), path[i])];

module sweep(shape, path_transforms, closed=false) {

    pathlen = len(path_transforms);
    segments = pathlen + (closed ? 0 : -1);
    shape3d = to_3d(shape);

    function sweep_points() =
      flatten([for (i=[0:pathlen-1]) transform(path_transforms[i], shape3d)]);

    function loop_faces() = [let (facets=len(shape3d))
        for(s=[0:segments-1], i=[0:facets-1])
          [(s%pathlen) * facets + i, 
           (s%pathlen) * facets + (i + 1) % facets, 
           ((s + 1) % pathlen) * facets + (i + 1) % facets, 
           ((s + 1) % pathlen) * facets + i]];

    bottom_cap = closed ? [] : [[for (i=[len(shape3d)-1:-1:0]) i]];
    top_cap = closed ? [] : [[for (i=[0:len(shape3d)-1]) i+len(shape3d)*(pathlen-1)]];
    polyhedron(points = sweep_points(), faces = concat(loop_faces(), bottom_cap, top_cap), convexity=5);
}
//
// very minimal set of linalg functions needed by so3, se3 etc.

// cross and norm are builtins
//function cross(x,y) = [x[1]*y[2]-x[2]*y[1], x[2]*y[0]-x[0]*y[2], x[0]*y[1]-x[1]*y[0]];
//function norm(v) = sqrt(v*v);

function vec3(p) = len(p) < 3 ? concat(p,0) : p;
function vec4(p) = let (v3=vec3(p)) len(v3) < 4 ? concat(v3,1) : v3;
function unit(v) = v/norm(v);

function identity3()=[[1,0,0],[0,1,0],[0,0,1]]; 
function identity4()=[[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]];


function take3(v) = [v[0],v[1],v[2]];
function tail3(v) = [v[3],v[4],v[5]];
function rotation_part(m) = [take3(m[0]),take3(m[1]),take3(m[2])];
function rot_trace(m) = m[0][0] + m[1][1] + m[2][2];
function rot_cos_angle(m) = (rot_trace(m)-1)/2;

function rotation_part(m) = [take3(m[0]),take3(m[1]),take3(m[2])];
function translation_part(m) = [m[0][3],m[1][3],m[2][3]];
function transpose_3(m) = [[m[0][0],m[1][0],m[2][0]],[m[0][1],m[1][1],m[2][1]],[m[0][2],m[1][2],m[2][2]]];
function transpose_4(m) = [[m[0][0],m[1][0],m[2][0],m[3][0]],
                           [m[0][1],m[1][1],m[2][1],m[3][1]],
                           [m[0][2],m[1][2],m[2][2],m[3][2]],
                           [m[0][3],m[1][3],m[2][3],m[3][3]]]; 
function invert_rt(m) = construct_Rt(transpose_3(rotation_part(m)), -(transpose_3(rotation_part(m)) * translation_part(m)));
function construct_Rt(R,t) = [concat(R[0],t[0]),concat(R[1],t[1]),concat(R[2],t[2]),[0,0,0,1]];

// Hadamard product of n-dimensional arrays
function hadamard(a,b) = !(len(a)>0) ? a*b : [ for(i = [0:len(a)-1]) hadamard(a[i],b[i]) ];
//
// List helpers

/*!
  Flattens a list one level:

  flatten([[0,1],[2,3]]) => [0,1,2,3]
*/
function flatten(list) = [ for (i = list, v = i) v ];


/*!
  Creates a list from a range:

  range([0:2:6]) => [0,2,4,6]
*/
function range(r) = [ for(x=r) x ];

/*!
  Reverses a list:

  reverse([1,2,3]) => [3,2,1]
*/
function reverse(list) = [for (i = [len(list)-1:-1:0]) list[i]];

/*!
  Extracts a subarray from index begin (inclusive) to end (exclusive)
  FIXME: Change name to use list instead of array?

  subarray([1,2,3,4], 1, 2) => [2,3]
*/
function subarray(list,begin=0,end=-1) = [
    let(end = end < 0 ? len(list) : end)
      for (i = [begin : 1 : end-1])
        list[i]
];

/*!
  Returns a copy of a list with the element at index i set to x

  set([1,2,3,4], 2, 5) => [1,2,5,4]
*/
function set(list, i, x) = [for (i_=[0:len(list)-1]) i == i_ ? x : list[i_]];
//
//use <se3.scad>
//use <linalg.scad>
//use <lists.scad>

/*!
  Creates a rotation matrix

  xyz = euler angles = rz * ry * rx
  axis = rotation_axis * rotation_angle
*/
function rotation(xyz=undef, axis=undef) = 
	xyz != undef && axis != undef ? undef :
	xyz == undef  ? se3_exp([0,0,0,axis[0],axis[1],axis[2]]) :
	len(xyz) == undef ? rotation(axis=[0,0,xyz]) :
	(len(xyz) >= 3 ? rotation(axis=[0,0,xyz[2]]) : identity4()) *
	(len(xyz) >= 2 ? rotation(axis=[0,xyz[1],0]) : identity4()) *
	(len(xyz) >= 1 ? rotation(axis=[xyz[0],0,0]) : identity4());

/*!
  Creates a scaling matrix
*/
function scaling(v) = [
	[v[0],0,0,0],
	[0,v[1],0,0],
	[0,0,v[2],0],
	[0,0,0,1],
];

/*!
  Creates a translation matrix
*/
function translation(v) = [
	[1,0,0,v[0]],
	[0,1,0,v[1]],
	[0,0,1,v[2]],
	[0,0,0,1],
];

// Convert between cartesian and homogenous coordinates
function project(x) = subarray(x,end=len(x)-1) / x[len(x)-1];

function transform(m, list) = [for (p=list) project(m * vec4(p))];
function to_3d(list) = [ for(v = list) vec3(v) ];
//
//use <linalg.scad>
//use <so3.scad>

function combine_se3_exp(w, ABt) = construct_Rt(rodrigues_so3_exp(w, ABt[0], ABt[1]), ABt[2]);

// [A,B,t]
function se3_exp_1(t,w) = concat(
	so3_exp_1(w*w),
	[t + 0.5 * cross(w,t)]
);

function se3_exp_2(t,w) = se3_exp_2_0(t,w,w*w);
function se3_exp_2_0(t,w,theta_sq) = 
se3_exp_23(
	so3_exp_2(theta_sq), 
	C = (1.0 - theta_sq/20) / 6,
	t=t,w=w);

function se3_exp_3(t,w) = se3_exp_3_0(t,w,sqrt(w*w)*180/PI,1/sqrt(w*w));

function se3_exp_3_0(t,w,theta_deg,inv_theta) = 
se3_exp_23(
	so3_exp_3_0(theta_deg = theta_deg, inv_theta = inv_theta),
	C = (1 - sin(theta_deg) * inv_theta) * (inv_theta * inv_theta),
	t=t,w=w);

function se3_exp_23(AB,C,t,w) = 
[AB[0], AB[1], t + AB[1] * cross(w,t) + C * cross(w,cross(w,t)) ];

function se3_exp(mu) = se3_exp_0(t=take3(mu),w=tail3(mu)/180*PI);

function se3_exp_0(t,w) =
combine_se3_exp(w,
// Evaluate by Taylor expansion when near 0
	w*w < 1e-8 
	? se3_exp_1(t,w)
	: w*w < 1e-6
	  ? se3_exp_2(t,w)
	  : se3_exp_3(t,w)
);

function se3_ln(m) = se3_ln_to_deg(se3_ln_rad(m));
function se3_ln_to_deg(v) = concat(take3(v),tail3(v)*180/PI);

function se3_ln_rad(m) = se3_ln_0(m, 
	rot = so3_ln_rad(rotation_part(m)));
function se3_ln_0(m,rot) = se3_ln_1(m,rot,
	theta = sqrt(rot*rot));
function se3_ln_1(m,rot,theta) = se3_ln_2(m,rot,theta,
	shtot = theta > 0.00001 ? sin(theta/2*180/PI)/theta : 0.5,
	halfrotator = so3_exp_rad(rot * -.5));
function se3_ln_2(m,rot,theta,shtot,halfrotator) =
concat( (halfrotator * translation_part(m) - 
	(theta > 0.001 
	? rot * ((translation_part(m) * rot) * (1-2*shtot) / (rot*rot))
	: rot * ((translation_part(m) * rot)/24)
	)) / (2 * shtot), rot);

__se3_test = [20,-40,60,-80,100,-120];
echo(UNITTEST_se3=norm(__se3_test-se3_ln(se3_exp(__se3_test))) < 1e-8);
//
// so3

//use <linalg.scad>

function rodrigues_so3_exp(w, A, B) = [
[1.0 - B*(w[1]*w[1] + w[2]*w[2]), B*(w[0]*w[1]) - A*w[2],          B*(w[0]*w[2]) + A*w[1]],
[B*(w[0]*w[1]) + A*w[2],          1.0 - B*(w[0]*w[0] + w[2]*w[2]), B*(w[1]*w[2]) - A*w[0]],
[B*(w[0]*w[2]) - A*w[1],          B*(w[1]*w[2]) + A*w[0],          1.0 - B*(w[0]*w[0] + w[1]*w[1])]
];

function so3_exp(w) = so3_exp_rad(w/180*PI);
function so3_exp_rad(w) =
combine_so3_exp(w,
	w*w < 1e-8 
	? so3_exp_1(w*w)
	: w*w < 1e-6
	  ? so3_exp_2(w*w)
	  : so3_exp_3(w*w));

function combine_so3_exp(w,AB) = rodrigues_so3_exp(w,AB[0],AB[1]);

// Taylor series expansions close to 0
function so3_exp_1(theta_sq) = [
	1 - 1/6*theta_sq, 
	0.5
];

function so3_exp_2(theta_sq) = [
	1.0 - theta_sq * (1.0 - theta_sq/20) / 6,
	0.5 - 0.25/6 * theta_sq
];

function so3_exp_3_0(theta_deg, inv_theta) = [
	sin(theta_deg) * inv_theta,
	(1 - cos(theta_deg)) * (inv_theta * inv_theta)
];

function so3_exp_3(theta_sq) = so3_exp_3_0(sqrt(theta_sq)*180/PI, 1/sqrt(theta_sq));


function rot_axis_part(m) = [m[2][1] - m[1][2], m[0][2] - m[2][0], m[1][0] - m[0][1]]*0.5;

function so3_ln(m) = 180/PI*so3_ln_rad(m);
function so3_ln_rad(m) = so3_ln_0(m,
	cos_angle = rot_cos_angle(m),
	preliminary_result = rot_axis_part(m));

function so3_ln_0(m, cos_angle, preliminary_result) = 
so3_ln_1(m, cos_angle, preliminary_result, 
	sin_angle_abs = sqrt(preliminary_result*preliminary_result));

function so3_ln_1(m, cos_angle, preliminary_result, sin_angle_abs) = 
	cos_angle > sqrt(1/2)
	? sin_angle_abs > 0
	  ? preliminary_result * asin(sin_angle_abs)*PI/180 / sin_angle_abs
	  : preliminary_result
	: cos_angle > -sqrt(1/2)
	  ? preliminary_result * acos(cos_angle)*PI/180 / sin_angle_abs
	  : so3_get_symmetric_part_rotation(
	      preliminary_result,
	      m,
	      angle = PI - asin(sin_angle_abs)*PI/180,
	      d0 = m[0][0] - cos_angle,
	      d1 = m[1][1] - cos_angle,
	      d2 = m[2][2] - cos_angle
			);

function so3_get_symmetric_part_rotation(preliminary_result, m, angle, d0, d1, d2) =
so3_get_symmetric_part_rotation_0(preliminary_result,angle,so3_largest_column(m, d0, d1, d2));

function so3_get_symmetric_part_rotation_0(preliminary_result, angle, c_max) =
	angle * unit(c_max * preliminary_result < 0 ? -c_max : c_max);

function so3_largest_column(m, d0, d1, d2) =
		d0*d0 > d1*d1 && d0*d0 > d2*d2
		?	[d0, (m[1][0]+m[0][1])/2, (m[0][2]+m[2][0])/2]
		: d1*d1 > d2*d2
		  ? [(m[1][0]+m[0][1])/2, d1, (m[2][1]+m[1][2])/2]
		  : [(m[0][2]+m[2][0])/2, (m[2][1]+m[1][2])/2, d2];

__so3_test = [12,-125,110];
echo(UNITTEST_so3=norm(__so3_test-so3_ln(so3_exp(__so3_test))) < 1e-8);
//
function square(size) = [[-size,-size], [-size,size], [size,size], [size,-size]] / 2;

function circle(r) = [for (i=[0:$fn-1]) let (a=i*360/$fn) r * [cos(a), sin(a)]];

function regular(r, n) = circle(r, $fn=n);

function rectangle_profile(size=[1,1]) = [	
	// The first point is the anchor point, put it on the point corresponding to [cos(0),sin(0)]
	[ size[0]/2,  0], 
	[ size[0]/2,  size[1]/2],
	[-size[0]/2,  size[1]/2],
	[-size[0]/2, -size[1]/2],
	[ size[0]/2, -size[1]/2],
];

// FIXME: Move rectangle and rounded rectangle from extrusion
//