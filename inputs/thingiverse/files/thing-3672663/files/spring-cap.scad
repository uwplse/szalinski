$fn=64;

//diameters from outside to inside, outer wall, outer diameter of pads, inner diameter of pads
d=[17,14.3,13.5];

//sizes of objects in z axis
diff=6;
z=[7-diff,7,10,12.5];

wall = 1;
//number of latches
latches = 16;
//latch gap size in degrees
latchGap = 4;
//fillets
r = [1,.3,.3,-0.01,.5,1.1,.2,.5];

gap=0.5;

not=0.001+0.001;

////////////////////////////////

//floor
cylinderRounded(d=[0,d[0]],h=z[0],r=[0,r[0],0,0]);

///outer support
cylinderRounded(d=[d[0]-2*wall,d[0]],h=z[1],r=[0,r[0],r[2],r[1]]);


///inner support
cylinderRounded(d=[0,d[2]-2*wall-(d[1]-d[2])-2*gap],h=z[3],r=[0,0,0,r[7]]);

///springs
difference(){
	union(){
		cylinderRounded(d=[d[2]-2*wall,d[2]],h=z[2],r=[0,0,0,r[3]]);
		translate([0,0,z[2]]) cylinderRounded(d=[d[2]-2*wall,d[1]],h=z[3]-z[2],r=[0,r[4],r[6],r[5]]);
	}
	
	for(i=[0:360/latches:360]){
		rotate([0,0,i]) translate([0,-d[0],z[0]+not]) triangle3D(latchGap,d[0],z[3]);
	}
}

///////////////////////////////

module cylinderRounded(d=[20,40],h=30,r=[1,-10,4,1]){
	rotate_extrude(convexity = 10)
	{
		//square
		difference(){
			translate([d[0]/2,0,0]) square([(d[1]-d[0])/2,h]);
			if(r[0]>0) translate([d[0]/2,0,0]) square([r[0],r[0]]);
			if(r[1]>0) translate([d[1]/2-r[1],0,0]) square([r[1],r[1]]);
			if(r[2]>0) translate([d[0]/2,h-r[2],0]) square([r[2],r[2]]);
			if(r[3]>0) translate([d[1]/2-r[3],h-r[3],0]) square([r[3],r[3]]);
		}
		
		//corners
		
		if(r[0]>0){
			intersection(){
				translate([d[0]/2+r[0], r[0], 0]) circle(r = r[0]);
				translate([d[0]/2,0,0]) square([r[0],r[0]]);
			}
		} else {
			difference(){
				translate([d[0]/2+r[0], 0, 0]) square([-r[0],-r[0]]);
				translate([d[0]/2+r[0], -r[0], 0]) circle(r = -r[0]);
			}
		}
		
		if(r[1]>0){
			intersection(){
				translate([d[1]/2-r[1], r[1], 0]) circle(r = r[1]);
				translate([d[1]/2-r[1],0,0]) square([r[1],r[1]]);
			}
		} else {
			difference(){
				translate([d[1]/2, 0, 0]) square([-r[1],-r[1]]);
				translate([d[1]/2-r[1], -r[1], 0]) circle(r = -r[1]);
			}
		}
		
		if(r[2]>0){
			intersection(){
				translate([d[0]/2+r[2], h-r[2], 0]) circle(r = r[2]);
				translate([d[0]/2,h-r[2],0]) square([r[2],r[2]]);
			}
		} else {
			difference(){
				translate([d[0]/2+r[2], h+r[2], 0]) square([-r[2],-r[2]]);
				translate([d[0]/2+r[2], h+r[2], 0]) circle(r = -r[2]);
			}
		}

		if(r[3]>0){
			intersection(){
				translate([d[1]/2-r[3], h-r[3], 0]) circle(r = r[3]);
				translate([d[1]/2-r[3],h-r[3],0]) square([r[3],r[3]]);
			}
		} else {
			difference(){
				translate([d[1]/2, h+r[3], 0]) square([-r[3],-r[3]]);
				translate([d[1]/2-r[3], h+r[3], 0]) circle(r = -r[3]);
			}
		}		
	}
}

module triangle3D(angle=10,h=10,z=10){
	linear_extrude(z) triangle(angle,h);
}

module triangle(angle=10,h=10){	
	r=angle/2;
	base=h*tan(r);
	sidex=2.1*base*cos(r);
	sidey=h/cos(r)+base;
	
	intersection(){
		translate([-base,0,0]) rotate([0,0,-r]) square([sidex,sidey]);
		translate([base,0,0]) rotate([0,0,r]) translate([-sidex,0,0]) square([sidex,sidey]);
		translate([-1.1*base,0,0]) square([2.2*base,1.1*h]);
	}
}