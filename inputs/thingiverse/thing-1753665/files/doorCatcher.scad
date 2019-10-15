//BEGIN CUSTOMIZER VARIABLES
/*[door]*/
//How thick is the door?
doorWidth = 1.75;
//
catcherHeight = 3;
//
catcherLength = 2;
/*[advanced]*/
//How thick do you want it to be?
thickness = .125;
//allows units entered to be inches.
scaleFactor = 25.4;
//END CUSTOMIZER VARIABLES
scale(scaleFactor){
	difference(){
		cube([doorWidth+thickness*2,catcherLength,catcherHeight],center = true);
		translate([0,-thickness,thickness]){
			cube([doorWidth*1.01,catcherLength,catcherHeight],center = true);
		}
	}
}