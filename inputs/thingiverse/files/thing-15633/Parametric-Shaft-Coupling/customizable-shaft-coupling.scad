//code by Griffin Nicoll 2013
//GNU GPL v3

//shaft diameter
shaft1 = 5;
//shaft diameter
shaft2 = 7.8;
//diameter of bolt shaft
boltShaft = 3.5;
//diameter of bolt head
boltHead = 6.7;
//diameter of washer. 0 if unused
washer = 0;
//diameter across nut flats
nut = 7.8;
//depth of nut trap
trap = 2;
//minimun coupling length
length = 30;
//thinest part of the back
thickness = 4;
//distance between halfs so it can clamp down
offset = 2;
//bridge on top of traps (one layer height)
bridge = 0.3;
//gap between sliding parts
gap = 0.3;
//width of thinnest stable wall
wall = 1.6;

//generated dimensions
height = thickness+trap+max(shaft1,shaft2)/2+gap;
nutR = nut/(2*cos(30));
boltX = max(min(length/2-max(boltHead/2,nutR+gap+wall),length/4),
		boltHead/4+nutR/2+gap+wall/2,washer/2+gap+wall/2);
boltY1 = max((shaft1+boltShaft)/2+gap+wall,boltHead/2+gap+wall/2,
		nut/2+gap+wall/2,washer/2+gap+wall/2);
boltY2 = max((shaft2+boltShaft)/2+gap+wall,boltHead/2+gap+wall/2,
		nut/2+gap+wall/2,washer/2+gap+wall/2);

//placing sides
for(a=[0,1])rotate([0,0,a*180])translate([0,max(boltY1,boltY2)+
	max(boltHead/2,nutR,washer/2)+gap*2+wall+1])clamp();

module clamp(){
difference(){
	clampBlock();
	//shaft1
	translate([wall/2,0,height])rotate([0,90,0])
		cylinder(r=shaft1/2,h=2*max(boltX+1,nutR+gap+wall,boltHead+gap+wall),$fn=24);
	//shaft2
	translate([-wall/2,0,height])rotate([0,-90,0])
		cylinder(r=shaft2/2,h=2*max(boltX+1,nutR+gap+wall,boltHead+gap+wall),$fn=24);
	//bolt holes
	translate([boltX,boltY1,trap+bridge])cylinder(r=boltShaft/2+gap,h=height,$fn=16);
	translate([boltX,-boltY1,trap+bridge])cylinder(r=boltShaft/2+gap,h=height,$fn=16);
	translate([-boltX,boltY2,trap+bridge])cylinder(r=boltShaft/2+gap,h=height,$fn=16);
	translate([-boltX,-boltY2,trap+bridge])cylinder(r=boltShaft/2+gap,h=height,$fn=16);
	//nut traps
	translate([boltX,boltY1,-1])cylinder(r=nutR+gap,h=trap+1,$fn=6);
	translate([-boltX,-boltY2,-1])cylinder(r=nutR+gap,h=trap+1,$fn=6);
	//washers
	if(washer>0){
		translate([boltX,boltY1,-1])cylinder(r=washer/2+gap,h=trap+1,$fn=24);
		translate([-boltX,-boltY2,-1])cylinder(r=washer/2+gap,h=trap+1,$fn=24);
	}
	//bolt traps or washers
	translate([boltX,-boltY1,-1])cylinder(r=max(boltHead,washer)/2+gap,h=trap+1,$fn=24);
	translate([-boltX,boltY2,-1])cylinder(r=max(boltHead,washer)/2+gap,h=trap+1,$fn=24);
}
}

module clampBlock(){
linear_extrude(height=height-offset/2){
	hull(){
		translate([length/2-1,0])square(size=[2,shaft1+wall*2],center=true);
		translate([-length/2+1,0])square(size=[2,shaft2+wall*2],center=true);
		translate([boltX,boltY1])clampCorner();
		translate([boltX,-boltY1])clampCorner();
		translate([-boltX,boltY2])clampCorner();
		translate([-boltX,-boltY2])clampCorner();
	}
}
}

module clampCorner(){
	union(){
		circle(max(washer,boltHead)/2+gap+wall,$fn=24);
		circle(nutR+gap+wall,$fn=6);
	}
}