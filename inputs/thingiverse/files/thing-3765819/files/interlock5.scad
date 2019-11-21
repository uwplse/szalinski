$fn=4;

size=[40,40];
blockSize=10; //number of lines in a block
thickness=0.49;
gap=0.01;
step=thickness+gap;

////////////////////////////////////////////////////////
linear_extrude(1) intersection(){
	interlock5(size);
	square(size);
}

////////////////////////////////////////////////////////

module interlock5(size=[30,30]){
	bs=blockSize*step;
	
	//diagonal
	for(x=[0:bs:max(size.x,size.y)]){
		t([x,x,0]) doubleBlock(0);
	}

	//x direction
	for(x=[0:2*bs:(size.x-2*bs)/2]){
		for(d=[0:bs:size.x]){
			t([d+x+2*bs,d-x-2*bs,0]) doubleBlock(0);
		}
	}

	//y direction
	for(y=[0:2*bs:(size.y-2*bs)/2]){
		for(d=[0:bs:size.y]){
			t([d-y-2*bs,d+y+2*bs,0]) doubleBlock(0);
		}
	}
}

module doubleBlock(swap=0){
	t([0,-gap/2,0]) block(1);
	tr([-gap/2,step*blockSize,0],-90) mirror([1,0,0]) block(1);
}

module block(end=0){
	lines=blockSize;
	length=2*lines*step-step;
	
	///long lines
	for(i=[0:lines-1]){
		t([0.5*thickness,(i+0.5)*step,0]) line([[0,0],[length,0]],thickness);
	}

	///connection 1
	for(i=[0:2:lines-2]){
		t([0.5*thickness,(i+0.5)*step,0]) line([[length,0],[length,step]],thickness);
	}

	///connection 2
	for(i=[1:2:lines-2]){
		t([0.5*thickness,(i+0.5)*step,0]) line([[0,0],[0,step]],thickness);
	}
	
//	if(end==0){
//		t([0.5*thickness,(lines-2+0.5)*step,0]) line([[length,step],[length+step,step]],thickness);
//	}
//
	if(end==1){
		t([0.5*thickness,(lines-2+0.5)*step,0]) line([[0,step],[0,2*step]],thickness);
	}
}

module line(points=[[0,0],[1,1]],t=0.5){
	for(i=[0:len(points)-2]) hull(){
		tr(points[i]) square([t,t],center=true);
		tr(points[i+1]) square([t,t],center=true);
	}
}

////////////////////////////////////////////////////////

module t(v=[0,0,0]){translate(v) children();}
module r(a=[0,0,0],rp=[0,0,0]){translate(rp) rotate(a) translate(-rp) children();}
module tr(v=[0,0,0],a=[0,0,0],rp=[0,0,0]){t(v) r(a,rp) children();}
module rt(a=[0,0,0],rp=[0,0,0],v=[0,0,0]){r(a,rp) t(v) children();}
module u(){union() children();}
