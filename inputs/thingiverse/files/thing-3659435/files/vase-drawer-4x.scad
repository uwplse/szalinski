size=[100,50,30];
holder=[10,30,8,10];
thread=0.45;

not=0.001;

vaseFloor([size.x,size.y,2*thread]);
cubeHolderVase4(size,holder,thread);


module cubeVase4(size=[10,10,10],thread=0.45,gap=0.001){
	t2=2*thread;
	t2g=t2+gap;
	
	cube([t2,size.y,size.z]);
	t([t2g,0,0]) cube([2*thread,size.y-t2g,size.z]);
	t([2*t2g,0,0]) cube([t2,t2g+t2,size.z]);

	t([2*t2g,0,0]) cube([size.x-2*t2g,2*thread,size.z]);
	t([2*t2g,t2g,0]) cube([size.x-3*t2g,2*thread,size.z]);
	t([t2g,size.y-t2-t2g,0]) cube([size.x-2*t2g,t2,size.z]);
	t([0,size.y-t2,0]) cube([size.x,t2,size.z]);

	t([size.x-t2,0,0]) cube([t2,size.y,size.z]);
	t([size.x-t2g-t2,t2g,0]) cube([t2,size.y-2*t2g,size.z]);	
}

module triangle(w=1){
	linear_extrude(w) polygon([[0,0],[0,holder.x],[holder.x,holder.x]]);
}

/// 2 wall cube without bottom or ceiling
module cubeHolderVase4(size=[10,10,10],holder=[5,10,3,2],thread=0.45,gap=0.001){
	tg=thread+gap;
	shift=(size.y-holder.y)/2;
	t2=2*thread;
	t2g=t2+gap;
	
	difference(){
		u(){
			cubeVase4(size,thread,gap);
		
			///support holder
			for(y=[shift,size.y-shift-4*thread-gap]){
				t([size.x,y,holder[3]]) rt([90,0,0],[0,0,0],[0,0,-(4*thread+gap)])triangle(4*thread+gap);
			}
			
			///holder
			t([size.x+holder.x-t2,shift,holder[3]+holder.x-not]) cube([t2,holder.y,holder.z+2*not]);
			t([size.x+holder.x-2*t2-gap,shift+t2g,holder[3]+holder.x-not]) cube([t2,holder.y-2*t2g,holder.z+2*not]);
			t([size.x+gap,shift+holder.y-t2g-t2,holder[3]+holder.x-not]) cube([t2,t2g+t2,holder.z+2*not]);
			
			t([size.x,shift,holder[3]+holder.x-not]) cube([holder.x,t2,holder.z+2*not]);
			t([size.x,shift+t2g,holder[3]+holder.x-not]) cube([holder.x-t2g,t2,holder.z+2*not]);
			t([size.x+t2g,shift+holder.y-t2g-t2,holder[3]+holder.x-not]) cube([holder.x-2*t2g,t2,holder.z+2*not]);
			t([size.x+t2g,shift+holder.y-t2,holder[3]+holder.x-not]) cube([holder.x-t2g,t2,holder.z+2*not]);
			
		}

		///support
		for(y=[shift+2*thread,size.y-shift-2*thread-gap]){
			t([size.x-2*thread,y,holder[3]]) rt([90,0,0],[0,0,0],[0,0,-gap])triangle(gap);
		}
		
		///holder
		t([size.x-2*thread,shift+2*thread,holder[3]+holder.x-not]) cube([2*thread,gap,holder.z+2*not]);
	}
	
	//holder
//	t([0,0,holder[3]]) difference(){
//		t([size.x,shift,holder.x]) cube([holder.x,holder.y,holder.z]);
//		t([size.x,shift+2*thread,holder.x-not]) cube([holder.x-2*thread,holder.y-4*thread,holder.z+2*not]);
//	}
}

module vaseFloor(size=[10,10,2]){
	cube(size);
}

module t(v=[0,0,0]){translate(v) children();}
module r(a=[0,0,0],rp=[0,0,0]){translate(rp) rotate(a) translate(-rp) children();}
module tr(v=[0,0,0],a=[0,0,0],rp=[0,0,0]){t(v) r(a,rp) children();}
module rt(a=[0,0,0],rp=[0,0,0],v=[0,0,0]){r(a,rp) t(v) children();}
module u(){union() children();}
