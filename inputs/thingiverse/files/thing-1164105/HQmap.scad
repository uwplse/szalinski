outer_radius=100; //[30:200]
inner_radius=98; //[29:199]

image=[0.000,0.000,0000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,1.000,0.000,1.000,0.000,1.000,0.000,1.000,0.000,1.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,1.000,0.000,1.000,0.000,1.000,0.000,1.000,0.000,1.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,1.000,0.000,1.000,0.000,1.000,0.000,1.000,0.000,1.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,1.000,0.000,1.000,0.000,1.000,0.000,1.000,0.000,1.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,1.000,0.000,1.000,0.000,1.000,0.000,1.000,0.000,1.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000]; // [image_array:5000x5000]

size=sqrt(len(image));
hsize=size/2;
qsize=size/4;

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
	p1i=p1*inner_radius;
	p2i=p2*inner_radius;
	p3i=p3*inner_radius;
	p4i=p4*inner_radius;
	p1o=p1*outer_radius;
	p2o=p2*outer_radius;
	p3o=p3*outer_radius;
	p4o=p4*outer_radius;
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
function getPoint(x,y)=image[y*size+x]<0.5;
