

//Draws a parametric, potentially twisted, tesseract (hyper cube)
//Can adjust the lengths, width of sticks, and angles of rotation of inner cube.

//Derived from the following:
//  vector/matrix math routines from http://www.thingiverse.com/thing:9447
//  Connected Stick routines from my thing:  http://www.thingiverse.com/thing:43806
//  single layer raft idea from:  http://www.thingiverse.com/thing:23886

//written by Craig Zupke (Ekpuz), January 2013

Stick_Diameter=5;
Outer_Cube_Length=75;
Inner_Cube_Length=40;
X_Angle=15;
Y_Angle=15;
Z_Angle=15;
r=Stick_Diameter/2; //radious of sticks
oL=Outer_Cube_Length/2; //half of length of outer cube
iL=Inner_Cube_Length/2; //length of inner cube

ax=X_Angle; //angle of rotation of inner cube along x axis
ay=Y_Angle;//angle of rotation of inner cube along y axis
az=Z_Angle;//angle of rotation of inner cube along z axis

function CubeList(L)=[[L,L,L],
		   [-L,L,L],
			[-L,-L,L],
			[L,-L,L],
			[L,L,-L],
			[-L,L,-L],
			[-L,-L,-L],
			[L,-L,-L]];

	
Rx=transform_rotx(ax);
Ry=transform_roty(ay);
Rz=transform_roty(az);

Rxy= mat4_mult_mat4(Rx, Ry);
Rxyz=mat4_mult_mat4(Rxy,Rz);
echo("Rxyz",Rxyz);
iCL=RotateCubeList(Rxyz,CubeList(iL));
echo("iCL=",iCL);
bot=(oL+2*r);
StickTesseract(CubeList(oL),iCL,r);


function RotateCubeList(RM,CL)=[vec3_from_point3(vec4_mult_mat4(point3_from_vec3(CL[0]), RM)),
								vec3_from_point3(vec4_mult_mat4(point3_from_vec3(CL[1]), RM)),
								vec3_from_point3(vec4_mult_mat4(point3_from_vec3(CL[2]), RM)),
								vec3_from_point3(vec4_mult_mat4(point3_from_vec3(CL[3]), RM)),
								vec3_from_point3(vec4_mult_mat4(point3_from_vec3(CL[4]), RM)),
								vec3_from_point3(vec4_mult_mat4(point3_from_vec3(CL[5]), RM)),
								vec3_from_point3(vec4_mult_mat4(point3_from_vec3(CL[6]), RM)),
								vec3_from_point3(vec4_mult_mat4(point3_from_vec3(CL[7]), RM))];

module DrawStick(x1,y1,z1,x2,y2,z2,rs){
	xt=x2-x1;
	yt=y2-y1;
	zt=z2-z1;
	L=sqrt(xt*xt+yt*yt+zt*zt);
	th=0;
	Q1=[xt,yt,zt];
	Q2=[L,0,0];
	Q1dotQ2=xt*L;//Q1*Q2;
	echo(Q1dotQ2);
	theta=acos(Q1dotQ2/L/L);
if (theta==180)
{
   translate([x2,y2,z2])rotate(a=[0,90,0])union(){
	cylinder(h=L,r=rs);
	sphere(r=rs);
	translate([0,0,L])sphere(r=rs);
   }
echo("theta==180",L,zt,yt);
} else {
    translate([x1,y1,z1])rotate(a=theta,v=[0,-L*zt,L*yt])rotate(a=[0,90,0])union(){
	cylinder(h=L,r=rs);
	sphere(r=rs);
	translate([0,0,L])sphere(r=rs);
   }
}

	
echo ("theta=",theta);
}

	
//union(){DrawStick(20,20,20,50,20,20,5);DrawStick(50,0,0,50,50,0,5);DrawStick(50,50,0,0,50,00,5);};//


module ConnectedSticks(CoordinateList,r){
	p1=CoordinateList[0];
	p2=CoordinateList[1];
	np=len(CoordinateList);
	echo("np=",np);
	for(i=[1:len(CoordinateList)]){
			assign(p1=CoordinateList[i-1]);
			assign(p2=CoordinateList[i]);
			echo("i=",i,p1,p2,CoordinateList[2]);
			DrawStick(CoordinateList[i-1][0],CoordinateList[i-1][1],CoordinateList[i-1][2],CoordinateList[i][0],CoordinateList[i][1],CoordinateList[i][2],r);
			
		
	}
}

//ConnectedSticks([[0,0,0],[10,0,0],[10,10,0],[10,10,10]],2);
//StickCube([[50,50,50],
//		   [-50,50,50],
//			[-50,-50,50],
//			[50,-50,50],
//			[50,50,-50],
//			[-50,50,-50],
//			[-50,-50,-50],
//			[50,-50,-50]],5);

//StickTesseract(CubeList(50),CubeList(20),r);

module StickCube(corners,r){
	A=corners[0];
	B=corners[1];
	C=corners[2];
	D=corners[3];
	E=corners[4];
	F=corners[5];
	G=corners[6];
	H=corners[7];

	union(){
		ConnectedSticks([A,B,C,D,A],r);
		ConnectedSticks([E,F,G,H,E],r);
		ConnectedSticks([A,E],r);
		ConnectedSticks([B,F],r);
		ConnectedSticks([C,G],r);
		ConnectedSticks([D,H],r);
	}
}
module StickTesseract(OutCorners,InCorners,r){
	oA=OutCorners[0];
	oB=OutCorners[1];
	oC=OutCorners[2];
	oD=OutCorners[3];
	oE=OutCorners[4];
	oF=OutCorners[5];
	oG=OutCorners[6];
	oH=OutCorners[7];
	iA=InCorners[0];
	iB=InCorners[1];
	iC=InCorners[2];
	iD=InCorners[3];
	iE=InCorners[4];
	iF=InCorners[5];
	iG=InCorners[6];
	iH=InCorners[7];

	union(){
		ConnectedSticks([oA,oB,oC,oD,oA],r);
		ConnectedSticks([oE,oF,oG,oH,oE],r);
		ConnectedSticks([oA,oE],r);
		ConnectedSticks([oB,oF],r);
		ConnectedSticks([oC,oG],r);
		ConnectedSticks([oD,oH],r);
		ConnectedSticks([iA,iB,iC,iD,iA],r);
		ConnectedSticks([iE,iF,iG,iH,iE],r);
		ConnectedSticks([iA,iE],r);
		ConnectedSticks([iB,iF],r);
		ConnectedSticks([iC,iG],r);
		ConnectedSticks([iD,iH],r);
		ConnectedSticks([iA,oA],r);
		ConnectedSticks([iB,oB],r);
		ConnectedSticks([iC,oC],r);
		ConnectedSticks([iD,oD],r);
		ConnectedSticks([iE,oE],r);
		ConnectedSticks([iF,oF],r);
		ConnectedSticks([iG,oG],r);
		ConnectedSticks([iH,oH],r);

	}
}

//written to compliment routines in William A Adams' code
//Create vec3 from homogonized point (Added by Craig Zupke)
function vec3_from_point3(pnt)=[pnt[0],pnt[1],pnt[2]];

//The code below I borrowed from http://www.thingiverse.com/thing:9447
//I've only included those routines I ended up using.  If I had known about it 
//when initially writing my stuff, it probably would have turned out a bit less
//"kludgy".

//===================================== 
// This is public Domain Code
// Contributed by: William A Adams
// May 2011
//=====================================

/*
	A set of math routines for graphics calculations

	There are many sources to draw from to create the various math
	routines required to support a graphics library.  The routines here
	were created from scratch, not borrowed from any particular 
	library already in existance.

	One great source for inspiration is the book:
		Geometric Modeling
		Author: Michael E. Mortenson

	This book has many great explanations about the hows and whys
	of geometry as it applies to modeling.

	As this file may accumulate quite a lot of routines, you can either
	include it whole in your OpenScad files, or you can choose to 
	copy/paste portions that are relevant to your particular situation.

	It is public domain code, simply to avoid any licensing issues.
*/

//=========================================
//	Matrix 4X4 Operations
//
// Upper left 3x3 == scaling, shearing, reflection, rotation (linear transformations)
// Upper right 3x1 == Perspective transformation
// Lower left 1x3 == translation
// Lower right 1x1 == overall scaling
//=========================================

function mat4_identity() = [
	[1, 0, 0, 0],
	[0, 1, 0, 0],
	[0, 0, 1, 0],
	[0, 0, 0, 1]
	];

function mat4_transpose(m) = [
	[m[0][0], m[1][0], m[2][0], m[3][0]],
	[m[0][1], m[1][1], m[2][1], m[3][1]],
	[m[0][2], m[1][2], m[2][2], m[3][2]],
	[m[0][3], m[1][3], m[2][3], m[3][3]]
	];

function mat4_col(m, col) = [
	m[0][col],
	m[1][col],
	m[2][col],
	m[3][col]
	];

function mat4_add_mat4(m1, m2) = [
	vec4_add(m1[0], m2[0]),
	vec4_add(m1[1], m2[1]),
	vec4_add(m1[2], m2[2]),
	vec4_add(m1[3], m2[3])
	];

// Multiply two 4x4 matrices together
// This is one of the workhorse mechanisms of the 
// graphics system
function mat4_mult_mat4(m1, m2) = [
	[vec4_dot(m1[0], mat4_col(m2,0)),
	vec4_dot(m1[0], mat4_col(m2,1)),
	vec4_dot(m1[0], mat4_col(m2,2)),
	vec4_dot(m1[0], mat4_col(m2,3))],

	[vec4_dot(m1[1], mat4_col(m2,0)),
	vec4_dot(m1[1], mat4_col(m2,1)),
	vec4_dot(m1[1], mat4_col(m2,2)),
	vec4_dot(m1[1], mat4_col(m2,3))],
	
	[vec4_dot(m1[2], mat4_col(m2,0)),
	vec4_dot(m1[2], mat4_col(m2,1)),
	vec4_dot(m1[2], mat4_col(m2,2)),
	vec4_dot(m1[2], mat4_col(m2,3))],

	[vec4_dot(m1[3], mat4_col(m2,0)),
	vec4_dot(m1[3], mat4_col(m2,1)),
	vec4_dot(m1[3], mat4_col(m2,2)),
	vec4_dot(m1[3], mat4_col(m2,3))],
];

// This is the other workhorse routine
// Most transformations are of a vector and 
// a transformation matrix.
function vec4_mult_mat4(vec, mat) = [
	vec4_dot(vec, mat4_col(mat,0)), 
	vec4_dot(vec, mat4_col(mat,1)), 
	vec4_dot(vec, mat4_col(mat,2)), 
	vec4_dot(vec, mat4_col(mat,3)), 
	];

function vec4_mult_mat34(vec, mat) = [
	vec4_dot(vec, mat4_col(mat,0)), 
	vec4_dot(vec, mat4_col(mat,1)), 
	vec4_dot(vec, mat4_col(mat,2))
	];


// Linear Transformations

//	Rotation
function transform_rotx(angle) = [
	[1, 0, 0, 0],
	[0, cos(angle), sin(angle), 0],
	[0, -sin(angle), cos(angle), 0],
	[0, 0, 0, 1]
	];

function  transform_rotz(deg) = [
	[cos(deg), sin(deg), 0, 0],
	[-sin(deg), cos(deg), 0, 0],
	[0, 0, 1, 0],
	[0, 0, 0, 1]
	];

function  transform_roty(deg) = [
	[cos(deg), 0, -sin(deg), 0],
	[0, 1, 0, 0],
	[sin(deg), 0, cos(deg), 0],
	[0, 0, 0, 1]
	];

//=======================================
//
// 				Vector Routines
//
//=======================================

// Basic vector routines

function vec4_dot(v1,v2) = v1[0]*v2[0]+v1[1]*v2[1]+v1[2]*v2[2]+v1[3]*v2[3];


//=======================================
//
// 				Point Routines
//
//=======================================

// Create a homogenized point from a vec3
function point3_from_vec3(vec) = [vec[0], vec[1], vec[2], 1]; 
