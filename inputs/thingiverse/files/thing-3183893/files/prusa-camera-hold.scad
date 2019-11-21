// using DotSCAD https://github.com/JustinSDK/dotSCAD (GPL)
// using scad-utils https://github.com/OskarLinde/scad-utils (MIT)

// which part to generate
part="test - all"; // ["test - all", "arm", "camera front and arm", "camera rear"]

// depth under hotbed
dl=50; 

// arm length outside heat bed
zd=100; // arm outside heat bed

// arm to frame material margin
m=0.25;

// camera arm to arm material margin
bm=0.1; // mm

// camera height
lh=30; // camera arm height

// camera twist left (degrees)
twl=31; // camera twist left

// camera twist down (degrees)
twd=5; // camera twist down

// arm one position
a1=0;

// arm two position
a2=30;

// heat bed to frame distance
hhd=7;

// end of settings
module end_of_settings() {}

hh=hhd + m;    // height of heat bed frame
hw=12.5 + m; // width of heat bed frame
hd=6 +0.25 + m;    // diameter of screw to heat bed
dd=7+6; // height of heat bed


el=10; // distance out to match/join arms
fmb=-5;  // material below frame
fma=6;  // material above frame
fms=2;  // material side of frame

dms=sqrt(2)*10;
aw=14;
ah=dd-5;

// 7x12.5
// d6
// 25.2x24.2 c 10mm up cable 17mm


// ===== include <library.scad>
module box(pos,size) { translate(pos) cube(size); }

module rrbox(pos=[0,0,0],size=[1,1,1],r=[0.1,0.1,0.1])
{
   module rrrect(x,y,rx,ry,box=1,c1=1,c2=1)
   {
      div=(rx+ry);
      if (box) translate([rx,0,-ry]) cube([x-rx*2,y,ry+ry]);
      if (c1) translate([rx,0,0]) rotate([-90,0,0]) scale([rx/div,ry/div,1]) cylinder(h=y,r=div);
      if (c2) translate([x-rx,0,0]) rotate([-90,0,0]) scale([rx/div,ry/div,1]) cylinder(h=y,r=div);
   }
   module rrbox(size,r)
   {
      isize=[size.x-r.x*2,size.y-r.y*2,size.z-r.z*2];
      translate([r.x,r.y,r.z]) cube([isize.x,isize.y,isize.z]);
      union()
      {
         translate([0,r.y,r.z       ]) rrrect(size.x,isize.y,r.x,r.z,$fn=$fn);
         translate([0,r.y,size.z-r.z]) rrrect(size.x,isize.y,r.x,r.z,$fn=$fn);

         translate([size.x-r.x,0,r.z       ]) rotate([0,0,90]) rrrect(size.y,isize.x,r.y,r.z,box=1,$fn=$fn);
         translate([size.x-r.x,0,size.z-r.z]) rotate([0,0,90]) rrrect(size.y,isize.x,r.y,r.z,box=1,$fn=$fn);

         translate([0,r.y       ,r.z]) rotate([90,0,0]) rrrect(size.x,isize.z,r.x,r.y,$fn=$fn);
         translate([0,size.y-r.y,r.z]) rotate([90,0,0]) rrrect(size.x,isize.z,r.x,r.y,$fn=$fn);

         translate([0,r.y,r.z]) cube([size.x,isize.y,isize.z]);

         div=(r.x+r.y+r.z);
         for (x=[0,isize.x])
         for (y=[0,isize.y])
         for (z=[0,isize.z])
            translate([r.x+x,r.y+y,r.z+z]) scale([r.x/div,r.y/div,r.z/div]) sphere(r=div);
      }
   }

   translate(pos) rrbox(size,r);
}

module r0box(pos=[0,0,0],size=[1,1,1],r=0.1)
{
   module rrect(x,y,r,box=1,c1=1,c2=1)
   {
      if (box) translate([r,0,-r]) cube([x-r*2,y,r+r]);
      if (c1) translate([r,0,0]) rotate([-90,0,0]) cylinder(h=y,r=r);
      if (c2) translate([x-r,0,0]) rotate([-90,0,0]) cylinder(h=y,r=r);
   }
   module rbox(size,r)
   {
      isize=[size.x-r*2,size.y-r*2,size.z-r*2];
      union()
      {
         translate([0,r,r       ]) rrect(size.x,isize.y,r,$fn=$fn);
         translate([0,r,size.z-r]) rrect(size.x,isize.y,r,$fn=$fn);

         translate([size.x-r,0,r       ]) rotate([0,0,90]) rrect(size.y,isize.x,r,box=1,$fn=$fn);
         translate([size.x-r,0,size.z-r]) rotate([0,0,90]) rrect(size.y,isize.x,r,box=1,$fn=$fn);

         translate([0,r       ,r]) rotate([90,0,0]) rrect(size.x,isize.z,r,$fn=$fn);
         translate([0,size.y-r,r]) rotate([90,0,0]) rrect(size.x,isize.z,r,$fn=$fn);

         translate([0,r,r]) cube([size.x,isize.y,isize.z]);

         for (x=[0,isize.x])
         for (y=[0,isize.y])
         for (z=[0,isize.z])
            translate([r+x,r+y,r+z]) sphere(r=r);
      }
   }

   translate(pos) rbox(size,r);
}

module roundbox(pos=[0,0,0],size=[1,1,1],r=0.1)
{
   rrbox(pos,size,[r,r,r]);
}

module cyl_x(base=[0,0,0],h=10,r=5)
{
   translate(base)
      rotate([0,90,0])
      cylinder(h=h,r=r);
}

module cyl_y(base=[0,0,0],h=10,r=5)
{
   translate(base) rotate([-90,0,0]) cylinder(h=h,r=r);
}

module cyl_z(base=[0,0,0],h=10,r=5)
{
   translate(base) cylinder(h=h,r=r);
}

module hexagon(base=[0,0,0],h=10,w=10,h=10*1.12)
{
   wh=w/2;
   hh=h/2;
   hq=0.27*h;
   translate(base)
   linear_extrude(height=h)
      polygon([[0,-hh],
               [wh,-hq],
               [wh,hq],
               [0,hh],
               [-wh,hq],
               [-wh,-hq]]);
}

module rzsquare(size=[10,10],r=1)
{
   union()
   {
      translate([r,0]) square([size.x-r*2,size.y]);
      translate([0,r]) square([size.x,size.y-r*2]);
      translate([r,r]) circle(r=r);
      translate([r,size.y-r]) circle(r=r);
      translate([size.x-r,r]) circle(r=r);
      translate([size.x-r,size.y-r]) circle(r=r);
   }
}


// box rounded only in z dimension
module rzbox(base=[0,0,0],size=[10,10,10],r=1)
{
   translate(base)
   linear_extrude(height=size.z)
      rzsquare(size=size,r=r);
}

// x,y = inner size, r=extra radius
module extrude_frame(x,y,r=20)
{
   xs=x-r*2;
   ys=y-r*2;
   translate([r,y,0]) rotate([90,0,0]) rotate([0,90,0]) linear_extrude(height=xs) children();
   translate([r,0,0]) mirror([0,1,0]) rotate([90,0,0]) rotate([0,90,0]) linear_extrude(height=xs) children();
   translate([x,y-r,0]) rotate([90,0,0]) linear_extrude(height=ys) children();
   translate([0,y-r,0]) mirror([1,0,0]) rotate([90,0,0]) linear_extrude(height=ys) children();

   translate([r,r,0]) rotate([0,0,180]) rotate_extrude(angle=90) translate([r,0]) children();
   translate([x-r,r,0]) rotate([0,0,-90]) rotate_extrude(angle=90) translate([r,0]) children();
   translate([r,y-r,0]) rotate([0,0,90]) rotate_extrude(angle=90) translate([r,0]) children();
   translate([x-r,y-r,0]) rotate([0,0,0]) rotate_extrude(angle=90) translate([r,0]) children();
}

// ==== end include <library.scad>



// material to remove
module printer_frame()
{
   box([-100,-hw/2,0],[100,hw,hh]);
   cyl_z([0,0,0],h=hh,r=hw/2,$fn=36);
   cyl_z([0,0,hh-0.1],h=10,r=hd/2,$fn=72);
   cyl_z([-5,0,hh-0.1],h=10,r=hd/2,$fn=72);
   box([-5,-hd/2,hh-0.1],[5,hd,10]);

   rotate([0,0,90+45])
      box([-dms,-dms,dd],[100,100,10]);
}

module arm(test_bed=false)
{
   rotate([0,0,180])
      translate([-dms-zd,-dms,-dd])
      rotate([0,0,45])
      difference()
   {
      union()
      {
         box([-dl,-hw/2-fms,-fmb],[dl+10,hw+fms*2,hh+fmb+fma]);

         rotate([0,0,-45])
            box([0,0,dd-ah],[14+zd,aw,ah]);
      
      }
      printer_frame();
      intersection()
      {
         for (y=[-hw/2-1,hw/2-1.5,-3.3,0.8])
            box([-dl+1,y,dd-1],[14+dl+el-2,2.5,2]);

         if (test_bed)
            # rotate([0,0,90+45]) // bed
                box([-dms+2,-dms+2,0],[220,270,20]);
      }
   }
}

ch=25.2; // camera height
cw=24.2; // camera width
coh=10;  // camera optics height
cod=14;  // cutout for optics diameter
ccw=20;  // cable width
cosh=10; // camera optics shroud depth
cosha=3.5; // camera optics shroud sides height
cab=1;    // height above board
cbb=3;    // height below board
cbh=1;   // board height
ct=1.2;  // camera box wall thickness
cft=1.2;  // camera box front wall thickness
ctt=cab+cbb+cbh; // box interior total
ceb=1; // height above front

taw=aw+2; // twist arm width

fovx=62.2;
fovy=48.8;

module camera_box()
{
   cliph=ctt+ct+cft+0.2;
   difference()
   {
      box([-ct,-ct,0],[cw+ct*2,ch+ct*2,cliph+ceb+ct]);
      box([0,0,ct+2],[cw,ch,cliph+ceb+0.1]); // interior (not round box)
      box([cw-5,ch/2-ccw/2,ct-0.1],[10,ccw,10]); // cable
      roundbox([0,0,ct],[cw,ch,cliph+ceb+0.1],r=2,$fn=24); // interior (round)
   }
   intersection()
   {
      box([-ct,-ct,0],[cw+ct*2,ch+ct*2,cliph+ceb+ct]);
      union()
      {
         cyl_z([8,-ct,cliph],h=ceb,r=1.8,$fn=24);
         cyl_z([ch-8,-ct,cliph],h=ceb,r=1.8,$fn=24);
         cyl_z([8,ch+ct,cliph],h=ceb,r=1.8,$fn=24);
         cyl_z([ch-8,ch+ct,cliph],h=ceb,r=1.8,$fn=24);
      }
   }
   
   cyl_z([ 2.0,2.1,   0],h=ct+cbb,r=1.5,$fn=24);
   cyl_z([ 2.0,ch-2.1,0],h=ct+cbb,r=1.5,$fn=24);
   cyl_z([14.5,2.1,   0],h=ct+cbb,r=1.5,$fn=24);
   cyl_z([14.5,ch-2.1,0],h=ct+cbb,r=1.5,$fn=24);
   cyl_z([ 2.0,2.1,   0],h=ct+ctt,r=0.95,$fn=24);
   cyl_z([ 2.0,ch-2.1,0],h=ct+ctt,r=0.95,$fn=24);
   cyl_z([14.5,2.1,   0],h=ct+ctt,r=0.95,$fn=24);
   cyl_z([14.5,ch-2.1,0],h=ct+ctt,r=0.95,$fn=24);
}


// ===== include <scad-utils/transformations.scad>

// ===== include <se3.scad>

// ===== include <linalg.scad>
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

// ==== end include <linalg.scad>


// ===== include <so3.scad>
// so3


// ===== include <linalg.scad>
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

// ==== end include <linalg.scad>


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

// ==== end include <so3.scad>


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

// ==== end include <se3.scad>


// ===== include <linalg.scad>
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

// ==== end include <linalg.scad>


// ===== include <lists.scad>
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

/*!
  Remove element from the list by index.
  remove([4,3,2,1],1) => [4,2,1]
*/
function remove(list, i) = [for (i_=[0:1:len(list)-2]) list[i_ < i ? i_ : i_ + 1]];

// ==== end include <lists.scad>


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

// ==== end include <scad-utils/transformations.scad>


// ===== include <list-comprehension-demos/sweep.scad>

// ===== include <../scad-utils/linalg.scad>
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

// ==== end include <../scad-utils/linalg.scad>


// ===== include <../scad-utils/transformations.scad>

// ===== include <se3.scad>

// ===== include <linalg.scad>
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

// ==== end include <linalg.scad>


// ===== include <so3.scad>
// so3


// ===== include <linalg.scad>
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

// ==== end include <linalg.scad>


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

// ==== end include <so3.scad>


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

// ==== end include <se3.scad>


// ===== include <linalg.scad>
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

// ==== end include <linalg.scad>


// ===== include <lists.scad>
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

/*!
  Remove element from the list by index.
  remove([4,3,2,1],1) => [4,2,1]
*/
function remove(list, i) = [for (i_=[0:1:len(list)-2]) list[i_ < i ? i_ : i_ + 1]];

// ==== end include <lists.scad>


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

// ==== end include <../scad-utils/transformations.scad>


// ===== include <../scad-utils/lists.scad>
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

/*!
  Remove element from the list by index.
  remove([4,3,2,1],1) => [4,2,1]
*/
function remove(list, i) = [for (i_=[0:1:len(list)-2]) list[i_ < i ? i_ : i_ + 1]];

// ==== end include <../scad-utils/lists.scad>


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

// ==== end include <list-comprehension-demos/sweep.scad>

module wave_cylinder(r=10,h=20,w=2,amp=2,step=4,waves=4)
{

shape = [[0,0,0], [w,0,0], [w,1,0], [0,1,0]];

path = [for (a=[0:step:360-step])
    rotation([90,0,a]) * translation([r,0,0]) * scaling([1,h+amp*abs(sin(a*waves+90)), 1])
];

sweep(shape, path, true);
}

module camera_front()
{
   cfm=0.1;
   translate([0,0,ctt+ct])
   difference()
   {
      union()
      {
         box([cfm,cfm,0],[cw-cfm*2,ch-cfm*2,cft]); // square part
         box([cfm,(ch-taw)/2,0],[cw+cft+0.5-cfm,taw,4]); // connecft to twist arm + reinforce
//         cyl_z([cw-coh,ch/2,0],h=cft+cosh,r=cod/2+cft); // shroud
         liph=cft+1;
         cyl_z([cw-coh,ch/2,0],h=liph,r=cw/2-1,$fn=72); // lip
         box([cfm,cfm,0],[5,ch-cfm*2,liph]); // square part
         box([cw-5+cfm,cfm,0],[5,ch-cfm*2,liph]); // square part
         translate([cw-coh,ch/2,0])
            wave_cylinder(r=cod/2+0.1,h=cft+cosh,w=cft,amp=cosha,step=2,waves=2);
      }
      cyl_z([cw-coh,ch/2,-0.1],h=10,r=cod/2,$fn=72); // camera hole
   }

   if (0) // fov tester
   translate([cw-coh,ch/2,0])
      for (roty=[-fovy/2,0,fovy/2])
         rotate([0,roty,0])
            for (rotx=[-fovx/2,0,fovx/2])
               rotate([rotx,0,0]) cyl_z([0,0,0],h=1000,r=1);
}

module camera(front=false,back=false)
   rotate([0,90,0])
   translate([-ch,-cw/2,-ct])
{
   if (back) camera_box();
   if (front) camera_front();
}


// ===== include <dotscad/rotate_p.scad>
/**
* rotate_p.scad
*
* Rotates a point 'a' degrees around an arbitrary axis. 
* The rotation is applied in the following order: x, y, z. 
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-rotate_p.html
*
**/ 


// ===== include <__private__/__to2d.scad>
function __to2d(p) = [p[0], p[1]];
// ==== end include <__private__/__to2d.scad>
;

// ===== include <__private__/__to3d.scad>
function __to3d(p) = [p[0], p[1], 0];
// ==== end include <__private__/__to3d.scad>
;

function _rotx(pt, a) = 
    let(cosa = cos(a), sina = sin(a))
    [
        pt[0], 
        pt[1] * cosa - pt[2] * sina,
        pt[1] * sina + pt[2] * cosa
    ];

function _roty(pt, a) = 
    let(cosa = cos(a), sina = sin(a))
    [
        pt[0] * cosa + pt[2] * sina, 
        pt[1],
        -pt[0] * sina + pt[2] * cosa, 
    ];

function _rotz(pt, a) = 
    let(cosa = cos(a), sina = sin(a))
    [
        pt[0] * cosa - pt[1] * sina,
        pt[0] * sina + pt[1] * cosa,
        pt[2]
    ];

function _rotate_p_3d(point, a) =
    _rotz(_roty(_rotx(point, a[0]), a[1]), a[2]);

function to_avect(a) =
     len(a) == 3 ? a : (
         len(a) == 2 ? [a[0], a[1], 0] : (
             len(a) == 1 ? [a[0], 0, 0] : [0, 0, a]
         ) 
     );

function rotate_p(point, a) =
    let(angle = to_avect(a))
    len(point) == 3 ? 
        _rotate_p_3d(point, angle) :
        __to2d(
            _rotate_p_3d(__to3d(point), angle)
        );

// ==== end include <dotscad/rotate_p.scad>
;

// ===== include <dotscad/polysections.scad>
/**
* polysections.scad
*
* Crosscutting a tube-like shape at different points gets several cross-sections.
* This module can operate reversely. It uses cross-sections to construct a tube-like shape.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-polysections.html
*
**/


// ===== include <__private__/__reverse.scad>
function __reverse(vt) = 
    let(leng = len(vt))
    [
        for(i = [0:leng - 1])
            vt[leng - 1 - i]
    ];
// ==== end include <__private__/__reverse.scad>
;

module polysections(sections, triangles = "SOLID") {

    function side_indexes(sects, begin_idx = 0) = 
        let(       
            leng_sects = len(sects),
            leng_pts_sect = len(sects[0])
        ) 
        concat(
            [
                for(j = [begin_idx:leng_pts_sect:begin_idx + (leng_sects - 2) * leng_pts_sect])
                    for(i = [0:leng_pts_sect - 1]) 
                        [
                            j + i, 
                            j + (i + 1) % leng_pts_sect, 
                            j + (i + 1) % leng_pts_sect + leng_pts_sect
                        ]
            ],
            [
                for(j = [begin_idx:leng_pts_sect:begin_idx + (leng_sects - 2) * leng_pts_sect])
                    for(i = [0:leng_pts_sect - 1]) 
                        [
                            j + i, 
                            j + (i + 1) % leng_pts_sect + leng_pts_sect , 
                            j + i + leng_pts_sect
                        ]
            ]      
        );

    function search_at(f_sect, p, leng_pts_sect, i = 0) =
        i < leng_pts_sect ?
            (p == f_sect[i] ? i : search_at(f_sect, p, leng_pts_sect, i + 1)) : -1;
    
    function the_same_after_twisting(f_sect, l_sect, leng_pts_sect) =
        let(
            found_at_i = search_at(f_sect, l_sect[0], leng_pts_sect)
        )
        found_at_i <= 0 ? false : 
            l_sect == concat(
                [for(i = [found_at_i:leng_pts_sect-1]) f_sect[i]],
                [for(i = [0:found_at_i - 1]) f_sect[i]]
            ); 

    function to_v_pts(sects) = 
            [
            for(sect = sects) 
                for(pt = sect) 
                    pt
            ];                   

    module solid_sections(sects) {
        
        leng_sects = len(sects);
        leng_pts_sect = len(sects[0]);
        first_sect = sects[0];
        last_sect = sects[leng_sects - 1];
   
        v_pts = [
            for(sect = sects) 
                for(pt = sect) 
                    pt
        ];

        function begin_end_the_same() =
            first_sect == last_sect || 
            the_same_after_twisting(first_sect, last_sect, leng_pts_sect);

        if(begin_end_the_same()) {
            f_idxes = side_indexes(sects);

            polyhedron(
                v_pts, 
                f_idxes
            ); 

            // hook for testing
            test_polysections_solid(v_pts, f_idxes);
        } else {
            first_idxes = [for(i = [0:leng_pts_sect - 1]) leng_pts_sect - 1 - i];  
            last_idxes = [
                for(i = [0:leng_pts_sect - 1]) 
                    i + leng_pts_sect * (leng_sects - 1)
            ];    

            f_idxes = concat([first_idxes], side_indexes(sects), [last_idxes]);
            
            polyhedron(
                v_pts, 
                f_idxes
            );   

            // hook for testing
            test_polysections_solid(v_pts, f_idxes);             
        }
    }

    module hollow_sections(sects) {
        leng_sects = len(sects);
        leng_sect = len(sects[0]);
        half_leng_sect = leng_sect / 2;
        half_leng_v_pts = leng_sects * half_leng_sect;

        function strip_sects(begin_idx, end_idx) = 
            [
                for(i = [0:leng_sects - 1]) 
                    [
                        for(j = [begin_idx:end_idx])
                            sects[i][j]
                    ]
            ]; 

        function first_idxes() = 
            [
                for(i =  [0:half_leng_sect - 1]) 
                    [
                       i,
                       i + half_leng_v_pts,
                       (i + 1) % half_leng_sect + half_leng_v_pts, 
                       (i + 1) % half_leng_sect
                    ] 
            ];

        function last_idxes(begin_idx) = 
            [
                for(i =  [0:half_leng_sect - 1]) 
                    [
                       begin_idx + i,
                       begin_idx + (i + 1) % half_leng_sect,
                       begin_idx + (i + 1) % half_leng_sect + half_leng_v_pts,
                       begin_idx + i + half_leng_v_pts
                    ]     
            ];            

        outer_sects = strip_sects(0, half_leng_sect - 1);
        inner_sects = strip_sects(half_leng_sect, leng_sect - 1);

        outer_v_pts =  to_v_pts(outer_sects);
        inner_v_pts = to_v_pts(inner_sects);

        outer_idxes = side_indexes(outer_sects);
        inner_idxes = [ 
            for(idxes = side_indexes(inner_sects, half_leng_v_pts))
                __reverse(idxes)
        ];

        first_outer_sect = outer_sects[0];
        last_outer_sect = outer_sects[leng_sects - 1];
        first_inner_sect = inner_sects[0];
        last_inner_sect = inner_sects[leng_sects - 1];
        
        leng_pts_sect = len(first_outer_sect);

        function begin_end_the_same() = 
           (first_outer_sect == last_outer_sect && first_inner_sect == last_inner_sect) ||
           (
               the_same_after_twisting(first_outer_sect, last_outer_sect, leng_pts_sect) && 
               the_same_after_twisting(first_inner_sect, last_inner_sect, leng_pts_sect)
           ); 

        v_pts = concat(outer_v_pts, inner_v_pts);

        if(begin_end_the_same()) {
            f_idxes = concat(outer_idxes, inner_idxes);

            polyhedron(
                v_pts,
                f_idxes
            );      

            // hook for testing
            test_polysections_solid(v_pts, f_idxes);                     
        } else {
            first_idxes = first_idxes();
            last_idxes = last_idxes(half_leng_v_pts - half_leng_sect);

            f_idxes = concat(first_idxes, outer_idxes, inner_idxes, last_idxes);
            
            polyhedron(
                v_pts,
                f_idxes
            ); 

            // hook for testing
            test_polysections_solid(v_pts, f_idxes);              
        }
    }
    
    module triangles_defined_sections() {
        module tri_sections(tri1, tri2) {
            hull() polyhedron(
                points = concat(tri1, tri2),
                faces = [
                    [0, 1, 2], 
                    [3, 5, 4], 
                    [1, 3, 4], [2, 1, 4], [2, 3, 0], 
                    [0, 3, 1], [2, 4, 5], [2, 5, 3]
                ]
            );  
        }

        module two_sections(section1, section2) {
            for(idx = triangles) {
               tri_sections(
                    [
                        section1[idx[0]], 
                        section1[idx[1]], 
                        section1[idx[2]]
                    ], 
                    [
                        section2[idx[0]], 
                        section2[idx[1]], 
                        section2[idx[2]]
                    ]
                );
            }
        }
        
        for(i = [0:len(sections) - 2]) {
             two_sections(
                 sections[i], 
                 sections[i + 1]
             );
        }
    }
    
    if(triangles == "SOLID") {
        solid_sections(sections);
    } else if(triangles == "HOLLOW") {
        hollow_sections(sections);
    }
    else {
        triangles_defined_sections();
    }
}

// override it to test

module test_polysections_solid(points, faces) {

}
// ==== end include <dotscad/polysections.scad>
;

// ===== include <dotscad/path_extrude.scad>
/**
* path_extrude.scad
*
* It extrudes a 2D shape along a path. 
* This module is suitable for a path created by a continuous function.
* It depends on the rotate_p function and the polysections module. 
* Remember to include "rotate_p.scad" and "polysections.scad".
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-path_extrude.html
*
**/


// ===== include <__private__/__is_vector.scad>
function __is_vector(value) = !(value >= "") && len(value) != undef;
// ==== end include <__private__/__is_vector.scad>
;

// ===== include <__private__/__to3d.scad>
function __to3d(p) = [p[0], p[1], 0];
// ==== end include <__private__/__to3d.scad>
;

// ===== include <__private__/__angy_angz.scad>
function __angy_angz(p1, p2) = 
    let(
        dx = p2[0] - p1[0],
        dy = p2[1] - p1[1],
        dz = p2[2] - p1[2],
        ya = atan2(dz, sqrt(pow(dx, 2) + pow(dy, 2))),
        za = atan2(dy, dx)
    ) [ya, za];
// ==== end include <__private__/__angy_angz.scad>
;

// ===== include <__private__/__length_between.scad>
function __length_between(p1, p2) =
    let(
        dx = p2[0] - p1[0],
        dy = p2[1] - p1[1],
        dz = p2[2] - p1[2]
    ) sqrt(pow(dx, 2) + pow(dy, 2) + pow(dz, 2));
// ==== end include <__private__/__length_between.scad>
;

module path_extrude(shape_pts, path_pts, triangles = "SOLID", twist = 0, scale = 1.0, closed = false) {
    sh_pts = len(shape_pts[0]) == 3 ? shape_pts : [for(p = shape_pts) __to3d(p)];
    pth_pts = len(path_pts[0]) == 3 ? path_pts : [for(p = path_pts) __to3d(p)];

    len_path_pts = len(pth_pts);    
    len_path_pts_minus_one = len_path_pts - 1;     

    scale_step_vt = __is_vector(scale) ? 
        [(scale[0] - 1) / len_path_pts_minus_one, (scale[1] - 1) / len_path_pts_minus_one] :
        [(scale - 1) / len_path_pts_minus_one, (scale - 1) / len_path_pts_minus_one];

    scale_step_x = scale_step_vt[0];
    scale_step_y = scale_step_vt[1];
    twist_step = twist / len_path_pts_minus_one;

    function section(p1, p2, i) = 
        let(
            length = __length_between(p1, p2),
            angy_angz = __angy_angz(p1, p2),
            ay = -angy_angz[0],
            az = angy_angz[1]
        )
        [
            for(p = sh_pts) 
                let(scaled_p = [p[0] * (1 + scale_step_x * i), p[1] * (1 + scale_step_y * i), p[2]])
                rotate_p(
                     rotate_p(
                         rotate_p(scaled_p, twist_step * i), [90, 0, -90]
                     ) + [i == 0 ? 0 : length, 0, 0], 
                     [0, ay, az]
                ) + p1
        ];
    
    function path_extrude_inner(index) =
       index == len_path_pts ? [] :
           concat(
               [section(pth_pts[index - 1], pth_pts[index],  index)],
               path_extrude_inner(index + 1)
           );

    function calculated_sections() =
        let(sections = path_extrude_inner(1))
        closed && pth_pts[0] == pth_pts[len_path_pts_minus_one] ?
            concat(sections, [sections[0]]) : // round-robin
            concat([section(pth_pts[0], pth_pts[1], 0)], sections);
   
   sections = calculated_sections();

    polysections(
        sections,
        triangles = triangles
    );   

    // hook for testing
    test_path_extrude(sections);
}

// override to test
module test_path_extrude(sections) {

}
// ==== end include <dotscad/path_extrude.scad>
;

// ===== include <dotscad/bezier_curve.scad>
/**
* bezier_curve.scad
*
* Given a set of control points, the bezier_curve function returns points of the Bézier path. 
* Combined with the polyline, polyline3d or hull_polyline3d module defined in my lib-openscad, 
* you can create a Bézier curve.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-bezier_curve.html
*
**/ 


// ===== include <__private__/__to2d.scad>
function __to2d(p) = [p[0], p[1]];
// ==== end include <__private__/__to2d.scad>
;

function _combi(n, k) =
    let(  
        bi_coef = [      
               [1],     // n = 0: for padding
              [1,1],    // n = 1: for Linear curves, how about drawing a line directly?
             [1,2,1],   // n = 2: for Quadratic curves
            [1,3,3,1]   // n = 3: for Cubic Bézier curves
        ]  
    )
    n < len(bi_coef) ? bi_coef[n][k] : (
        k == 0 ? 1 : (_combi(n, k - 1) * (n - k + 1) / k)
    );
        
function bezier_curve_coordinate(t, pn, n, i = 0) = 
    i == n + 1 ? 0 : 
        (_combi(n, i) * pn[i] * pow(1 - t, n - i) * pow(t, i) + 
            bezier_curve_coordinate(t, pn, n, i + 1));
        
function _bezier_curve_point(t, points) = 
    let(n = len(points) - 1) 
    [
        bezier_curve_coordinate(
            t, 
            [for(p = points) p[0]], 
            n
        ),
        bezier_curve_coordinate(
            t,  
            [for(p = points) p[1]], 
            n
        ),
        bezier_curve_coordinate(
            t, 
            [for(p = points) p[2]], 
            n
        )
    ];

function bezier_curve(t_step, points) = 
    let(
        pts = concat([
            for(t = [0: ceil(1 / t_step) - 1])
                _bezier_curve_point(t * t_step, points)
        ], [_bezier_curve_point(1, points)])
    ) 
    len(points[0]) == 3 ? pts : [for(pt = pts) __to2d(pt)];

// ==== end include <dotscad/bezier_curve.scad>
;

rear=-7;

module twistarm()
{
   t_step = 0.05;

   shape_pts=[ [-taw/2,-2], [taw/2,-2], [taw/2,2], [-taw/2,2] ];
   v=[-cos(twd),sin(twd)*sin(twl),-sin(twd)*cos(twl)];
   
   path_pts = bezier_curve(0.03,
                           [ //[-ah,0,rear+a1],
                             [0,0,rear+a1],
                             [5,0,rear+a1],
                             [10,0,rear+a1],
                             [lh+15*v.x,15*v.y,15*v.z],
                             [lh+12*v.x,12*v.y,12*v.z],
                             [lh+10*v.x,10*v.y,10*v.z],
                             [lh+8*v.x,8*v.y,8*v.z],
                             [lh+5*v.x,5*v.y,5*v.z],
                             [lh+2*v.x,2*v.y,2*v.z],
                             [lh,0,0] ]);
   

   path_extrude(shape_pts, path_pts, twist=-twl);
}

module twistarm2()
{
   t_step = 0.05;

   shape_pts=[ [-taw/2,-2], [taw/2,-2], [taw/2,2], [-taw/2,2] ];
   v=[-cos(twd),sin(twd)*sin(twl),-sin(twd)*cos(twl)];
   
   path_pts = bezier_curve(0.02,
                           [ //[-ah,0,rear+a2],
                             [0,0,rear+a2],
                             [1,0,rear+a2],
                             [2,0,rear+a2],
                             [8,0,rear+a2],
                             [10,0,0],
                             [lh+15*v.x,15*v.y,15*v.z],
                             [lh+5*v.x,5*v.y,5*v.z],
                             [lh+2*v.x,2*v.y,2*v.z],
                             [lh,0,0] ]);
   

   path_extrude(shape_pts, path_pts, twist=-twl);
}

module uparm()
{
   translate([2,aw/2,lh])
      rotate([0,0,twl])
      rotate([0,twd,0])
      translate([-7,-0.5,0])
      camera(front=true);
   
   translate([2,aw/2,0])
      rotate([0,0,180])
      rotate([0,-90,0])
   {
      twistarm();
      twistarm2();
   }

   th=1;
   translate([rear+2,0,0])
      difference()
   {
      union()
      {
         box([-2,-(taw-aw)/2,-ah-th],[34,taw,ah+th*2]);
         smr=4/2;
         cyl_y([-2+smr,-(taw-aw)/2,-ah-th],h=taw,r=smr,$fn=36);
         cyl_y([32-smr,-(taw-aw)/2,-ah-th],h=taw,r=smr,$fn=36);
      }
      box([-5,-bm,-ah-bm],[200,aw+bm*2,ah+bm*2]);
   }

}

if (part=="test - all")
{
   arm(test_bed=true);

   translate([7,0.05,0.05])
   {

#translate([2,aw/2,lh])
      rotate([0,0,twl])
         rotate([0,twd,0])
         translate([-7.2,-0.5,0])
         camera(back=true);

      uparm();
   }
}

if (part=="camera front and arm")
{
   rotate([0,-90,0]) uparm();
}

if (part=="arm")
   rotate([180,0,0]) arm();

if (part=="camera rear")
   rotate([0,-90,0]) camera(back=true);

//   camera_front();

//twistarm();

//uparm();

//rotate([0,-90,0]) uparm();
// rotate([0,-90,0]) camera(back=true);
