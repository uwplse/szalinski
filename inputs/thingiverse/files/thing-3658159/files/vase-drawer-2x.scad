size=[100,50,30];
holder=[10,30,10,10];
thread=0.45;

not=0.001;

vaseFloor([size.x,size.y,2*thread]);
cubeHolderVase2(size,holder,thread);

/// 2 wall cube without bottom or ceiling
module cubeVase2(size=[10,10,10],thread=0.45,gap=0.001){
	difference(){
		cube(size);
		t([2*thread,2*thread,-size.z]) cube([size.x-4*thread,size.y-4*thread,3*size.z]);
		
		///1st layer
		rt(45,v=[0,-gap/2,0]) cube([2*thread*sqrt(2)+gap,gap,size.x]);
	}
}

/// 2 wall cube without bottom or ceiling
module cubeHolderVase2(size=[10,10,10],holder=[5,10,3,2],thread=0.45,gap=0.001){
	
	difference(){
		cubeVase2(size,thread,gap);
		t([size.x-2*thread,shift+2*thread,holder.x+holder[3]]) cube([2*thread,gap,holder.z]);
	}

	shift=(size.y-holder.y)/2;

	//support holder
	for(y=[shift,size.y-shift-2*thread]){
		t([size.x,y,holder[3]]) rt([90,0,0],[0,0,0],[0,0,-2*thread]) linear_extrude(2*thread) polygon([[0,0],[0,holder.x],[holder.x,holder.x]]);
	}
	
	//holder
	t([0,0,holder[3]]) difference(){
		t([size.x,shift,holder.x]) cube([holder.x,holder.y,holder.z]);
		t([size.x,shift+2*thread,holder.x-not]) cube([holder.x-2*thread,holder.y-4*thread,holder.z+2*not]);
	}
}

module vaseFloor(size=[10,10,2]){
	cube(size);
}

module t(v=[0,0,0]){translate(v) children();}
module r(a=[0,0,0],rp=[0,0,0]){translate(rp) rotate(a) translate(-rp) children();}
module tr(v=[0,0,0],a=[0,0,0],rp=[0,0,0]){t(v) r(a,rp) children();}
module rt(a=[0,0,0],rp=[0,0,0],v=[0,0,0]){r(a,rp) t(v) children();}
module u(){union() children();}
