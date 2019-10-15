/* [Global] */

// Which one would you like to see?
part = "first"; // [first:Two Walls,second:Three Walls]

/* [Walls Joint] */
// Enter the Wall Thickness
Wall_Thickness = 3 ;
// Enter the Acrylic Thickness
Acrylic_Thickness = 3 ;
// Enter the Cube Size - Minimum:(Acrylic Thickness + (Wall Thickness * 4) + 5)
Cube_Size = 20;


print_part();

module print_part() {
	if (part == "first") {
		Two_Walls();
	} else if (part == "second") {
		Three_Walls();
	}
}


module Three_Walls() {
group() {  group(){
	difference() {
	difference() {
	difference() {
	difference() {
	cube (size = Cube_Size, center = false);
	cube (size = [Cube_Size-(Acrylic_Thickness+Wall_Thickness*2), Cube_Size-(Acrylic_Thickness+Wall_Thickness*2), Cube_Size-Wall_Thickness*2-Acrylic_Thickness], center = false);
	}
	multmatrix([[1.0, 0.0, 0.0,0.0], [0.0, 1.0, 0.0, Cube_Size-Wall_Thickness-Acrylic_Thickness], [0.0, 0.0, 1.0, 0.0], [0, 0, 0, 1]]){
	cube (size = [Cube_Size-Wall_Thickness, Acrylic_Thickness, Cube_Size-Wall_Thickness], center = false);
	} 
	}
	multmatrix([[1.0, 0.0, 0.0,Cube_Size-Wall_Thickness-Acrylic_Thickness], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 1.0, 0.0], [0, 0, 0, 1]]){
	cube (size = [Acrylic_Thickness, Cube_Size-Wall_Thickness, Cube_Size-Wall_Thickness], center = false);
	}
	}
	multmatrix([[1.0, 0.0, 0.0,0.0], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 1.0, Cube_Size-Wall_Thickness-Acrylic_Thickness], [             0, 0, 0, 1]]){
	cube (size = [Cube_Size-Wall_Thickness*2-Acrylic_Thickness, Cube_Size-Wall_Thickness*2-Acrylic_Thickness, Acrylic_Thickness], center = false);
	}
	}
	}
	}
}
	
module Two_Walls() {	
group() {
	group(){
	difference() {
	difference() {
	difference() {
	cube (size = Cube_Size, center = false);
	cube (size = [Cube_Size- (Acrylic_Thickness+Wall_Thickness*2), Cube_Size- (Acrylic_Thickness+Wall_Thickness*2), Cube_Size-Wall_Thickness], center = false);
	}
	multmatrix([[1.0, 0.0, 0.0,0.0], [0.0, 1.0, 0.0, Cube_Size-Wall_Thickness-Acrylic_Thickness], [0.0, 0.0, 1.0, 0.0], [0, 0, 0, 1]]){
	cube (size = [Cube_Size-Wall_Thickness, Acrylic_Thickness, Cube_Size-Wall_Thickness], center = false);
	}
	}
	multmatrix([[1.0, 0.0, 0.0,Cube_Size-Wall_Thickness-Acrylic_Thickness], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 1.0, 0.0], [0, 0, 0, 1]]){
	cube (size = [Acrylic_Thickness, Cube_Size-Wall_Thickness, Cube_Size-Wall_Thickness], center = false);
	}
	}
	}
	}
}