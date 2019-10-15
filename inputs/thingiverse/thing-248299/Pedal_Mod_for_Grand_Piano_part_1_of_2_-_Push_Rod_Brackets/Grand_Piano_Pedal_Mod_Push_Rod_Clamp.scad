


//Depth of the pedal frame in mm
PedFrameDepth=44;

//Width of the pedal fram in mm
PedFrameWidth=34;

//Diameter of push-rod in mm. Minimum of 4mm and maximum of 10mm reccommended.
PushRodDiameter=9.5;

/*[hidden]*/

PushRodRad=PushRodDiameter/2;


/*
Hardware for connecting support arm to clamp: 5mm x 40mm bolt + 5mm lock-nut

Hardware for clamp: two 4mm bolts longer than the frame depth by 10mm + two 4mm lock-nuts

!!! use a 4mm diameter or larger push-rod !!!

*/

$fn=20;


//main body for clamp
difference(){
	union(){
		cube([PedFrameWidth+6,PedFrameDepth+6,30],center=true);
		//cylinder to provide strength at base of support-arm
		translate([(PedFrameWidth+3)/2+4,-((PedFrameDepth+6)/2+3),0])cylinder(r=8,h=30,center=true);
		//blocks for bolts
		translate([-(((PedFrameWidth+6)/2)+5),0,0])cube([10,PedFrameDepth+6,30],center=true);

		translate([(((PedFrameWidth+6)/2)+8),0,-10])cube([16,(PedFrameDepth+6)/2,10],center=true);
	}
	
	//negative space to form clamp interior
	cube([PedFrameWidth+1,PedFrameDepth+1,32],center=true);

	//negative space to separate clamp into two pieces
	cube([PedFrameWidth+40,15,33],center=true);

	//hole for bolt to connect support-arm for push rod
	translate([(PedFrameWidth+6)/2+3,-((PedFrameDepth+6)/2+4),0])cylinder(r=3,h=32,center=true);

	//holes for clamp-bolts
	translate([-(((PedFrameWidth+6)/2)+5),0,10])rotate([90,0,0])cylinder(r=2.5,h=PedFrameDepth+8,center=true);
	translate([-(((PedFrameWidth+6)/2)+5),0,-10])rotate([90,0,0])cylinder(r=2.5,h=PedFrameDepth+8,center=true);
	translate([(((PedFrameWidth+6)/2)+11),0,-10])rotate([90,0,0])cylinder(r=2.5,h=PedFrameDepth,center=true);
}


//support-arm for push-rod mount

difference(){
	//main bar
	translate([-((PedFrameWidth)+24),0,-(15-((PushRodDiameter+6)/2))])cube([40,150,PushRodDiameter+6],center=true);

	//hole for push-rod
	translate([-((PedFrameWidth)+24),-(75-(PushRodRad+3)),-(15-((PushRodDiameter+6)/2))])rotate([0,90,0])cylinder(r=PushRodRad+0.75,h=42,center=true);

	//negative space to slide over support-arm connector
	translate([-((PedFrameWidth)+24),48,-(15-((PushRodDiameter+6)/2))])cube([32,150,PushRodDiameter+8],center=true);

	//negative space between push-rod guides
	translate([-((PedFrameWidth)+24),-75,-(15-((PushRodDiameter+6)/2))])cube([32,50,PushRodDiameter+8],center=true);

	//holes for connecting bolt
	translate([-((PedFrameWidth)+24),70,-(15-((PushRodDiameter+6)/2))])rotate([0,90,0])cylinder(r=3,h=42,center=true);
	translate([-((PedFrameWidth)+24),60,-(15-((PushRodDiameter+6)/2))])rotate([0,90,0])cylinder(r=3,h=42,center=true);
	translate([-((PedFrameWidth)+24),50,-(15-((PushRodDiameter+6)/2))])rotate([0,90,0])cylinder(r=3,h=42,center=true);
	translate([-((PedFrameWidth)+24),40,-(15-((PushRodDiameter+6)/2))])rotate([0,90,0])cylinder(r=3,h=42,center=true);
	translate([-((PedFrameWidth)+24),30,-(15-((PushRodDiameter+6)/2))])rotate([0,90,0])cylinder(r=3,h=42,center=true);
	translate([-((PedFrameWidth)+24),20,-(15-((PushRodDiameter+6)/2))])rotate([0,90,0])cylinder(r=3,h=42,center=true);
	translate([-((PedFrameWidth)+24),10,-(15-((PushRodDiameter+6)/2))])rotate([0,90,0])cylinder(r=3,h=42,center=true);
	translate([-((PedFrameWidth)+24),0,-(15-((PushRodDiameter+6)/2))])rotate([0,90,0])cylinder(r=3,h=42,center=true);
	translate([-((PedFrameWidth)+24),-10,-(15-((PushRodDiameter+6)/2))])rotate([0,90,0])cylinder(r=3,h=42,center=true);
	translate([-((PedFrameWidth)+24),-20,-(15-((PushRodDiameter+6)/2))])rotate([0,90,0])cylinder(r=3,h=42,center=true);
}

