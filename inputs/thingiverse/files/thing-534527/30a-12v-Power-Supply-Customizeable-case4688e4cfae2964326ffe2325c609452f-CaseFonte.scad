Case_Width = 114;
Case_Height = 50;
Case_Depth = 50;
Case_thickness = 2;

Connector_Width = 28;
Connector_Height = 20;
Connector_Position = 7;
Connector_Screw_Distance = 5;


Button_Radius = 10; 
Button_Distance = 15;

Wire_Hole_Height = 10;
Wire_Hole_Width = 20;

cube([Case_Width + (Case_thickness * 2),Case_Depth + (Case_thickness * 2), Case_thickness]);
cube([Case_thickness,Case_Depth + (Case_thickness * 2),Case_Height]);
cube([Case_Width + (Case_thickness * 2), Case_thickness, Case_Height]);
difference(){
	translate([Case_Width + Case_thickness, 0,0]) cube([Case_thickness, Case_Depth + (Case_thickness * 2), Case_Height]);
	translate([Case_Width - 3 ,Case_thickness,Case_thickness])	cube([10,Wire_Hole_Width,Wire_Hole_Height]);
}
difference() {
	translate ([0,Case_Depth + Case_thickness,0]) cube([Case_Width + Case_thickness,Case_thickness,Case_Height]);
	
	//Conector
	translate([Case_Width - Connector_Width - 15, Case_Depth - 1 , Connector_Position])     	cube([Connector_Width, (Case_thickness * 2) + 2,Connector_Height]);
	// Parafusos conector
	rotate(90, [1,0,0]) translate([Case_Width - Connector_Width - Button_Distance - 6, Button_Distance + 2 , -Case_Depth - (Case_thickness * 3) - 1])  cylinder(h = (Case_thickness * 4) + 2, r=1.6);
	rotate(90, [1,0,0]) translate([Case_Width - Connector_Width + Button_Distance + 4, Button_Distance + 2, -Case_Depth - (Case_thickness * 3) - 1])  cylinder(h = (Case_thickness * 4) + 2, r=1.6);


	// Botão
	rotate(90, [1,0,0]) translate([20, Button_Distance , -Case_Depth - (Case_thickness * 2) - 1]) cylinder(h = (Case_thickness * 2) + 2, r=Button_Radius);
}
