
//Width of the metal bar in mm
BarWidth=19;

//Thickness of the metal bar in mm
BarThickness=3;

/*[hidden]*/

/*
Use 4mm diameter nuts and bolts for all attachments! 4mm diameter screws also.
*/

$fn=20;

//1st half of the rocker-hinge mount bracket
translate([0,5,0])
difference(){

union(){
	//bottom plate
	cube([40,6,BarWidth+14],center=true);

	//structure for axle hole
	hull(){
		translate([0,12,-(((BarWidth+14)/2)-1.5)])cylinder(r=6,h=3,center=true);
		translate([0,2,-(((BarWidth+14)/2)-1.5)])cube([20,2,3],center=true);
	}
}

	//axle hole
	translate([0,12,-(((BarWidth+14)/2)-1.5)])cylinder(r=2.5,h=4,center=true);
	
	//cut-away for other half
	translate([0,3,3.5])cube([42,6.25,BarWidth+14],center=true);

	//screw holes
	translate([-10,0,2.5])rotate([90,0,0])cylinder(r=2.5,h=10,center=true);
	translate([10,0,2.5])rotate([90,0,0])cylinder(r=2.5,h=10,center=true);

}


//2nd half of the rocker-hinge mount bracket
rotate([0,0,180])
translate([0,5,0])
difference(){

union(){
	//bottom plate
	cube([40,6,BarWidth+14],center=true);

	//structure for axle hole
	hull(){
		translate([0,12,-(((BarWidth+14)/2)-1.5)])cylinder(r=6,h=3,center=true);
		translate([0,2,-(((BarWidth+14)/2)-1.5)])cube([20,2,3],center=true);
	}
}

	//axle hole
	translate([0,12,-(((BarWidth+14)/2)-1.5)])cylinder(r=2.5,h=4,center=true);
	
	//cut-away for other half
	translate([0,-3,3.5])cube([42,6.25,BarWidth+14],center=true);

	//screw holes
	translate([-10,0,2.5])rotate([90,0,0])cylinder(r=2.5,h=10,center=true);
	translate([10,0,2.5])rotate([90,0,0])cylinder(r=2.5,h=10,center=true);

}


//Rocker hinge that slides over bar

difference(){
	//main geometry
	union(){
		translate([-35,0,-(((BarWidth+14)/2)-13)])
		cube([BarThickness+7,40,BarWidth+7],center=true);
		hull(){
			translate([-35-(((BarThickness+7)/2)+6),0,-(((BarWidth+14)/2)-13)])
			cylinder(r=6,h=BarWidth+7,center=true);
			translate([-35-(((BarThickness+7)/2)-1.5),0,-(((BarWidth+14)/2)-13)])
			cube([3,15,BarWidth+7],center=true);
		}
	}

	//hole for bar
	translate([-35,0,-(((BarWidth+14)/2)-13)])
	cube([BarThickness+1,42,BarWidth+1],center=true);

	//holes for bolts
	translate([-35,13,-(((BarWidth+14)/2)-13)])rotate([0,90,0])
	cylinder(r=2.5,h=BarThickness+10,center=true);
	
	translate([-35,-13,-(((BarWidth+14)/2)-13)])rotate([0,90,0])
	cylinder(r=2.5,h=BarThickness+10,center=true);

	//hole for axle
	translate([-35-(((BarThickness+7)/2)+6),0,-(((BarWidth+14)/2)-13)])
	cylinder(r=2.5,h=BarWidth+9,center=true);
}