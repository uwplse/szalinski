include <utils/build_plate.scad>
// preview[view:south west, tilt:top diagonal]

// Pick a predefined Shape or "custom" and define a new one
selected_shape = 0; //[0:Square,1:Trapezoid,2:Tower,3:Custom]
// Level of recursion, careful with high recursions, this may be slow
recursion=3; //[1,2,3,4]
// Line in OpenSCAD polygon notation that will be used as base for the fractal. Points should have positive x values and the last point needs to have y=0.
custom_shape = [[[2,0.75],[2,-0.75],[5,-0.75],[5,0],[9,0]],[[0,1,2,3,4]]];
shapes=[[[[0.8,1],[0.8,0],[3.6,0]],[[0,1,2]]],
	[[[1,1.2],[2,0],[4.4,0]],[[0,1,2]]],
	[[[5,5.5],[5,3],[2,3],[2,2],[25,0]],[[0,1,2,3,4]]]];
base_size=100; //[20:300]
// How much is added to the base of the fractal
appendage = 10; //[1:50]
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
build_plate_manual_x = 100; //[100:400]
build_plate_manual_y = 100; //[100:400]
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

module fractal(base_size,shape,recursion) {
	abslen=shape[0][len(shape[0])-1][0]/2;
	translate([0,0,appendage])
	rotate([0,0,45])
	recursive([shape[0]/abslen,shape[1]],recursion,[-base_size/sqrt(2),0,0],[0,-base_size/sqrt(2),0],[base_size/sqrt(2),0,0],[0,base_size/sqrt(2),0]);
};

module recursive(shape,rec,pp1,pp2,pp3,pp4) {
	mp=(pp1+pp2+pp3+pp4)/4;
	l13=(pp3-pp1)/2;
	l24=(pp2-pp4)/2;
	ll13=sqrt(l13[0]*l13[0]+l13[1]*l13[1]+l13[2]*l13[2]);
	ll24=sqrt(l24[0]*l24[0]+l24[1]*l24[1]+l24[2]*l24[2]);
	l1=-(mp-pp1)/2;
	l2=-(mp-pp2)/2;
	l3=-(mp-pp3)/2;
	l4=-(mp-pp4)/2;
	normal=cross(l24/ll24,l13/ll13)*(ll13+ll24)/(2*sqrt(2));
	if(rec==0) {
		polyhedron(points=[pp1,pp2,pp3,pp4],triangles=[[0,2,1],[0,3,2]]);
	} else {
		for(i = [1:len(shape[1][0])-1]) {
			forLine(i);
		}
	}
	module forLine(i) {
		lp1=shape[0][shape[1][0][i-1]];
		lp2=shape[0][shape[1][0][i]];
		p1=mp+[lp1[0]*l1[0]+lp1[1]*normal[0],lp1[0]*l1[1]+lp1[1]*normal[1],lp1[0]*l1[2]+lp1[1]*normal[2]];
		p2=mp+[lp1[0]*l2[0]+lp1[1]*normal[0],lp1[0]*l2[1]+lp1[1]*normal[1],lp1[0]*l2[2]+lp1[1]*normal[2]];
		p3=mp+[lp1[0]*l3[0]+lp1[1]*normal[0],lp1[0]*l3[1]+lp1[1]*normal[1],lp1[0]*l3[2]+lp1[1]*normal[2]];
		p4=mp+[lp1[0]*l4[0]+lp1[1]*normal[0],lp1[0]*l4[1]+lp1[1]*normal[1],lp1[0]*l4[2]+lp1[1]*normal[2]];
		p5=mp+[lp2[0]*l1[0]+lp2[1]*normal[0],lp2[0]*l1[1]+lp2[1]*normal[1],lp2[0]*l1[2]+lp2[1]*normal[2]];
		p6=mp+[lp2[0]*l2[0]+lp2[1]*normal[0],lp2[0]*l2[1]+lp2[1]*normal[1],lp2[0]*l2[2]+lp2[1]*normal[2]];
		p7=mp+[lp2[0]*l3[0]+lp2[1]*normal[0],lp2[0]*l3[1]+lp2[1]*normal[1],lp2[0]*l3[2]+lp2[1]*normal[2]];
		p8=mp+[lp2[0]*l4[0]+lp2[1]*normal[0],lp2[0]*l4[1]+lp2[1]*normal[1],lp2[0]*l4[2]+lp2[1]*normal[2]];
		recursive(shape,rec-1,p5,p6,p2,p1);
		recursive(shape,rec-1,p6,p7,p3,p2);
		recursive(shape,rec-1,p7,p8,p4,p3);
		recursive(shape,rec-1,p4,p8,p5,p1);
		if(i==1&&lp1[0]>0) {
			recursive(shape,rec-1,p1,p2,p3,p4);
		}
		if(rec==recursion&&i==len(shape[1][0])-1) {
			addAppendage();
		}
		module addAppendage() {
			polyhedron(points=[p5,p6,p7,p8,
				[p5[0],p5[1],-appendage],[p6[0],p6[1],-appendage],
				[p7[0],p7[1],-appendage],[p8[0],p8[1],-appendage]],
				triangles=[[0,1,4],[1,5,4],[1,2,5],[2,6,5],[2,7,6],[2,3,7],[0,7,3],[0,4,7],[4,5,6],[4,6,7]]);
		}
	}
}

if(selected_shape>2) {
	fractal(base_size,custom_shape,recursion);
} else {
	fractal(base_size,shapes[selected_shape],recursion);
}

function cross(a,b)=[a[1]*b[2]-a[2]*b[1],a[2]*b[0]-a[0]*b[2],a[0]*b[1]-a[1]*b[0]];