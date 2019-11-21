//CUSTOMIZER VARIABLES

//Size of the full piece
totalsize=12;	//	[6: small (6"), 12: medium, 16: large]

//How many cups do you want (doesn't include the middle cup)?
cups=4;		//		[1:8]

//Do you want a cup in the middle?
middlecup=1; 	//	[0: no, 1:yes]

//Width of your drink. For reference, Coca-Cola is 2.5 but about 2.75 with some wiggle room. Make sure that your cups do not run off the side of the piece. 
drinkwidth=4;	//		[2:5]

//Height of the cup (should be a little more than half of your actual drink height)
drinkheight=4;// 	[1:5]

//Minimum distance of cups away from sides - if your cups run off the side, make this value higher.
sidedist=0.25;	//	[0.1:5]

//Thickness of the cup wall. This determines how how thick your cup is. 
cupthick=0.125;	// [0.0625:0.5]

//Thickness of the bottom of cups (typical value is 2x the size of the cupthicknes)
botthick=0.25; // [0.03125:1]

//Detail of spheres - a value of approximately 50 is reccomened. Higher detail corresponds to longer rendering and slicing times. 
sfn=50;	//	[30:200]



//Setting your unit. Model is designed for inches. 
unit=25.4; // [1: mm, 10: cm, 25.4 : in (default)]




//This option will not appear
joint_thickness = 2;
//This option will not appear
jointsize=15;
//This option will not appear
jointhole = 1.75;
//This option will not appear
joint_spacing =0.5; 
//This option will not appear
joint_arms = 5; 
//This option will not appear
jointarm_width = 10; 
//This option will not appear
sizeval=totalsize/2;	
//This option will not appear
var=totalsize/cups-sidedist;



//----------------------------------------------Holes----------------------------------------------\\



module holesforcups(cups) {
	for(i=[0:cups]) {
		rotate([0,0,360/cups*i]) {
			translate([var*unit,var*unit,botthick*unit]) {
				cupholesize();
			}
		}
	}
}



module holesforjoints() {
	translate([(totalsize/5*unit),0,jointhole*unit]) {
			jointholesize();
	}
	translate([(totalsize/5*-1*unit),0,jointhole*unit]) {
			jointholesize();
	}
}


//-------------------------------------------Hole sizing-------------------------------------------\\


module cupholesize() {
	cylinder(r=(drinkwidth/2+botthick/2)*unit, h=(drinkheight+botthick)*unit, $fn=sfn);
}
	


module jointholesize() {
	rotate([90]) {
		cylinder(r=jointhole/2*unit, h=jointhole*unit, $fn=sfn);
	}
}

//-------------------------------------------Base shapes-------------------------------------------\\
module cup() {
	difference() {
		cylinder(r=(drinkwidth/2+botthick/2)*unit, h=(drinkheight+botthick)*unit+1, $fn=sfn); 
		translate([0,0,botthick*unit+1]) {
			cylinder(r=drinkwidth/2*unit, h=drinkheight*unit, $fn=sfn);
		}
	}
}
	


module ball() {
rotate([-90,0,0]) {
	sphere(r=jointsize);
	translate([0,0,-jointsize]) cylinder(r1=8,r2=6,h=3);
	translate([0,0,-jointsize-3]) cylinder(r=8,h=3);
	}
}



module joint() {
rotate([90,0,0]) {
difference()
{
	sphere(r=jointsize+joint_spacing+joint_thickness);
	sphere(r=jointsize+joint_spacing);
	translate([0,0,-jointsize-3]) cube([jointsize+joint_spacing+joint_thickness+25,jointsize+joint_spacing+joint_thickness+25,18],center=true);
	for(i=[0:joint_arms])
	{
		rotate([0,0,360/joint_arms*i]) translate([-jointarm_width/2,0, -jointsize/2-4])
			cube([jointarm_width,jointsize+joint_spacing+joint_thickness+20,jointsize+6]);
	}
}
	translate([0,0,jointsize-2]) cylinder(r2=8,r1=8,h=5);

}
}

module halfsphere() {
	difference() {
		scale([1,1,0.5]) {
			sphere(r=sizeval*unit, $fn=sfn);
		}
		translate([-sizeval*unit,-sizeval*unit,-sizeval*unit]) {
			cube([totalsize*unit,totalsize*unit,sizeval*unit]);
		}
	}
}




//---------------------------------------------Plurals---------------------------------------------\\
module cups(cups) {	
	for(i=[0:cups]) {
	rotate([0,0,360/cups*i]) {
		translate([var*unit,var*unit,botthick*unit]) {
			cup();
			}
		}
	}
holesforcups(cups);
}

module jointandball() {
	translate([(totalsize/5*unit),0,jointhole*unit]) {
			joint();
	}
	translate([(totalsize/5*-1*unit),0,jointhole*unit]) {
			ball();
	}
}


//---------------------------------------------Combos---------------------------------------------\\

module half() {
	difference() {
		fullnojointsmiddlecup(cups);
		translate([-totalsize*unit/2,0]) {
			cube([totalsize*unit,totalsize*unit,(cupthick+totalsize)*unit]);
		}
	}
}

module middlecup() {
cup();
}


module fullnojointsmiddlecup(cups) {
	difference() {
		halfsphere();
		holesforcups(cups);
		translate([0,0,botthick*unit]) {
			cupholesize();
		}
	}
translate([0,0,botthick*unit]) {
	cup();
cups(cups);
	}
}
		


module final(cups) {
	difference() {
		half(cups);
		holesforjoints();
	}
jointandball();
}


module export(cups) {
	final(cups);
	
	translate([0,50,0]) {
		rotate([0,0,180]) {
			final(cups);
		}
	}	
}
//----------------------------------------Actual Code----------------------------------------\\

export(cups);