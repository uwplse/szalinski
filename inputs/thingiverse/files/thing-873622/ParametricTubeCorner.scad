// Parametric Square Aluminum Tube Corner Box Connector 
// Original by sandfrog 
// Updated by madmike8
// Just Change the Tube Size and Wall Thickness Varibles
Tube_Outside_Size = 19;
Wall_Thickness = 1.7;
Bottom_Screw_Diameter = 4;
Bottom_Screw_Recess_Diameter = 8;
Leg_Screw_Diameter = 3;

//Do not Change anything Below.

TubeInsideSize = Tube_Outside_Size - (Wall_Thickness*2);
translate([0,0,19])rotate([180,0,0])union()
{
 {	 				

// Grundwürfel - Basic Cube
	difference() {
		cube([Tube_Outside_Size,Tube_Outside_Size,Tube_Outside_Size]);
		translate([(Tube_Outside_Size/2),(Tube_Outside_Size/2),0])
	// MDF-Verschraubung - Screwing
		cylinder(Tube_Outside_Size,r=(Bottom_Screw_Diameter/2), $fn=100);
		translate([(Tube_Outside_Size/2),(Tube_Outside_Size/2),TubeInsideSize])		
	// Senkkopfschrauben-Vertiefung - Countersunk recess
		cylinder(3.45,r=(
Bottom_Screw_Recess_Diameter/2), $fn=100);
	}
}

translate	([Tube_Outside_Size,Wall_Thickness,Wall_Thickness]) {	 		
	// Verbindungswürfel-links - Right Leg connection cube
	difference() {
		cube([TubeInsideSize,TubeInsideSize,TubeInsideSize]);
		translate([(TubeInsideSize/2),(TubeInsideSize/2),0])
		cylinder(Tube_Outside_Size,r=(Leg_Screw_Diameter/2), $fn=100);
	}
}

translate	([Wall_Thickness,Tube_Outside_Size,Wall_Thickness]) {	 		
	// Verbindungswürfel-rechts - Left Leg connection cube
	difference() {
		cube([TubeInsideSize,TubeInsideSize,TubeInsideSize]);
		translate([(TubeInsideSize/2),(TubeInsideSize/2),0])
		cylinder(Tube_Outside_Size,r=(Leg_Screw_Diameter/2), $fn=100);
	}
}

translate	([Wall_Thickness,Wall_Thickness,
(-1*TubeInsideSize)]) {	 		
	// Verbindungswürfel-rechts - Bottom connection cube
	difference() {
		cube([TubeInsideSize,TubeInsideSize,TubeInsideSize]);
		translate([(TubeInsideSize/2),(TubeInsideSize/2),0])
		cylinder(Tube_Outside_Size,r=(Bottom_Screw_Diameter/2), $fn=100);
		translate([(TubeInsideSize/2),0,(TubeInsideSize/2)])
		rotate([0,90,90])cylinder(Tube_Outside_Size,r=(Leg_Screw_Diameter/2), $fn=100);

	}
}
}