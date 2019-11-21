//Distance Between the X Axis Bars
X_Bar_Distance=50;

//The Diameter of the X Axis Bars
X_Bar_Diameter=9; 

//The Distance Between the Screw Holes on the Fan
Fan_Screw_Distance=82.55; 

//The Diameter of the Screw to Hold the Fan in Place
Fan_Screw_Diameter=4;

//The Thickness of the Holder. This affects the thickness on the Z axis as well as on the X/Y Axis
Overall_Thickness=3;

//The Resolution of the Holder
Resolution=48; 

//Ignore this variable
$fn=Resolution;

fan_holder();

module fan_holder(){
difference(){
	union(){
	
	
		translate([X_Bar_Distance/2,0,0])
			cylinder(Overall_Thickness, (X_Bar_Diameter)/2+Overall_Thickness,(X_Bar_Diameter)/2+Overall_Thickness);
		
		translate([X_Bar_Distance/-2,0,0])
			cylinder(Overall_Thickness, (X_Bar_Diameter)/2+Overall_Thickness,(X_Bar_Diameter)/2+Overall_Thickness);
		
		translate([0,(X_Bar_Diameter+Overall_Thickness)/-2,Overall_Thickness/2])
		cube([X_Bar_Distance,Overall_Thickness, Overall_Thickness],center = true);
	
	}
		hull(){
		
		translate([X_Bar_Distance/2,0,-1])
			cylinder(Overall_Thickness+2, (X_Bar_Diameter)/2,(X_Bar_Diameter)/2);
		
		translate([X_Bar_Distance/2,X_Bar_Diameter*3,-1])
			cylinder(Overall_Thickness+2, (X_Bar_Diameter)/2,(X_Bar_Diameter)/2);
	
	}

	hull(){
		translate([X_Bar_Distance/-2,0,-1])
			cylinder(Overall_Thickness+2, (X_Bar_Diameter)/2,(X_Bar_Diameter)/2);
		
		translate([X_Bar_Distance/-2,X_Bar_Diameter*3,-1])
			cylinder(Overall_Thickness+2, (X_Bar_Diameter)/2,(X_Bar_Diameter)/2);
	
	}

}
difference(){
union(){

hull(){
translate([0,(X_Bar_Diameter)/-2,0])
cylinder(Overall_Thickness,(Overall_Thickness)/2,(Overall_Thickness)/2);

translate([X_Bar_Distance/6,(X_Bar_Diameter+Overall_Thickness+2),0])
cylinder(Overall_Thickness,(Overall_Thickness)/2,(Overall_Thickness)/2);
}

hull(){
translate([0,(X_Bar_Diameter)/-2,0])
cylinder(Overall_Thickness,(Overall_Thickness)/2,(Overall_Thickness)/2);

translate([X_Bar_Distance/-6,(X_Bar_Diameter+Overall_Thickness+2),0])
cylinder(Overall_Thickness,(Overall_Thickness)/2,(Overall_Thickness)/2);
}

hull(){
translate([X_Bar_Distance/-6,(X_Bar_Diameter+Overall_Thickness+2),0])
cylinder(Overall_Thickness,(Overall_Thickness)/2,(Overall_Thickness)/2);

translate([Fan_Screw_Distance/-2,(X_Bar_Diameter+Overall_Thickness)*1.5,0])
cylinder(Overall_Thickness,(Overall_Thickness)/2,(Overall_Thickness)/2);
}

hull(){
translate([X_Bar_Distance/6,(X_Bar_Diameter+Overall_Thickness+2),0])
cylinder(Overall_Thickness,(Overall_Thickness)/2,(Overall_Thickness)/2);

translate([Fan_Screw_Distance/2,(X_Bar_Diameter+Overall_Thickness)*1.5,0])
cylinder(Overall_Thickness,(Overall_Thickness)/2,(Overall_Thickness)/2);
}

translate([Fan_Screw_Distance/2,(X_Bar_Diameter+Overall_Thickness)*1.5,0])
cylinder(Overall_Thickness,(Fan_Screw_Diameter)/2+Overall_Thickness,(Fan_Screw_Diameter)/2+Overall_Thickness);

translate([Fan_Screw_Distance/-2,(X_Bar_Diameter+Overall_Thickness)*1.5,0])
cylinder(Overall_Thickness,(Fan_Screw_Diameter)/2+Overall_Thickness,(Fan_Screw_Diameter)/2+Overall_Thickness);

}

translate([Fan_Screw_Distance/2,(X_Bar_Diameter+Overall_Thickness)*1.5,-1])
cylinder(Overall_Thickness+2,(Fan_Screw_Diameter)/2,(Fan_Screw_Diameter)/2);

translate([Fan_Screw_Distance/-2,(X_Bar_Diameter+Overall_Thickness)*1.5,-1])
cylinder(Overall_Thickness+2,(Fan_Screw_Diameter)/2,(Fan_Screw_Diameter)/2);

}
}
