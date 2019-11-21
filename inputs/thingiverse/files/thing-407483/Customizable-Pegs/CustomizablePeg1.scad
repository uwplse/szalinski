// ************* Credits part *************

// Programmed by Fryns - July 2014

// ************* Declaration part *************

/* [Peg] */
TopThickness=3;
PegLength=80;
PegWidth=10;
PegThickness=1.5;

/* [Hook] */
HookLength=20;
HookSpace=4;
HookThickness=2;

/* [Hidden] */
Manifoldfix=0.01;

// preview[view:north, tilt:top]

// ************* Executable part *************

rotate([90,0,90])
Assembly();


// ************* Module part *************
module Assembly(){
	cube([PegWidth+HookThickness+HookSpace,PegWidth,TopThickness]); // peg top
	intersection(){
		PegSolid();
		PegSkeleton();
	}
	PegHook();
}

module PegSolid(){	// makes solid version of peg
	intersection(){	// makes peg point
		translate([PegWidth/2,PegWidth/2,0])
			cylinder(h = PegLength, r1 = PegLength, r2 = 0,$fn=50, center = false); 
		cube([PegWidth,PegWidth,PegLength]);
	}
}

module PegHook(){
	difference(){	// makes hook curve
		translate([PegWidth,0,0])
			cube([HookSpace,PegWidth,HookLength]);
		translate([PegWidth+HookSpace/2,PegWidth/2,HookSpace/2+TopThickness])
			rotate([90,0,0])
				cylinder(h = PegWidth+Manifoldfix, r = HookSpace/2,$fn=50 ,center = true);
		translate([PegWidth,0,HookSpace/2+TopThickness])
			cube([HookSpace,PegWidth,HookLength]);
		translate([PegWidth,PegThickness/2*sqrt(2),TopThickness])
			cube([HookSpace/2,PegWidth-PegThickness*sqrt(2)+Manifoldfix,HookLength]);
	}

	intersection(){	// makes hook 
		translate([PegWidth+HookSpace,PegWidth/2,-HookLength])
			rotate([45,0,0])
		cube([HookThickness,HookLength*sqrt(2),HookLength*sqrt(2)]);
		translate([PegWidth+HookSpace,0,0])
		cube([HookThickness,PegWidth,HookLength]);
	}
}

module PegSkeleton(){	// makes peg skeleton from 4 quarters
	translate([0,-Manifoldfix,0])
	PegSkeletonQuarter();
	translate([PegWidth+Manifoldfix,0,0])
		rotate([0,0,90])
	PegSkeletonQuarter();
	translate([PegWidth,PegWidth+Manifoldfix,0])
		rotate([0,0,180])
	PegSkeletonQuarter();
	translate([-Manifoldfix,PegWidth,0])
		rotate([0,0,-90])
	PegSkeletonQuarter();
}

module PegSkeletonQuarter(){	// makes peg skeleton quarter
	intersection(){
		translate([PegWidth/2,PegWidth/2,0])
			rotate([0,0,45])
		cube([PegWidth,PegWidth,PegLength]);
		PegSkeletonIntermidiate();
	}
}

module PegSkeletonIntermidiate(){	// makes peg skeleton structure for quarter
	translate([PegWidth/2,PegWidth/2,(PegWidth+TopThickness)/2*sqrt(2)])
		rotate([-90,0,0])
			rotate([0,0,45])
	difference(){		// makes peg cross
		cube([PegWidth,PegWidth,PegWidth/2]);
		translate([PegThickness,PegThickness,0])
			cube([PegWidth,PegWidth,PegWidth]);

	}
	translate([PegWidth/2,PegWidth/2,0])
		rotate([0,0,45])
	difference(){		// makes peg cross
		cube([PegWidth,PegWidth,PegLength]);
		translate([PegThickness/2,PegThickness/2,0])
				cube([PegWidth,PegWidth,PegLength]);
	}
}