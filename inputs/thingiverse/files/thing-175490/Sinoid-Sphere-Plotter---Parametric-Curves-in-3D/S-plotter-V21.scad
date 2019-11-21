// Sinoid Sphere Plotter V2.1
// This is public domain, free software by Jürgen Lochner, 2013
// www.thingiverse.com/Ablapo
// You are free to improve this. 

// Size:
gr=10;

// a sei winkel in xy ebene, b sei winkel in xz ebene
//function rx(a,b) =  cos(a )*cos(b )*gr ;			// basic sphere
//function ry(a,b) =  sin(a)*cos(b )*gr;			// basic sphere
//function rz(a,b) =  sin( b ) *gr ;					// basic sphere

//function rx(a,b) =  cos(a )*cos(b )*gr ;			// f1 Fortue cookie
//function ry(a,b) =  sin(a)*cos(b )*gr;			// f1 Fortue cookie
//function rz(a,b) =  sin(  a*2 )  *gr;				// f1 Fortue cookie

//function rx(a,b) =  cos(a )*cos(b )*gr ;			// f2 XOXO
//function ry(a,b) =  sin(a)*cos(b )*gr;			// f2 XOXO
//function rz(a,b) =  sin(  a*2+b )  *gr;			// f2 XOXO

//function rx(a,b) =  cos(a )*cos(b )*gr ;			// f3 2ears
//function ry(a,b) =  sin(a)*cos(b )*gr;			// f3 2ears
//function rz(a,b) =  (cos(  a  ) +cos(b)) *gr;	// f3 2ears

//function rx(a,b) =  cos(a )*cos(b )*gr ;			// f4 8
//function ry(a,b) =  sin(a)*cos(b )*gr;			// f4 8
//function rz(a,b) =  (cos(  a  ) +sin(b)) *gr;	// f4 8

//function ry(a,b) =  sin(a)*cos(b )*gr;			// f5
//function rx(a,b) =  cos(a*2 )*cos(b*2 )*gr ;		// f5
//function rz(a,b) =  (cos(  a  ) +sin(a )) *gr;	// f5

function rx(a,b)=   gr*cos(a)*(2+cos(a/2)*cos(b)-sin(a/2)*sin(2*b)); 	//figure 8 immersion
function ry(a,b)=   gr*sin(a)*(2+cos(a/2)*cos(b)-sin(a/2)*sin(2*b)); 	//figure 8 immersion
function rz(a,b) =  gr*(sin(a/2)*cos(b)+cos(a/2)*sin(2*b));				//figure 8 immersion

//function rx(a,b)= (sin(a)+sin(2*a)*2 +cos(b))*gr ;	// knot
//function ry(a,b)= (cos(a)-cos(2*a)*2 -sin(b))*gr;		//	knot
//function rz(a,b) = (-sin(3*b )+2*cos(a ))*gr;			// knot


// Use OpenSCAD to change functions:
sorry = 1; //[1: you cannot change functions in Customizer]

// Details:
detail=20;

steps=360/detail;

// Thickness:
d=0.5;

// Choose mode:
style=2;// [1:smooth slow, 2:flaking fast]

// alpha period:
ap=360;

// beta period:
bp=360;

module objekt( ){cube([d,d,d],center=true);}

module polyplot(x1,y1,z1, x2,y2,z2, x3,y3,z3){
	hull() {
		translate([x1,y1,z1]) objekt();
		translate([x2,y2,z2]) objekt();
		translate([x3,y3,z3]) objekt();
	}
}

module smooth (){
	for (i =[0:steps:ap-steps]){
		for (j =[0:steps:bp-steps]){
	polyplot (	rx(i,j), ry(i,j), rz(i,j), 
					rx(i+steps,j), ry(i+steps,j), rz(i+steps,j), 
					rx(i+steps,j+steps), ry(i+steps,j+steps), rz(i+steps,j+steps));

	color ("red")
	polyplot (	rx(i,j),ry(i,j),rz(i,j), 
					rx(i+steps,j+steps),ry(i+steps,j+steps),rz(i+steps,j+steps),  
					rx(i,j+steps),ry(i,j+steps),rz(i,j+steps));

		}	
	}
}

module polyplot2(x1,y1,z1, x2,y2,z2, x3,y3,z3){
	ax=x2-x1;		bx=x3-x1;
	ay=y2-y1;		by=y3-y1;
	az=z2-z1;		bz=z3-z1;
	axbx= ay*bz - az*by;
	axby= az*bx - ax*bz;
	axbz= ax*by - ay*bx;
	haxb = sqrt(axbx*axbx+axby*axby+axbz*axbz);	
	nx = axbx/haxb *d;
	ny = axby/haxb *d;
	nz = axbz/haxb *d;

	polyhedron(	points=[ [0,0,0],	[x1 ,y1 ,z1 ], [x2 ,y2 ,z2 ], [x3 ,y3 ,z3 ],  
						[x1+nx,y1+ny,z1+nz], [x2+nx,y2+ny,z2+nz], [x3+nx,y3+ny,z3+nz]],
					triangles = [[1,2,3], [6,5,4], [2,1,4], [2,4,5], [3,2,6], [2,5,6], [1,6,4], [3,6,1]]
				); 
}

module flake(){
	rsteps=steps+0.1;
	for ( i = [0: steps: ap - steps]){
		for ( j = [0: steps: bp - steps]){
		hull(){	
			polyplot2 (	rx(i,j), ry(i,j), rz(i,j), 
					rx(i+rsteps,j), ry(i+rsteps,j), rz(i+rsteps,j), 
					rx(i+rsteps,j+rsteps), ry(i+rsteps,j+rsteps), rz(i+rsteps,j+rsteps));

			polyplot2 (	rx(i,j),ry(i,j),rz(i,j), 
					rx(i+rsteps,j+rsteps),ry(i+rsteps,j+rsteps),rz(i+rsteps,j+rsteps),  
					rx(i,j+rsteps),ry(i,j+rsteps),rz(i,j+rsteps));
		}	
		}
	}
}

if (style==1) smooth();
if (style==2) flake();
