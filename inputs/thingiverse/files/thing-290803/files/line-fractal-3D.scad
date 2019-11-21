include <utils/build_plate.scad>
// preview[view:south west, tilt:top diagonal]

// Pick a predefined Shape or "custom" and define a new one
selected_shape = 0; //[0:Square,1:Trapezoid,2:Tile,3:Mushroom,4:Hexagonal,5:Custom]
// Level of recursion, careful with high recursions, this may be slow
recursion=3; //[1,2,3,4]
// Line in OpenSCAD polygon notation that will be used as base for the fractal. Points should have positive x values and the last point needs to have y=0.
custom_shape = [[[2,1],[2,-1],[6,-1],[6,0],[9,0]],[[0,1,2,3,4]]];
shapes=[[[[1,1],[1,0],[3.001,0]],[[0,1,2]]],
	[[[1,1.1],[2,0],[4,0]],[[0,1,2]]],
	[[[4,-0.5],[3,0.5],[5,0.5],[10,0]],[[0,1,2,3]]],
	[[[2,7],[3,7],[3,10],[9,10],[15,6],[8,8],[4,8],[4,0],[30,0]],[[0,1,2,3,4,5,6,7,8]]],
	[[[1,1.232],[2,0.366],[1,-0.5],[5.4,0]],[[0,1,2,3]]]];
base_size=100; //[50:500]
// How much is added to the base of the fractal
appendage = 10; //[1:50]
precision = 0.001;
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
build_plate_manual_x = 100; //[100:400]
build_plate_manual_y = 100; //[100:400]
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

module fractal(base_size,shape,recursion) {
	abslen=shape[0][len(shape[0])-1][0]/2;
	translate([0,0,appendage])
	rotate([0,0,45])
	recursive([shape[0]/abslen,shape[1]],recursion,[-base_size/sqrt(2),0,0],[0,-base_size/sqrt(2),0],[base_size/sqrt(2),0,0],[0,base_size/sqrt(2),0],abslen);
};

module recursive(shape,rec,pp1,pp2,pp3,pp4) {
	mp=(pp1+pp2+pp3+pp4)/4;
	l13=(pp3-pp1)/2;
	l24=(pp2-pp4)/2;
	ll13=length(l13);
	ll24=length(l24);
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
		ln12=length(p2-p1);
		ln23=length(p3-p2);
		ln34=length(p4-p3);
		ln41=length(p1-p4);
		ln56=length(p6-p5);
		ln67=length(p7-p6);
		ln78=length(p8-p7);
		ln85=length(p5-p8);
		if(i==1&&lp1[0]>0) {
			recursive(shape,rec-1,p1,p2,p3,p4);
		}
		if(lp2[0]==lp1[0]||(lp2[1]!=lp1[1]&&i!=(len(shape[0]))-1)) {
			recursive(shape,rec-1,p5,p6,p2,p1);
			recursive(shape,rec-1,p6,p7,p3,p2);
			recursive(shape,rec-1,p7,p8,p4,p3);
			recursive(shape,rec-1,p4,p8,p5,p1);
		} else if(lp2[0]>=lp1[0]) {
			createFaces();
		} else {
			createInvertedFaces();
		}
		if(rec==recursion&&i==len(shape[1][0])-1) {
			addAppendage();
		}

		module createFaces() {
			p9=p5+(p6-p5)*((ln56-ln12)/(2*ln56));
			p10=p6-(p6-p5)*((ln56-ln12)/(2*ln56));
			p11=p6+(p7-p6)*((ln67-ln23)/(2*ln67));
			p12=p7-(p7-p6)*((ln67-ln23)/(2*ln67));
			p13=p7+(p8-p7)*((ln78-ln34)/(2*ln78));
			p14=p8-(p8-p7)*((ln78-ln34)/(2*ln78));
			p15=p8+(p5-p8)*((ln85-ln41)/(2*ln85));
			p16=p5-(p5-p8)*((ln85-ln41)/(2*ln85));
			fill(p1,p2,p3,p4,p5,p6,p7,p8,
				p9+(p1-p9)*precision,
				p10+(p2-p10)*precision,
				p11+(p2-p11)*precision,
				p12+(p3-p12)*precision,
				p13+(p3-p13)*precision,
				p14+(p4-p14)*precision,
				p15+(p4-p15)*precision,
				p16+(p1-p16)*precision);
		}

		module createInvertedFaces() {
			p9=p1-(p1-p4)*((ln41-ln85)/(2*ln41));
			p10=p4+(p1-p4)*((ln41-ln85)/(2*ln41));
			p11=p4-(p4-p3)*((ln34-ln78)/(2*ln34));
			p12=p3+(p4-p3)*((ln34-ln78)/(2*ln34));
			p13=p3-(p3-p2)*((ln23-ln67)/(2*ln23));
			p14=p2+(p3-p2)*((ln23-ln67)/(2*ln23));
			p15=p2-(p2-p1)*((ln12-ln56)/(2*ln12));
			p16=p1+(p2-p1)*((ln12-ln56)/(2*ln12));
			fill(p5,p8,p7,p6,p1,p4,p3,p2,
				p9+(p5-p9)*precision,
				p10+(p8-p10)*precision,
				p11+(p8-p11)*precision,
				p12+(p7-p12)*precision,
				p13+(p7-p13)*precision,
				p14+(p6-p14)*precision,
				p15+(p6-p15)*precision,
				p16+(p5-p16)*precision);
		}

		module addAppendage() {
			polyhedron(points=[p5,p6,p7,p8,
				[p5[0],p5[1],-appendage],[p6[0],p6[1],-appendage],
				[p7[0],p7[1],-appendage],[p8[0],p8[1],-appendage]],
				triangles=[[0,1,4],[1,5,4],[1,2,5],[2,6,5],[2,7,6],[2,3,7],[0,7,3],[0,4,7],[4,5,6],[4,6,7]]);
		}
	}

	module fill(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16) {
		recursive(shape,rec-1,p1,p9,p10,p2);
		polyhedron(points=[p5,p6,p10,p9],triangles=[[0,2,1],[0,3,2]]);
		recursive(shape,rec-1,p2,p11,p12,p3);
		polyhedron(points=[p6,p7,p12,p11],triangles=[[0,2,1],[0,3,2]]);
		recursive(shape,rec-1,p3,p13,p14,p4);
		polyhedron(points=[p7,p8,p14,p13],triangles=[[0,2,1],[0,3,2]]);
		recursive(shape,rec-1,p4,p15,p16,p1);
		polyhedron(points=[p8,p5,p16,p15],triangles=[[0,2,1],[0,3,2]]);
		recursive(shape,rec-1,p1,p16,p5,p9);
		recursive(shape,rec-1,p2,p10,p6,p11);
		recursive(shape,rec-1,p3,p12,p7,p13);
		recursive(shape,rec-1,p4,p14,p8,p15);
	}
}

if(selected_shape>4) {
	fractal(base_size,custom_shape,recursion);
} else {
	fractal(base_size,shapes[selected_shape],recursion);
}

function cross(a,b)=[a[1]*b[2]-a[2]*b[1],a[2]*b[0]-a[0]*b[2],a[0]*b[1]-a[1]*b[0]];

function scalarProduct(a,b)=a[0]*b[0]+a[1]*b[1]+a[2]*b[2];

function lengthpow2(vec)=scalarProduct(vec,vec);

function length(vec)=sqrt(lengthpow2(vec));
