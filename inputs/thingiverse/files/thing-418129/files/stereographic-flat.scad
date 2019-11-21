outer_radius=100; //[30:200]
inner_radius=90; //[29:199]
cutoff=70; //[30:90]
pcutoff=cutoff/100;

image=[0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,1.000,0.000,1.000,0.000,1.000,0.000,1.000,0.000,1.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,1.000,0.000,1.000,0.000,1.000,0.000,1.000,0.000,1.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,1.000,0.000,1.000,0.000,1.000,0.000,1.000,0.000,1.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,1.000,0.000,1.000,0.000,1.000,0.000,1.000,0.000,1.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,1.000,0.000,1.000,0.000,1.000,0.000,1.000,0.000,1.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000]; // [image_array:75x75]

size=sqrt(len(image));
hsize=size/2;
qsize=size/4;
northpole=[0,0,outer_radius]*1;

for(x=[0:size-1]) {
	for(y=[0:size-1]) {
		if(getPoint(x,y)) {
			drawPoint(x,y);
		}
	}
}

module drawPoint(x,y) {
	xt=x-hsize;
	yt=y-hsize;
	p1=project((xt-0.5)/qsize,(yt-0.5)/qsize);
	p2=project((xt-0.5)/qsize,(yt+0.5)/qsize);
	p3=project((xt+0.5)/qsize,(yt+0.5)/qsize);
	p4=project((xt+0.5)/qsize,(yt-0.5)/qsize);
	f1=flatten(p1);
	f2=flatten(p2);
	f3=flatten(p3);
	f4=flatten(p4);
	p1i=intersectLineAndSphereAtCenter(northpole,p1*inner_radius,inner_radius*f1);
	p2i=intersectLineAndSphereAtCenter(northpole,p2*inner_radius,inner_radius*f2);
	p3i=intersectLineAndSphereAtCenter(northpole,p3*inner_radius,inner_radius*f3);
	p4i=intersectLineAndSphereAtCenter(northpole,p4*inner_radius,inner_radius*f4);
	p1o=intersectLineAndSphereAtCenter(northpole,p1i,outer_radius*f1);
	p2o=intersectLineAndSphereAtCenter(northpole,p2i,outer_radius*f2);
	p3o=intersectLineAndSphereAtCenter(northpole,p3i,outer_radius*f3);
	p4o=intersectLineAndSphereAtCenter(northpole,p4i,outer_radius*f4);
	polyhedron(points=[p1i,p2i,p3i,p4i,p1o,p2o,p3o,p4o],
		triangles=[[0,1,2],[0,2,3],[4,7,5],[7,6,5]]);
	if(x==0||!getPoint(x-1,y)) {
		polyhedron(points=[p1i,p1o,p2i,p2o],triangles=[[0,1,2],[1,3,2]]);
	}
	if(x==size-1||!getPoint(x+1,y)) {
		polyhedron(points=[p3i,p3o,p4i,p4o],triangles=[[0,1,2],[1,3,2]]);
	}
	if(y==0||!getPoint(x,y-1)) {
		polyhedron(points=[p4i,p4o,p1i,p1o],triangles=[[0,1,2],[1,3,2]]);
	}
	if(y==size-1||!getPoint(x,y+1)) {
		polyhedron(points=[p2i,p2o,p3i,p3o],triangles=[[0,1,2],[1,3,2]]);
	}
}

function project(x,y)=[2*x/(1+x*x+y*y),2*y/(1+x*x+y*y),(x*x+y*y-1)/(1+x*x+y*y)];

function flatten(p)=(p[2]<-pcutoff)?1.02+pcutoff+p[2]:1;

function getPoint(x,y)=image[y*size+x]<0.5;

function lengthpow2(vec)=scalarProduct(vec,vec);

function scalarProduct(vec1,vec2)=vec1[0]*vec2[0]+vec1[1]*vec2[1]+vec1[2]*vec2[2];

function intersectLineAndSphereAtCenter(lp1, lp2, radius)=lp1+solveQuadraticEquationPositive(
	lengthpow2(lp2-lp1),
	2*scalarProduct(lp2-lp1,lp1),
	lengthpow2(lp1)-radius*radius)*(lp2-lp1);

function solveQuadraticEquationPositive(a,b,c)=(sqrt(b*b-4*a*c)-b)/(2*a);
