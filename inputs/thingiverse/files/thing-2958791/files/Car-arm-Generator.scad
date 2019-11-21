// RC car arm
// Eric Lindholm

// There are a lot of parameters for this file.
// All sizes are in mm.

// The diameter of the pin at the frame point. This controls the thickness of the part.
Inner_Hole_Diam=3.5;    // [2:0.5:8]
// The frame width is the distance between the two hole mounts for the inner joint.
Frame_Width=31;       // [10:1:60]
// The arm length is the distance between the frame point and the knuckle.
Arm_Length=93;        // [20:1:150]
// The diameter of the pin at the knuckle point. This controls the slope of the part.
Outer_Hole_Diam=3.5;    // [2:0.5:8]
// The knuckle width is the distance between the two hole mounts on the knuckle.
Knuckle_Width=15;     // [6:1:40]
// The distance around the knuckle width. This also affects the width around the frame mount.
Max_Knuckle_Width=28; // [8:1:80]
//  The Y distance between the frame mounting point and knuckle mounting point. 
Knuckle_Offset=7;   // [-30:1:80] 
// Number of holes between the frame and knuckle. This is where the shocks mount. 
Middle_Hole_Number=4; // [0:1:8]
// This is the distance from the frame point to the MIDDLE shock mount.
Middle_Hole_X=50;     // [10:1:120]
// This is the distance from the front of the frame mount to the flat of the shock mount areas.
Middle_Hole_Offset=5;     // [0:1:50]
// This is the diameter of each shock mount hole.
Middle_Hole_Diam=3;   // [1.5:0.5:8]
// This creates a round channel for an axle, where the outer edge of the channel corresponds to the knuckle swivel point and 1 diameter above the frame swivel point. 0 = disable
Channel_Diam=16;       // [0:0.5:20]
// This basically mirrors the part. Or, you could have both sides in the same file.
Side="Right";         // ["Left","Right","Both"]

// Preview[view:south east, tilt: top diagonal]

/* [hidden] */

// Make the thing
if(Side=="Right")
	arm();
if(Side=="Left")
	mirror([1,0,0])
		arm();
if(Side=="Both") {
	translate([ht,0,0])
		arm();
	translate([-ht,0,0])
		mirror([1,0,0])
			arm();
}

// Other parameters
$fn=36;
Rib_Thickness=3;
Mount_Width=0.5*Frame_Width;     // The depth of the shock mount holes
Tolerance=0.2;     // expands all hole diameters by this much
// Math
ht=2.25*Inner_Hole_Diam;
knucklecenterline=(Frame_Width-Knuckle_Width)/2-Knuckle_Offset;
extra=(Max_Knuckle_Width-Knuckle_Width)/2;
maxwidth=Frame_Width+extra*2;
endht=2.1*Outer_Hole_Diam;
polygonend=Arm_Length-endht;
Middle_Hole_Y=maxwidth/2-Middle_Hole_Offset;
// All the ribs math
//langle=atan(0.5*(ht-endht-0.1)/(polygonend-ht));
//langlelen=(polygonend-ht)/cos(langle)+0.5;
sangleR=atan(0.5*(Max_Knuckle_Width-maxwidth+knucklecenterline*2)/(polygonend-endht));
sanglelenR=(polygonend-ht)/cos(sangleR)+endht/2;
sangleL=atan(0.5*(Max_Knuckle_Width-maxwidth-knucklecenterline*2)/(polygonend-endht));
sanglelenL=(polygonend-ht)/cos(sangleR)+endht/2;
changley=atan((Channel_Diam+Outer_Hole_Diam/2)/Arm_Length);
changlez=atan(knucklecenterline/polygonend);
chlen=Arm_Length*2;
crangleR=-atan((Max_Knuckle_Width/2+maxwidth/2-Rib_Thickness-knucklecenterline)/(polygonend-ht));
cranglelenR=(polygonend-ht)/cos(crangleR)+Rib_Thickness/4;
crangleL=atan((Max_Knuckle_Width/2+maxwidth/2
-Rib_Thickness+knucklecenterline)/(polygonend-ht));
cranglelenL=(polygonend-ht)/cos(crangleL)+Rib_Thickness/4;
// Shock mount math
mountxlen=Middle_Hole_Diam*1.5*Middle_Hole_Number;
holedepth=Mount_Width*1.4;
m=-0.5*(maxwidth-Max_Knuckle_Width+knucklecenterline)/(polygonend-ht);
insidehole=(Middle_Hole_Y+Mount_Width-m*Middle_Hole_X<=Max_Knuckle_Width/2+knucklecenterline-m*polygonend);


//Debug
//echo(knucklecenterline);
//echo(sangle);
//echo(m);
//echo(Middle_Hole_Y-m*Middle_Hole_X);
//echo(Max_Knuckle_Width-m*polygonend);
//echo(insidehole);

// Main module
module arm() {
difference() {
	// Positive entities
	union() {
		// Frame mount point
		translate([0,0,ht/2])
			rotate(90,[1,0,0])
				cylinder(r=ht/2,h=maxwidth,center=true);
		translate([ht/2,0,ht/2])
			cube([ht,maxwidth,ht],center=true);
		// Main: create lower portion, then side ribs, then cross-ribs
		// Flat base
		//translate([ht,0,0])
			//rotate(-langle,[0,1,0])
				linear_extrude(height=Rib_Thickness,convexity=10,twist=0)
					polygon(points=[[ht,maxwidth/2],[ht,-maxwidth/2],[polygonend,knucklecenterline-Max_Knuckle_Width/2],[polygonend,knucklecenterline+Max_Knuckle_Width/2]]);
		// Side ribs
		translate([ht,maxwidth/2,0])
			rotate(sangleR,[0,0,1])
				rotate(90,[1,0,0])
					linear_extrude(height=Rib_Thickness,convexity=10,twist=0)
						polygon(points=[[0,0],[sanglelenR,0],[sanglelenR,endht],[0,ht]]);
		translate([ht,-maxwidth/2,0])
			rotate(-sangleL,[0,0,1])
				rotate(-90,[1,0,0])
					linear_extrude(height=Rib_Thickness,convexity=10,twist=0)
						polygon(points=[[0,0],[sanglelenL,0],[sanglelenL,-endht],[0,-ht]]);
		// Cross ribs
		translate([ht,maxwidth/2,0])
			rotate(crangleR,[0,0,1])
				rotate(90,[1,0,0])
					linear_extrude(height=Rib_Thickness,convexity=10,twist=0)
						polygon(points=[[0,0],[0,ht],[cranglelenR,endht],[cranglelenR,0]]);
		translate([ht,-maxwidth/2,0])
			rotate(crangleL,[0,0,1])
				rotate(-90,[1,0,0])
					linear_extrude(height=Rib_Thickness,convexity=10,twist=0)
						polygon(points=[[0,0],[0,-ht],[cranglelenL,-endht],[cranglelenL,0]]);

		// Knuckle Mount point
		translate([polygonend+endht/2,knucklecenterline,endht/2])
			cube([endht,Max_Knuckle_Width,endht],center=true);
		translate([Arm_Length,knucklecenterline,endht/2])
			rotate(90,[1,0,0])
				cylinder(r=endht/2,h=Max_Knuckle_Width,center=true);

		// Shock mounting points
		if(insidehole)
			translate([0,0,(endht+ht)/4])
				InsideMountHolePos();
		else
			translate([0,0,(endht+ht)/4])
				OutsideMountHolePos();
	}
	// Negative entities
	union() {
		// Frame hole and cut-out
		translate([0,0,ht/2])
			rotate(90,[1,0,0])
				cylinder(r=Inner_Hole_Diam/2+Tolerance,h=maxwidth+1,center=true);
		translate([0,0,ht/2])
			cube([ht+4,Frame_Width+Tolerance,ht+4], center=true);
		// Knuckle hole and cut-out
		translate([Arm_Length,knucklecenterline,endht/2])
			rotate(90,[1,0,0])
				cylinder(r=Outer_Hole_Diam/2+Tolerance,h=maxwidth+2    ,center=true);
		translate([Arm_Length,knucklecenterline,endht/2])
			cube([endht*3/2,Knuckle_Width+Tolerance,endht+1],center=true);
		// Axle channel cut-out
		translate([0,0,Channel_Diam*1.5+endht/2])
			rotate(changlez,[0,0,1])
				rotate(90+changley,[0,1,0])
		 			cylinder(r=Channel_Diam/2,h=chlen);

		// Shock mounting points
		if(insidehole)
			translate([0,0,(endht+ht)/4])
				InsideMountHoleNeg();
		else
			translate([0,0,(endht+ht)/4])
				OutsideMountHoleNeg();
	}
}
}

// Creates shock mountings inside rib area
module InsideMountHolePos() {
translate([Middle_Hole_X,Middle_Hole_Y,0])
	union() {
		cube([mountxlen,holedepth,Middle_Hole_Diam*1.7],center=true);
		translate([-mountxlen/2,0,0])
			rotate(90,[1,0,0])
				cylinder(r=Middle_Hole_Diam*0.85,h=holedepth,center=true);
		translate([mountxlen/2,0,0])
			rotate(90,[1,0,0])
				cylinder(r=Middle_Hole_Diam*0.85,h=holedepth,center=true);
	}
}

// negative section for the inside holes
module InsideMountHoleNeg() {
translate([Middle_Hole_X,Middle_Hole_Y,0])
	union() {
		cube([mountxlen,Mount_Width+Tolerance,ht*1.5],center=true);
		translate([-mountxlen/2,0,0])
			rotate(90,[1,0,0])
				cylinder(r=ht*0.75,h=Mount_Width+Tolerance,center=true);
		translate([mountxlen/2,0,0])
			rotate(90,[1,0,0])
				cylinder(r=ht*0.75,h=Mount_Width+Tolerance,center=true);
		if(Middle_Hole_Number>1)
			for(m=[1:1:Middle_Hole_Number])
				translate([-mountxlen/2+(m-1)*mountxlen/(Middle_Hole_Number-1),-Mount_Width,0])
					rotate(-90,[1,0,0])
						cylinder(r=Middle_Hole_Diam/2+Tolerance,h=holedepth+maxwidth/2,center=false);
		if(Middle_Hole_Number==1)
			translate([0,-Mount_Width,0])
				rotate(-90,[1,0,0])
					cylinder(r=Middle_Hole_Diam/2+Tolerance,h=holedepth+maxwidth/2,center=false);
	}
}

// Creates shock mountings outside rib area
module OutsideMountHolePos() {
translate([Middle_Hole_X,Middle_Hole_Y,0])
	union() {
		translate([0,-holedepth/2,0])
			cube([mountxlen,holedepth,Middle_Hole_Diam*1.7],center=true);
		translate([-mountxlen/2,-holedepth/2,0])
			rotate(90,[1,0,0])
				cylinder(r=Middle_Hole_Diam*0.85,h=holedepth,center=true);
		translate([mountxlen/2,-holedepth/2,0])
			rotate(90,[1,0,0])
				cylinder(r=Middle_Hole_Diam*0.85,h=holedepth,center=true);
	}
}

// Negative section for the outer holes
module OutsideMountHoleNeg() {
translate([Middle_Hole_X,Middle_Hole_Y,0])
	union()  {
		if(Middle_Hole_Number>1)
			for(m=[1:1:Middle_Hole_Number])
				translate([-mountxlen/2+(m-1)*mountxlen/(Middle_Hole_Number-1),0,0])
					rotate(90,[1,0,0])
						cylinder(r=Middle_Hole_Diam/2+Tolerance,holedepth*7/4,center=true);
		if(Middle_Hole_Number==1)
			rotate(90,[1,0,0])
				cylinder(r=Middle_Hole_Diam/2,holedepth*7/4,center=true);
		translate([0,holedepth/2,0])
			cube([mountxlen,holedepth,ht],center=true);
		translate([-mountxlen/2,holedepth/2,0])
			rotate(90,[1,0,0])
				cylinder(r=ht*0.75,h=holedepth,center=true);
		translate([mountxlen/2,holedepth/2,0])
			rotate(90,[1,0,0])
				cylinder(r=ht*0.75,h=holedepth,center=true);
	}
}