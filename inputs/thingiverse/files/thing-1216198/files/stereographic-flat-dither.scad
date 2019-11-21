include <utils/build_plate.scad>
// preview[view:south west, tilt:top diagonal]

outer_radius=50; //[20:200]
inner_radius=45; //[19:199]
cutoff=70; //[30:100]
pcutoff=cutoff/100;
white_threshold=1; //[0.5:0.01:1]
black_threshold=0.01; //[0:0.01:0.5]
white_max=0.95; //[0.5:0.01:1]
black_min=0.05; //[0:0.01:0.5]

build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
build_plate_manual_x = 100; //[100:400]
build_plate_manual_y = 100; //[100:400]
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

image=[0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255,0.5019607843137255]; // [image_array:75x75]

size=sqrt(len(image));
hsize=size/2;
qsize=size/4;
northpole=[0,0,outer_radius]*1;

translate([0,0,outer_radius*cutoff/100]) {
    data=[for(x=[0:size-1]) let(
        rowdata=[for(y=[0:size-1]) (isPointVisible(x,y))?drawPoint(x,y,getPoint(x,y)):[[],[]]])
        addAllPointsAndFaces(rowdata,len(rowdata)-1)];
    polydata=addAllPointsAndFaces(data,len(data)-1);
    polyhedron(points=polydata[0],faces=polydata[1]);
}

function drawPoint(x,y,v)=let(
	xt=x-hsize,
	yt=y-hsize,
	p1=project((xt-0.5)/qsize,(yt-0.5)/qsize),
	p2=project((xt-0.5)/qsize,(yt+0.5)/qsize),
	p3=project((xt+0.5)/qsize,(yt+0.5)/qsize),
	p4=project((xt+0.5)/qsize,(yt-0.5)/qsize),
	f1=flatten(p1),
	f2=flatten(p2),
	f3=flatten(p3),
	f4=flatten(p4),
	p1i=intersectLineAndSphereAtCenter(northpole,p1*inner_radius,inner_radius*f1),
	p2i=intersectLineAndSphereAtCenter(northpole,p2*inner_radius,inner_radius*f2),
	p3i=intersectLineAndSphereAtCenter(northpole,p3*inner_radius,inner_radius*f3),
	p4i=intersectLineAndSphereAtCenter(northpole,p4*inner_radius,inner_radius*f4),
    p1o=intersectLineAndSphereAtCenter(northpole,p1i,outer_radius*f1),
    p2o=intersectLineAndSphereAtCenter(northpole,p2i,outer_radius*f2),
    p3o=intersectLineAndSphereAtCenter(northpole,p3i,outer_radius*f3),
    p4o=intersectLineAndSphereAtCenter(northpole,p4i,outer_radius*f4),
    pixel=(v<=black_threshold)?
        [[p1i,p2i,p3i,p4i,p1o,p2o,p3o,p4o],[[0,1,2],[0,2,3],[4,7,5],[7,6,5]]]
    :drawPointWithHole(xt,yt,v,p1i,p2i,p3i,p4i,p1o,p2o,p3o,p4o),
	s1=(x==0||!isPointVisible(x-1,y))?[[p1i,p1o,p2i,p2o],[[0,1,2],[1,3,2]]]:[[],[]],
	s2=(x==size-1||!isPointVisible(x+1,y))?[[p3i,p3o,p4i,p4o],[[0,1,2],[1,3,2]]]:[[],[]],
	s3=(y==0||!isPointVisible(x,y-1))?[[p4i,p4o,p1i,p1o],[[0,1,2],[1,3,2]]]:[[],[]],
	s4=(y==size-1||!isPointVisible(x,y+1))?[[p2i,p2o,p3i,p3o],[[0,1,2],[1,3,2]]]:[[],[]])
    addPointsAndFaces(s4,addPointsAndFaces(
        s3,addPointsAndFaces(addPointsAndFaces(pixel,s1),s2)));

function drawPointWithHole(xt,yt,v,p1i,p2i,p3i,p4i,p1o,p2o,p3o,p4o)=let(
        vl=black_min+v*(white_max-black_min),
        p5=project((xt-0.5*vl)/qsize,(yt-0.5*vl)/qsize),
        p6=project((xt-0.5*vl)/qsize,(yt+0.5*vl)/qsize),
        p7=project((xt+0.5*vl)/qsize,(yt+0.5*vl)/qsize),
        p8=project((xt+0.5*vl)/qsize,(yt-0.5*vl)/qsize),
        f5=flatten(p5),
        f6=flatten(p6),
        f7=flatten(p7),
        f8=flatten(p8),
        p5i=intersectLineAndSphereAtCenter(northpole,p5*inner_radius,inner_radius*f5),
        p6i=intersectLineAndSphereAtCenter(northpole,p6*inner_radius,inner_radius*f6),
        p7i=intersectLineAndSphereAtCenter(northpole,p7*inner_radius,inner_radius*f7),
        p8i=intersectLineAndSphereAtCenter(northpole,p8*inner_radius,inner_radius*f8),
    	p5o=intersectLineAndSphereAtCenter(northpole,p5i,outer_radius*f5),
        p6o=intersectLineAndSphereAtCenter(northpole,p6i,outer_radius*f6),
        p7o=intersectLineAndSphereAtCenter(northpole,p7i,outer_radius*f7),
        p8o=intersectLineAndSphereAtCenter(northpole,p8i,outer_radius*f8)
        )
        [[p1i,p2i,p3i,p4i,p5i,p6i,p7i,p8i,p1o,p2o,p3o,p4o,p5o,p6o,p7o,p8o],
		[[0,1,4],[1,5,4],[1,2,5],[2,6,5],[2,3,6],[3,7,6],[3,0,7],[0,4,7],
            [9,8,12],[13,9,12],[10,9,13],[14,10,13],[11,10,14],[15,11,14],[8,11,15],[12,8,15],
            [4,5,12],[5,13,12],[5,6,13],[6,14,13],[6,7,14],[7,15,14],[7,4,12],[7,12,15]]];

function addAllPointsAndFaces(data,i)=(i==0)?data[0]:addPointsAndFaces(addAllPointsAndFaces(data,i-1),data[i]);

function addPointsAndFaces(old,new)=[concat(old[0],new[0]),addFaces(old[1],new[1],len(old[0]))];

function addFaces(oldFaces,newFaces,pointNum)=concat(oldFaces,addToVectors(newFaces,pointNum));

function addToVectors(vec,x)=[for(v=vec) [for(a=v) a+x]];

function project(x,y)=[2*x/(1+x*x+y*y),2*y/(1+x*x+y*y),(x*x+y*y-1)/(1+x*x+y*y)];

function flatten(p)=(p[2]<-pcutoff)?1.02+pcutoff+p[2]:1;

function getPoint(x,y)=sqrt(image[y*size+x]);

function isPointVisible(x,y)=getPoint(x,y)<=white_threshold;

function lengthpow2(vec)=scalarProduct(vec,vec);

function scalarProduct(vec1,vec2)=vec1[0]*vec2[0]+vec1[1]*vec2[1]+vec1[2]*vec2[2];

function intersectLineAndSphereAtCenter(lp1, lp2, radius)=lp1+solveQuadraticEquationPositive(
	lengthpow2(lp2-lp1),
	2*scalarProduct(lp2-lp1,lp1),
	lengthpow2(lp1)-radius*radius)*(lp2-lp1);

function solveQuadraticEquationPositive(a,b,c)=(sqrt(b*b-4*a*c)-b)/(2*a);
