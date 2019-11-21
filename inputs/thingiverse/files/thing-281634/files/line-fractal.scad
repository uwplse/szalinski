include <utils/build_plate.scad>
// preview[view:south, tilt:top]

// Pick a predefined Shape or "custom" and define a new one
selected_shape = 0; //[0:Square,1:Triangular,2:Spiky,3:Custom]
// Level of recursion, careful with high recursions, this may be slow
recursion=4; //[1,2,3,4,5,6,7]
// Line in OpenSCAD polygon notation that will be used as base for the fractal. First and last point should have y=0.01 and no point should go below that.
custom_shape = [[[0,-0.01],[1,-0.01],[2,1.9],[3,1.9],[4,-0.01],[5,-0.01]],[[0,1,2,3,4,5]]];
shapes=[[[[0,-0.01],[1,-0.01],[1,0.9],[2,0.9],[2,-0.01],[3,-0.01]],[[0,1,2,3,4,5]]],
	[[[0,-0.01],[1,-0.01],[2,1.75],[3,-0.01],[4,-0.01]],[[0,1,2,3,4]]],
	[[[0,-0.01],[1.5,-0.01],[2.5,1.25],[2,-0.01],[3.5,-0.01]],[[0,1,2,3,4]]]];
scale=30; //[1:100]
thickness = 3; //[1:30]
// How much is added to the base of the fractal
appendage = 10; //[1:50]
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
build_plate_manual_x = 100; //[100:400]
build_plate_manual_y = 100; //[100:400]
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

module fractal(scale,shape,recursion) {
	starttoend=shape[0][0]+shape[0][len(shape[0])-1];
	abslen=sqrt(pow(starttoend[0],2)+pow(starttoend[1],2))*scale;
	heigth=maxy(shape[0],len(shape[0])-1)*scale-appendage;
	translate(shape[0][0]-[abslen/2,appendage+heigth/2,thickness])
	color([1,1,1])
	cube([abslen,appendage,thickness]);
	translate([-abslen/2,-heigth/2,0]) recursive([shape[0]*scale,shape[1]],abslen,recursion);
};

module recursive(shape,abslen,rec,loc=[0,0],rot=0) {
	for(i = [1:len(shape[1][0])-1]) {
		if(rec>0) {
			forline(shape,abslen,rec,loc,rot,i);
		}
	}
	translate(loc)
	rotate(rot)
	color([rec/recursion,rec/recursion,rec/recursion])
	linear_extrude(height=thickness)
	polygon(points = shape[0], paths = shape[1]);
}

module forline(shape,abslen,rec,loc,rot,i) {
	p1=shape[0][shape[1][0][i-1]];
	p2=shape[0][shape[1][0][i]];
	line=p2-p1;
	len=sqrt(pow(line[0],2)+pow(line[1],2));
	alpha=atan2(line[1],line[0]);
	beta=atan2(p1[1],p1[0])+rot;
	len2=sqrt(pow(p1[0],2)+pow(p1[1],2));
	pnew=[cos(beta)*len2,sin(beta)*len2];
	recursive([shape[0]*len/abslen,shape[1]],len,rec-1,loc+pnew,alpha+rot);
}

if(selected_shape>2) {
	fractal(scale,custom_shape,recursion);
} else {
	fractal(scale,shapes[selected_shape],recursion);
}

function maxy(points, index=0)=index<0?0:max(points[index][1],maxy(points,index-1));