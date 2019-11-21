$fn=8;

size=[30,40];
blockSize=15; //number of lines in a block
thickness=0.49;
gap=0.01;
step=thickness+gap;

////////////////////////////////////////////////////////

linear_extrude(1) interlock4(size);

////////////////////////////////////////////////////////

module interlock4(size=[30,30]){
	for(y=[0:2*blockSize*step:size.y]){

		for(x=[0:2*blockSize*step:size.x]){
			t([x,y,0]) doubleBlock(0);
		}

		for(x=[0:2*blockSize*step:size.x]){
			t([x,y+blockSize*step,0]) doubleBlock(1);
		}

	}
}

module doubleBlock(swap=0){
	if(!swap){
		block(0);
		tr([step*blockSize,step*blockSize,0],-90) block(1);
	} else {
		mirror([0,1,0]){
			r(-90) block(1);
			t([step*blockSize,-1*step*blockSize,0]) block(0);
		}
	}
}

module block(end=0){
	lines=blockSize;
	length=lines*step-step;
	
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
	
	if(end==0){
		t([0.5*thickness,(lines-2+0.5)*step,0]) line([[length,step],[length+step,step]],thickness);
	}

	if(end==1){
		t([0.5*thickness,(lines-2+0.5)*step,0]) line([[length,step],[length,2*step]],thickness);
	}
}

module line(points=[[0,0],[1,1]],t=0.5){
	for(i=[0:len(points)-2]) hull(){
		t(points[i]) circle(d=t);
		t(points[i+1]) circle(d=t);
	}
}

////////////////////////////////////////////////////////

module t(v=[0,0,0]){translate(v) children();}
module r(a=[0,0,0],rp=[0,0,0]){translate(rp) rotate(a) translate(-rp) children();}
module tr(v=[0,0,0],a=[0,0,0],rp=[0,0,0]){t(v) r(a,rp) children();}
module rt(a=[0,0,0],rp=[0,0,0],v=[0,0,0]){r(a,rp) t(v) children();}
module u(){union() children();}
